## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | thecloudsolutions/terraform-aws-components-internal.git//acm | main |
| <a name="module_acm_certificate_validation"></a> [acm\_certificate\_validation](#module\_acm\_certificate\_validation) | thecloudsolutions/terraform-aws-components-internal.git//acm | main |
| <a name="module_route53_record"></a> [route53\_record](#module\_route53\_record) | thecloudsolutions/terraform-aws-components-internal.git//route53 | main |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_map"></a> [acm\_map](#input\_acm\_map) | Keyed collection of acm definitions. | <pre>map(object({<br/>    certificate = optional(object({<br/>      domain_name               = string<br/>      validation_method         = string<br/>      subject_alternative_names = optional(list(string))<br/><br/>      options = optional(object({<br/>        certificate_transparency_logging_preference = string<br/>      }))<br/><br/>      tags = optional(map(string))<br/>    }))<br/><br/>    certificate_validation = optional(object({<br/>      certificate_arn         = optional(string)<br/>      certificate_custom_name = optional(string)<br/>      custom_zone_id          = optional(string)<br/>      region                  = optional(string)<br/>      validation_record_fqdns = optional(list(string), [])<br/><br/>      timeouts = optional(object({<br/>        create = string<br/>      }))<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_ids"></a> [acm\_certificate\_ids](#output\_acm\_certificate\_ids) | The ID of the certificate |
| <a name="output_acm_certificate_arns"></a> [acm\_certificate\_arns](#output\_acm\_certificate\_arns) | The ARN of the certificate |
| <a name="output_acm_certificate_domain_names"></a> [acm\_certificate\_domain\_names](#output\_acm\_certificate\_domain\_names) | The domain name for which the certificate is issued |
| <a name="output_acm_certificate_domain_validation_options"></a> [acm\_certificate\_domain\_validation\_options](#output\_acm\_certificate\_domain\_validation\_options) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g., if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_acm_certificate_statuses"></a> [acm\_certificate\_statuses](#output\_acm\_certificate\_statuses) | Status of the certificate. |
| <a name="output_acm_certificate_tags_all"></a> [acm\_certificate\_tags\_all](#output\_acm\_certificate\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_acm_certificate_validation_ids"></a> [acm\_certificate\_validation\_ids](#output\_acm\_certificate\_validation\_ids) | The time at which the certificate was issued |
| <a name="output_route53_record_names"></a> [route53\_record\_names](#output\_route53\_record\_names) | The name of the record. |
| <a name="output_route53_record_fqdns"></a> [route53\_record\_fqdns](#output\_route53\_record\_fqdns) | FQDN built using the zone domain and name. |
