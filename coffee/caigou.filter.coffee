$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]

Model =
  q: ko.observable(params.q)
  noclose: ko.observable()
  orders_only: ko.observable(false)

Model.to_string = ->
    query = ['!ifhide', 'status:1', '!ifclose', '!iftovoid']
    query.push '(variety.cate_name:"'+Model.q()+'" OR member.company.no:"'+Model.q()+'" OR standard_address:"'+Model.q()+'" OR operate_staff.name:"'+Model.q()+'")' if Model.q()
    query.push '!progress=10000' if Model.orders_only()
    query.push '!progress=20000' if Model.orders_only()
    query.push '!progress=70000' if Model.noclose()
    query.push '!progress=90000' if Model.noclose()
    query.join(' AND ')

module.exports = Model
