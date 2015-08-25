$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]

Model =
  q: ko.observable(params.q)
  isqihuo: ko.observable(params.isqihuo || 1)
  ifsale:  ko.observable(params.ifsale  || 0)
  pinming: ko.observable(params.pinming)
  paihao:  ko.observable(params.paihao)
  company: ko.observable(params.company)
  cangku:  ko.observable(params.cangku)
  hf_value:  ko.observable(params.hf_value)
  lf_value:  ko.observable(params.lf_value)
  qsf_value:  ko.observable(params.qsf_value)
  dwfrl_u10_value:  ko.observable(params.dwfrl_u10_value)
  company_id: ko.observable(params.company_id)

Model.to_string = ->
    query = ['!ifhide', 'status:1']
    zhibiao = 'OR dwfrl_ar:'+Model.q() if parseInt(Model.q()) > 0
    q = [
      '('
      'variety.cate_name:"'+Model.q()+'"'
      'OR jg_address_info:"'+Model.q()+'"'
      zhibiao
      ')'
    ]
    query.push q.join ' '                           if Model.q()
    query.push 'supply_type:'+Model.isqihuo()       if Model.isqihuo()
    query.push 'is_sale:true'                       if Model.ifsale()
    query.push 'pinming_one:'+Model.pinming()       if Model.pinming()
    query.push 'paihao:'+Model.paihao()             if Model.paihao()
    query.push 'hf_ar:'+Model.hf_value()            if Model.hf_value()
    query.push 'qlf_ar:'+Model.lf_value()           if Model.lf_value()
    query.push 'qsf:'+Model.qsf_value()             if Model.qsf_value()
    query.push 'dwfrl_ar:'+Model.dwfrl_ar()         if Model.dwfrl_u10_value()
    query.push 'member_info:'+Model.paihao()        if Model.company()
    query.push 'jg_address_info:'+Model.cangku()     if Model.cangku()
    query.push 'member.company_id:'+Model.company_id()   if Model.company_id()
    query.join(' AND ')

Model.to_json = ->
    q = Model.q().replace(/[+ ]+/, ' ')

    json =
        query:
          filtered:
            filter:
              and: [{
                bool:
                  must_not:
                    term:
                      ifhide: true
              }, {
                term:
                  status: 1
              }]

    if q.indexOf(' ') > 0
      json.query.filtered.query =
        query_string:
          query: q
          fields: [ "variety.cate_name", "jg_address_info" ]
          default_operator: "AND"

      nums = q.match(/\d+/)

      if nums.length
        json.query.filtered.filter.and.push
          term:
            dwfrl_ar: nums[0]
    else
      json.query.filtered.query =
        multi_match:
          query: q
          fields: [ "variety.cate_name", "jg_address_info" ]
          type: "phrase"

      json.query.filtered.query.multi_match.fields.push "dwfrl_ar" if parseInt(Model.q()) > 0

    json

module.exports = Model
