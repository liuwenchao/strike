$ = require 'jquery'
ko = require 'knockout'

account =
  truename: ko.observable()
  mobile:   ko.observable()
  sms:      ko.observable()
  password: ko.observable()
  repasswd: ko.observable()
  error:    ko.observable()
  register: ->
    if account.password() == account.repasswd()
      $.post 'http://test.api.zhaomw.cn/members.json', ko.toJS(account), success, failure
    else
      account.error '两次密码不一样！'
  _format: 'json'

success = ->
  window.location.href='login.html'

failure = ->
  account.error data.error

ko.applyBindings account
