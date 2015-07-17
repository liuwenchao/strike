$ = require 'jquery'
ko = require 'knockout'
account = require 'account'
# account = require 'account'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.'))

switch route
  when 'register'
    ko.applyBindings account
  when 'news'
    ko.applyBindings account
  else # fall back to index
    account.load()
    ko.applyBindings account
