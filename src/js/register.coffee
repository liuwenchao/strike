$ = require 'jquery'
ko = require 'knockout'

register = (form) ->
  if form.password.value != form.repasswd.value
    window.alert '两次密码不一样！'
    return false
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: 'http://test.api.zhaomw.cn/members.json'
    data: ko.toJS(account)
    success: -> window.location.href='login.html'
    error: -> window.alert '验证码错误！'

verify = ->
  if account.mobile() and account.mobile().length == 11
    $.ajax
      type: 'post'
      xhrFields:
        withCredentials: true
      url: 'http://test.api.zhaomw.cn/messages.json'
      data:
        mobile: account.sms()
        tpl: 'mcode'
      success: -> window.alert '验证码已经发送您的手机，请查收！'
      # success: (data) -> window.alert data.content
  else
    window.alert '请输入正确的手机号码！'

account =
  username: ko.observable()
  mobile:   ko.observable()
  sms:      ko.observable()
  password: ko.observable()
  repasswd: ko.observable()
  _format: 'json'

ko.applyBindings
  account: account
  register: register
  verify: verify
