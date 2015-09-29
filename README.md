## HTML skeleton based on Knockout, Webpack and CoffeeScript

# Introduction
This is a barebones framework fully configured for rapid development with following:
* [webpack](http://webpack.github.io/)
* [gulp](http://gulpjs.com/)
* [CoffeeScript](http://coffeescript.org/)
* [Knockout](http://knockoutjs.com) - You can easily replace it with other MVVM framework

Webpack runs webpack-dev-server in development for on-the-fly compilation of source file changes. It can also compile assets for production.

CoffeeScript, SCSS and Bower are installed and configured.

By default, CSS files are included by requiring them in JavaScript files via webpack magic. This reduces network latency and allows webpack to intelligently manage which files are actually required.


# Install

```bash
##install node.js npm
# https://nodejs.org/

# set this if you are in China
npm config -g set registry "http://registry.npm.taobao.org/"

# update npm
npm install -g npm
# install development tools
npm install -g gulp webpack-dev-server bower coffee-script
# install project dependencies
npm install

# open this in browser
open http://localhost:8080/webpack-dev-server/index.html
# or
open http://localhost:8080/index.html
```

# Development

```bash
# Run webpack-dev-server
gulp

# Or manually run webpack if needed
webpack -d --colors
```

# Production

```bash
# Compile assets for production
gulp build
```
