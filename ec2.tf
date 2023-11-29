resource "aws_instance" "web" {
  ami                     = "ami-093467ec28ae4fe03"
  instance_type           = "t2.micro"
  key_name                = "docker"
  vpc_security_group_ids  = [aws_security_group.sg.id]
  tags = {
    "Name" = "terraform"
  }

connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("docker.pem")  # Update with the path to your private key
      host     = aws_instance.web.public_ip
    }
provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install httpd -y",
      "sudo yum install unzip -y",
      "wget https://www.free-css.com/assets/files/free-css-templates/download/page284/pet-shop.zip",
      "sudo unzip pet-shop.zip",
      "sudo mv -f pet-shop-website-template /var/www/html/"
    ]
  }
}
