# Project Structure
main.tf – Terraform config for VPC, EKS, and Bastion host  
variables.tf – Declares configurable variables  
terraform.tfvars – Sets variable values  
k8s_deployment.yaml – Kubernetes yaml file to deploy the simpleTimeService container  

# Step1: Installation on our local Machine(Linux Ubuntu)
Update system  
=> sudo apt update && sudo apt upgrade -y  
Install AWS CLI  
=> sudo apt install awscli -y  

Install kubectl  
=> curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"  
=> chmod +x kubectl  
=> sudo mv kubectl /usr/local/bin/  

Install Terraform  
=> sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl  
=> curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg   
=> echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs)  main" | sudo tee /etc/apt/sources.list.d/hashicorp.list  
=> sudo apt update  
=> sudo apt install terraform -y  

Install eksctl  
=> curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp  
=> sudo mv /tmp/eksctl /usr/local/bin  


AWS Authentication  
=> aws configure  
Enter AWS Access Key, Secret Key, Region (e.g., us-east-1), Output format(e.g., json)  

# Directory Structure
terraform/  
│  
├── main.tf   
├── variables.tf  
├── outputs.tf  
├── terraform.tfvars  
├── provider.tf  
├── k8s_deployment.yaml  
├── README.md  


# Step2: Deploy Infrastructure
Clone this repo:  
=> git clone https://github.com/PIKESHRI/Particle41-Devops-Challenge/terraform   
=> cd terraform  

Set your SSH key name in terraform.tfvars:  
key_name = "your-keypair-name"  

Deploy with Terraform:  
=> terraform init  
=> terraform apply  

Terraform will create:  
1. VPC with 2 public and 2 private subnets  
2. EKS cluster in private subnets  
3. Bastion EC2 host in public subnet  

# Step3: Access Bastion Host  
1. Get Bastion IP:  
   => terraform output  
3. SSH into it:  
   => ssh -i your-key.pem ubuntu@<bastion-ip>  

# Step4: Set Up EKS Inside Bastion  
1. On the EC2 instance, configure AWS CLI:  
   => aws configure  
3. Confirm kubectl is installed (it’s in user data in main.tf for bastion host creation):  
   => kubectl version --client  
5. Connect to EKS:  
   => aws eks --region us-east-1 update-kubeconfig --name simpletimeservice-cluster  
   => kubectl get nodes  

# Step5: Deploy the App  
1. Copy Kubernetes deployment file(k8s_deployment.yaml) from local machine to the bastion host  
  => scp -i your-key.pem k8s_deployment.yaml ubuntu@<bastion-ip>:~  
2. On the Bastion EC2:  
   => kubectl apply -f k8s_deployment.yaml  
   => kubectl get svc  
3. Access the app using the LoadBalancer EXTERNAL-IP.  
   http://EXTERNAL-IP  







