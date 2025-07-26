package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCurrencyConverterPipeline(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../Terraform", // Update if your folder is named differently
		VarFiles:     []string{"../Terraform/terraform.tfvars"},
	}

	defer terraform.Destroy(t, terraformOptions) // Cleanup after test
	terraform.InitAndApply(t, terraformOptions)  // Deploy Terraform infra

	// Validate CodePipeline name is correctly created
	pipelineName := terraform.Output(t, terraformOptions, "pipeline_name")
	assert.NotEmpty(t, pipelineName)
}
