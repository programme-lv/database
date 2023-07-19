DELETE FROM programming_languages;

INSERT INTO programming_languages
    VALUES ('cpp17', 'C++17 (GNU G++)', 'main.cpp', 'g++ -std=c++17 -o main main.cpp', './main', 'g++ --version',
    e'#include <iostream>
int main() { std::cout << "Hello, World!"; }', 'cpp');

INSERT INTO programming_languages
    VALUES ('python3.10', 'Python 3.10', 'main.py', null, 'python3.10 main.py', 'python3.10 --version',
    'print("Hello, World!")', 'python');

INSERT INTO programming_languages
    VALUES ('java18', 'Java 18', 'Main.java', 'javac Main.java', 'java Main', 'java --version',
    e'public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}', 'java');

