$ = require 'jquery'
ko = require 'knockout'

form =
  pinming_one: ko.observable()
  # caigou_content: ko.observable()
  pay_type: ko.observable()
  pay_address_one: ko.observable()
  pay_address_two: ko.observable()
  pay_price: ko.observable()
  pay_weight: ko.observable()

address1 = ko.observableArray()
address2 = ko.observableArray()

$.get 'http://test.search.zhaomw.cn/city/_search?size=100&q=parent_id:0', (data)->
  for city in data.hits.hits
    address1.push
      id: city._source.city_id
      name: city._source.city_name

refreshAddressTwo = ->
  if form.pay_address_one()
    $.get 'http://test.search.zhaomw.cn/city/_search?size=100&q=parent_id:'+form.pay_address_one(), (data)->
      address2.removeAll()
      for city in data.hits.hits
        address2.push
          id: city._source.city_id
          name: city._source.city_name

save = ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: 'http://test.api.zhaomw.cn/supplies'
    data: ko.toJS(form)
    success: -> window.alert '发布成功'
    # window.location.href='index.html'

ko.applyBindings
  form: form
  save: save
  address1: address1
  address2: address2
  refreshAddressTwo: refreshAddressTwo
