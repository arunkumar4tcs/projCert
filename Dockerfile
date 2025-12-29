FROM devopsedu/webapp
COPY . /var/www/html/
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
