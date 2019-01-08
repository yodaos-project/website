dist/docs:
	@mkdir -p dist
	tools/build-apidocs.sh

dist/index.html: dist/docs
	tools/build-page.js index > $@

dist/downloads: dist/docs
	@mkdir -p dist/downloads
	tools/build-page.js downloads > $@/index.html

dist/assets:
	@mkdir -p dist/assets
	cp assets/* ./dist/assets/

dist: dist/docs dist/index.html dist/downloads dist/assets

clean:
	@rm -rf ./dist
