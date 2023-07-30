import bcrypt
import psycopg2

DB_HOST = 'localhost'
DB_PORT = 5432
DB_NAME = 'proglv'
DB_USER = 'proglv'
DB_PASS = 'proglv'
ADMIN_USERNAME = 'admin'
ADMIN_PASSWORD = 'admin'
ADMIN_EMAIL = 'admin@programme.lv'
ADMIN_FIRSTNAME = 'Antons'
ADMIN_LASTNAME = 'Maizītis'

conn = psycopg2.connect(f"""
host={DB_HOST} port={DB_PORT}
dbname={DB_NAME} user={DB_USER} password={DB_PASS}
""")


def hash_password(password):
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed.decode('utf-8')


cur = conn.cursor()
cur.execute('''
    INSERT INTO users
    (username, email, hashed_password, first_name, last_name, is_admin)
    VALUES (%s, %s, %s, %s, %s, %s)
    ON CONFLICT DO NOTHING
''', (
    ADMIN_USERNAME, ADMIN_EMAIL, hash_password(ADMIN_PASSWORD),
    ADMIN_FIRSTNAME, ADMIN_LASTNAME, True
))

conn.commit()
cur.close()
conn.close()
