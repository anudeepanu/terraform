terraform {
  backend "s3" {
    bucket = "endhuku"
    key = "keypair"
    access_key = "accesskey"
    secret_key = "secret-key"
    region = "us-west-2"
  }
}

