$  = require 'jquery'
ko = require 'knockout'
require 'css/style.css'

route = window.location.pathname.substr(1,window.location.pathname.indexOf('.')-1)

switch route
  when 'home'
    ko.applyBindings
      welcome: 'Weppack, Gulp, CoffeeScript and Knockout (Or other MVVM)'
      suprise: -> window.alert 'And a CHEESEBURG!'

  when 'proxy'
    window.alert 'I have done something important before you enter'
    window.location = 'home.html'

  else # do nothing
