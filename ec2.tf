resource "aws_instance" "web" {
  ami                     = "ami-0cbd40f694b804622"
  instance_type           = "t2.micro"
  key_name                = "project1"
  vpc_security_group_ids  = [aws_security_group.sg.id]
  tags = {
    "Name" = "terraform"
  }

connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("project1.pem")  # Update with the path to your private key
      host     = aws_instance.web.public_ip
    }
provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      # "sudo apt-get install nginx -y",
      # "sudo apt-get install unzip -y",
      "wget https://www.free-css.com/assets/files/free-css-templates/download/page284/pet-shop.zip",
      "sudo unzip pet-shop.zip",
      "sudo mv pet-shop-website-template /var/www/html/"
    ]
  }
}