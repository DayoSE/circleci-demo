#!/bin/bash
unamestr=$(uname)
PS3='Please select an option from the above choices: '
options=("Cloud Breach S3"
        "EC2 SSRF"
        "Spring4Shell Lab"
        "Code to Cloud"
        "Quit")

#get public ip
IP=$(curl https://ipinfo.io/ip)

if [[ $unamestr == 'Darwin' ]]; then
    RANDOM_STRING=`echo $RANDOM | md5 | head -c 20;`
else
    RANDOM_STRING=`echo $RANDOM | md5sum | head -c 20;`
fi

select opt in "${options[@]}"
do
    case $opt in
        "Cloud Breach S3")
            echo "Cloud Breach S3"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3
            # create temp directory 
            mkdir $(pwd)/temp-lab
            mkdir $(pwd)/temp-lab/cloud_s3_breach-lab-server
            
            [ -d $(pwd)/temp-lab/cloud_s3_breach-lab-server/terraform ] && { echo "Directory Already Exist" && exit; }

            cp -r $(pwd)/cloud_s3_breach/terraform temp-lab/cloud_s3_breach-lab-server/
            cp -r $(pwd)/cloud_s3_breach/assets temp-lab/cloud_s3_breach-lab-server/
            cd $(pwd)/temp-lab/cloud_s3_breach-lab-server/terraform
            # terraform module install
            ssh-keygen -b 4096 -t rsa -f ./panw -q -N ""
            ls -la
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform init
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform apply -var cgid=$RANDOM_STRING -var cg_whitelist=$IP/32 --auto-approve
            break
            ;;
        "EC2 SSRF")
            echo "EC2 SSRF"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3
            
            # create temp directory 
            mkdir $(pwd)/temp-lab
            mkdir $(pwd)/temp-lab/ec2_ssrf-lab-server
            
            [ -d $(pwd)/temp-lab/ec2_ssrf-lab-server/terraform ] && { echo "Directory Already Exist" && exit; }

            cp -r $(pwd)/ec2_ssrf_breach/terraform temp-lab/ec2_ssrf-lab-server/
            cp -r $(pwd)/ec2_ssrf_breach/assets temp-lab/ec2_ssrf-lab-server/
            cd $(pwd)/temp-lab/ec2_ssrf-lab-server/terraform
            # terraform module install
            ssh-keygen -b 4096 -t rsa -f ./panw -q -N ""
            ls -la
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform init
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform apply -var cgid=$RANDOM_STRING -var cg_whitelist=$IP/32 --auto-approve
            break
            ;;
        "Spring4Shell Lab")
            echo "Spring4Shell Lab"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3
            
            # create temp directory 
            mkdir $(pwd)/temp-lab
            mkdir $(pwd)/temp-lab/spring4shell_cloud_breach
            
            [ -d $(pwd)/temp-lab/spring4shell_cloud_breach/terraform ] && { echo "Directory Already Exist" && exit; }

            cp -r $(pwd)/spring4shell_cloud_breach/terraform temp-lab/spring4shell_cloud_breach/
            cp -r $(pwd)/spring4shell_cloud_breach/vuln_app temp-lab/spring4shell_cloud_breach/
            cd $(pwd)/temp-lab/spring4shell_cloud_breach/terraform
            # terraform module install
            ssh-keygen -b 4096 -t rsa -f ./panw -q -N ""
            ls -la
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform init
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform apply -var cgid=$RANDOM_STRING -var cg_whitelist=$IP/32 --auto-approve
            break
            ;;
        "Code to Cloud")
            echo "Code to Cloud"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3
            
            # create temp directory 
            mkdir $(pwd)/temp-lab
            mkdir $(pwd)/temp-lab/code2cloud_cloud_breach
            mkdir $(pwd)/temp-lab/code2cloud_cloud_breach/infra 
            
            [ -d $(pwd)/temp-lab/code2cloud_cloud_breach/terraform ] && { echo "Directory Already Exist" && exit; }

            cp -r $(pwd)/code2cloud_cloud_breach/infra temp-lab/code2cloud_cloud_breach/
            cp -r $(pwd)/code2cloud_cloud_breach/app temp-lab/code2cloud_cloud_breach/
            cd $(pwd)/temp-lab/code2cloud_cloud_breach/infra
            
            # terraform module install
            ssh-keygen -b 4096 -t rsa -f ./panw -q -N ""
            ls -la
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform init
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform apply -var code2cloudid=$RANDOM_STRING -var code2cloud_whitelist=$IP/32 --auto-approve
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
