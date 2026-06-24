<!-- markdownlint-disable -->
[![Release](https://img.shields.io/github/v/release/thecloudsolutions/terraform-aws-acm-module?style=for-the-badge&color=6150E8)](https://github.com/thecloudsolutions/terraform-aws-acm-module/releases)
[![Commit](https://img.shields.io/github/last-commit/thecloudsolutions/terraform-aws-acm-module?style=for-the-badge&color=FF9800)](https://github.com/thecloudsolutions/terraform-aws-acm-module/commits)
[![Issues](https://img.shields.io/github/issues/thecloudsolutions/terraform-aws-acm-module?style=for-the-badge&color=BB019E)](https://github.com/thecloudsolutions/terraform-aws-acm-module/issues)
[![Terraform](https://img.shields.io/badge/terraform-1.5.5-%20?style=for-the-badge&color=009FD2)](https://github.com/hashicorp/terraform/blob/v1.5/CHANGELOG.md#155-august-9-2023)
[![License](https://img.shields.io/github/license/thecloudsolutions/terraform-aws-acm-module?style=for-the-badge&color=3FB950)](https://github.com/thecloudsolutions/terraform-aws-acm-module/blob/main/LICENSE)

# terraform-aws-acm-module

[![Cloud Solutions Banner][banner]](https://thecloudsolutions.com/)

[![Sponsor Us](https://img.shields.io/badge/sponsor_us-FF9800?style=for-the-badge)](https://github.com/sponsors/thecloudsolutions)
[![Hire Us](https://img.shields.io/badge/hire_us-009FD2?style=for-the-badge)](https://thecloudsolutions.com/contact-us)
[![Maintained By](https://img.shields.io/badge/maintained_by-Cloud_Solutions-6150E8?style=for-the-badge)](https://thecloudsolutions.com/)

## Description

A Terraform module that provisions AWS Certificate Manager certificates with Route 53 DNS validation into a unified, easy-to-use interface.

## Variable Naming

In all Cloud Solutions **components** and **modules**, we intentionally use the _map suffix for input variables that accept map(object(...)).

For example:
```hcl
variable "rds_map" {
  type        = map(object({ ... }))
  description = "Defines multiple RDS instances keyed by logical name."
}
```
⚠️ This is a deliberate deviation from [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/syntax/style).
We fully acknowledge that this naming convention does not follow the Terraform style guide, which recommends naming variables based on what they represent, not how they're implemented. We understand this, and want to emphasize:
1. This is a deliberate, informed decision, not an oversight.
2. Our primary goal is clarity and consistency for developers using our modules.
3. The intent is to give users immediate understanding of what kind of structure they're supplying.

✅ Why we made this decision (for our components and modules only)
This convention exists only within our components and modules structure. Here's why it works well for us:
1. Instant clarity for users - The _map suffix immediately signals that the variable supports multiple instances, each keyed by name. This avoids confusion around whether a variable is singular or plural.
2. Uniformity across all resources - Instead of struggling with awkward plurals (like kmses, rdses, vpcs, cloudfronts, account_managements) or inconsistent suffixes (_configs, _definitions, etc.), we use one simple, predictable pattern.
3. Avoids naming collisions - The _map suffix never conflicts with native Terraform or AWS resource types.
4. Future-proof for contributors - When contributors see _map, they can safely assume the structure is a map(object(...)) without checking variables.tf.

🙌 What this means for contributors
If you're contributing to Cloud Solutions components or modules, please:

1. Use the _map suffix when introducing a new map(object(...)) variable.
2. Follow the naming pattern consistently: rds_map, vpc_map, cloudfront_map, etc.
3. Don't apply this convention to Terraform projects outside components or modules - it's a local convention, not a global best practice.

If you have strong opinions or ideas for evolving this standard, you're welcome to open a discussion.

## Usage

```hcl
module "terraform-aws-acm-module" {
  source = "thecloudsolutions/terraform-aws-acm-module"
  # Cloud Solutions recommends to pin every module to a specific version
  # version = "x.x.x"

  # Required variables
  acm_map = {
    key = <value>
  }
}
```

> [!IMPORTANT]
> In our examples we don't pin modules to specific versions to keep the documentation aligned with the latest releases.
> However, for your own projects, we recommend to pin each module to the exact version you're using. This approach helps maintain the stability of your infrastructure.
> Additionally, adopting a structured process for version updates will help prevent unexpected changes.

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

## Quick Start

The project is under active development, and we welcome all contributors! 🎉
  
Before you start, please review our [Contributor Guidelines](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) to understand the expectations and processes.
  
Follow these steps to get started:
  
---
  
### 1. **Fork the Repository**
- Click the **"Fork"** button on the repository's GitHub page to create a copy under your GitHub account.

> [!TIP]
> If you're new to GitHub, check out the [GitHub Docs](https://docs.github.com/en/get-started) to familiarize yourself with key concepts like forking, branching, and pull requests.
  
### 2. **Clone the Fork**
- Clone your fork to your local machine using:
  ```bash
  git clone https://github.com/<your-username>/<repository-name>.git
  ```
  
### 3. **Create a Branch**
- Create a new branch for your contribution:
  ```bash
  git checkout -b your-feature-name
  ```
  
### 4. **Make Changes**
- Implement your changes in the codebase.
- Ensure you follow the project's style guide and standards.
  
> [!WARNING]
> Always adhere to the project's coding standards and best practices outlined in the [CONTRIBUTING.md](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) file.
    
### 5. **Test Your Changes**
- Run tests to verify your changes locally.
- Follow any project-specific testing instructions.
    
### 6. **Commit Your Changes**
- Stage and commit your changes with a clear and concise message:
  ```bash
  git add .
  git commit -m "Add description of the change"
  ```

> [!NOTE]
> Use meaningful commit messages in the present tense (e.g., "Add feature X" instead of "Added feature X").
  
### 7. **Push Your Branch**
- Push your branch to your fork:
  ```bash
  git push origin your-feature-name
  ```
    
### 8. **Open a Pull Request (PR)**
- Navigate to the original repository and click the **"New Pull Request"** button.
- Select your branch and submit your PR following the [Pull Request template](https://github.com/thecloudsolutions/.github/blob/main/.github/PULL_REQUEST_TEMPLATE/pull_request_template.md).
- Use keywords like `Closes #123` to link your PR to a related issue.
  
### **🎉 Congratulations, you’ve made your first contribution! 🎉**  
We appreciate your effort and look forward to reviewing your work.

## About Us

**Cloud Solutions: Innovating Open Source for AWS & DevOps**

Cloud Solutions creates and maintains free, open-source tools to help startups thrive in the AWS Cloud and DevOps space. Our mission is to make advanced technology accessible to businesses of all sizes.

With years of experience and a commitment to innovation, we design solutions that simplify workflows, encourage collaboration, and drive growth - removing cost barriers along the way. Every contribution brings us closer to a future where technology empowers all.

Your support makes everything we do possible.

Thank you for being part of our journey to empower innovation and build a stronger Open Source future!

## Contributing

The project is under active development, and we welcome all contributors! 🎉 

Before you start, please review our [Contributor Guidelines](CONTRIBUTING.md) to understand the expectations and processes.

## Blog

Link to our [blog](https://thecloudsolutions.com/blog), where you can explore in-depth articles. Gain valuable insights and expert analysis on AWS cloud solution strategies and trends.

## License

The project is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## Copyrights

Copyright © 2020-2026 [Cloud Solutions](https://thecloudsolutions.com)

[banner]: https://github.com/thecloudsolutions/.github/blob/main/profile/banner.png