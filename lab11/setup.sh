git clone https://github.com/akopytov/sysbench.git

docker-compose exec maxscale maxctrl list servers

sysbench /root/sysbench/src/lua/oltp_read_only.lua --threads=16 --events=0 --time=300 --mysql-host=13.95.29.234 --mysql-user=root --mysql-password=root_password --mysql-port=3306 --tables=10 --table-size=10000 --range_selects=off --db-ps-mode=disable --report-interval=1 --db-driver=mysql prepare
sysbench /root/sysbench/src/lua/oltp_read_only.lua --threads=16 --events=0 --time=300 --mysql-host=13.95.29.234 --mysql-user=root --mysql-password=root_password --mysql-port=4006 --tables=10 --table-size=10000 --range_selects=off --db-ps-mode=disable --report-interval=1 --db-driver=mysql run
