CWD:=$(shell pwd)$(pwd:sh)
UNAME:=$(shell uname -s)$(uname -s:sh)
JSETTINGS=PATH=$(CWD)/build/bin:$(PATH) JANET_PATH=$(CWD)/build JANET_HEADERPATH=$(CWD)/janet
CFLAGS=-std=c99 -Wall -Wextra -Og -fvisibility=hidden
CLIBS=-lm -lpthread
LDFLAGS=-rdynamic
ifeq ($(UNAME), Darwin)
	CLIBS:=$(CLIBS) -ldl
else ifeq ($(UNAME), Linux)
	CLIBS:=$(CLIBS) -lrt -ldl
else ifeq ($(UNAME), Haiku)
	LDFLAGS=-Wl,--export-dynamic
endif

.PHONY: default
default: build

# Also set things up.
build/bin/janet: janet/janet.c janet/janet.h janet/janetconf.h janet/shell.c
	mkdir -p build/bin
	mkdir -p build/lib
	cp janet/jpm build/bin
	cc $(CFLAGS) -fPIC -g -o build/bin/janet -Ijanet janet/janet.c janet/shell.c $(LDFLAGS) $(CLIBS)
	$(JSETTINGS) build/bin/janet build/bin/jpm install mendoza
	$(JSETTINGS) build/bin/janet build/bin/jpm install https://github.com/andrewchambers/janet-where-defined

.PHONY: wasm
wasm: static/js/janet.js
static/js/janet.js: janet/janet.c janet/janet.h janet/janetconf.h janet/webrepl.c build/bin/janet
	mkdir -p build
	emcc $(CFLAGS) -o static/js/janet.js -Ijanet janet/janet.c janet/webrepl.c \
		-s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap"]' \
		-s ALLOW_MEMORY_GROWTH=1 \
		-s AGGRESSIVE_VARIABLE_ELIMINATION=1 \
		-DJANET_BUILD=$$(build/bin/janet -e '(print `"` janet/build `"`)')

.PHONY: build
build: build/bin/janet
	@$(JSETTINGS) mdz build

.PHONY: clean
clean: build/bin/janet
	@$(JSETTINGS) mdz clean

.PHONY: watch
watch: build/bin/janet
	@$(JSETTINGS) mdz watch

.PHONY: run
run: build/bin/janet
	@$(JSETTINGS) mdz serve

.PHONY: deploy
deploy: build
	@echo "Deploying..."
	aws s3 rm s3://janet-lang.org --recursive
	aws s3 cp site s3://janet-lang.org --recursive
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	@echo "Done!"
