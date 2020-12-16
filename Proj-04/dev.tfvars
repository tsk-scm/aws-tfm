region        = "us-east-1"
vpc-cidr      = "192.168.1.0/24"
project       = "Proj04"
azs           = ["a", "b", "c", "d"]
public-sn     = ["192.168.1.0/27", "192.168.1.32/27", "192.168.1.64/27", "192.168.1.96/27"]
private-sn    = ["192.168.1.128/27", "192.168.1.160/27", "192.168.1.192/27", "192.168.1.224/27"]
public-tls    = [443, 22, 80]
public-cidr   = "146.184.0.84/32"
instance-type = "t2.micro"
key-name      = "Awskey"
