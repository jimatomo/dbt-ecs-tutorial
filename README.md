# dbt-ecs-tutorial
tutorial for dbt (data build tool) with ECS on Fargate


<br>

## Dependency
* AWS CLI v2  
* Terraform

<br>

## Setup
AWS CloudShell is recommended.
After creating your environment, execute below
```
# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Verigy the installation
# If you get an error that terraform could not be found, your PATH environment variable was not set up properly.
terraform version

# Clone
git clone https://github.com/jimatomo/dbt-ecs-tutorial.git

# presetting (Create Terraform Backend)
cd dbt-ecs-tutorial/presettings/
./presetting.sh

# terraform apply
cd ../terraform/projects
terraform init
terraform plan
terraform apply
```

<br>

## Usage
Please Read Zenn book  
[Zenn book](https://zenn.dev/jimatomo)  
 (I'm writing now ...)  

<br>

## Clean
After handson, Clean up your AWS environment
```
# From top directory
pwd

# Clean up environment created by Terraform 
cd ../projects

terraform destroy
```

Delete Terraform Backend Cloudformation Stack on Management Console. ( Stack Name: <b>terraform_backend_s3</b> )
<br>

https://console.aws.amazon.com/cloudformation/

<br>

## References
[AWS CLI v2 Refference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html)  
[Terraform Language Docs](https://www.terraform.io/docs/language/index.html)
[Terraform aws modules](https://registry.terraform.io/providers/hashicorp/aws/latest)
<br>

## License
Copyright (c) 2021 jimatomo  
This software is released under the MIT License  
https://opensource.org/licenses/mit-license.php
