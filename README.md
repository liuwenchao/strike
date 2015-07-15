## Weixin application for zhaomei

# Introduction of the Framework
This Frontend StarterKit is a barebones framework with [gulp](http://gulpjs.com/) and [webpack](http://webpack.github.io/) fully configured for rapid development.

Webpack runs webpack-dev-server in development for on-the-fly compilation of source file changes. It can also compile assets for production.

CoffeeScript, SCSS and Bower are installed and configured.

By default, CSS files are included by requiring them in JavaScript files via webpack magic. This reduces network latency and allows webpack to intelligently manage which files are actually required. See [src/js/head.coffee](src/js/head.coffee).


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

# open this in browser, make sure 80 port is not used.
open http://dev.wx.zhaomw.cn/webpack-dev-server/index.html
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
