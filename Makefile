CC = clang
CFLAGS = -Wall -Wextra -O2
FRAMEWORKS = -framework CoreGraphics -framework ApplicationServices
PREFIX = /usr/local

all: keyguard snoop-key

keyguard: keyguard.c
	$(CC) $(CFLAGS) -o $@ $< $(FRAMEWORKS)

snoop-key: snoop-key.c
	$(CC) $(CFLAGS) -o $@ $< $(FRAMEWORKS)

install: keyguard
	install -m 755 keyguard $(PREFIX)/bin/keyguard

clean:
	rm -f keyguard snoop-key

.PHONY: install clean
