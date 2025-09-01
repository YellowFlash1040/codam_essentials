### 1. Endianness background

- **Host byte order**: The way your computer stores multibyte values in memory (could be little-endian or big-endian).
- **Network byte order**: By convention, always **big-endian** on the Internet.

So, when sending/receiving data across the network, you often need to convert between host order and network order.

---

### 2. The functions

- **`htons`**  
  _Host TO Network Short_  
  Converts a 16-bit (2-byte) value from host order → network order.  
  Example use: Port numbers (because ports are 16-bit values).
- **`htonl`**  
  _Host TO Network Long_  
  Converts a 32-bit (4-byte) value from host order → network order.  
  Example use: IPv4 addresses (because they are 32-bit values).

---

### 3. Opposites (when receiving data)

- **`ntohs`** = Network TO Host Short (16-bit)
- **`ntohl`** = Network TO Host Long (32-bit)

---

### 4. Where to use which

- **When binding or connecting sockets**:

```c
struct  sockaddr_in  addr;
addr.sin_family = AF_INET;
addr.sin_port = htons(8080); // convert port (16-bit)
addr.sin_addr.s_addr = htonl(INADDR_ANY); // convert IPv4 (32-bit)`
```

- **When parsing received data**:

```c
uint16_t port = ntohs(addr.sin_port);
uint32_t ip   = ntohl(addr.sin_addr.s_addr);
```

---

✅ **Rule of thumb:**

- If it’s a **port** → use **`htons` / `ntohs`**.
- If it’s an **IPv4 address** or any other 32-bit number → use **`htonl` / `ntohl`**.
