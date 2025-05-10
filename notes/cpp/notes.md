## Type casting in C++

| Cast Type          | Purpose                                  | Valid Use Case                                                | Runtime Check? | Safe?                 |
| ------------------ | ---------------------------------------- | ------------------------------------------------------------- | -------------- | --------------------- |
| `static_cast`      | Safe conversion between related types    | Numeric conversions, upcast, downcast in hierarchy            | ❌             | ✅ (compile-time)     |
| `dynamic_cast`     | Safe downcasting in polymorphic types    | Casting between base/derived classes (with virtual functions) | ✅             | ✅ (runtime check)    |
| `reinterpret_cast` | Reinterpret data at the bit level        | Unsafe type conversion between unrelated pointer types        | ❌             | ⚠️ (use with caution) |
| `const_cast`       | Add/remove `const`/`volatile` qualifiers | Modifying `const`-qualified data (use carefully)              | ❌             | ⚠️ (use with caution) |

### Bash history search:

When you press `Ctrl + R` in a terminal (like `bash`), you enter `reverse-i-search` mode, which lets you search your `command history`.

To exit from it:

- Press `Ctrl + G` → Cancels the search and returns to the prompt without running anything.
- Press `Esc` → Exits the search and keeps the current match on the prompt for editing.
- Press `Enter` → Runs the currently matched command.

## Header guards

### ✅ #pragma once

This is a special, widely supported pragma that tells the compiler:

“Only include this header file once per compilation, no matter how many times it's referenced.”

Example:

```cpp
// myclass.hpp
#pragma once

class MyClass
{
    // ...
};
```

This works like a built-in header guard.

#### How it works internally:

The compiler **remembers** that it has already included the file once.

The next time it encounters `#include "myclass.hpp"`, it just **skips** it.

This is usually **faster** and less error-prone than manual `#ifndef` guards.

#### Other examples of #pragma (you may see occasionally):

```cpp
#pragma warning(disable : 4996) // MSVC: disable specific warning
#pragma GCC optimize("O3") // GCC: force optimization
#pragma pack(1) // Change struct alignment to 1 byte
```

These are highly compiler-specific. For example:

`MSVC` uses `#pragma warning`

`GCC/Clang` might use `#pragma GCC` ... or `#pragma clang` ...

⚠️ Only use them when you're sure about compiler compatibility.


## 🔑 Access Specifiers in C++

In C++, **access specifiers** like `public`, `private`, and `protected` control the visibility of class members (variables and methods). Here's how they work:

---

### Access Specifiers

1. **`private`** (default in classes):
   - Members are accessible **only inside the class**.
2. **`public`**:
   - Members are accessible **from anywhere** where the object is visible.
3. **`protected`**:
   - Members are accessible **inside the class** and **by derived (child) classes**, but **not by other code**.

---

### Syntax Example

```cpp
class MyClass
{
private:
    int secret; // only accessible inside MyClass

public:
    void setSecret(int value)
    {
        secret = value;
    }

    int getSecret()
    {
        return secret;
    }
};
```

You can use multiple access specifiers within a class, and they apply to all following members until the next one appears.

---

### Is indentation required in C++?

- **NO**, indentation (tabs or spaces) is **not required by the compiler**.
- But it's **strongly recommended** for readability and teamwork.
  
This compiles fine:
```cpp
class A{private:int x;public:void f(){}};
```

But this is more readable:
```cpp
class A
{
private:
    int x;

public:
    void f()
    {
    }
};
```
