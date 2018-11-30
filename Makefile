run:
	cd src && python3 -m http.server 8080

refresh:
	$(MAKE) -C ~/code/janet janet.js -j 16
	cp ~/code/janet/janet.js src/js/janet.js
	cp ~/code/janet/janet.wasm src/js/janet.wasm

deploy:
	echo "Deploying..."
	aws s3 rm s3://janet-lang.org --recursive
	aws s3 cp src s3://janet-lang.org --recursive
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	echo "Done!"

.PHONY: deploy run refresh
