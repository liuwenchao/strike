$  = require 'jquery'
ko = require 'knockout'

route = window.location.pathname.substr(1,window.location.pathname.indexOf('.')-1)

switch route
  when 'home'
    ko.applyBindings
      welcome: 'Knockout Weppack and CoffeeScript'
      suprise: -> window.alert 'And a CHEESEBURG!'

  when 'proxy'
    window.alert 'I have done something important before you enter'
    window.location = 'home.html'

  else # do nothing
