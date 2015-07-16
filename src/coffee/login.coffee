$ = require 'jquery'
ko = require 'knockout'

account =
  _username: ko.observable()
  _password: ko.observable()
  _format: 'json'

success = ->
  window.location.href='index.html'

failure = ->
  window.alert '用户名或者密码错误！'

login = ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: 'http://test.account.zhaomw.cn/login'
    data: ko.toJS(account)
    success: success
    error: failure

ko.applyBindings
  account: account
  login: login
