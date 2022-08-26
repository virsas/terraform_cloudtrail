# terraform_cloudtrail

Terraform module to configure cloudtrail

## Dependencies

- IAM Role  <https://github.com/virsas/terraform_iam_role>
- CW Group  <https://github.com/virsas/terraform_cw_group>
- KMS  <https://github.com/virsas/terraform_kms>
- S3  <https://github.com/virsas/terraform_s3_bucket>

## Terraform example

``` terraform
#######################
# Cloudtrail variable
#######################
variable "ct-example" { 
    default = {
        name          = "example-cloudtrail"
        logging       = true
        globalevents  = true
        logvalidation = true
        multiregion   = true
        multiorg      = false
        logretention  = 180
        bucket_prefix = ""
    }
}

#######################
# Cloudtrail module
#######################
module "ct-example" {
  source    = "git::https://github.com/virsas/terraform_cloudtrail.git?ref=v1.0.0"
  instance  = var.ct-example
  bucket    = module.s3_logs.id
  kms       = module.kms-ct.arn
  cwgroup   = module.cw-ct.arn
  cwrole    = module.iam-role-ct.arn
}
```
