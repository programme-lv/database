import psycopg2
import db_interface as dbi
import utils
import toml
import os

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
TASK_DIR = './data/summa'

conn = psycopg2.connect(f"""
host={DB_HOST} port={DB_PORT}
dbname={DB_NAME} user={DB_USER} password={DB_PASS}
""")


def ensure_admin_exists(cur):
    '''Ensures that the admin user exists'''
    if dbi.user_exists(cur, ADMIN_USERNAME):
        print('Admin user already exists. Fetching ID.')
        return dbi.get_user_id(cur, ADMIN_USERNAME)
    else:
        print('Creating admin user.')
        return dbi.create_user(cur, ADMIN_USERNAME, ADMIN_EMAIL,
                               utils.hash_password(ADMIN_PASSWORD),
                               ADMIN_FIRSTNAME, ADMIN_LASTNAME, True)


try:
    cur = conn.cursor()
    admin_id = ensure_admin_exists(cur)
    print(f'Admin user ID: {admin_id}')

    problem_toml = toml.load(f'{TASK_DIR}/problem.toml')
    code = problem_toml['code']
    name = problem_toml['name']
    time_ms = problem_toml['time']*1000
    memory_kb = problem_toml['memory']*1024
    type_id = problem_toml['type']
    authors = problem_toml['authors']

    task_id = dbi.create_task(cur, admin_id)
    print(f'Task ID: {task_id}')

    version_id = dbi.create_version(cur, task_id, code, name,
                                    time_ms, memory_kb, type_id)

    print(f'Version ID: {version_id}')

    dbi.update_task(cur, task_id, admin_id, version_id, None)

    md_statement_dir = f'{TASK_DIR}/statements'
    md_files = dict()
    md_files['input'] = f'{md_statement_dir}/input.md'
    md_files['output'] = f'{md_statement_dir}/output.md'
    md_files['story'] = f'{md_statement_dir}/story.md'
    md_contents = dict()
    for key, value in md_files.items():
        with open(value, 'r') as f:
            md_contents[key] = f.read()

    md_statement_id = dbi.create_md_statement(cur,
                                              md_contents['story'],
                                              md_contents['input'],
                                              md_contents['output'],
                                              None, None, version_id)
    print(f'MD Statement ID: {md_statement_id}')

    for author in authors:
        dbi.create_version_author(cur, version_id, author)
    print('Authors added.')

    test_dir = f'{TASK_DIR}/tests'
    testnames = set()
    for filename in os.listdir(test_dir):
        testnames.add(filename.split('.')[0])

    conn.commit()
except Exception as e:
    print(f"Error: {e}")
    conn.rollback()
finally:
    cur.close()
    conn.close()
