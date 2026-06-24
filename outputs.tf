output "acm_certificate_ids" {
  value       = module.acm_certificate.acm_certificate_ids
  description = "The ID of the certificate"
}

output "acm_certificate_arns" {
  value       = module.acm_certificate.acm_certificate_arns
  description = "The ARN of the certificate"
}

output "acm_certificate_domain_names" {
  value       = module.acm_certificate.acm_certificate_domain_names
  description = "The domain name for which the certificate is issued"
}

output "acm_certificate_domain_validation_options" {
  value       = module.acm_certificate.acm_certificate_domain_validation_options
  description = "Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g., if SANs are defined. Only set if DNS-validation was used."
}

output "acm_certificate_statuses" {
  value       = module.acm_certificate.acm_certificate_statuses
  description = "Status of the certificate."
}

output "acm_certificate_tags_all" {
  value       = module.acm_certificate.acm_certificate_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "acm_certificate_validation_ids" {
  value       = module.acm_certificate_validation.acm_certificate_validation_ids
  description = "The time at which the certificate was issued"
}

output "route53_record_names" {
  value       = module.route53_record.route53_record_names
  description = "The name of the record."
}

output "route53_record_fqdns" {
  value       = module.route53_record.route53_record_fqdns
  description = "FQDN built using the zone domain and name."
}
