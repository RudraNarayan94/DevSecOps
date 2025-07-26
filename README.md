# Task 1: Currency Converter Frontend – DevSecOps Pipeline

This repository hosts the frontend (React) application and infrastructure-as-code (Terraform) needed to deploy the app via a fully automated DevSecOps pipeline on AWS.

## 🌐 Live Demo

[http://13.234.112.221](http://13.234.112.221)

---

## 🛠️ Stack

- **React** – Frontend Framework
- **AWS EC2** – Hosting the app
- **AWS S3** – Artifact storage for CodePipeline
- **AWS CodePipeline** – CI/CD pipeline
- **AWS CodeBuild** – Build React app
- **AWS CodeDeploy** – Deploy app to EC2
- **Terraform** – Infrastructure as Code (IaC)

---

## ⚙️ Directory Structure

```
DevSecOps/
├── App/                    # React frontend application
├── Terraform/
│   ├── main.tf            # Main infrastructure configuration
│   ├── variables.tf       # Variable definitions
│   ├── backend.tf         # S3 backend configuration
│   └── output.tf          # Output values
├── buildspec.yml          # CodeBuild configuration
├── appspec.yml            # CodeDeploy configuration
└── scripts/
    └── install.sh         # Deployment scripts
```

---

## 🚀 Setup Instructions

### 1. Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 0.14 installed
- SSH key pair generated
- GitHub Personal Access Token

### 2. Generate SSH Key Pair

```bash
ssh-keygen -t rsa -b 2048 -f ~/Desktop/DevSecOps/devsecops-keypair
```

### 3. Configure Terraform Variables

Create `Terraform/terraform.tfvars`:

```hcl
project_name       = "Currency-Converter"
bucket_name        = "currency-converter-terraform-state-<your-unique-id>"
aws_region         = "ap-south-1"
ami_id             = "ami-0e670eb768a5fc3d4"  # Amazon Linux 2023
instance_type      = "t3.micro"
key_name           = "devsecops-keypair"
public_key_path    = "/path/to/devsecops-keypair.pub"
github_owner       = "YourGitHubUsername"
github_repo        = "Currency-Converter"
github_branch      = "main"
github_token       = "your_github_pat"
instance_tag_key   = "Name"
instance_tag_value = "webserver"
```

### 4. Deploy Infrastructure

```bash
cd Terraform/
terraform init
terraform plan
terraform apply
```

### 5. Verify Deployment

After deployment completes:

- Check CodePipeline status in AWS Console
- Access the app at the EC2 public IP
- Monitor CodeDeploy deployment logs

---

## 🏗️ Infrastructure Components

### Networking

- **VPC**: Custom VPC with CIDR `10.0.0.0/16`
- **Subnet**: Public subnet in `ap-south-1a`
- **Internet Gateway**: For public internet access
- **Security Group**: Allows HTTP (80) and SSH (22)

### Compute

- **EC2 Instance**: t3.micro running Amazon Linux 2023
- **Key Pair**: For SSH access
- **IAM Role**: EC2 instance profile with S3 access

### CI/CD Pipeline

- **CodePipeline**: 3-stage pipeline (Source → Build → Deploy)
- **CodeBuild**: Builds React app using `buildspec.yml`
- **CodeDeploy**: Deploys to EC2 using `appspec.yml`
- **S3 Bucket**: Stores pipeline artifacts

---

## 🧪 Testing

Once deployment completes:

```bash
# Get EC2 public IP
terraform output ec2_public_ip

# Test the application
curl http://<ec2-public-ip>
```

---

## 🧪 Infrastructure Testing with Terratest

To validate the Terraform modules using Terratest:

### 1. Install Prerequisites

Ensure you have Go (for Terratest), Terraform, and Git installed.

### 2. Project Structure

Organize your project like this:

```
DevSecOps/
├── Terraform/                     # Your Terraform code (main.tf, variables.tf, etc)
└── test/                          # Terratest files
    └── terraform_pipeline_test.go
```

### 3. Write the Test Code

Create `test/terraform_pipeline_test.go`:

```go
package test

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformPipeline(t *testing.T) {
  t.Parallel()

  tf := &terraform.Options{
    TerraformDir: "../Terraform", // Path to your Terraform directory
  }

  defer terraform.Destroy(t, tf)             // Cleanup resources after test
  terraform.InitAndApply(t, tf)             // Run terraform init + apply

  // Test pipeline creation
  pipelineName := terraform.Output(t, tf, "pipeline_name")
  assert.NotEmpty(t, pipelineName)

  // Test EC2 instance creation
  ec2PublicIP := terraform.Output(t, tf, "ec2_public_ip")
  assert.NotEmpty(t, ec2PublicIP)
}
```

### 4. Initialize Go Project

From the project root directory:

```bash
go mod init currency-converter-test
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/stretchr/testify/assert
```

### 5. Run the Test

From the root directory:

```bash
go test ./test -v -timeout 30m
```

This will:

- Initialize and apply your Terraform configuration
- Capture and assert the outputs (`pipeline_name` and `ec2_public_ip`)
- Automatically destroy resources after testing

### 6. Test Configuration

For comprehensive testing, you can also create a test-specific `terraform.tfvars` file in the `test/` directory with test values.

---

## 📋 Pipeline Stages

1. **Source**: Pulls code from GitHub repository
2. **Build**: Runs `npm install` and `npm run build`
3. **Deploy**: Uses CodeDeploy to deploy to EC2 instance

---

## 🔧 Troubleshooting

### Common Issues

- **S3 bucket name conflicts**: Ensure bucket name is globally unique
- **GitHub token permissions**: Token needs `repo` scope
- **EC2 instance not accessible**: Check security group rules
- **CodeDeploy agent**: Verify agent is running on EC2

### Useful Commands

```bash
# Check Terraform state
terraform show

# Destroy infrastructure
terraform destroy

# SSH into EC2 instance
ssh -i devsecops-keypair ec2-user@<ec2-public-ip>
```

---

## 📌 Notes

- Default port 80 (HTTP) is open to public in Security Group
- CodeDeploy agent is automatically installed via user data
- S3 bucket versioning is enabled for artifact storage
- GitHub Version 1 provider is used (consider upgrading to CodeStar Connection)

---

## 🔐 Security Considerations

- SSH access is open to `0.0.0.0/0` (consider restricting to your IP)
- IAM policies follow least privilege principle
- S3 bucket has versioning enabled
- EC2 instance uses IAM roles instead of access keys

---

## 👨‍💻 Author

**Rudra Narayan**

- 🔗 [LinkedIn](https://linkedin.com/in/your-profile)
- 📧 [Email](mailto:your-email@example.com)

---

## 📜 License

MIT License - see LICENSE file for details
