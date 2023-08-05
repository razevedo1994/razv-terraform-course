resource "aws_instance" "example" {
    ami             = var.ami
    instance_type   = var.instance_type
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true
    
    tags = {
      Name = var.project_name
    }
}