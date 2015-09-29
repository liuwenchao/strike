server {
    listen 80;

    root /var/www/example/dist;
  	index index.html;
    error_log /var/log/nginx/example.error.log;
    access_log /var/log/nginx/example.access.log;


    server_name example.com;

    location = /index.html {
        expires 0;
    }

    location / {
        expires max;
        add_header Cache-Control "public";
    }
}
