$ = require 'jquery'
ko = require 'knockout'
account = require 'account'
news = require 'news'
hangqing = require 'hangqing'
caigou = require 'caigou'
supply = require 'supply'
address = require 'address'

route = window.location.pathname.substr(1,window.location.pathname.lastIndexOf('.')-1)

switch route
  when 'register'
    ko.applyBindings account
  when 'caigou_new'
    ko.applyBindings
      save: caigou.create
  when 'supply_new'
    address.listArea()
    ko.applyBindings
      save: supply.create
      area: address.area
      area_list: address.area_list
      city_list: address.city_list
  when 'myorder'
    news.list()
    ko.applyBindings news
  when 'orders'
    caigou.list()
    ko.applyBindings
      records: caigou.records
      more: caigou.more
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
