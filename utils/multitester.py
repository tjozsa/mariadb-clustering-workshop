import mariadb 

conn = mariadb.connect(
    user="cluster_user",
    password="clusterpass",
    host="13.95.29.234",
    port=4006,
    database="mydb")

cur = conn.cursor() 


cur.execute("CREATE TABLE IF NOT EXISTS employees (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), address VARCHAR(255))")

# #retrieving information 
# some_name = "Georgi" 
# cur.execute("SELECT first_name,last_name FROM employees WHERE first_name=?", (some_name,)) 

# for first_name, last_name in cur: 
#     print(f"First name: {first_name}, Last name: {last_name}")
    
#insert information 
try: 
    cur.execute("INSERT INTO employees (name, address) VALUES (?, ?)", ("Maria","DB")) 
except mariadb.Error as e: 
    print(f"Error: {e}")

conn.commit() 
print(f"Last Inserted ID: {cur.lastrowid}")
    
conn.close()