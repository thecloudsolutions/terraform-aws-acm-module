module "acm_certificate" {
  source = "git@github.com:thecloudsolutions/terraform-aws-components-internal.git//acm?ref=main"

  acm_map = { for key, acm in var.acm_map :
    key => {
      certificate = acm.certificate
    }
    if acm.certificate != null
  }
}

module "acm_certificate_validation" {
  source = "git@github.com:thecloudsolutions/terraform-aws-components-internal.git//acm?ref=main"

  acm_map = { for key, acm in var.acm_map :
    key =>
    {
      certificate_validation = merge(
        acm.certificate_validation,
        {
          certificate_arn = try(acm.certificate_validation.certificate_arn, null) != null ? acm.certificate_validation.certificate_arn : module.acm_certificate.acm_certificate_arns[key]

          validation_record_fqdns = length(acm.certificate_validation.validation_record_fqdns) > 0 ? acm.certificate_validation.validation_record_fqdns : [
            for dvo in module.acm_certificate.acm_certificate_domain_validation_options[key] :
            module.route53_record.route53_record_fqdns[key]["${key}-${dvo.domain_name}"]
            if try(acm.certificate_validation, null) != null &&
            try(acm.certificate_validation.custom_zone_id, null) != null &&
            try(acm.certificate.validation_method, "") == "DNS"
          ]
        }
      )
    }
    if acm.certificate_validation != null
  }
}

module "route53_record" {
  source = "git@github.com:thecloudsolutions/terraform-aws-components-internal.git//route53?ref=main"

  route53_map = {
    for key, acm in var.acm_map :
    key => {
      records = {
        for dvo in module.acm_certificate.acm_certificate_domain_validation_options[
          acm.certificate_validation.certificate_custom_name
        ] :
        "${key}-${dvo.domain_name}" => {
          name            = dvo.resource_record_name
          records         = [dvo.resource_record_value]
          type            = dvo.resource_record_type
          zone_id         = acm.certificate_validation.custom_zone_id
          ttl             = 60
          allow_overwrite = true
        }

        if try(acm.certificate_validation.certificate_custom_name, null) != null
        && try(acm.certificate_validation.custom_zone_id, null) != null
        && try(acm.certificate.validation_method, null) == "DNS"
      }
    }
    if try(acm.certificate_validation, null) != null
  }
}
