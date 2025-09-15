You can make your error messages much clearer by showing the line of input with a caret pointing at the exact column. Here's a simple way to do it:

```cpp
void printError(const std::string& lineText, size_t line, size_t column, const std::string& message)
{
    std::cerr << "Error at line " << line << ", column " << column << ": " << message << "\n";
    std::cerr << lineText << "\n";

    // Print spaces up to the column, then a caret
    for (size_t i = 1; i < column; ++i)
        std::cerr << ' ';
    std::cerr << "^\n";
}
```

**Usage example:**

```cpp
std::string inputLine = "let x = 42;";
size_t line = 1;
size_t column = 8; // let's say error is at '='
printError(inputLine, line, column, "Unexpected token");
```

**Output:**

```js
Error at line 1, column 8: Unexpected token
let x = 42;
       ^
```

---

💡 Notes:

- `column` here is **1-based**, so the caret aligns properly.
- You need to keep the original line text for each token or reconstruct it from your buffer.
- This is basically how compilers like GCC/Clang show syntax errors.

If you want, I can show a **version that works directly with your Lexer/Token setup**, so each token knows its line text and prints errors automatically. It makes integration seamless. Do you want me to do that?

### Clang example

```c
src/main.cpp: In function ‘int main()’:
src/main.cpp:8:13: error: expected ‘;’ before ‘}’ token
    8 |     return 0
      |             ^
      |             ;
    9 | }
      | ~
make: *** [Makefile:83: build/obj/main.o] Error 1
```
