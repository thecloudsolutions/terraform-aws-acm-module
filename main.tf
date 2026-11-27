module "acm_certificate" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-acm-component.git?ref=main"

  acm_map = { for key, acm in var.acm_map :
    key => {
      certificate          = acm.certificate
      existing_certificate = acm.existing_certificate
    }
    if acm.certificate != null || acm.existing_certificate != null
  }
}

module "acm_certificate_validation" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-acm-component.git?ref=main"

  acm_map = { for key, acm in var.acm_map :
    key =>
    {
      certificate_validation = merge(
        acm.certificate_validation,
        {
          certificate_arn = acm.certificate_validation.certificate_arn != null ? acm.certificate_validation.certificate_arn : module.acm_certificate.acm_certificate_arns[acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : key]
          region          = acm.certificate_validation.region != null ? acm.certificate_validation.region : (acm.certificate_validation.certificate_arn == null ? module.acm_certificate.acm_certificate_regions[acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : key] : null)

          validation_record_fqdns = length(acm.certificate_validation.validation_record_fqdns) > 0 ? acm.certificate_validation.validation_record_fqdns : (acm.certificate_validation.validation_records_custom_name != null ? [
            for name, fqdn in module.route53_certificate_validation.route53_record_fqdns[acm.certificate_validation.validation_records_custom_name] : fqdn
            ] : [
            for name, fqdn in lookup(module.route53_certificate_validation.route53_record_fqdns, key, {}) : fqdn
          ])
        }
      )
    }
    if try(acm.certificate_validation.wait_for_validation, false)
  }
}

module "route53_certificate_validation" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-route53-component.git?ref=main"

  route53_map = {
    for key, acm in {
      for key, acm in var.acm_map : key => merge(
        acm.certificate_validation,
        {
          domain_validation_options = acm.certificate_validation.domain_validation_options != null ? acm.certificate_validation.domain_validation_options : ((acm.certificate_validation.certificate_arn == null || acm.certificate_validation.certificate_custom_name != null) && (var.acm_map[acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : key].certificate != null ? var.acm_map[acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : key].certificate.validation_method == "DNS" : false) ? module.acm_certificate.acm_certificate_domain_validation_options[acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : key] : [])
        }
      )
      if try(acm.certificate_validation.validation_records_custom_name, null) == null && (try(acm.certificate_validation.create_route53_records, null) != null ? acm.certificate_validation.create_route53_records : (try(acm.certificate_validation.custom_zone_id, null) != null || length(try(acm.certificate_validation.custom_zone_ids, {})) > 0))
    } :
    key => {
      records = {
        for dvo in acm.domain_validation_options :
        "${key}-${regex("^(?:\\*\\.)?(.+)$", dvo.domain_name)[0]}" => {
          name    = dvo.resource_record_name
          records = [dvo.resource_record_value]
          type    = dvo.resource_record_type
          zone_id = lookup(merge(
            { for domain, zone_id in acm.custom_zone_ids : "*.${domain}" => zone_id },
            acm.custom_zone_ids
          ), dvo.domain_name, lookup(acm.custom_zone_ids, "*.${dvo.domain_name}", acm.custom_zone_id))
          ttl             = acm.record_ttl
          allow_overwrite = acm.allow_overwrite
        }

        if !contains([for option in acm.domain_validation_options : "*.${option.domain_name}"], dvo.domain_name)
      }
    }
  }
}
