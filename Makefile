# Point to location of janet source
JANET_SOURCE=~/code/janet

# Create output directory
$(shell mkdir -p out)
$(shell cp -rf src/* out)

# Generate documentation pages
build: out/index.html \
	out/arrays.html \
	out/abstract_machine.html \
	out/bindings.html \
	out/buffers.html \
	out/data_structures.html \
	out/destructuring.html \
	out/fibers.html \
	out/flow.html \
	out/functions.html \
	out/introduction.html \
	out/loop.html \
	out/macros.html \
	out/numbers.html \
	out/peg.html \
	out/prototypes.html \
	out/specials.html \
	out/strings.html \
	out/syntax.html

out/%.html: md/%.md templates/docpage.html tools/templater.janet tools/md.janet
	tools/templater.janet \
		--content $< \
		--out $@ \
		--template templates/docpage.html

out/index.html: md/index.md templates/index.html tools/templater.janet tools/md.janet
	tools/templater.janet \
		--content $< \
		--out $@ \
		--template templates/index.html

# Run a local version of the website
run: build
	cd out && python3 -m http.server 8080

# Rebuild web version of janet for online REPL with latest Janet
refresh:
	$(MAKE) -C $(JANET_SOURCE) docs
	cp $(JANET_SOURCE)/build/doc.html src/doc.html
	$(MAKE) -C $(JANET_SOURCE) emscripten -j 16
	cp $(JANET_SOURCE)/build/janet.js src/js/janet.js
	cp $(JANET_SOURCE)/build/janet.wasm src/js/janet.wasm

# Deploy static website to AWS
deploy: build
	echo "Deploying..."
	aws s3 rm s3://janet-lang.org --recursive
	aws s3 cp out s3://janet-lang.org --recursive
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	echo "Done!"

.PHONY: deploy run refresh build
