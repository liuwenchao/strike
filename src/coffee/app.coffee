$ = require 'jquery'
ko = require 'knockout'
account = require 'account'
news = require 'news'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.'))

switch route
  when 'register'
    ko.applyBindings account
  when 'news'
    news.list()
    ko.applyBindings news
  else # fall back to index
    account.load()
    ko.applyBindings account
