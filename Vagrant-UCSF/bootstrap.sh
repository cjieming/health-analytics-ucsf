#!/bin/bash

#####################################################################################
# UPDATE #
echo "Updating package list"
sudo apt-get -y update >/dev/null 2>&1

#####################################################################################
# INSTALLING FUNCTIONS #
# To reduce verbosity
function apt_install {
	for p in $@; do
		echo "installing $p"
    	sudo apt-get -y install $p >/dev/null 2>&1
	done
}

function pip_install {
	for p in $@; do
		echo "installing $p"
    	sudo pip install $p >/dev/null 2>&1
	done
}

#####################################################################################
# MODULES #

# Basics an dependencies
apt_install python-pip libpq-dev python-dev build-essential python-setuptools
pip install --upgrade pip >/dev/null 2>&1
apt_install python-nose g++ git libatlas3gf-base libatlas-dev pyyaml cython unixodbc-dev
apt_install python-numpy python-pandas
pip_install jupyter

# Scipy
apt_install python-scipy

# Scraping
apt_install python-requests python-scrapy
pip_install bs4 feedparser

# European Data Format
pip_install pyedflib

# NLP
pip_install nltk

# Web framework
pip_install flask

# Visualization
apt_install matplotlib
pip_install seaborn bokeh

# DB connection
pip_install psycopg2 pymongo pyodbc

# Pandas DB connector
pip_install sqlalchemy

# AWS
pip_install boto3

# Scikit-learn
pip_install scikit-learn

# Theano
pip_install theano

# Keras
pip_install keras

# Tensorflow
sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp27-none-linux_x86_64.whl >/dev/null 2>&1

# Postgres
apt_install postgresql postgresql-contrib

# Java
echo "Downloading and installing Java"
apt_install default-jdk

# Others
apt_install libhdf5-7

# Download & install Hadoop
echo "Downloading and installing Hadoop"
wget http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
tar -xzvf hadoop-2.7.3.tar.gz >/dev/null 2>&1
sudo mv hadoop-2.7.3 /usr/local/hadoop
sudo echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed \"s:bin/java::\")" >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh


# Download Scala
echo "Downloading and installing Scala"
wget https://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.tgz >/dev/null 2>&1
tar -xzvf scala-2.12.1.tgz >/dev/null 2>&1
sudo mv scala-2.12.1 /usr/local/scala
echo "export PATH=\"/usr/local/scala/bin:$PATH\"" >> ~/.bash_profile

# Download Spark
echo "Downloading and installing Spark"
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz >/dev/null 2>&1
tar -xzvf spark-2.1.0-bin-hadoop2.7.tgz >/dev/null 2>&1
sudo mv spark-2.1.0-bin-hadoop2.7 /usr/local/spark >/dev/null 2>&1
echo "export PATH=\"/usr/local/spark/bin:$PATH\"" >> ~/.bash_profile

printf '*** SETUP FINISHED! ***'
#####################################################################################
