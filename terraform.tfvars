#Project
project_name = "nestor"


#VPC
region   = "us-west-2"
az_count = 2


#s3
s3_name = "project-dev-storage-bucket"



#RDS
instance_class = "db.m5.large"
rds_version    = "15.00.4153.1.v1"
rds_username   = "mssql"
rds_password   = "baTL7_=BRl8u"


#ecs
ECS_INSTANCE_TYPE   = "t2.micro"
image               = "vad1mo/hello-world-rest"
coter_port          = 5050
cpu                 = 256
memory              = 256


#ses
ses_email = "nestor20010625@gmail.com"


#tag
tag_env  = "test"
tag_proj = "nestor625"


#Bastion Host
ubuntu_INSTANCE_TYPE = "t2.micro"
keypair_name_ec2 = "ubuntu_key"


#endpoint
service_name = "com.amazonaws.us-west-2.s3"


#apige
apigw_stage_name = "nestor"