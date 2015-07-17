$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

account =
  username: ko.observable()
  password: ko.observable()

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
    success: -> window.location.href='index.html'
    error:   -> window.alert '用户名或者密码错误！'

ko.applyBindings
  account: account
  login: login
