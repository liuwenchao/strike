$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

Model = ->
  id: ko.observable()
  pingming: ko.observable()
  price: ko.observable()
  weight: ko.observable()
  rezhi: ko.observable()
  isquhuo: ko.observable()
  address: ko.observable()
  addtime: ko.observable()
  company_name: ko.observable()

records = ko.observableArray()
mine = ko.observableArray()

fill = (data, model) ->
  model = new Model() if not model
  model.id  data.supply_id
  model.pingming data.variety[0]?.cate_name
  model.price data.pay_price
  model.weight data.jiaoge_weight
  model.rezhi data.dwfrl_u10_value
  model.isquhuo data.isqihuo
  model.address data.jiaoge_address
  model.addtime new Date data.add_time*1000
  model.company_name data.member.company?.company_name
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

listMine = ->
  $.ajax
    type: 'get'
    xhrFields:
      withCredentials: true
    url: parameters.api.host + '/supplies'
    data:
      limit: 10
    success: (data) ->
      for record in data
        mine.push fill record

more = (from) ->
  $.get params.search.host + '/supply/_search?size=10&q=!ifhide&from='+from, (data) ->
    for record in data.hits.hits
      records.push fill record._source

module.exports =
  records: records
  mine: mine
  create: create
  list: list
  listMine: listMine
  more: more
