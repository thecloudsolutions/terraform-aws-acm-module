variable "acm_map" {
  type = map(object({
    certificate = optional(object({
      certificate_authority_arn = optional(string)
      certificate_body          = optional(string)
      certificate_chain         = optional(string)
      domain_name               = optional(string)
      early_renewal_duration    = optional(string)
      key_algorithm             = optional(string)
      private_key               = optional(string)
      private_key_wo            = optional(string)
      private_key_wo_version    = optional(number)
      region                    = optional(string)
      subject_alternative_names = optional(set(string))
      validation_method         = optional(string)

      options = optional(object({
        certificate_transparency_logging_preference = optional(string)
        export                                      = optional(string)
      }))

      validation_option = optional(set(object({
        domain_name       = string
        validation_domain = string
      })))

      tags = optional(map(string))
    }))

    existing_certificate = optional(object({
      domain      = optional(string)
      key_types   = optional(set(string))
      most_recent = optional(bool)
      region      = optional(string)
      statuses    = optional(list(string))
      types       = optional(list(string))

      tags = optional(map(string))
    }))

    certificate_validation = optional(object({
      allow_overwrite                = optional(bool, true)
      certificate_arn                = optional(string)
      certificate_custom_name        = optional(string)
      create_route53_records         = optional(bool)
      custom_zone_id                 = optional(string)
      custom_zone_ids                = optional(map(string), {})
      record_ttl                     = optional(number, 60)
      region                         = optional(string)
      validation_record_fqdns        = optional(set(string), [])
      validation_records_custom_name = optional(string)
      wait_for_validation            = optional(bool, true)

      domain_validation_options = optional(set(object({
        domain_name           = string
        resource_record_name  = string
        resource_record_type  = string
        resource_record_value = string
      })))

      timeouts = optional(object({
        create = string
      }))
    }))
  }))

  description = "Keyed collection of acm definitions"
}
