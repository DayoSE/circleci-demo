#!/bin/bash
# Bash Menu Script Example

#get public ip
IP=$(curl https://ipinfo.io/ip)

PS3='Please select lab option from below choices: '
options=("Destroy Cloud Breach S3"
        "Destroy EC2 SSRF"
        "Spring4Shell Lab"
        "Code to Cloud"
        "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Destroy Cloud Breach S3")
            echo "Cloud Breach S3"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3

            [ -d $(pwd)/temp-lab/cloud_s3_breach-lab-server/terraform ] || { echo "Directory Doesn't Exist" && exit; }

            cd $(pwd)/temp-lab/cloud_s3_breach-lab-server/terraform
            # destroy terraform command
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform destroy -var cgid=wifu8rhr8fn -var cg_whitelist=$IP/32 --auto-approve
            
            if [ $? -eq 0 ]; then
                cd ../../../
                mkdir -p $(pwd)/archive
                time_stamp=$(date +%Y-%m-%d-%T)
                mkdir -p $(pwd)/archive/${time_stamp} 
                mv $(pwd)/temp-lab/cloud_s3_breach-lab-server $(pwd)/archive/${time_stamp}/
            else
                echo "Got error in terraform script"
                exit
            fi
            break
            ;;
        "Destroy EC2 SSRF")
            echo "EC2 SSRF"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3

            [ -d $(pwd)/temp-lab/ec2_ssrf-lab-server/terraform ] || { echo "Directory Doesn't Exist" && exit; }

            cd $(pwd)/temp-lab/ec2_ssrf-lab-server/terraform
            # destroy terraform command
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform destroy -var cgid=wifu8rhr8fn -var cg_whitelist=$IP/32 --auto-approve
            
            if [ $? -eq 0 ]; then
                cd ../../../
                mkdir -p $(pwd)/archive
                time_stamp=$(date +%Y-%m-%d-%T)
                mkdir -p $(pwd)/archive/${time_stamp} 
                mv $(pwd)/temp-lab/ec2_ssrf-lab-server $(pwd)/archive/${time_stamp}/
            else
                echo "Got error in terraform script"
                exit
            fi
            break
            ;;

        "Spring4Shell Lab")
            echo "Spring4Shell Lab"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3

            [ -d $(pwd)/temp-lab/spring4shell_cloud_breach/terraform ] || { echo "Directory Doesn't Exist" && exit; }

            cd $(pwd)/temp-lab/spring4shell_cloud_breach/terraform
            # destroy terraform command
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform destroy -var cgid=wifu8rhr8fn -var cg_whitelist=$IP/32 --auto-approve
            
            if [ $? -eq 0 ]; then
                cd ../../../
                mkdir -p $(pwd)/archive
                time_stamp=$(date +%Y-%m-%d-%T)
                mkdir -p $(pwd)/archive/${time_stamp} 
                mv $(pwd)/temp-lab/spring4shell_cloud_breach $(pwd)/archive/${time_stamp}/
            else
                echo "Got error in terraform script"
                exit
            fi
            break
            ;;

        "Code to Cloud")
            echo "Code to Cloud"
            read -p "Access Key ID [Required]:" n1
            read -p "Secret Access Key: [Required]:" n2
            read -p "AWS session token: [Optional]:" n3

            [ -d $(pwd)/temp-lab/code2cloud_cloud_breach/infra ] || { echo "Directory Doesn't Exist" && exit; }

            cd $(pwd)/temp-lab/code2cloud_cloud_breach/infra
            # destroy terraform command
            AWS_ACCESS_KEY_ID=$n1 AWS_SECRET_ACCESS_KEY=$n2 AWS_SESSION_TOKEN=$n3 terraform destroy -var code2cloudid=wifu8rhr8fn -var code2cloud_whitelist=$IP/32 --auto-approve
            
            if [ $? -eq 0 ]; then
                cd ../../../
                mkdir -p $(pwd)/archive
                time_stamp=$(date +%Y-%m-%d-%T)
                mkdir -p $(pwd)/archive/${time_stamp} 
                mv $(pwd)/temp-lab/code2cloud_cloud_breach $(pwd)/archive/${time_stamp}/
            else
                echo "Got error in terraform script"
                exit
            fi
            break
            ;;

        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done