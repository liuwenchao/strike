$ = require 'jquery'
ko = require 'knockout'
account = require 'account'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.'))

switch route
  when 'news'
    account.load()
    ko.applyBindings account
  else # fall back to index
    account.load()
    ko.applyBindings account
