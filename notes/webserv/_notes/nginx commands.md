`nginx -s stop -c $(pwd)/nginx.conf` - start server
`nginx -c $(pwd)/nginx.conf` - stop server
`nginx -t -c $(pwd)/nginx.conf` - test config file

nginx.conf file example:

```
pid /tmp/nginx.pid;

events {}

http
{
	error_log /tmp/error.log;
    access_log /tmp/access.log;

    server
	{
        listen 8080;
        server_name localhost;
        root /home/youruser/current_folder/html;
        index index.html;

        location / {
            autoindex on;
        }
    }
}
```
