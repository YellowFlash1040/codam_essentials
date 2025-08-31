If you want your webserver to be portable across **Linux, BSD, and macOS**  
you need to wrap your code with **OS-specific macros**.  
Here's a summary of the macros and the platforms they represent:

---

### 1. Linux

- **Macros:**

```c
#if defined(__linux__)
```

- **Available functions:**  
  `select`, `poll`, `epoll_create`, `epoll_ctl`, `epoll_wait`

---

### 2. macOS

- **Macros:**

```c
#elif defined(__APPLE__) && defined(__MACH__)
```

- **Available functions:**  
  `select`, `poll`, `kqueue`, `kevent`

---

### 3. FreeBSD (and most BSD variants)

- **Macros:**

```c
#elif defined(__FreeBSD__)
```

- **Available functions:**  
  `select`, `poll`, `kqueue`, `kevent`
- **Other BSDs:**  
  OpenBSD: `__OpenBSD__`  
  NetBSD: `__NetBSD__`  
  DragonFlyBSD: `__DragonFly__`

---

### 4. Generic fallback

- **Macro:**

```c
#else
#error "Unsupported OS"
#endif
```

- You could fall back to `select` or `poll` if you want basic functionality.

---

### Example skeleton

```c
#if defined(__linux__)
#include <sys/epoll.h>
void runEventLoop()
{
    // Use epoll
}
#elif defined(__APPLE__) && defined(__MACH__)
#include <sys/event.h>
void runEventLoop()
{
    // Use kqueue
}
#elif defined(__FreeBSD__)
#include <sys/event.h>
void runEventLoop()
{
    // Use kqueue
}
#else
#error "Unsupported OS"
#endif
```

A way to make macro a bit more readable:

```c
// Define a macro that represents all BSD-like or Apple platforms
#if !defined(PLATFORM_BSD_OR_APPLE)
#define PLATFORM_BSD_OR_APPLE  \
    (defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__))
#endif

// Then use it in your preprocessor directive
#elif PLATFORM_BSD_OR_APPLE
    // Your platform-specific code here
```

```c
// Define individual platform macros
#define IS_APPLE   defined(__APPLE__)
#define IS_FREEBSD defined(__FreeBSD__)
#define IS_OPENBSD defined(__OpenBSD__)
#define IS_NETBSD  defined(__NetBSD__)
#define IS_DRAGON  defined(__DragonFly__)

// Combine them in the preprocessor check
#elif (IS_APPLE || IS_FREEBSD || IS_OPENBSD || IS_NETBSD || IS_DRAGON)
    // Your platform-specific code here
```
