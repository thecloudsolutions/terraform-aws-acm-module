## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | git::https://github.com/thecloudsolutions/terraform-aws-acm-component.git | main |
| <a name="module_acm_certificate_validation"></a> [acm\_certificate\_validation](#module\_acm\_certificate\_validation) | git::https://github.com/thecloudsolutions/terraform-aws-acm-component.git | main |
| <a name="module_route53_record"></a> [route53\_record](#module\_route53\_record) | git::https://github.com/thecloudsolutions/terraform-aws-route53-component.git | main |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_map"></a> [acm\_map](#input\_acm\_map) | Keyed collection of acm definitions | <pre>map(object({<br/>    certificate = optional(object({<br/>      certificate_authority_arn = optional(string)<br/>      certificate_body          = optional(string)<br/>      certificate_chain         = optional(string)<br/>      domain_name               = optional(string)<br/>      early_renewal_duration    = optional(string)<br/>      key_algorithm             = optional(string)<br/>      private_key               = optional(string)<br/>      private_key_wo            = optional(string)<br/>      private_key_wo_version    = optional(number)<br/>      region                    = optional(string)<br/>      subject_alternative_names = optional(set(string))<br/>      validation_method         = optional(string)<br/><br/>      options = optional(object({<br/>        certificate_transparency_logging_preference = optional(string)<br/>        export                                      = optional(string)<br/>      }))<br/><br/>      validation_option = optional(set(object({<br/>        domain_name       = string<br/>        validation_domain = string<br/>      })))<br/><br/>      tags = optional(map(string))<br/>    }))<br/><br/>    existing_certificate = optional(object({<br/>      domain      = optional(string)<br/>      key_types   = optional(set(string))<br/>      most_recent = optional(bool)<br/>      region      = optional(string)<br/>      statuses    = optional(list(string))<br/>      types       = optional(list(string))<br/><br/>      tags = optional(map(string))<br/>    }))<br/><br/>    certificate_validation = optional(object({<br/>      allow_overwrite                = optional(bool, true)<br/>      certificate_arn                = optional(string)<br/>      certificate_custom_name        = optional(string)<br/>      create_route53_records         = optional(bool)<br/>      custom_zone_id                 = optional(string)<br/>      custom_zone_ids                = optional(map(string), {})<br/>      record_ttl                     = optional(number, 60)<br/>      region                         = optional(string)<br/>      validation_record_fqdns        = optional(set(string), [])<br/>      validation_records_custom_name = optional(string)<br/>      wait_for_validation            = optional(bool, true)<br/><br/>      domain_validation_options = optional(set(object({<br/>        domain_name           = string<br/>        resource_record_name  = string<br/>        resource_record_type  = string<br/>        resource_record_value = string<br/>      })))<br/><br/>      timeouts = optional(object({<br/>        create = string<br/>      }))<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_ids"></a> [acm\_certificate\_ids](#output\_acm\_certificate\_ids) | The ID of the certificate |
| <a name="output_acm_certificate_arns"></a> [acm\_certificate\_arns](#output\_acm\_certificate\_arns) | The ARN of the certificate |
| <a name="output_acm_certificate_regions"></a> [acm\_certificate\_regions](#output\_acm\_certificate\_regions) | Region where the certificate is managed. |
| <a name="output_acm_certificate_domain_names"></a> [acm\_certificate\_domain\_names](#output\_acm\_certificate\_domain\_names) | The domain name for which the certificate is issued |
| <a name="output_acm_certificate_domain_validation_options"></a> [acm\_certificate\_domain\_validation\_options](#output\_acm\_certificate\_domain\_validation\_options) | Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g., if SANs are defined. Only set if DNS-validation was used. |
| <a name="output_acm_certificate_not_after"></a> [acm\_certificate\_not\_after](#output\_acm\_certificate\_not\_after) | Expiration date and time of the certificate. |
| <a name="output_acm_certificate_not_before"></a> [acm\_certificate\_not\_before](#output\_acm\_certificate\_not\_before) | Start of the validity period of the certificate. |
| <a name="output_acm_certificate_pending_renewal"></a> [acm\_certificate\_pending\_renewal](#output\_acm\_certificate\_pending\_renewal) | Whether a private certificate eligible for managed renewal is within the early renewal period. |
| <a name="output_acm_certificate_renewal_eligibility"></a> [acm\_certificate\_renewal\_eligibility](#output\_acm\_certificate\_renewal\_eligibility) | Whether the certificate is eligible for managed renewal. |
| <a name="output_acm_certificate_renewal_summary"></a> [acm\_certificate\_renewal\_summary](#output\_acm\_certificate\_renewal\_summary) | Information about the status of ACM's managed renewal for the certificate. |
| <a name="output_acm_certificate_statuses"></a> [acm\_certificate\_statuses](#output\_acm\_certificate\_statuses) | Status of the certificate. |
| <a name="output_acm_certificate_tags_all"></a> [acm\_certificate\_tags\_all](#output\_acm\_certificate\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_acm_certificate_types"></a> [acm\_certificate\_types](#output\_acm\_certificate\_types) | Source of the certificate. |
| <a name="output_acm_certificate_validation_ids"></a> [acm\_certificate\_validation\_ids](#output\_acm\_certificate\_validation\_ids) | The time at which the certificate was issued |
| <a name="output_acm_certificate_validation_arns"></a> [acm\_certificate\_validation\_arns](#output\_acm\_certificate\_validation\_arns) | The ARN of the validated certificate. |
| <a name="output_acm_certificate_validation_emails"></a> [acm\_certificate\_validation\_emails](#output\_acm\_certificate\_validation\_emails) | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |
| <a name="output_acm_existing_certificate_ids"></a> [acm\_existing\_certificate\_ids](#output\_acm\_existing\_certificate\_ids) | The ID of the existing certificate. |
| <a name="output_acm_existing_certificate_arns"></a> [acm\_existing\_certificate\_arns](#output\_acm\_existing\_certificate\_arns) | The ARN of the existing certificate. |
| <a name="output_acm_existing_certificate_regions"></a> [acm\_existing\_certificate\_regions](#output\_acm\_existing\_certificate\_regions) | Region where the existing certificate is managed. |
| <a name="output_acm_existing_certificate_domains"></a> [acm\_existing\_certificate\_domains](#output\_acm\_existing\_certificate\_domains) | The domain of the existing certificate. |
| <a name="output_acm_existing_certificates"></a> [acm\_existing\_certificates](#output\_acm\_existing\_certificates) | The existing ACM-issued certificate. |
| <a name="output_acm_existing_certificate_chains"></a> [acm\_existing\_certificate\_chains](#output\_acm\_existing\_certificate\_chains) | Certificates forming the existing certificate's chain of trust. |
| <a name="output_acm_existing_certificate_statuses"></a> [acm\_existing\_certificate\_statuses](#output\_acm\_existing\_certificate\_statuses) | Status of the existing certificate. |
| <a name="output_acm_existing_certificate_tags"></a> [acm\_existing\_certificate\_tags](#output\_acm\_existing\_certificate\_tags) | Tags assigned to the existing certificate. |
| <a name="output_route53_record_names"></a> [route53\_record\_names](#output\_route53\_record\_names) | The name of the record. |
| <a name="output_route53_record_fqdns"></a> [route53\_record\_fqdns](#output\_route53\_record\_fqdns) | FQDN built using the zone domain and name. |
