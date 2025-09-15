Here’s a breakdown of **which directives are valid in which context**:

---

## 📍 Context hierarchy

```bash
http {
	server {
		location {
        }
    }
}
```

## 🌍 http-level (top)

Allowed:

- `client_max_body_size`
- `error_page`
- `server`

## 📦 server-level (inside `server {}`)

Allowed:

- `listen`
- `server_name`
- `root`
- `location`
- `client_max_body_size` (optional override)
- `error_page` (optional override)

## 📂 location-level (inside `location {}`)

Allowed:

- `root`
- `limit_except`
- `deny` (only inside `limit_except`)
- `index`
- `autoindex`
- `return`
- `client_max_body_size` (optional override)
- `upload_store`
- `cgi_pass`

## 🛑 Special rules

- `server` is only valid inside `http`.
- `location` is only valid inside `server`.
- `limit_except` is only valid inside `location`.
- `deny` is only valid inside `limit_except`.

---

✅ With this table you can enforce:

- If someone puts `listen` inside `http`, throw an error.
- If `deny` appears outside `limit_except`, throw an error.
- If `location` is declared outside `server`, throw an error.
