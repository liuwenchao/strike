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
    caigou.listMine()
    supply.listMine()
    ko.applyBindings
      caigou: caigou
      supplies: supply.mine
  when 'orders'
    caigou.list()
    ko.applyBindings
      result: caigou.result
  when 'profile'
    successCallback = -> account.address.area(account.profile.area())
    errorCallback   = -> window.location.href='/'
    account.load successCallback, errorCallback

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
  when 'oauth'
    #
  else
