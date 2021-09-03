#!/bin/bash
yum -y update
yum -y install httpd

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h1>Server Private IP</h1>
<h2>$myip</h2>
<b>Version 3.0</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httpd on