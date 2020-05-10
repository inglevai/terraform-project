#/bin/bash
apt-get install apache2
service httpd restart
chkconfig httpd on
echo "<h1> Deployed by Terraform </h1>" > /var/www/html/index.html 