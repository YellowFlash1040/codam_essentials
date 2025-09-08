In Nginx, you can set the maximum allowed size for client request bodies using the **`client_max_body_size`** directive. This limits the size of files or data that clients can send in POST requests.

Here’s how you can do it:

### Example:

```
http {
    client_max_body_size 20M;  # Limit to 20 megabytes

    server {
        listen 80;
        server_name example.com;

        location / {
            root /var/www/html;
            index index.html;
        }
    }
}
```

### Key points:

- You can also put `client_max_body_size` inside a `server` or `location` block if you want to set it per server or per location.
- The size can be specified in **bytes**, **k** (kilobytes), **m** (megabytes), or **g** (gigabytes).
- Default is **1M** if not specified.

#### Example per location:

```
server {
    listen 80;
    server_name example.com;

    location /uploads {
        client_max_body_size 50M;
    }
}
```

This allows larger uploads only for `/uploads`, leaving other locations at the default 1 MB.

---

When a client sends a request body larger than the `client_max_body_size` limit in Nginx:

1.  **Nginx immediately stops reading the request body** once the limit is exceeded.
2.  **It returns an HTTP 413 “Payload Too Large” error** to the client.
3.  **The request is not forwarded** to any upstream servers or processed further.

Some extra notes:

- The error can be **customized** using the `error_page` directive:

```
server {
    listen 80;
    server_name example.com;

    client_max_body_size 10M;

    error_page 413 /custom_413.html;

    location / {
        root /var/www/html;
    }

    location = /custom_413.html {
        root /var/www/errors;
    }
}
```

- This way, users see a friendly error page instead of the default 413 response.

So essentially, `client_max_body_size` protects your server from too-large requests and can be handled gracefully with a custom error page.
