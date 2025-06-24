# Create a "base" Security Group for EC2 instances
resource "aws_ro" "name" {

}

resource "aws_security_group" "sg_base_ec2" {
  name        = "aws_sg_base_ec2"
  vpc_id      = aws_vpc.customVPC.id
  description = "Base security Group for EC2 instances"
}

# Create a "base" Security Group for RS
resource "aws_security_group" "sg_rds" {
  name        = "aws_sg_rds"
  vpc_id      = aws_vpc.customVPC.id
  description = "Base security Group for RDS"

  ingress {
    description     = "Allow MySQL from EC2 SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_base_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Allow access from the Internet to port 22 (SSH) in the Public EC2 instances
resource "aws_security_group_rule" "sr_internet_to_ec2_ssh" {
  security_group_id = aws_security_group.sg_base_ec2.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.public_ip}/32"]
  description       = "Allow access from the Internet to port 22 (SSH)"
}

# Allow access from the Internet for ICMP protocol (e.g. ping) to the EC2 instances
resource "aws_security_group_rule" "sr_internet_to_ec2_icmp" {
  security_group_id = aws_security_group.sg_base_ec2.id
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"] # Internet
  description       = "Allow access from the Internet for ICMP protocol"
}

# Allow all outbound traffic to the Internet
resource "aws_security_group_rule" "sr_all_outbund" {
  security_group_id = aws_security_group.sg_base_ec2.id
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic to Internet"
}

# Create a Security Group for the Front end Server
resource "aws_security_group" "sg_front_end" {
  name        = "aws_sg_front_end"
  vpc_id      = aws_vpc.customVPC.id
  description = "Front end Server Security"
}

# Allow access from the Internet to port 80 HTTP in the EC2 instances
resource "aws_security_group_rule" "sr_internet_to_front_end_http" {
  security_group_id = aws_security_group.sg_front_end.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Internet
  description       = "Access from the Internet to port 80 in the EC2 instances"
}

# Create a Security Group for the Back-end Server
resource "aws_security_group" "sg_back_end" {
  name        = "aws_sg_back_end"
  vpc_id      = aws_vpc.customVPC.id
  description = "Back-end Server Security"
}

# Allow access from the front-end to port 8080 in the back-end API
resource "aws_security_group_rule" "sr_front_end_to_api" {
  security_group_id        = aws_security_group.sg_back_end.id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_front_end.id
  description              = "Allow access from the front-end to port 8080 in the back-end API"
}

# Upload a Private Key Pair for SSH Instance Authentication
resource "aws_key_pair" "kp_config_user" {
  key_name   = "kp_config_user"
  public_key = file("id_rsa.pub")
}


resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1" # GitHub's trusted thumbprint
  ]
}


data "aws_iam_policy_document" "github_oidc_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo_owner}/${var.repo_name}:*"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsTerraformRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
  depends_on = [
    aws_iam_openid_connect_provider.github
  ]
}

resource "aws_iam_role_policy_attachment" "terraform_permissions" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}