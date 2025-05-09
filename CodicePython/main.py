import mysql.connector


# programma per database fatto in classe

mydb = mysql.connector.connect(
    host="localhost", user="root",
    password="codelyoko", database="classicmodels"
)

#recuperiamo un cursore, serve per iterare
cursor = mydb.cursor()
cursor.execute("SELECT * FROM employees")

#stampiamo il contenuto del cursore, e quindi della query x[n] dove n è il numero della colonna
for x in cursor:
    print(x[1], x[2])