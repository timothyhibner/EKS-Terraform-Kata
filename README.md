"# EKS-Terraform-Kata" 
This kata is to practice building out a EKS cluster using Terrafrom.

Instead of typing Terraform loads of times in this documentation I will abbervate Terrafrom to TF


Notes: 
1. Getting AWS Credentials steup
  For this purpose I recommed taking the easy path and creating a IAM User with the AdministratorAccess policy attached. Then creating an access key for CLI access this is used by terraform to deploy locally.

2. Once this is done you will need to configure your credentials. 
AWS credential file is located here:
C:\Users\[user]\.aws\credentials

Sound look somenthing like this:

[TFDeploy]
# This key identifies your AWS account.  
# In this case it is terraform.deploy IAM user for account 575282423198 
aws_access_key_id = xxxxxxx
# Treat this secret key like a password. Never share it or store it in source
# control. If your secret key is ever disclosed, immediately use IAM to delete
# the key pair and create a new one.
aws_secret_access_key = xxxxxxxx

3. Creating the EKS cluster 

Then do the command before the terrafrom plan/apply.



export AWS_PROFILE=TFDeploy
terraform plan
terraform apply


4. About state files and tf locking files. Below describes the process.

It is highly recommended that you do not store the state file and the lock file locally.  Otherwise you risk getting out of sync with what is in AWS verses what is not.

To store Terraform state in S3 you need two things:

An S3 backend block in your Terraform config — tells Terraform where to read/write the .tfstate file.
A DynamoDB table (recommended) — provides state locking so two runs can't corrupt the state simultaneously.
The backend block would go in a backend.tf file and look like this:

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "eks-kata/terraform.tfstate"
    region         = "us-east-2"
    profile        = "TFDeploy"
    encrypt        = true

    # State locking via DynamoDB
    dynamodb_table = "terraform-state-lock"
  }
}
A few important things to know:

The S3 bucket and DynamoDB table must already exist before running terraform init — Terraform can't bootstrap its own backend. You'd create them manually or with a separate "bootstrap" Terraform config.
The key is just the path inside the bucket, so you can reuse one bucket across many projects by using different keys (e.g. eks-kata/terraform.tfstate, another-project/terraform.tfstate).
Encryption — encrypt = true enables server-side encryption at rest. You can also add a kms_key_id if you want to use a customer-managed KMS key.
Running terraform init after adding the backend will prompt you to migrate any existing local state into the bucket automatically.

5. I have went ahead and created a bootstrap TF that will configure this.
See the bootstrap folder.
To creat the S3 bucket and dynamoDB for the statefile and lock file do the following:
  cd bootstrap
  terraform init
  terraform apply

This unfortunately means the state file and the lock file will be on your local for this opperation.  So keep that in minde if you need to alter it later.   This is the perverbail chicken and egg problem.