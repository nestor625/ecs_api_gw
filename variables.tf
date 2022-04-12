#Project
variable "project_name" {
  description = "Project Name"
}

#VPC
variable "region" {
  description = "AWS Region"
}

variable "az_count" {
  type        = number
  description = "AZ Count"
}


#RDS
variable "rds_username" {
  description = "RDS Username"
}

variable "rds_password" {
  description = "RDS Password"
}

variable "rds_version" {
}

variable "instance_class" {
}

#S3
variable "s3_name" {
  description = "S3 Bucket name"
}

variable "index_document" {
  description = "S3 Bucket name"
  default     = "n0625"
}

#tag value
variable "tag_env" {
  description = "Environment tag Value"
}

variable "tag_proj" {
  description = "Project tag Value"
}


#ecs
variable "ECS_INSTANCE_TYPE" {
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0a5e7c9183d1cea27"
    us-west-2 = "ami-0794df61693647a62"
    eu-west-1 = "ami-c8337dbb"
    ap-east-1 = "ami-023561d20388aeb53"
  }
}

#bastion
variable "ubuntu" {
  type = map(string)
  default = {
    us-west-2 = "ami-0359b3157f016ae46"
    #"ami-0892d3c7ee96c0bf7"
    us-east-1 = "ami-04505e74c0741db8d"
    ap-east-1 = "ami-0b981d9ee99b28eba"
  }
  
}


#apigw
variable "apigw_stage_name" {
  
}

variable "ubuntu_INSTANCE_TYPE" {
}

variable "keypair_name_ec2" {
}

variable "image" {
}

variable "coter_port" {
}

variable "cpu" {  
}

variable "memory" {
}

# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html



#ses
variable "ses_email" {
}

#endpoint
variable "service_name" {
}





#ses:"Statement": [{"Effect":"Allow","Action":"ses:SendRawEmail","Resource":"*"}]
#ses-smtp-user.20220315-165124

#openssl s_client -crlf -quiet -starttls smtp -connect email-smtp.us-west-2.amazonaws.com:465