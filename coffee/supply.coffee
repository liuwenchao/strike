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
  loading: ko.observable(false);
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
      jg_weight: form.jiaoge_weight.value
      jg_address_info: form.jiaoge_address.value
    contentType: 'application/json'
    success: -> window.location.href='myorder.html'

load = (id) ->
  record = new SupplyModel.Model()
  if id
    $.ajax
      type: 'get'
      url: parameters.search.host + '/supply/' + id
      success: (data) ->
        SupplyModel.fill data._source, record
      error: ->
        $.ajax
          type: 'get'
          xhrFields:
            withCredentials: true
          url: parameters.api.host + '/supplies/' + id
          success: (data) ->
            SupplyModel.fill data, record
  return record

list = (params)->
  return if result.loading()  #prevent double listing
  result.loading true
  result.from params.from if params?.from
  result.sort params.sort if params?.sort

  q = filter.to_json()

  q.from = result.from()
  q.size = result.size()

  sort = result.sort().split(':')

  q.sort = new Object
  q.sort[sort[0]] = sort[1]

  $.post parameters.search.host + '/supply/_search',
  JSON.stringify(q)
  , (data) ->
    result.q if result.q() then result.q().replace(/[+ ]+/, ' ') else result.q()
    result.total data.hits.total
    result.rows.removeAll() if result.from() == 0
    result.more result.from()+result.size()
    for record in data.hits.hits
      result.rows.push SupplyModel.fill record._source
    result.loading false

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

result.toggleSort = (column)->
  result.from 0
  switch column
    when 'pay_price'
      if result.sort() == 'pay_price:desc'
        result.sort 'pay_price:asc'
      else
        result.sort 'pay_price:desc'
    when 'jg_weight'
      if result.sort() == 'jg_weight:desc'
        result.sort 'jg_weight:asc'
      else
        result.sort 'jg_weight:desc'

_push_state = (key, newValue)->
  params = {}
  for param in decodeURIComponent(location.search).substr(1).split('&')
    params[param.split('=')[0]] = param.split('=')[1]
  params[key] = newValue
  window.history.pushState params, document.title, window.location.pathname+'?'+$.param(params)

# conduct search when sort or from is changed
result.sort.subscribe (newValue)->
  list()
  _push_state 'sort', newValue

result.from.subscribe (newValue)->
  list()
  _push_state 'from', newValue

module.exports =
  result:  result
  create:  create
  list:    list
  load:    load
  listMine: listMine
