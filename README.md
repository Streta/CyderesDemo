# Cyderes Demo for DevOps Skills Assessment Coding Challenge 

**Problem Statement**: Setup minikube on local host and create a pod running an exposed web server, show you are able to land on nginx web server on web browser

Using chocolately package manager on windows 11 pc, installed minikube through powershell CLI

`choco install minikube`

Installed kubectl to create cluster for NGINX web server deployement

`choco install kubernetes-cli`

Installed docker on windows 11 pc using link; https://www.docker.com/get-started/

After restarting pc, I used docker to start minikube on docker

`minikube start --driver=docker`

![image](https://github.com/user-attachments/assets/6093731b-00f3-4300-ac28-9c87655c833c)

Not to begin deploying NGINX web server

`kubectl create deployement nginx --image=nginx`

Using IP generated by minikube I was not able to route to the web locally on port 80 using my web browser as I was getting an error code 500 that the server encountered an unexpected condition preventing it from fulfilling the request.

`kubectl expose deployment nginx --type=NodePort ==port=80`

Windows firewall was disabled and I could still not land on nginx web server using port 80 on web browser

![{D1E4B743-2C17-4136-853D-94888FF09651}](https://github.com/user-attachments/assets/1490912d-64b1-4ee2-923f-c0940b171e5a)

The only resolution to solve this would be to port forward manually to expose the web server to my local machine and subnet mask

`kubectl port-forward service/nginx 8080:80`

After this was completed i manually entered localhost:8080 onto web browser URL and was able to land on nginx splash plage using google chrome web browser

![image](https://github.com/user-attachments/assets/6d05a2a6-0b48-4f0f-a48a-c93818573eac)

# End of Assessment problem #1

**Problem Statement**: Create terraform code to launch an AWS instance then output a property value from the instance to the CLI in plaintext

**Provider:** AWS 
&nbsp;

**Backend:** S3 Bucket
&nbsp;

**Resource:** EC2 Instance Virtual Machine
&nbsp;

**Data Object:** Instance ID
&nbsp;

**Output:** Instance ID on CLI in plaintext

Configured AWS to create user named “Cyderes” with EC2 & S3 full access permissions using IAM console

![image](https://github.com/user-attachments/assets/65f90df6-84f2-404b-aabd-c97d0f253983)

Configured AWS dashboard to make Bucket named "cyderes-bucket"

![image](https://github.com/user-attachments/assets/6a1576e5-c629-429f-9878-beead683f6d9)

Made directory for main.tf on windows PC for demo 

![image](https://github.com/user-attachments/assets/f3f7cff1-9a5c-4d19-af56-fcfb2697ef9b)

Created main.tf and then wrote code for it on VS code editor with terminal open (terraform code will be uploaded to git directory for review)

here is the tf code inline for preview 

`provider "aws" {  # region dedicated to US east coast (my region)
  region = "us-east-2"  
}`

`terraform {  # created basic s3 bucket on AWS, then preset region in this secion to us east
  backend "s3" {
    bucket = "cyderes-bucket"
    key    = "terraform.tfstate"
    region = "us-east-2"  
  }
}`

` 
data "aws_ami" "latest_amazon_linux" {  # created values for linux instance
  most_recent = true
  owners      = ["amazon"]
`
`  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}`

`resource "aws_instance" "example" {   # free tier of aws allows micro instance creations, enabled an example for output 
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
`
 ` tags = {
    Name = "example-instance"
  }
}`

`output "instance_id" {  # output for terraform to write out instance ID on cli when apply is run
  description = "The ID"
  value       = aws_instance.example.id
}`


After adding all this code above into a file called "main.tf" in VS code I was able to launch the terminal in underview and then initialize the terraform code and then apply it, thus exposing the ID of the S3 bucket virtual machine instance

![{D6A8B37C-075C-4F92-BE02-561801EF0CDA}](https://github.com/user-attachments/assets/83906941-5cd3-41f1-8b4e-57bf1e4d472a)

# End of Assessment problem #2

**Final Notes:**  If any further explanation is needed in this demonstration please feel free to slack me @ Roosevelt Mendieta and I will follow up with additional info
&nbsp;

Thank you for coming to my presentation! :)


