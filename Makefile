dist/docs:
	tools/build-apidocs.sh

dist/index.html: dist/docs
	@mkdir -p dist
	tools/build-homepage.js > $@

dist: dist/docs dist/index.html

clean:
	@rm -rf ./dist
