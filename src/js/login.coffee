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
    $.post 'http://test.account.zhaomw.cn/login', ko.toJS(account)
    .done success
    .fail failure

ko.applyBindings
  account: account
  login: login
