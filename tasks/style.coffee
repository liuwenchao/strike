gulp = require 'gulp'
$    = require('gulp-load-plugins')()

AUTOPREFIXER_BROWSERS = [
  'ie >= 10',
  'ie_mob >= 10',
  'ff >= 30',
  'chrome >= 34',
  'safari >= 7',
  'opera >= 23',
  'ios >= 7',
  'android >= 4.4',
  'bb >= 10'
]

# Compile and Automatically Prefix Stylesheets
gulp.task 'styles', ->
  # For best performance, don't add Sass partials to `gulp.src`
  gulp.src ['src/css/*.css']
    .pipe $.autoprefixer
      browsers: AUTOPREFIXER_BROWSERS
    .pipe gulp.dest '.tmp/styles'
    # Concatenate And Minify Styles
    .pipe $.if '*.css', $.csso()
    .pipe $.changed 'dist/css'
    .pipe gulp.dest 'dist/css'
    .pipe $.size
      title: 'styles'
