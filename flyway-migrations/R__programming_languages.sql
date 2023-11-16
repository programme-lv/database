BEGIN;

SET CONSTRAINTS ALL DEFERRED;

DELETE FROM
    programming_languages;
INSERT INTO public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled)
VALUES ('python3.10', 'Python 3.10', 'main.py', null, 'python3.10 main.py', 'python3.10 --version', 'print("Hello, World!")', 'python', null, false);
INSERT INTO public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled)
VALUES ('java18', 'Java 18', 'Main.java', 'javac Main.java', 'java Main', 'java --version', e'public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}', 'java', 'Main', false);
INSERT INTO public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled)
VALUES ('python3.11', 'Python 3.11', 'main.py', null, 'python3.11 main.py', 'python3.10 --version', 'print("Hello, World!")', 'python', null, true);
INSERT INTO public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled)
VALUES ('go1.19', 'Go 1.19', 'main.go', 'go build main.go', './main', 'go version', e'package main
import "fmt"
func main() {
    fmt.Println("Hello, World!")
}', 'go', 'main', true);

INSERT INTO public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled)
VALUES ('cpp17', 'C++17 (GNU G++) asdf', 'main.cpp', 'g++ -std=c++17 -o main main.cpp', './main', 'g++ --version', e'#include <iostream>
int main() { std::cout << "Hello, World!" << endl; }', 'cpp', 'main', true);



COMMIT;
