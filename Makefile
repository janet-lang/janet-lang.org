CWD:="$(shell pwd)$(pwd:sh)"
UNAME:=$(shell uname -s)$(uname -s:sh)
JSETTINGS=PATH="$(CWD)/build/bin:$(PATH)" JANET_PATH="$(CWD)/build" JANET_HEADERPATH="$(CWD)/janet" JANET_BINPATH="$(CWD)/build/bin"
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

build/bin/janet: janet/janet.c janet/janet.h janet/shell.c
	mkdir -p build/bin
	mkdir -p build/lib
	mkdir -p build/share/man/man1
	cc $(CFLAGS) -fPIC -o build/bin/janet -Ijanet janet/janet.c janet/shell.c $(LDFLAGS) $(CLIBS)
	git clone https://github.com/janet-lang/jpm || true
	cd jpm && git pull origin master || true
	@cd jpm && $(JSETTINGS) PREFIX=$(CWD)/build/ $(CWD)/build/bin/janet bootstrap.janet
	@$(JSETTINGS) build/bin/jpm install mendoza
	@$(JSETTINGS) build/bin/jpm install spork

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
	@$(JSETTINGS) build/bin/mdz build

.PHONY: clean
clean: build/bin/janet
	@$(JSETTINGS) build/bin/mdz clean

.PHONY: watch 
watch: build/bin/janet
	@$(JSETTINGS) build/bin/mdz watch

.PHONY: run
run: build/bin/janet
	@$(JSETTINGS) build/bin/mdz serve

.PHONY: deploy
deploy: build
	@echo "Deploying..."
	aws s3 sync site s3://janet-lang.org --delete
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	@echo "Done!"
