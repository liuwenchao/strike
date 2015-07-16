$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

account =
  username: ko.observable()
  password: ko.observable()

success = ->
  window.location.href='index.html'

failure = ->
  window.alert '用户名或者密码错误！'

login = ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: parameters.account.host+'/login'
    data:
      _username: account.username()
      _password: account.password()
      _format: 'json'
    success: success
    error: failure

ko.applyBindings
  account: account
  login: login
