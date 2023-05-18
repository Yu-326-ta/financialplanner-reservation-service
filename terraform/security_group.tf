# security group
resource "aws_security_group" "fptask_sg" {
  name        = "${var.project}-${var.environment}-sg"
  description = "security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "fptask_sg_in_ssh" {
  security_group_id = aws_security_group.fptask_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "fptask_sg_in_http" {
  security_group_id = aws_security_group.fptask_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
