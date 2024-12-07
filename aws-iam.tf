############## Iam Role & SSM Manager Policy ################


# IAM Role for SSM
resource "aws_iam_role" "ssm_role" {
  name = "ejb-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach SSM Managed Policy to the Role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

# Instance Profile for EC2
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ejb-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}
