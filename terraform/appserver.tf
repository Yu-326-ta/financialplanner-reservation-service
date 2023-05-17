# key pair
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("./key/fptask-dev-keypair.pub")

  tags = {
    Name    = "${var.project}-${var.environment}-keypairß"
    Project = var.project
    Env     = var.environment
  }
}

# ec2
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.fptask_sg.id,
  ]
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name    = "${var.project}-${var.environment}-app-ec2"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}
