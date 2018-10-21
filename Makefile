deploy:
	echo "Deploying..."
	aws s3 rm s3://janet-lang.org --recursive
	aws s3 cp src s3://janet-lang.org --recursive
	aws cloudfront create-invalidation --distribution-id E36S10WSIVPLGB --paths "/*"
	echo "Done!"

.PHONY: deploy
