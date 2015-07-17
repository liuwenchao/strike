$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

Model = ->
  id: ko.observable()
  pinming_one: ko.observable()
  pay_type: ko.observable()
  pay_address_one: ko.observable()
  pay_address_two: ko.observable()
  pay_price: ko.observable()
  pay_weight: ko.observable()
  operate_staff_id: 0

records = ko.observableArray()

fill = (data, model) ->
  model = new Model() if not model
  model.id data.supply_id
  model.price data.standard_price_money
  model.weight data.standard_ton
  model.rezhi data.standard_div_content?.rezhi_value
  model.company_name data.member_info
  model.pinming data.variety[0]?.cate_name
  model.addtime new Date data.add_time*1000
  model.staff data.operate_staff?.staff_truename
  model.tel data.operate_staff?.staff_mobile
  model.address data.standard_address
  model.status '交易成功'
  model

create = (form) ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: parameters.api.host+'/supplies'
    data: JSON.stringify
      pinming_one: form.pinming_one.value
      pay_type: form.pay_type.value
      pay_address_one: form.pay_address_one.value
      pay_address_two: form.pay_address_two.value
      pay_price: form.pay_price.value
      pay_weight: form.pay_weight.value
    contentType: 'application/json'
    success: -> window.alert '发布成功'
    # window.location.href='index.html'

list = ->
  $.get params.search.host + '/supply/_search?size=10&q=!ifhide', (data) ->
    for record in data.hits.hits
      records.push fill record._source

more = (from) ->
  $.get params.search.host + '/supply/_search?size=10&q=!ifhide&from='+from, (data) ->
    for record in data.hits.hits
      records.push fill record._source

module.exports =
  records: records
  create: create
  list: list
  more: more
