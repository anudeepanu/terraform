terraform {
  backend "s3" {
    bucket = "endhuku"
    key = "vpc2"
    access_key = "accesskey"
    secret_key = "secretkey"
    region = "us-west-2"
  }
}

