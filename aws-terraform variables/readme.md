# variable used for manage the coustimze and reusable infra. 
# in terraform we are using input variables for manageing source code with diffrent functionality
# Input variable help you to create dynamic Infrastructure. 
# type of variables availabel in terraform 
#  1. string 
#  2. number 
#  3. list 
#  4. map 
#  5. object
#  6. sets. 

# variables cand be define in main.tf or variable.tf/vars.tf but according best practise 
# we mostly create varibles in vars.tf 
# structure of define variables 
# variable "name of variables" { 
#    description = " details of Input vatianbles" 
#    type = "data type like string number list" 
#     default = "pre define value"
# }

# whenever you want use your varibles in resources you have to mention 
#  xyz = var.abc  where abc is a value define in variables

# Declare valraible values 
# 1st method on run time screen print 
# 2nd method use cli 
# example of varialbe pass cli 
# 
# terraform plan   -var aws_region="ap-south-1" -var aws_access_key="xxxxx" -var aws_secret_key="xxxxx"
# 3rd way to manage using files 
# files called terraform.tfvars/*.auto.tfvars