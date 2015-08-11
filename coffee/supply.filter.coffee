$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]

Model =
  q: ko.observable(params.q)
  isqihuo: ko.observable(params.isqihuo || 0)
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
    query = ['!ifhide']
    query.push '(variety.cate_name:'+Model.q()+' OR paihao:'+Model.q()+')' if Model.q()
    query.push 'isqihuo:'+Model.isqihuo()           if Model.isqihuo()
    query.push 'pinming_one:'+Model.pinming()       if Model.pinming()
    query.push 'paihao:'+Model.paihao()             if Model.paihao()
    query.push 'hf_value:'+Model.hf_value()         if Model.hf_value()
    query.push 'lf_value:'+Model.lf_value()         if Model.lf_value()
    query.push 'qsf_value:'+Model.qsf_value()       if Model.qsf_value()
    query.push 'dwfrl_u10_value:'+Model.dwfrl_u10_value()  if Model.dwfrl_u10_value()
    query.push 'member_info:'+Model.paihao()        if Model.company()
    query.push 'jiaoge_address:'+Model.cangku()     if Model.cangku()
    query.push 'member.company_id:'+Model.company_id()   if Model.company_id()
    query.join(' AND ')

module.exports = Model
