variable "vpc_cidr" {
    type=string
}
variable "env"{
    type=string
}
variable "pub_sub_1_cidr"{
    type=string
}
variable "pub_sub_2_cidr"{
    type=string
}
variable "priv_sub_1_cidr"{
    type=string
}
variable "priv_sub_2_cidr"{
    type=string
}
variable "azs"{
    type=list(string)
}
