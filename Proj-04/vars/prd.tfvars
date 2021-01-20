region        = "us-east-1"
vpc-cidr      = "192.168.2.0/24"
project       = "Proj04"
azs           = ["a", "b", "c", "d"]
public-sn     = ["192.168.2.0/27", "192.168.2.32/27", "192.168.2.64/27", "192.168.2.96/27"]
private-sn    = ["192.168.2.128/27", "192.168.2.160/27", "192.168.2.192/27", "192.168.2.224/27"]
public-tls    = [443, 22, 80]
public-subnets   = ["146.184.0.84/32", "173.56.13.157/32"]
instance-type = "t2.micro"
key-name      = "Awskey"
