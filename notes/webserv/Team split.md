
## 🔹 Proposal: Split into 3 Major Parts

### **1. Configuration & Setup (Member A – "Config person")**

**Responsibilities:**
-   Parse `.conf` file (nginx-like format).
-   Build internal representation of servers and locations.
-   Provide an API for others to query settings (root dir, error pages, CGI path, methods allowed, etc.).
    

**Folder:**
`config/`

**Deliverable:**
-   A clean `Config` object.
-   Something like `ServerConfig serverConfigs[];` that networking code can loop over to create listening sockets.
    

----------

### **2. Networking & Event Loop (Member B – "Network person")**

**Responsibilities:**
-   Initialize sockets from config.
-   Handle non-blocking I/O with epoll/kqueue/poll.
-   Accept new clients, track them, and feed raw data into HTTP parser.
-   Manage client lifecycle (connected → request read → response sent → close).
    

**Folder:**
`network/` 

**Deliverable:**
-   Pass **raw HTTP requests** (as strings/buffers) to the HTTP layer.
-   Take **responses** (as strings/buffers) from HTTP layer and send to clients.
    

----------

### **3. HTTP Parsing & Response Handling (Member C – "HTTP person")**

**Responsibilities:**

-   Parse requests (headers, method, URI, body).    
-   Decide response (static file, CGI, error).
-   Build response (status line, headers, body).
-   Run CGI scripts (fork/execve, environment, pipes).
-   Generate error responses.
    

**Folder:**
`http/` 

**Deliverable:**

-   Provide API:
    `HttpResponse handleRequest(HttpRequest&, const ServerConfig&, const LocationConfig&);` 
    
-   Return a complete `HttpResponse` that networking layer just writes back to client.

## 🔄 How the Parts Interact

1.  **Config person** provides `ServerConfig`s → **Network person** uses them to open sockets.
    
2.  **Network person** feeds raw buffers from clients → **HTTP person** parses them into `HttpRequest`.
    
3.  **HTTP person** produces an `HttpResponse` → **Network person** sends it back.

## ⚡️ Benefits of this Split

-   Each member is responsible for **one clear domain** meaning fewer merge conflicts.
-   You can test each part independently:
    -   Config parser tested with `.conf` files.    
    -   Networking tested with `curl`.
    -   HTTP tested with fake raw requests (unit tests).