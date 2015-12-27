VERSION = $(shell grep version package.json | grep -oE '[0-9\.]+')
PKGNAME = $(shell grep name package.json |/bin/grep -o '[^"]*",'|/bin/grep -o '[^",]*')

COFFEE = coffee -c -b

RM = rm -rf

COFFEE_TARGETS = $(shell find src/lib -type f -name "*.coffee"|sed 's,src/,,'|sed 's,\.coffee,\.js,')

lib: ${COFFEE_TARGETS}

lib/%.js: src/lib/%.coffee
	$(COFFEE) -o lib $<

clean:
	$(RM) lib
