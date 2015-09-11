$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
filter     = require 'caigou.filter'
Model = require 'caigou.model'

result =
  q: ko.observable()
  size: 5
  more: ko.observable(false)
  from: ko.observable(0)
  rows: ko.observableArray()
  sort: ko.observable('id:desc')
  total: ko.observable(0)
  filter: filter
  loading: ko.observable(false)
  currentPage: ko.pureComputed -> (Math.ceil result.from()/result.size)+1
  pageCount:   ko.pureComputed -> Math.ceil result.total()/result.size
  pageUp    : -> result.from if result.from() == 0 then 0 else (result.currentPage()-2)*result.size
  pageDown  : -> result.from result.currentPage()*result.size
  pageFirst : -> result.from 0
  pageLast  : -> result.from (result.pageCount()-1)*result.size
  isFirstPage : ko.pureComputed -> result.from() <= 0
  isLastPage  : ko.pureComputed -> result.from() + result.size >= result.total()


# conduct search when sort or from is changed
result.sort.subscribe ->
  result.from 0
  list()
result.from.subscribe -> list()

create = (form) ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: parameters.api.host+'/requirements'
    data: JSON.stringify
      type1: form.standard_cate_one.value
      content: form.caigou_content.value
      caigou:
        pay_price: form.pay_price.value
        pay_weight: form.pay_weight.value
        standard_address: form.pay_address.value
    contentType: 'application/json'
    success: -> window.location.href='myorder.html'

list = ->
  return if result.loading()  #prevent double listing
  result.loading true
  q = result.q()
  $.get parameters.search.host + '/caigou/_search',
    q: filter.to_string
    from: result.from()
    sort: result.sort()
    size: result.size
  , (data) ->
    result.total data.hits.total
    result.rows.removeAll() if result.from() == 0
    result.more result.from()+result.size
    for record in data.hits.hits
      result.rows.push Model.fill record._source
    result.loading false

listMine = (from = 0, filter)->
  $.ajax
    type: 'get'
    xhrFields:
      withCredentials: true
    url: parameters.api.host + '/requirements'
    data:
      start: from
      limit: 100
      q: filter
    success: (data) ->
      result.rows.removeAll() if from == 0
      result.more from+result.size
      for record in data
        result.rows.push Model.fill record
    error: -> window.location='login.html'

module.exports =
  result:  result
  create:  create
  list:    list
  listMine: listMine
