$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]

Model =
  q: ko.observable(params.q)
  isqihuo: ko.observable(params.isqihuo)
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
    query.push 'cargo_name:'+Model.paihao()             if Model.paihao()
    query.push 'hf_ar:'+Model.hf_value()            if Model.hf_value()
    query.push 'qlf_ar:'+Model.lf_value()           if Model.lf_value()
    query.push 'qsf:'+Model.qsf_value()             if Model.qsf_value()
    query.push 'dwfrl_ar:'+Model.dwfrl_ar()         if Model.dwfrl_u10_value()
    query.push 'member_info:'+Model.paihao()        if Model.company()
    query.push 'jg_address_info:'+Model.cangku()     if Model.cangku()
    query.push 'member.company_id:'+Model.company_id()   if Model.company_id()
    query.join(' AND ')

Model.to_json = ->
    json =
        query:
          filtered:
            query:
              bool:
                must: []
            filter:
              and: [{
                or: [{
                  range:
                    online_expire_date:
                      gt: 'now'
                }, {
                  not:
                    exists:
                      field:
                        'online_expire_date'
                }]
              }, {
                term:
                  status: 1
              }]

    q = if Model.q() then Model.q().replace(/[+ ]+/, ' ') else Model.q()

    if q
      if q.indexOf(' ') > 0
        nums = q.match(/\d+/)

        if nums.length
          q = q.replace(nums[0], '')

          json.query.filtered.filter.and.push
            term:
              dwfrl_ar: parseInt(nums[0])

        json.query.filtered.query.bool.must.push
          query_string:
            query: q
            fields: [ "variety.cate_name", "jg_address_info" ]
            default_operator: "AND"
      else
        json.query.filtered.query.bool.must.push
          multi_match:
            query: q
            fields: [ "variety.cate_name", "jg_address_info" ]
            type: "phrase"

        json.query.filtered.query.bool.must[0].multi_match.fields.push "dwfrl_ar" if parseInt(Model.q()) > 0

    if Model.isqihuo()
      json.query.filtered.filter.and.push
        term:
          supply_type: Model.isqihuo()

    if Model.ifsale()
      json.query.filtered.filter.and.push
        term:
          is_sale: true

    if Model.pinming()
      json.query.filtered.filter.and.push
        term:
          pinming_one: Model.pinming()

    if Model.paihao()
      json.query.filtered.query.bool.must.push
        multi_match:
          query: Model.paihao()
          fields: [ "cargo_name" ]
          type: "phrase"

    if Model.hf_value() && parseFloat(Model.hf_value())
      json.query.filtered.filter.and.push
        term:
          hf_ar: parseFloat(Model.hf_value())

    if Model.lf_value() && parseFloat(Model.lf_value())
      json.query.filtered.filter.and.push
        term:
          qlf_ar: parseFloat(Model.lf_value())

    if Model.qsf_value() && parseFloat(Model.qsf_value())
      json.query.filtered.filter.and.push
        term:
          qsf: parseFloat(Model.qsf_value())

    if Model.dwfrl_u10_value() && parseInt(Model.dwfrl_u10_value())
      json.query.filtered.filter.and.push
        term:
          dwfrl_ar: parseInt(Model.dwfrl_u10_value())

    if Model.company()
      json.query.filtered.query.bool.must.push
        multi_match:
          query: Model.company()
          fields: [ "member_info" ]
          type: "phrase"

    if Model.cangku()
      json.query.filtered.query.bool.must.push
        multi_match:
          query: Model.cangku()
          fields: [ "jg_address_info" ]
          type: "phrase"

    if Model.company_id()
      json.query.filtered.query.bool.must.push
        multi_match:
          query: Model.company_id()
          fields: [ "member.company_id" ]
          type: "phrase"

    json

module.exports = Model
