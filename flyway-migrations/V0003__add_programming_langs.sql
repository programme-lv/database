INSERT INTO programming_languages (
        id,
        full_name,
        code_filename,
        compile_cmd,
        execute_cmd,
        env_version_cmd
    )
VALUES (
        'cpp17',
        'C++17 (GNU G++)',
        'main.cpp',
        'g++ -std=c++17 -o main main.cpp',
        './main',
        'g++ --version'
    ),
    (
        'python3.10',
        'Python 3.10',
        'main.py',
        NULL,
        'python3.10 main.py',
        'python3.10 --version'
    ),
    (
        'java18',
        'Java 18',
        'Main.java',
        'javac Main.java',
        'java Main',
        'java --version'
    );