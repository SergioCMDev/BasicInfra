resource "aws_db_instance" "wordpress_db" {
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine_version          = "8.0"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [aws_security_group.sg_rds.id]


  tags = {
    Environment = "dev"
    Tier        = "free"
    name        = "DB_Wordpress"
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.privateSubnetExample1.id, aws_subnet.privateSubnetExample2.id]
}