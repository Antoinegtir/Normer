FROM fedora:36

RUN dnf install -y bash make

COPY normz.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/normz.sh

CMD ["/usr/local/bin/normz.sh"]
