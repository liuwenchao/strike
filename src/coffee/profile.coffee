$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

profile =
  member_id: ko.observable()
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

address1 = ko.observableArray()
address2 = ko.observableArray()
profile.area.subscribe ->
  refreshAddressTwo()

$.get parameters.search.host + '/city/_search?size=100&q=parent_id:0', (data)->
  for record in data.hits.hits
    address1.push
      id: record._source.city_id
      name: record._source.city_name

refreshAddressTwo = ->
  if profile.area()
    $.get parameters.search.host+'/city/_search?size=100&q=parent_id:'+profile.area(), (data)->
      address2.removeAll()
      for city in data.hits.hits
        address2.push city._source.city_name
      profile.city_name profile.city() if profile.city()

$.ajax
  type: 'GET'
  xhrFields:
    withCredentials: true
  url: parameters.account.host+'/?_format=json'
  success: (data) ->
    profile.member_id data.memberId
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
  error: ->
    window.location.href = '/'

save = ->
  $.ajax
    type: 'PUT'
    xhrFields:
      withCredentials: true
    url: parameters.api.host+'/members/'+profile.member_id()
    data: ko.toJSON(profile)
    contentType: 'application/json'
    success: -> window.alert '发布成功'
    # window.location.href='index.html'

ko.applyBindings
  profile: profile
  address1: address1
  address2: address2
  save: save
