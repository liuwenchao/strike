$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
address = require 'address'

profile =
  member_id: ko.observable()
  username: ko.observable()
  truename: ko.observable()
  mobile: ko.observable()
  purpose_company: ko.observable()
  telephone: ko.observable()
  fax: ko.observable()
  qq: ko.observable()
  email: ko.observable()
  purpose_company_type: ko.observable()
  area: ko.observable()
  city: ko.observable()
  city_name: ko.observable()
  address: ko.observable()
  isLoggedin: ko.observable(false)
  weixin_id: ko.observable()
  name: ko.pureComputed ->
    profile.truename() || profile.username() || profile.mobile()

error = ko.observable(false)

fillProfile = (data)->
  profile.member_id data.memberId
  profile.username data.username
  profile.truename data.truename
  profile.mobile data.mobile
  profile.purpose_company data.purposeCompany
  profile.telephone data.telephone
  profile.fax data.fax
  profile.qq data.qq
  profile.email data.email
  profile.purpose_company_type data.purposeCompanyType
  profile.city data.cityName
  profile.city_name data.cityName
  profile.address data.address
  if data.cityName
    $.get parameters.search.host+'/city/_search?size=1&q=city_name:'+data.cityName, (found)->
      if found.hits.hits.length > 0
        address.area found.hits.hits[0]._source.parent_id

load = (callback, errorCallback)->
  $.ajax
    type: 'GET'
    xhrFields:
      withCredentials: true
    url: parameters.account.host+'/?_format=json'
    success: (data) ->
      fillProfile data
      profile.isLoggedin true
      callback() if callback
    error: ->
      if errorCallback then errorCallback() else window.location.href='login.html'

save = (form)->
  profile.city_name form.city_name.selectedOptions[0].text
  $.ajax
    type: 'PUT'
    xhrFields:
      withCredentials: true
    url: parameters.api.host+'/members/'+profile.member_id()
    data: JSON.stringify
      username: profile.username()
      truename: profile.truename()
      mobile: profile.mobile()
      purpose_company: profile.purpose_company()
      telephone: profile.telephone()
      fax: profile.fax()
      qq: profile.qq()
      email: profile.email()
      purpose_company_type: profile.purpose_company_type()
      city_name: profile.city_name()
      address: profile.address()
    contentType: 'application/json'
    success: -> error '保存成功'
    error:   -> window.location.href='/'

login = (form) ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: parameters.account.host+'/login'
    data:
      _username: form.username.value
      _password: form.password.value
      weixin_id: form.weixin_id.value
      _format: 'json'
    success: -> window.location.href='/'
    error:   -> error '用户名或者密码错误！'

logout = ->
  profile.isLoggedin false
  document.cookie = "PHPSESSID=; expires=Thu, 01 Jan 1970 00:00:01 GMT; domain=.zhaomw.cn; path=/"
  $.get parameters.account.host + '/logout?wechat=1'

register = (form) ->
  if form.mobile.value.length == 0 or form.username.value.length == 0 or form.sms.value.length == 0 or form.password.value.length == 0
    error '所有字段都必填'
    return
  if form.password.value == form.repasswd.value
    $.ajax
      type: 'post'
      xhrFields:
        withCredentials: true
      contentType: 'application/json'
      url: parameters.api.host+'/members.json'
      data: JSON.stringify
        truename: form.truename.value
        mobile:   form.mobile.value
        username: form.mobile.value
        sms:      form.sms.value
        password: form.password.value
        weixin_id:form.weixin_id.value
      success: -> window.location.href='register_ok.html'
      error: (response) ->
        switch response.status
          when 400 then error '验证码错误或者已经过期！'
          when 409 then error '手机号码已经注册，请直接登录或者找回密码！'
          when 500 then error '注册失败，请联系我们！'
          else
            error response.statusText
  else
    error '两次密码不一样！'

resetPassword = (form) ->
  if form.mobile.length == 0 or form.sms.length == 0 or form.password.length == 0
    error '所有字段都必填'
    return
  if form.password.value == form.repasswd.value
    $.ajax
      type: 'PATCH'
      xhrFields:
        withCredentials: true
      contentType: 'application/json'
      url: parameters.api.host+'/members/'+form.mobile.value+'.json'
      data: JSON.stringify
        sms:      form.sms.value
        password: form.password.value
      success: -> window.location.href='register_ok.html'
      error: (response) ->
        switch response.status
          when 400 then error '验证码错误或者已经过期！'
          when 500 then error '修改失败，请联系我们！'
          else
            error response.statusText
  else
    error '两次密码不一样！'

verify = (mobile, template) ->
  if mobile and mobile.length == 11
    $.ajax
      type: 'post'
      xhrFields:
        withCredentials: true
      url: parameters.api.host+'/messages.json'
      data:
        mobile: mobile
        tpl:    template
      success: -> error '验证码已经发送您的手机，请查收！'
  else
    error '请输入正确的手机号码！'

module.exports =
  profile: profile
  address: address
  error: error
  load: load
  save: save
  login: login
  logout: logout
  register: register
  reset: resetPassword
  verify: verify
