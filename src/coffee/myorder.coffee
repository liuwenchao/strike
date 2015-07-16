$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

caigous  = ko.observableArray()
supplies = ko.observableArray()

$.ajax
  type: 'get'
  xhrFields:
    withCredentials: true
  url: params.api.host + '/caigous'
  data:
    limit: 10
  success: (data) ->
    for caigou in data
      caigous.push
        id: caigou.caigou_id
        price: caigou.standard_price_money
        weight: caigou.standard_ton
        rezhi: caigou.standard_div_content?.rezhi_value
        company_name: caigou.member_info
        pingming: caigou.variety[0]?.cate_name
        addtime: new Date caigou.add_time*1000
        staff: caigou.operate_staff?.staff_truename
        tel: caigou.operate_staff?.staff_mobile
$.ajax
  type: 'get'
  xhrFields:
    withCredentials: true
  url: params.api.host + '/supplies'
  data:
    limit: 10
  success: (data) ->
    for supply in data
      supplies.push
        id: supply.supply_id
        pingming: supply.variety[0]?.cate_name
        price: supply.pay_price
        weight: supply.jiaoge_weight
        rezhi: supply.dwfrl_u10_value
        isquhuo: supply.isqihuo
        address: supply.jiaoge_address
        addtime: new Date supply.add_time*1000
        company_name: supply.member.company?.company_name
        # title: news._source.title.substr 0,14
        # summary: news._source.summary
        # addtime: new Date news._source.addtime*1000

ko.applyBindings
  caigous:  caigous
  supplies: supplies
  all_caigou: ->
  checked_caigou: ->
  unchecked_caigou: ->
