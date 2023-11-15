DELETE FROM programming_languages;

INSERT INTO programming_languages
    VALUES ('cpp17', 'C++17 (GNU G++)', 'main.cpp', 'g++ -std=c++17 -o main main.cpp', './main', 'g++ --version',
    e'#include <iostream>
int main() { std::cout << "Hello, World!"; }', 'cpp', 'main');

INSERT INTO programming_languages
    VALUES ('python3.11', 'Python 3.11', 'main.py', null, 'python3.11 main.py', 'python3.11 --version',
    'print("Hello, World!")', 'python', null);

INSERT INTO programming_languages
    VALUES ('java18', 'Java 18', 'Main.java', 'javac Main.java', 'java Main', 'java --version',
    e'public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}', 'java', 'Main');

INSERT INTO programming_languages
    VALUES ('go1.19', 'Go 1.19', 'main.go', 'go build main.go', './main', 'go version',
    e'package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}', 'go', 'main');

