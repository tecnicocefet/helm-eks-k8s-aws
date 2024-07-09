# modules/irsa_ebs_csi/main.tf

resource "aws_iam_role" "this" {
  name = "ebs-csi-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "ebs_csi_policy" {
  name        = "ebs-csi-policy"
  description = "Policy for EBS CSI driver"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:DeleteSnapshot",
          "ec2:Describe*",
          "ec2:DetachVolume"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_attach" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.ebs_csi_policy.arn
}

output "iam_role_arn" {
  value = aws_iam_role.this.arn
}
