VERSION = $(shell grep version package.json | grep -oE '[0-9\.]+')
PKGNAME = $(shell grep name package.json |/bin/grep -o '[^"]*",'|/bin/grep -o '[^",]*')

COFFEE = coffee -c -b -p

RM = rm -rf
MKDIR = mkdir -p

LIB_TARGETS = $(shell find src/lib -type f -name "*.coffee"|sed 's,src/,,'|sed 's,\.coffee,\.js,')
TEST_TARGETS = $(shell find src/test -type f -name "*.coffee"|sed 's,src/,,'|sed 's,\.coffee,\.js,')

.PHONY: all

all: lib test

lib: ${LIB_TARGETS}

lib/%.js: src/lib/%.coffee
	@$(MKDIR) $(shell dirname $@)
	$(COFFEE) $< > $@

test/%.js: src/test/%.coffee
	@$(MKDIR) $(shell dirname $@)
	$(COFFEE) $< > $@

test: lib ${TEST_TARGETS}
	@sed -i 's,/src/,/,' ${TEST_TARGETS}

clean:
	$(RM) lib
	$(RM) test
