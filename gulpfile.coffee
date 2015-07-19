# See example gulpfile.js for file system development build:
# https://github.com/webpack/webpack-with-common-libs/blob/master/gulpfile.js

del               = require 'del'

gulp              = require 'gulp'
$                 = require('gulp-load-plugins')();
gutil             = require 'gulp-util'
RevAll            = require 'gulp-rev-all'

webpack           = require 'webpack'
WebpackDevServer  = require 'webpack-dev-server'
webpackConfig     = require './webpack.config.coffee'

AUTOPREFIXER_BROWSERS = [
  'ie >= 10'
  'ie_mob >= 10'
  'ff >= 30'
  'chrome >= 34'
  'safari >= 7'
  'opera >= 23'
  'ios >= 7'
  'android >= 4.4'
  'bb >= 10'
]

# Default task
gulp.task 'default', ['webpack-dev-server'], ->


############################################################
# Development build
############################################################
gulp.task 'webpack-dev-server', (callback) ->
  # modify some webpack config options
  conf = Object.create webpackConfig
  conf.devtool = 'source-map'
  conf.debug = true

  # Start a webpack-dev-server
  new WebpackDevServer webpack(conf),
    contentBase: conf.contentBase
    stats:
      colors: true
  .listen 8080, 'dev.wx.zhaomw.cn', (err) ->
    throw new gutil.PluginError('webpack-dev-server', err) if err
    gutil.log '[webpack-dev-server]', 'http://localhost:8080/webpack-dev-server/index.html'


############################################################
# Production build
############################################################
gulp.task 'clean', del.bind null, ['dist']

gulp.task 'build', ['webpack:build'], ->
  revAll = new RevAll()
  gulp.src 'src/**'
  .pipe $.if '*.css'
  , $.autoprefixer
    browsers: AUTOPREFIXER_BROWSERS
  , $.csso()
  .pipe $.if '*.html', $.minifyHtml
    empty: true
    spare: true
  .pipe revAll.revision()
  .pipe gulp.dest 'dist'

gulp.task 'webpack:build', (callback) ->
  conf = Object.create webpackConfig
  conf.plugins = conf.plugins.concat new webpack.DefinePlugin
    'process.env':
      NODE_ENV: JSON.stringify('production')
  , new webpack.optimize.DedupePlugin()
  , new webpack.optimize.UglifyJsPlugin()

  # run webpack
  webpack conf, (err, stats) ->
    throw new gutil.PluginError('webpack:build', err) if err
    gutil.log '[webpack:build]', stats.toString colors: true
    callback()
