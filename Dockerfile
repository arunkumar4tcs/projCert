FROM devopsedu/webapp
COPY . /var/www/html/
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
