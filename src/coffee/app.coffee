$ = require 'jquery'
ko = require 'knockout'
account = require 'account'
news = require 'news'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.')-1)

switch route
  when 'register'
    ko.applyBindings account
  when 'news'
    news.list()
    ko.applyBindings news
  when 'news_detail'
    ko.applyBindings news.load window.location.search.substr 4
  else # fall back to index
    account.load()
    ko.applyBindings account
