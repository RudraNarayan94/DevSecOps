output "pipeline_name" {
  value = aws_codepipeline.pipeline.name
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}
