### 1. What you have in your config

```nginx
server {

	location / {
		root /data/www;
    }

	location /images/ {
		root /data;
    }
}
```

So you have **two location blocks**:

- `location /` → maps to `/data/www`
- `location /images/` → maps to `/data/images` (because root is `/data`)

The question is: **when a request comes in, how does Nginx pick which `location` block to use?**

---

### 2. URI matching basics

When Nginx receives a request, e.g.:

`GET /images/example.png HTTP/1.1`

It looks at the **URI** (`/images/example.png`) and compares it to the `location` blocks inside the server that matched the request (based on server name and port).

**Step-by-step matching:**

1.  **Literal prefix match**: Nginx first looks for `location` blocks where the URI **starts with the prefix specified in the block**.

    - `/images/example.png` starts with `/images/` → matches `location /images/`
    - `/images/example.png` also starts with `/` → matches `location /`

2.  **Longest prefix wins**: If multiple `location` blocks match, Nginx **picks the one with the longest matching prefix**.

    - `/images/` is longer than `/` → Nginx chooses `location /images/`

3.  **Other types of matching** (optional for your understanding):

    - `location = /exact` → exact match
    - `location ~ /regex/` → regex match
    - `location ^~ /prefix/` → stops checking further if this prefix matches

For your example, Nginx **does not need to scan the filesystem first**. It only compares the **URI string** to the location prefixes.

---

### 3. After the location is chosen

Once a location block is selected:

- The URI is combined with the `root` directive to form the filesystem path.
- For example:

```bash
URI: /images/example.png
Matched location: /images/
Root: /data
Path = /data/images/example.png`
```

- Then Nginx tries to read that file. If it exists → serve it, else → 404.

---

### 4. Code perspective

If you were writing this logic yourself, it might look like this in pseudocode:

```cpp
string select_location(string uri, vector<Location> locations)
{
    Location* best_match = nullptr; int longest_prefix = -1;

	for (Location loc : locations)
	{
		if (uri.starts_with(loc.prefix))
		{
			if (loc.prefix.length() > longest_prefix)
			{
                best_match = &loc;
                longest_prefix = loc.prefix.length();
            }
        }
    }

	return best_match ? best_match->prefix : "/";
}
```

- `uri.starts_with(loc.prefix)` → checks if the request URI matches the location prefix.
- `longest_prefix` → ensures that the **most specific match wins**.

This is exactly how Nginx internally handles simple prefix location blocks.

---

✅ **Summary**

1.  Nginx looks only at the **URI**, not the filesystem, for matching `location` blocks.
2.  It finds all matching `location` prefixes.
3.  The **longest prefix match wins**.
4.  Only after selecting a location, Nginx uses `root` to map to a filesystem path.
