import mysql.connector

# Establish a connection to the MySQL database
conn = mysql.connector.connect(user='root', password='novablue', host='localhost', database='db_init_2022')

# Create a cursor object to interact with the database
cursor = conn.cursor()

# Query 1: Select all fields from the studio table
query1 = "SELECT * FROM studio"

cursor.execute(query1)
result1 = cursor.fetchall()

print("Studio table:")
for row in result1:
    print(row)

print()

# Query 2: Select all fields from the genre table
query2 = "SELECT * FROM genre"

cursor.execute(query2)
result2 = cursor.fetchall()

print("Genre table:")
for row in result2:
    print(row)

print()

# Query 3: Select movie names for movies with a runtime of less than two hours
query3 = "SELECT film_name FROM film WHERE film_runtime < 120"

cursor.execute(query3)
result3 = cursor.fetchall()

print("Movie names with a runtime of less than two hours:")
for row in result3:
    print(row[0])

print()

# Query 4: Get a list of film names and directors ordered by director
query4 = "SELECT film_name, film_director FROM film ORDER BY film_director"

cursor.execute(query4)
result4 = cursor.fetchall()

print("Film names and directors ordered by director:")
for row in result4:
    print(f"Film: {row[0]}, Director: {row[1]}")

# Close the cursor and the database connection
cursor.close()
conn.close()
