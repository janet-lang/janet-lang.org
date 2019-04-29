# Point to location of janet source
JANET_SOURCE=~/code/janet

default: build

build:
	mdz build

watch:
	mdz watch

# Run a local version of the website
run:
	mdz serve 8080

# Rebuild web version of janet for online REPL with latest Janet
refresh:
	$(MAKE) -C $(JANET_SOURCE) docs
	cp $(JANET_SOURCE)/build/doc.html static/doc.html
	$(MAKE) -C $(JANET_SOURCE) emscripten -j 16
	cp $(JANET_SOURCE)/build/janet.js static/js/janet.js
	cp $(JANET_SOURCE)/build/janet.wasm static/js/janet.wasm

# Deploy static website to AWS
deploy: build
	echo "Deploying..."
	aws s3 rm s3://janet-lang.org --recursive
	aws s3 cp site s3://janet-lang.org --recursive
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	echo "Done!"

clean:
	mdz clean

.PHONY: deploy run refresh build clean default watch
