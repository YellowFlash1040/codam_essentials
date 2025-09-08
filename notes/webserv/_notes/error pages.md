In **nginx**, you can specify custom error pages using the `error_page` directive inside a `server` or `location` block. Here's the basic syntax:

```nginx
server {
    listen 80;
    server_name example.com;

    root /var/www/html;

    # Default error pages
    error_page 404 /custom_404.html;
    error_page 500 502 503 504 /custom_50x.html;

    # Location for custom pages
    location = /custom_404.html {
        internal;  # Prevent direct access from clients
    }

    location = /custom_50x.html {
        internal;
    }
}
```

### Key points:

1.  `error_page <code> <uri>` – maps an HTTP status code (or multiple) to a URI for the error page.
2.  `internal` – ensures the page can only be served as an error response, not directly requested.
3.  You can specify multiple codes at once (e.g., `500 502 503 504`).
4.  The URI can be an absolute path (like `/errors/404.html`) relative to your `root`.
