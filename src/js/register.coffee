$ = require 'jquery'
ko = require 'knockout'

register = (form) ->
  if form.password.value != form.repasswd.value
    window.alert '两次密码不一样！'
    return false
  $.post 'http://test.api.zhaomw.cn/members.json', ko.toJS(account)
  .done -> window.location.href='login.html'
  .fail -> window.alert '验证码错误！'

verify = ->
  if account.mobile() and account.mobile().length == 11
    $.post 'http://test.api.zhaomw.cn/messages.json',
      mobile: account.sms()
      tpl: 'mcode'
    # .done -> window.alert '验证码已经发送您的手机，请查收！'
    .done (data) -> window.alert data.content
  else
    window.alert '请输入正确的手机号码！'

account =
  truename: ko.observable()
  mobile:   ko.observable()
  sms:      ko.observable()
  password: ko.observable()
  repasswd: ko.observable()
  _format: 'json'

ko.applyBindings
  account: account
  register: register
  verify: verify
