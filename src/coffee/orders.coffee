$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records  = ko.observableArray()

$.ajax
  type: 'get'
  url: params.search.host + '/caigou/_search?size=10&q=!ifhide'
  data:
    limit: 10
  success: (data) ->
    for record in data.hits.hits
      caigou = record._source
      records.push
        id: caigou.caigou_id
        price: caigou.standard_price_money
        weight: caigou.standard_ton
        rezhi: caigou.standard_div_content?.rezhi_value
        company_name: caigou.member_info
        pingming: caigou.variety[0]?.cate_name
        addtime: new Date caigou.add_time*1000
        staff: caigou.operate_staff?.staff_truename
        tel: caigou.operate_staff?.staff_mobile
        address: caigou.standard_address
        status: '交易成功' #TODO

ko.applyBindings
  records: records
