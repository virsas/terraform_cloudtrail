provider "aws" {
  region = var.region
}

resource "aws_cloudtrail" "ct" {
  name                          = var.instance.name
  s3_bucket_name                = var.bucket
  s3_key_prefix                 = var.instance.bucket_prefix
  include_global_service_events = var.instance.globalevents
  enable_log_file_validation    = var.instance.logvalidation
  is_multi_region_trail         = var.instance.multiregion
  is_organization_trail         = var.instance.multiorg
  enable_logging                = var.instance.logging
  kms_key_id                    = var.kms
  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }
  insight_selector {
    insight_type = "ApiCallRateInsight"
  }
  cloud_watch_logs_group_arn = "${var.cwgroup}:*"
  cloud_watch_logs_role_arn = var.cwrole
}
