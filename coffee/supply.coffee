$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
SupplyModel = require 'supply.model'
filter = require 'supply.filter'

result =
  q: ko.observable()
  size: ko.observable(5)
  more: ko.observable(false)
  from: ko.observable(0)
  rows: ko.observableArray()
  sort: ko.observable('id:desc')
  total: ko.observable(0)
  filter: filter
  currentPage: ko.pureComputed -> (Math.ceil result.from()/result.size())+1
  pageCount:   ko.pureComputed -> Math.ceil result.total()/result.size()
  pageUp    : -> result.from if result.from() == 0 then 0 else (result.currentPage()-2)*result.size()
  pageDown  : -> result.from result.currentPage()*result.size()
  pageFirst : -> result.from 0
  pageLast  : -> result.from (result.pageCount()-1)*result.size()
  isFirstPage : ko.pureComputed -> result.from() <= 0
  isLastPage  : ko.pureComputed -> result.from() + result.size() >= result.total()

create = (form)->
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
      jiaoge_weight: form.jiaoge_weight.value
      jiaoge_address: form.jiaoge_address.value
    contentType: 'application/json'
    success: -> window.location.href='myorder.html'

load = (id) ->
  record = new SupplyModel.Model()
  if id
    $.get parameters.search.host + '/supply/' + id, (data) ->
      SupplyModel.fill data._source, record
  return record

list = ->
  $.get parameters.search.host + '/supply/_search',
    q: filter.to_string()
    from: result.from()
    sort: result.sort()
    size: result.size()
  , (data) ->
    result.total data.hits.total
    result.rows.removeAll()# if result.from() == 0
    result.more result.from()+result.size()
    for record in data.hits.hits
      result.rows.push SupplyModel.fill record._source

listMine = (from = 0, filter)->
  $.ajax
    type: 'get'
    xhrFields:
      withCredentials: true
    url: parameters.api.host + '/supplies'
    data:
      start: from
      limit: 100
      q: filter
    success: (data) ->
      result.rows.removeAll() if from == 0
      result.more from+result.size()
      for record in data
        result.rows.push SupplyModel.fill record
    error: -> window.location='login.html'


# conduct search when sort or from is changed
result.sort.subscribe ->
  result.from 0
  list()
result.from.subscribe -> list()
module.exports =
  result:  result
  create:  create
  list:    list
  load:    load
  listMine: listMine
