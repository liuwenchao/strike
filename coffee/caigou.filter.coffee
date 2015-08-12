$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]

Model =
  q: ko.observable(params.q)
  noclose: ko.observable()

Model.to_string = ->
    query = ['!ifhide', 'ifcheck:1', '!ifclose']
    query.push '(variety.cate_name:'+Model.q()+' OR paihao:'+Model.q()+')' if Model.q()
    query.push '!progress=70000' if Model.noclose()
    query.push '!progress=90000' if Model.noclose()
    query.join(' AND ')

module.exports = Model
