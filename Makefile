.PHONY: serve
serve:
	zola serve

.PHONY: watch-css
watch-css:
	npm run css:watch

.PHONY: build
build:
	zola build