.PHONY: dev
dev:
	zola serve --interface 0.0.0.0

.PHONY: watch-css
watch-css:
	npm run css:watch

.PHONY: build
build:
	zola build

.PHONY: setup
setup:
	npm install

.PHONY: start
start: setup
	pm2 start make -- dev
	pm2 start make -- watch-css
	pm2 logs

.PHONY: kill
kill: 
	pm2 delete all
