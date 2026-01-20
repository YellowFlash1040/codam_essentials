## Quick summary:

"Duplication is cheaper than the wrong abstraction" - Sandi Matz  
If you see that a generic function became a dumping ground for special cases - make it WET instead of DRY

# 💧 WET Code — Explained

## ❓ What does “WET code” stand for?

**WET** is a software engineering acronym meaning:

> **WET = “Write Everything Twice”**  
> (or humorously, “We Enjoy Typing”)

It’s the opposite of **DRY** code —  
> **DRY = “Don’t Repeat Yourself.”**

### 💡 Explanation:
- **WET code** repeats logic, structures, or patterns unnecessarily.  
- It leads to **poor maintainability** — you have to fix bugs in multiple places.  
- Developers aim to refactor WET code into **DRY code**, where shared logic is extracted into reusable functions, modules, or classes.

---

### 🧩 Example

**WET version:**
```python
print("Hello, Alice!")
print("Hello, Bob!")
print("Hello, Carol!")
```

**DRY version:**
```python
def greet(name):
    print(f"Hello, {name}!")

for person in ["Alice", "Bob", "Carol"]:
    greet(person)
```

---

## 🧠 When WET Code Might Actually Be Better Than DRY Code

While “DRY is good” is common advice, **WET code isn’t always bad**.  
Sometimes, duplication improves **clarity**, **flexibility**, or **safety**.

---

### 1. 🧩 **When code clarity matters more than abstraction**

If DRY-ing code requires complicated abstractions that obscure intent, repetition may be clearer.

**Example:**
```python
# WET but clear
save_user_to_database()
send_user_welcome_email()

save_admin_to_database()
send_admin_welcome_email()
```

Over-generalizing this might make the code *less understandable*.

> ✅ Favor **clarity over cleverness.**

---

### 2. 🧪 **When requirements aren’t stable yet**

If your system is still changing, premature DRY-ing can cause **over-engineering**.  
It’s often easier to **refactor later** than to **untangle wrong abstractions**.

---

### 3. 🔍 **When repeated code serves different purposes**

Sometimes code *looks* similar but has **different business meaning**.  
Forcing them to share logic can make future changes confusing.

---

### 4. 🚀 **When performance or isolation is key**

Duplication may be needed for:
- **Performance optimization**
- **Module independence** or **fault isolation**

---

### ✅ Summary

| Principle | When to Apply |
|------------|----------------|
| **DRY** | When repetition clearly represents the *same logic* |
| **WET** | When duplication makes code clearer, safer, or easier to evolve |

> **“Duplication is better than the wrong abstraction.” – Sandi Metz**

---

## ⚡ Example: When DRY Code Makes Things Worse

### 🧩 Scenario
Two types of users — **Customers** and **Admins** — have slightly different signup flows.

**WET version (simple and readable):**
```python
def create_customer_account(name, email):
    validate_customer_email(email)
    save_customer_to_db(name, email)
    send_customer_welcome_email(email)

def create_admin_account(name, email):
    validate_admin_email(email)
    save_admin_to_db(name, email)
    send_admin_welcome_email(email)
```

**Refactored DRY version:**
```python
def create_account(name, email, user_type):
    validate_email(email, user_type)
    save_to_db(name, email, user_type)
    send_welcome_email(email, user_type)
```

### 🚨 Problem
As requirements evolve:
- Admins need 2FA.
- Customers have a separate database.
- Admin emails include credentials.

Your “generic” DRY function becomes messy:
```python
def create_account(name, email, user_type):
    if user_type == "customer":
        validate_customer_email(email)
        save_customer_to_db(name, email)
        send_customer_welcome_email(email)
    elif user_type == "admin":
        validate_admin_email(email)
        save_admin_to_db(name, email)
        send_admin_welcome_email(email)
        enable_two_factor_auth(email)
```

### 💥 Result
- The generic function becomes a **dumping ground**.  
- You lose **clarity** and **separation of intent**.  
- Future developers face complex conditionals.

---

### ✅ Better Balanced Approach

Keep shared logic DRY, but keep domain logic separate:

```python
def validate_email(email):
    # shared logic
    pass

def create_customer_account(name, email):
    validate_email(email)
    save_customer_to_db(name, email)
    send_customer_welcome_email(email)

def create_admin_account(name, email):
    validate_email(email)
    save_admin_to_db(name, email)
    send_admin_welcome_email(email)
    enable_two_factor_auth(email)
```

✅ Shared logic centralized  
✅ Domain logic distinct  
✅ Code still readable  

---

### 🧭 Takeaway
> **DRY the details, not the domain.**  
> It’s fine for high-level code to repeat if it expresses *different intentions*.
