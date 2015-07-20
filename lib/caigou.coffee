$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

Model = ->
  id: ko.observable()
  price: ko.observable()
  weight: ko.observable()
  rezhi: ko.observable()
  company_name: ko.observable()
  pingming: ko.observable()
  addtime: ko.observable()
  staff: ko.observable()
  tel: ko.observable()
  address: ko.observable()
  status: ko.observable()

result =
  size: 10
  more: ko.observable(false)
  from: ko.observable(0)
  rows: ko.observableArray()

fill = (data, model) ->
  model = new Model() if not model
  model.id data.caigou_id
  model.price data.standard_price_money || data.pay_price
  model.weight data.standard_ton || data.pay_weight
  model.rezhi data.standard_div_content?.rezhi_value
  model.company_name data.member_info
  model.pingming data.variety[0]?.cate_name
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
    url: parameters.api.host+'/caigouses'
    data: JSON.stringify
      standard_cate_one: form.standard_cate_one.value
      caigou_content: form.caigou_content.value
      pay_price: form.pay_price.value
      pay_weight: form.pay_weight.value
    contentType: 'application/json'
    success: -> window.alert '发布成功'
    # window.location.href='index.html'

list = (from)->
  $.get parameters.search.host + '/caigou/_search',
    size: result.size
    from: from
    q: '!ifhide'
  , (data) ->
    result.rows.removeAll() if from == 0
    result.more from+result.size
    for record in data.hits.hits
      result.rows.push fill record._source

listMine = (from = 0, filter)->
  $.ajax
    type: 'get'
    xhrFields:
      withCredentials: true
    url: parameters.api.host + '/caigous'
    data:
      start: from
      limit: result.size
      q: filter
    success: (data) ->
      result.rows.removeAll() if from == 0
      result.more from+result.size
      for record in data
        result.rows.push fill record

module.exports =
  result:  result
  create:  create
  list:    list
  listMine: listMine
