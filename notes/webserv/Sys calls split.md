## **Syscalls & libc functions categorization**

## 🔹 Part 1: **Configuration & Setup (Config person)**

Mostly parsing files and checking paths. Functions here are about **filesystem access**.

-   `access` → check if file exists / permissions (for config validation, error pages, CGI scripts).
-   `stat` → check file metadata (is it a dir? size?).
-   `open`, `close` → if for some reason you don't want to use C++ `ifstream`.
-   `opendir`, `readdir`, `closedir` → useful if config allows directory listing (not mandatory).
-   `strerror`, `errno` → error reporting during parsing/validation.

## 🔹 Part 2: **Networking & Event Loop (Network person)**

Everything about **sockets and non-blocking event multiplexing**.

-   Socket creation/connection:
    -   `socket`, `bind`, `listen`, `accept`, `connect`, `getsockname`, `getprotobyname`
    -   `setsockopt` (e.g. SO_REUSEADDR, SO_NOSIGPIPE)
    -   `getaddrinfo`, `freeaddrinfo`
-   Endianness helpers:
    -   `htons`, `htonl`, `ntohs`, `ntohl`
-   Event multiplexing:
    -   `select`, `poll`,
    -   `epoll_create`, `epoll_ctl`, `epoll_wait`,
    -   `kqueue`, `kevent`
-   Data transfer:
    -   `send`, `recv`,
-   FD management:
    -   `fcntl` (set O_NONBLOCK, FD_CLOEXEC, etc.)
    -   `read`, `write`
    -   `close`
-   Error handling:
    -   `strerror`, `gai_strerror`, `errno`

## 🔹 Part 3: **HTTP & CGI Handling (HTTP person)**

Where **request parsing, response generation, and CGI execution** happen.

-   CGI execution:
    -   `fork`, `execve`, `waitpid`
    -   `pipe`, `dup`, `dup2` (redirect stdin/stdout to CGI)
    -   `socketpair` (optional alternative to pipe)
-   Environment / working dir:
    -   `chdir` (for CGI execution inside correct directory)
-   Signals:
    -   `signal`, `kill` (handle child termination, timeouts)
-   File system (static file serving, error pages, upload dirs):
    -   `open`, `read`, `write`, `close`
    -   `stat` (get file size/type, check for directory listing)
    -   `access` (check file/script existence and permissions at request time)
-   Error handling:
    -   `strerror`, `errno` (report system errors in responses).
