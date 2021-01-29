project = "Proj-05"
region = "us-east-1"
vpc-cidr = "192.168.1.0/24"
az-suffix = ["a", "b"]
public-subnets = ["192.168.1.0/27", "192.168.1.32/27"]
private-subnets = ["192.168.1.128/27","192.168.1.160/27"]

instance-type = "t2.micro"
instance-name = "webserver"
key-name = "Awskey"

sg-name = "bastian-sg"
sg_ingress_rules = {
  "1" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "2" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
}
sg-description = "Security Group for Bastian"

