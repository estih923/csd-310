import mysql.connector

#Function to display films
def show_films(cursor, label):
    select_query = """
        SELECT film_name AS 'Film Name', film_director AS 'Director', genre_name AS 'Genre Name', studio_name AS 'Studio Name'
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id
    """
    cursor.execute(select_query)
    films = cursor.fetchall()

    print(f"-- {label} --")
    for film in films:
        print(f"Film Name: {film['Film Name']}")
        print(f"Director: {film['Director']}")
        print(f"Genre Name: {film['Genre Name']}")
        print(f"Studio Name: {film['Studio Name']}")
        print()


cnx = mysql.connector.connect(
    host='localhost',
    user='root',
    password='novablue',
    database='db_init_2022'
)
cursor = cnx.cursor(dictionary=True)


show_films(cursor, "DISPLAYING FILMS")

# Insert Star Wars Film
insert_query = """
    INSERT INTO film (film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)
    VALUES ('Star Wars', '1977', 121, 'George Lucas', 1, 2)
"""
cursor.execute(insert_query)
cnx.commit()


show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

# Update the genre of Alien
update_query = """
    UPDATE film
    SET genre_id = (SELECT genre_id FROM genre WHERE genre_name = 'Horror')
    WHERE film_name = 'Alien'
"""
cursor.execute(update_query)
cnx.commit()


show_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

#Delete Gladiator Movie
delete_query = """
    DELETE FROM film
    WHERE film_name = 'Gladiator'
"""
cursor.execute(delete_query)
cnx.commit()


show_films(cursor, "DISPLAYING FILMS AFTER DELETE")


cursor.close()
cnx.close()
