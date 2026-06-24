variable "acm_map" {
  type = map(object({
    certificate = optional(object({
      domain_name               = string
      validation_method         = string
      subject_alternative_names = optional(list(string))

      options = optional(object({
        certificate_transparency_logging_preference = string
      }))

      tags = optional(map(string))
    }))

    certificate_validation = optional(object({
      certificate_arn         = optional(string)
      certificate_custom_name = optional(string)
      custom_zone_id          = optional(string)
      region                  = optional(string)
      validation_record_fqdns = optional(list(string), [])

      timeouts = optional(object({
        create = string
      }))
    }))
  }))

  description = "Keyed collection of acm definitions."
}
