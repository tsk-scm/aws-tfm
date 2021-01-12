project = "Proj-05"
region = "us-east-1"
vpc-cidr = "192.168.1.0/24"
az-suffix = ["a", "b"]
public-cidr = ["192.168.1.0/27", "192.168.1.32/27"]
private-cidr = ["192.168.1.128/27","192.168.1.160/27"]
allow-ingress-cidr = ["146.184.0.84/32", "173.56.13.157/32"]
allow-egress-cidr = "0.0.0.0/0"

ssh-port = 22
instance-type = "t2.micro"
instance-name = "webserver"
key-name = "Awskey"

