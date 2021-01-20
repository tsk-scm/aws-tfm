project = "Proj-05"
region = "us-east-1"
vpc-cidr = "192.168.1.0/24"
az-suffix = ["a", "b"]
public-subnets = ["192.168.1.0/27", "192.168.1.32/27"]
private-subnets = ["192.168.1.128/27","192.168.1.160/27"]

instance-type = "t2.micro"
instance-name = "webserver"
key-name = "Awskey"

