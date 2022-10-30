#! /bin/bash
#TASK 2 

s3_bucket_name="upgrad-atul"
my_name="Atul"
time_stamp=$(date '+%d%m%Y-%H%M%S')

#Step 1: Perform an update of the package detail
sudo apt update -y

#Step 2: Install the apache2 package if it is not already installed
if [ 'dpkg -l apache2 | grep apache2 | wc -l' == 1 ]
then
        echo "Apache2 is already installed"
else
        echo "Installing Apache2"
        sudo apt install apache2 -y
fi

#Step 3: Ensure that the apache2 service is running
if [ 'systemctl status apache2 | grep running | wc -l' == 1 ]
then
        echo "Apache2 is already running"
else
        echo "Running Apache2"
        sudo systemctl start apache2
fi

#Step 4: Enasure that the apache2 service is enabled
if [ 'systemctl status apache2 | grep enabled | wc -l' == 1 ]
then
        echo "Apache2 is already enabled"
else
        echo "Enabling Apache2"
        sudo systemctl enable apache2
fi

#Step 5:Create a tar archive of apache2 access logs and error logs
tar -cvf /tmp/${my_name}-httpd-logs-${time_stamp}.tar /var/log/apache2/*.log

#Step 6:Copy the archive to s3 bucket
aws s3 \
cp /tmp/${my_name}-httpd-logs-${time_stamp}.tar \
s3://${s3_bucket_name}/${my_name}-httpd-logs-${time_stamp}.tar
