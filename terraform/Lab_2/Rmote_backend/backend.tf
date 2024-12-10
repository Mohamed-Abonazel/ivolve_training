terraform {
  backend "s3" {
    bucket = "ivolve-s3"   # Replace with your bucket name
    key    = "terraform/state.tfstate"
    region = "us-east-1"                     # Replace with your preferred AWS region
  }
}


