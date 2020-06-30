docker exec -it lab5_master1_1 mysql -pmaster1secret -e "CREATE USER 'repl1'@'%' IDENTIFIED BY 'slavepass';" -e "GRANT REPLICATION SLAVE ON *.* TO 'repl1'@'%';" -e "SHOW MASTER STATUS \G;"

docker exec -it lab5_master2_1 mysql -pmaster2secret -e "CREATE USER 'repl2'@'%' IDENTIFIED BY 'slavepass';" -e "GRANT REPLICATION SLAVE ON *.* TO 'repl2'@'%';" -e "SHOW MASTER STATUS \G;"

docker exec -it lab5_slave_1 mysql -pslavesecret -e "SET GLOBAL gtid_ignore_duplicates=ON;"


docker exec -it lab5_slave_1 mysql -pslavesecret -e "stop all slaves;" -e "CHANGE MASTER 'm-01' TO MASTER_HOST = 'master1', MASTER_USER = 'repl1', MASTER_PASSWORD = 'slavepass', MASTER_LOG_FILE = 'mariadb-bin.000003', MASTER_LOG_POS = 664;" -e "start all slaves;"

docker exec -it lab5_slave_1 mysql -pslavesecret -e "stop all slaves;" -e "CHANGE MASTER 'm-02' TO MASTER_HOST = 'master2', MASTER_USER = 'repl2', MASTER_PASSWORD = 'slavepass', MASTER_LOG_FILE = 'mariadb-bin.000003', MASTER_LOG_POS = 664;" -e "start all slaves;"

docker exec -it lab5_slave_1 mysql -pslavesecret -e "SHOW SLAVE 'm-01' STATUS \G;"


docker exec -it lab5_master1_1 mysql -pmaster1secret -e "CREATE DATABASE mydb1;"

docker exec -it lab5_master2_1 mysql -pmaster2secret -e "CREATE DATABASE mydb2;"

docker exec -it lab5_slave_1 mysql -pslavesecret -e "SHOW DATABASES;"
