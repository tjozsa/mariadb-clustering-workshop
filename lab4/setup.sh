docker exec -it lab4_master_1 mysql -pmastersecret -e "CREATE USER 'repl'@'%' IDENTIFIED BY 'slavepass';" -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';" -e "SHOW MASTER STATUS \G;"

docker exec -it lab4_slave1_1 mysql -pslave1secret -e "stop slave;" -e "CHANGE MASTER TO MASTER_HOST = 'master', MASTER_USER = 'repl', MASTER_PASSWORD = 'slavepass' ,MASTER_LOG_FILE = 'mariadb-bin.000003', MASTER_LOG_POS = 662;" -e "start slave;" -e "SHOW SLAVE STATUS \G;"

docker exec -it lab4_slave2_1 mysql -pslave2secret -e "stop slave;" -e "CHANGE MASTER TO MASTER_HOST = 'master', MASTER_USER = 'repl', MASTER_PASSWORD = 'slavepass' ,MASTER_LOG_FILE = 'mariadb-bin.000003', MASTER_LOG_POS = 662;" -e "start slave;" -e "SHOW SLAVE STATUS \G;"

docker exec -it lab4_master_1 mysql -pmastersecret -e "CREATE DATABASE mydb2;"

docker exec -it lab4_slave1_1 mysql -pslave1secret -e "SHOW DATABASES;"

docker exec -it lab4_slave2_1 mysql -pslave2secret -e "SHOW DATABASES;"