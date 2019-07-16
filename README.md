## Mediawiki App Setup

Setup of MediaWiki Application.

Following are the modules for Terraform 

1. VPC (Includes , VPC + Subnet + Routes + Gateways)
2. RDS (MariaDB for App)
3. EC2 (Servers + LoadBalancers)

Terraform uses Ansible to setup the MediaWiki installation 




## Process to run the above code. 

CentOS-7 machine has been used to setup it and following commands will work. 

1. Install Docker and start the service 

```
# setenforce 0
# yum install docker -y 
# systemctl enable docker 
# systemctl start docker 
```

2. Run the following container with the given command. 

```
# docker run -d -p 8080:8080 -p 50000:50000 -e AWS_ACCESS_KEY_ID=<ACCESS_KEY_ID> -e AWS_SECRET_ACCESS_KEY=<ACCESS_SECRET_KEY>  -e AWS_DEFAULT_REGION="us-east-1" -e RDS_USERNAME=<DBUSER> -e RDS_PASSWORD=<DBPASSWORD> rkalluru/jenkins-tw:v1

```

Replace the values with actual values and then run. 
