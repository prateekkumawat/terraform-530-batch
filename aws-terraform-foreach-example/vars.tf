variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
# itretting single value using list variables
# variable "instance_set" {
#   type = list(string)
# } 

# # itretting single value using map variables
# variable "instance_map" {
#   type = map(string)
#   default = {
#     "inst_a" = "Instance A",
#     "inst_b" = "Instance B"
    
#   }
# }

variable "instance_map" { 
    type = map(object({
        ami = string
        instance_type = string 
    }))
    
    default = { 
        instnace1 = { 
            ami = "ami-02b49a24cfb95941c"
            instance_type = "t2.micro"
        }
        instnace2 = { 
            ami = "ami-02b49a24cfb95941c"
            instance_type = "t2.small"
        }
        instnace3 = { 
            ami = "ami-02b49a24cfb95941c"
            instance_type = "t2.small"
            
        }
    }
}