require "refile/s3"

case
when Rails.env.production?
  aws = {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region:            "us-east-1",
    bucket:            "com-wavetronix-uploads"
  }
  Refile.cdn_host = "//www.wavetronix.com"
when Rails.env.staging?
  aws = {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region:            "us-east-1",
    bucket:            "com-wavetronix-staging-glados-uploads"
  }
  Refile.cdn_host = "//glados.staging.wavetronix.com"
end

if Rails.env.production? || Rails.env.staging?
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)
end
