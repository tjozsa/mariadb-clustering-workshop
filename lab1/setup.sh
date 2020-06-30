# tuti, hogy a csomagkezelo friss csomagokat lat
apt-get update -y

# telepitsuk a szervert es a kliens eszkozoket
apt-get install mariadb-server mariadb-client mariadb-backup mariadb-core-tools -y

# futtassuk a biztonsagi szkriptet
mysql_secure_installation

# Enter current password for root (enter for none): Press Enter
# Set root password? [Y/n] Y
# New password:
# Re-enter new password:
# Remove anonymous users? [Y/n] Y
# Disallow root login remotely? [Y/n] Y
# Remove test database and access to it? [Y/n] Y
# Reload privilege tables now? [Y/n] Y

#
# # MASTER Node telepites
#

nano /etc/mysql/mariadb.conf.d/50-server.cnf

#bind-address            = 0.0.0.0

# server-id = 1
# log_bin = /var/log/mysql/mysql-bin.log
# log_bin_index =/var/log/mysql/mysql-bin.log.index
# relay_log = /var/log/mysql/mysql-relay-bin
# relay_log_index = /var/log/mysql/mysql-relay-bin.index

systemctl restart mariadb

mysql -u root -p

# CREATE USER 'replication'@'%' identified by 'your-password';
# GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
# FLUSH PRIVILEGES;
# show master status;

# +------------------+----------+--------------+------------------+
# | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
# +------------------+----------+--------------+------------------+
# | mysql-bin.000001 |      313 |              |                  |
# +------------------+----------+--------------+------------------+

EXIT;

#
# # SLAVE
#
nano /etc/mysql/mariadb.conf.d/50-server.cnf

#bind-address            = 0.0.0.0

# server-id = 2
# log_bin = /var/log/mysql/mysql-bin.log
# log_bin_index =/var/log/mysql/mysql-bin.log.index
# relay_log = /var/log/mysql/mysql-relay-bin
# relay_log_index = /var/log/mysql/mysql-relay-bin.index

systemctl restart mariadb

mysql -u root -p

# CHANGE MASTER TO MASTER_HOST = 'your-master-host-ip', MASTER_USER = 'replication', MASTER_PASSWORD = 'your-password', MASTER_LOG_FILE = 'mysql-bin.000001', MASTER_LOG_POS = 313;

# start slave;
# exit;

##
## Teszteljuk le a replikaciot
##

# Master gepen
mysql -u root -p

# create database mydb;

# use mydb;
# CREATE TABLE products(product_id INT NOT NULL AUTO_INCREMENT,product_name VARCHAR(100) NOT NULL,product_manufacturer VARCHAR(40) NOT NULL,submission_date DATE,PRIMARY KEY ( product_id ));

# Slave gepen

mysql -u root -p

# SHOW SLAVE STATUS \G
# *************************** 1. row ***************************
#                Slave_IO_State: Waiting for master to send event
#                   Master_Host: your-master-host-ip
#                   Master_User: replication
#                   Master_Port: 3306
#                 Connect_Retry: 60
#               Master_Log_File: mysql-bin.000001
#           Read_Master_Log_Pos: 721
#                Relay_Log_File: mysql-relay-bin.000002
#                 Relay_Log_Pos: 945
#         Relay_Master_Log_File: mysql-bin.000001
#              Slave_IO_Running: Yes
#             Slave_SQL_Running: Yes

# show databases;

# +--------------------+
# | Database           |
# +--------------------+
# | information_schema |
# | mydb               |
# | mysql              |
# | performance_schema |
# +--------------------+