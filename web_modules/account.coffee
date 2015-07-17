$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

# Model = ->
#   member_id: ko.observable()
#   username: ko.observable()
#   truename: ko.observable()
#   mobile: ko.observable()
#   purpose_company: ko.observable()
#   telephone: ko.observable()
#   fax: ko.observable()
#   qq: ko.observable()
#   email: ko.observable()
#   purpose_company_type: ko.observable()
#   area: ko.observable()
#   city: ko.observable()
#   city_name: ko.observable()
#   address: ko.observable()
#

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
  name: ko.pureComputed ->
    profile.truename() || profile.username() || profile.mobile()

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
  profile.address data.address
  if data.cityName
    $.get parameters.search.host+'/city/_search?size=1&q=city_name:'+data.cityName, (found)->
      if found.hits.hits.length > 0
        profile.area found.hits.hits[0]._source.parent_id

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
    error:
      errorCallback() if errorCallback

save = ->
  $.ajax
    type: 'PUT'
    xhrFields:
      withCredentials: true
    url: parameters.api.host+'/members/'+profile.member_id()
    data: ko.toJSON profile
    contentType: 'application/json'
    success: -> window.alert '保存成功'
    error:   -> window.location.href='index.html'

login = (form) ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: parameters.account.host+'/login'
    data:
      _username: form.username.value
      _password: form.password.value
      _format: 'json'
    success: -> window.location.href='/'
    error:   -> window.alert '用户名或者密码错误！'

logout = ->
  profile.isLoggedin false
  document.cookie = "PHPSESSID=; expires=Thu, 01 Jan 1970 00:00:01 GMT; domain=.zhaomw.cn; path=/"
  window.location.href = '/'

module.exports =
  profile: profile
  load: load
  save: save
  login: login
  logout: logout
