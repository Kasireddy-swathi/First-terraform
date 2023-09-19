sudo yum -y update
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo yum install git -y
sudo rm -rf /var/www/html/*
git clone https://github.com/Kasireddy-swathi/ecomm.git /var/www/html/
