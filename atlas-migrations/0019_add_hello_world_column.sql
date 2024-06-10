ALTER TABLE programming_languages ADD COLUMN hello_world_code TEXT;
UPDATE programming_languages SET hello_world_code =
'#include <iostream>
int main() { std::cout << "Hello, World!"; }' WHERE id = 'cpp17';
UPDATE programming_languages SET hello_world_code =
'print("Hello, World!")' WHERE id = 'python3.10';
UPDATE programming_languages SET hello_world_code =
'public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}' WHERE id = 'java18';
