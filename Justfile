default: start

# Starts dev server
serve:
	zola serve --interface 127.0.0.1

# Watches and rebuild CSS
watch-css:
	npm run css:watch

# Builds app
build:
	zola build

# Install dependencies
setup:
	npm install

# Start development stack using pm2
start: setup kill
	pm2 start just -- serve
	pm2 start just -- watch-css
	pm2 logs

# Stops development stack
kill: 
	-pm2 delete all
