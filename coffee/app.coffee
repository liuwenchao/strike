$           = require 'jquery'
ko          = require 'knockout'
Swipe       = require 'swipe'
account     = require 'account'
news        = require 'news'
hangqing    = require 'hangqing'
ads         = require 'ads'
caigou      = require 'caigou'
supply      = require 'supply'
address     = require 'address'
variety     = require 'variety'
keyword     = require 'keyword'
weixin      = require 'weixin'

route = window.location.pathname.substr(1,window.location.pathname.indexOf('.')-1)

switch route
  when 'home'
    supply.result.size 4
    supply.result.filter.ifsale 1
    supply.list()
    ads.list()
    account.load false, ->
    ko.applyBindings
      account: account
      sales: supply.result.rows
      ads:   ads.records
    # http://www.idangero.us/swiper/api/#
    new Swipe '.swiper-container',
      pagination: '.swiper-pagination'
      observer: true
      autoplay: 1000
      speed: 1000
      loop : true
      # effect: 'cube'

  when 'caigou_new'
    account.load()
    params = {}
    for param in decodeURIComponent(location.search).substr(1).split('&')
      params[param.split('=')[0]] = param.split('=')[1]
    ko.applyBindings
      params: params
      save: caigou.create

  when 'supply_new'
    account.load()
    address.listArea()
    ko.applyBindings
      save: supply.create
      area: address.area
      area_list: address.area_list
      city_list: address.city_list

  when 'caigous'
    params = {}
    for param in decodeURIComponent(location.search).substr(1).split('&')
      params[param.split('=')[0]] = param.split('=')[1]
    caigou.result.q params.q
    caigou.result.filter.noclose true
    caigou.list()
    ko.applyBindings caigou

  when 'supplies'
    params = {}
    for param in decodeURIComponent(location.search).substr(1).split('&')
      params[param.split('=')[0]] = param.split('=')[1]
    supply.result.q params.q

    supply.list params
    ko.applyBindings supply

  when 'search'
    keyword.list()
    ko.applyBindings keyword

  when 'advanced'
    variety.list()
    ko.applyBindings
      filter: supply.result.filter
      pinmings: variety.result

  when 'supply'
    ko.applyBindings supply.load location.search.substr 4

  when 'myorder'
    caigou.listMine()
    supply.listMine()
    ko.applyBindings
      caigou: caigou
      supply: supply

  when 'orders'
    caigou.result.filter.orders_only true
    caigou.list()
    ko.applyBindings
      result: caigou.result

  when 'profile'
    account.load ->
      account.address.area(account.profile.area())

    account.address.listArea ->
      account.profile.area(account.address.area())

    ko.applyBindings account

  when 'news'
    news.list()
    ko.applyBindings news

  when 'news_detail'
    ko.applyBindings news.load window.location.search.substr 4

  when 'hangqing'
    hangqing.list()
    ko.applyBindings hangqing

  when 'login'
    account.load (-> location.href='/'), ->
    account.profile.weixin_id window.location.search.substr 11
    ko.applyBindings account

  when 'register'
    account.profile.weixin_id window.location.search.substr 11
    ko.applyBindings account

  when 'forget'
    ko.applyBindings account

  when 'oauth'
    weixin.load()

  when 'sale'
    supply.result.size 30
    supply.result.filter.ifsale 1
    supply.list()
    ko.applyBindings
      sales: supply.result.rows

  else # do nothing


# baidu tracking
hm = document.createElement("script")
hm.src = "//hm.baidu.com/hm.js?4fd59a7769eab72a692e7ed7cc97cee8"
s = document.getElementsByTagName("script")[0]
s.parentNode.insertBefore hm, s
