# if you want to describe any thing in terraform. you have to use "key" "value" method. 
ami = "ami-02b49a24cfb95941c"
ami is key and ami-id is value. 

if you are using string 
example
key1 = "prateek"

if you are using number 
key1 = 123

if you are define variable 
key1 = var.awsmyvar

if you are define resource 
key1 = aws_instnace.firstinstance.id/aws_instnace.firstinstance.name/