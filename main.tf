provider "aws" {  # region dedicated to US east coast (my region)
  region = "us-east-2"  
}

terraform {  # created basic s3 bucket on AWS, then preset region in this secion to us east
  backend "s3" {
    bucket = "cyderes-bucket"
    key    = "terraform.tfstate"
    region = "us-east-2"  
  }
}

data "aws_ami" "latest_amazon_linux" {  # created values for linux instance
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example" {   # free tier of aws allows micro instance creations, enabled an example for output 
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

output "instance_id" {  # output for terraform to write out instance ID on cli when apply is run
  description = "The ID"
  value       = aws_instance.example.id
}