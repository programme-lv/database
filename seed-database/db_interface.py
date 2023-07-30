def create_user(
        cursor, username, email, hashed_password,
        first_name, last_name, is_admin=False):
    '''Creates a new user and returns their ID'''
    cursor.execute('''
        INSERT INTO users
        (username, email, hashed_password, first_name, last_name,is_admin)
        VALUES (%s, %s, %s, %s, %s, %s)
        ON CONFLICT DO NOTHING
        RETURNING id
    ''', (username, email, hashed_password, first_name, last_name, is_admin))
    return cursor.fetchone()[0]


def user_exists(cursor, username):
    '''Returns True if a user with the given username exists'''
    cursor.execute('''
        SELECT EXISTS(
            SELECT 1
            FROM users
            WHERE username = %s
        )
    ''', (username,))
    return cursor.fetchone()[0]


def get_user_id(cursor, username):
    '''Returns the ID of a user with the given username'''
    cursor.execute('''
        SELECT id FROM users
        WHERE username = %s
    ''', (username,))
    return cursor.fetchone()[0]


def get_user_by_username(cursor, username):
    '''Returns a user with the given username'''
    cursor.execute('''
        SELECT * FROM users
        WHERE username = %s
    ''', (username,))
    return cursor.fetchone()


def create_task(cursor, created_by_id,
                relevant_version_id=None, published_version_id=None):
    '''Creates a new task and returns its ID'''
    cursor.execute('''
        INSERT INTO tasks
        (created_by_id, relevant_version_id, published_version_id)
        VALUES (%s, %s, %s)
        RETURNING id
    ''', (created_by_id, relevant_version_id, published_version_id))
    return cursor.fetchone()[0]


def update_task(cursor, task_id, created_by_id,
                relevant_version_id=None, published_version_id=None):
    cursor.execute('''
        UPDATE tasks
        SET created_by_id = %s, relevant_version_id = %s,
        published_version_id = %s
        WHERE id = %s
    ''', (created_by_id, relevant_version_id, published_version_id, task_id))


def create_version(cursor, task_id, short_code, full_name,
                   time_lim_ms, mem_lim_kb, testing_type_id, origin=None):
    '''Creates a new task version and returns its ID'''
    cursor.execute('''
        INSERT INTO task_versions
        (task_id, short_code, full_name, time_lim_ms, mem_lim_kb,
        testing_type_id, origin)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING id
    ''', (task_id, short_code, full_name, time_lim_ms, mem_lim_kb,
          testing_type_id, origin))
    return cursor.fetchone()[0]
