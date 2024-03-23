.PHONY: dev
dev:
	zola serve --interface 0.0.0.0

.PHONY: watch-css
watch-css:
	npm run css:watch

.PHONY: build
build:
	zola build
