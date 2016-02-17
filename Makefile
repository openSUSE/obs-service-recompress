prefix = /usr

servicedir = ${prefix}/lib/obs/service

all:

install:
	install -d $(DESTDIR)$(servicedir)
	install -m 0755 recompress $(DESTDIR)$(servicedir)
	install -m 0644 recompress.service $(DESTDIR)$(servicedir)

test:
	prove t/*.t

.PHONY: all install test
