VERSION = $(shell grep version package.json | grep -oE '[0-9\.]+')
PKGNAME = $(shell grep name package.json |/bin/grep -o '[^"]*",'|/bin/grep -o '[^",]*')

COFFEE = coffee -c -b -p

RM = rm -rf
MKDIR = mkdir -p

		# --loose-for-expressions \
		# --loose-for-of \
		# --loose-includes
DECAF = decaffeinate \
		--loose \
		--disallow-invalid-constructors
DECAF_DIR = decaf-lib

DECAF_TARGETS = $(shell find src -type f -name "*.coffee"|sed 's,src/,./,'|sed 's,\.coffee,\.js,')

.PHONY: all

all: ${DECAF_TARGETS}

bin/%.js: src/bin/%.coffee
	@$(MKDIR) $(shell dirname $@)
	$(DECAF) < $< > $@

lib/%.js: src/lib/%.coffee
	@$(MKDIR) $(shell dirname $@)
	$(DECAF) < $< > $@

test/%.js: src/test/%.coffee
	@$(MKDIR) $(shell dirname $@)
	$(DECAF) < $< > $@
