$ = require 'jquery'
ko = require 'knockout'
account = require 'account'
news = require 'news'
hangqing = require 'hangqing'
caigou = require 'caigou'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.')-1)

switch route
  when 'register'
    ko.applyBindings account
  when 'caigou_new'
    ko.applyBindings
      save: caigou.create
  when 'news'
    news.list()
    ko.applyBindings news
  when 'news_detail'
    ko.applyBindings news.load window.location.search.substr 4
  when 'hangqing'
    ko.applyBindings hangqing
  else # fall back to index
    account.load()
    ko.applyBindings account
