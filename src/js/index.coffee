$ = require 'jquery'
ko = require 'knockout'

account =
  isLoggedin: ko.observable(false)
  name: ko.observable()

$.ajax
  type: 'GET'
  xhrFields:
    withCredentials: true
  url: 'http://test.account.zhaomw.cn/?_format=json'
  success: (data) ->
      account.name data.truename || data.username || data.mobile
      account.isLoggedin true

ko.applyBindings account
