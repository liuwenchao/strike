$           = require 'jquery'
ko          = require 'knockout'
account     = require 'account'
news        = require 'news'
hangqing    = require 'hangqing'
caigou      = require 'caigou'
supply      = require 'supply'
address     = require 'address'

route = window.location.pathname.substr(1,window.location.pathname.indexOf('.')-1)

switch route
  when 'home'
    account.load()
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
  when 'supplies'
    supply.result.q location.search.substr 3
    supply.list()
    ko.applyBindings supply
  when 'supply'
    ko.applyBindings supply.load location.search.substr 4
  when 'myorder'
    caigou.listMine()
    supply.listMine()
    ko.applyBindings
      caigou: caigou
      supply: supply
  when 'orders'
    caigou.list()
    ko.applyBindings
      result: caigou.result
  when 'profile'
    account.load ->
      account.address.area(account.profile.area())
    , ->
      window.location.href='/'

    account.address.listArea ->
      account.profile.area(account.address.area())

    ko.applyBindings
      profile: account.profile
      address: account.address
      save: account.save
  when 'news'
    news.list()
    ko.applyBindings news
  when 'news_detail'
    ko.applyBindings news.load window.location.search.substr 4
  when 'hangqing'
    ko.applyBindings hangqing
  when 'register'
    ko.applyBindings account
  when 'oauth'
    #
  else
