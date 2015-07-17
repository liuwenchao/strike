$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

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

records  = ko.observableArray()

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

list = ->
  $.ajax
    type: 'get'
    url: params.search.host + '/supply/_search?size=10&q=!ifhide'
    data:
      limit: 10
    success: (data) ->
      for record in data.hits.hits
        records.push fill record._source

more = (from) ->
  $.ajax
    type: 'get'
    url: params.search.host + '/supply/_search?size=10&q=!ifhide&from='+from
    data:
      limit: 10
    success: (data) ->
      for record in data.hits.hits
        records.push fill record._source

ko.applyBindings
  records: records
  list: list
  more: more
