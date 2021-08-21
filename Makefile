CWD:=$(shell pwd)$(pwd:sh)
UNAME:=$(shell uname -s)$(uname -s:sh)
JSETTINGS=PATH=$(CWD)/build/bin:$(PATH) JANET_PATH=$(CWD)/build JANET_HEADERPATH=$(CWD)/janet
CFLAGS=-std=c99 -Wall -Wextra -O2 -fvisibility=hidden
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
build/bin/janet: janet/janet.c janet/janet.h janet/shell.c
	mkdir -p build/bin
	mkdir -p build/lib
	cc $(CFLAGS) -fPIC -o build/bin/janet -Ijanet janet/janet.c janet/shell.c $(LDFLAGS) $(CLIBS)

.PHONY: wasm
wasm: static/js/janet.js
static/js/janet.js: janet/janet.c janet/janet.h janet/webrepl.c build/bin/janet
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
	aws s3 sync site s3://janet-lang.org --delete
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	@echo "Done!"
