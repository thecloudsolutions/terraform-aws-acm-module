output "acm_certificate_ids" {
  value = { for key, id in module.acm_certificate.acm_certificate_ids :
    key => lookup(merge({}, [
      for validation_key, acm in var.acm_map : {
        "${acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : validation_key}" = module.acm_certificate_validation.acm_certificate_validation_arns[validation_key]
      }
      if try(acm.certificate_validation.wait_for_validation, false) && try(acm.certificate_validation.certificate_arn, null) == null
    ]...), key, id)
  }
  description = "The ID of the certificate"
}

output "acm_certificate_arns" {
  value = { for key, arn in module.acm_certificate.acm_certificate_arns :
    key => lookup(merge({}, [
      for validation_key, acm in var.acm_map : {
        "${acm.certificate_validation.certificate_custom_name != null ? acm.certificate_validation.certificate_custom_name : validation_key}" = module.acm_certificate_validation.acm_certificate_validation_arns[validation_key]
      }
      if try(acm.certificate_validation.wait_for_validation, false) && try(acm.certificate_validation.certificate_arn, null) == null
    ]...), key, arn)
  }
  description = "The ARN of the certificate"
}

output "acm_certificate_regions" {
  value       = module.acm_certificate.acm_certificate_regions
  description = "Region where the certificate is managed."
}

output "acm_certificate_domain_names" {
  value       = module.acm_certificate.acm_certificate_domain_names
  description = "The domain name for which the certificate is issued"
}

output "acm_certificate_domain_validation_options" {
  value       = module.acm_certificate.acm_certificate_domain_validation_options
  description = "Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g., if SANs are defined. Only set if DNS-validation was used."
}

output "acm_certificate_not_after" {
  value       = module.acm_certificate.acm_certificate_not_after
  description = "Expiration date and time of the certificate."
}

output "acm_certificate_not_before" {
  value       = module.acm_certificate.acm_certificate_not_before
  description = "Start of the validity period of the certificate."
}

output "acm_certificate_pending_renewal" {
  value       = module.acm_certificate.acm_certificate_pending_renewal
  description = "Whether a private certificate eligible for managed renewal is within the early renewal period."
}

output "acm_certificate_renewal_eligibility" {
  value       = module.acm_certificate.acm_certificate_renewal_eligibility
  description = "Whether the certificate is eligible for managed renewal."
}

output "acm_certificate_renewal_summary" {
  value       = module.acm_certificate.acm_certificate_renewal_summary
  description = "Information about the status of ACM's managed renewal for the certificate."
}

output "acm_certificate_statuses" {
  value       = module.acm_certificate.acm_certificate_statuses
  description = "Status of the certificate."
}

output "acm_certificate_tags_all" {
  value       = module.acm_certificate.acm_certificate_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "acm_certificate_types" {
  value       = module.acm_certificate.acm_certificate_types
  description = "Source of the certificate."
}

output "acm_certificate_validation_ids" {
  value       = module.acm_certificate_validation.acm_certificate_validation_ids
  description = "The time at which the certificate was issued"
}

output "acm_certificate_validation_arns" {
  value       = module.acm_certificate_validation.acm_certificate_validation_arns
  description = "The ARN of the validated certificate."
}

output "acm_certificate_validation_emails" {
  value       = module.acm_certificate.acm_certificate_validation_emails
  description = "A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
}

output "acm_existing_certificate_ids" {
  value       = module.acm_certificate.acm_existing_certificate_ids
  description = "The ID of the existing certificate."
}

output "acm_existing_certificate_arns" {
  value       = module.acm_certificate.acm_existing_certificate_arns
  description = "The ARN of the existing certificate."
}

output "acm_existing_certificate_regions" {
  value       = module.acm_certificate.acm_existing_certificate_regions
  description = "Region where the existing certificate is managed."
}

output "acm_existing_certificate_domains" {
  value       = module.acm_certificate.acm_existing_certificate_domains
  description = "The domain of the existing certificate."
}

output "acm_existing_certificates" {
  value       = module.acm_certificate.acm_existing_certificates
  description = "The existing ACM-issued certificate."
}

output "acm_existing_certificate_chains" {
  value       = module.acm_certificate.acm_existing_certificate_chains
  description = "Certificates forming the existing certificate's chain of trust."
}

output "acm_existing_certificate_statuses" {
  value       = module.acm_certificate.acm_existing_certificate_statuses
  description = "Status of the existing certificate."
}

output "acm_existing_certificate_tags" {
  value       = module.acm_certificate.acm_existing_certificate_tags
  description = "Tags assigned to the existing certificate."
}

output "route53_record_names" {
  value       = module.route53_record.route53_record_names
  description = "The name of the record."
}

output "route53_record_fqdns" {
  value       = module.route53_record.route53_record_fqdns
  description = "FQDN built using the zone domain and name."
}
