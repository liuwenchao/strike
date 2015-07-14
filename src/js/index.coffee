$ = require 'jquery'
ko = require 'knockout'

account =
    isLoggedin: false
$.get 'http://test.account.zhaomw.cn/?_format=json', (data) ->
    account.name = data.truename || data.username || data.mobile
    account.isLoggedin = true

ko.applyBindings account
