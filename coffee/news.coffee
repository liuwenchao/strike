$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
NewsModel = require 'news.model'

result =
  q: ko.observable()
  size: 5
  more: ko.observable(false)
  from: ko.observable(0)
  rows: ko.observableArray()
  sort: ko.observable('id:desc')
  total: ko.observable(0)
  loading: ko.observable(false)
  currentPage: ko.pureComputed -> (Math.ceil result.from()/result.size)+1
  pageCount:   ko.pureComputed -> Math.ceil result.total()/result.size
  pageUp    : -> result.from if result.from() == 0 then 0 else (result.currentPage()-2)*result.size
  pageDown  : -> result.from result.currentPage()*result.size
  pageFirst : -> result.from 0
  pageLast  : -> result.from (result.pageCount()-1)*result.size
  isFirstPage : ko.pureComputed -> result.from() <= 0
  isLastPage  : ko.pureComputed -> result.from() + result.size >= result.total()

result.from.subscribe -> list()

list = ->
  return if result.loading()  #prevent double listing
  result.loading true
  q = result.q()
  $.get parameters.search.host + '/news/_search',
    from: result.from()
    sort: result.sort()
    size: result.size
  , (data) ->
    result.total data.hits.total
    result.rows.removeAll() if result.from() == 0
    result.more result.from()+result.size
    for record in data.hits.hits
      result.rows.push NewsModel.fill record._source
    result.loading false

load = (id) ->
  record = new NewsModel.Model()
  if id
    $.get parameters.search.host + '/news/' + id, (news) ->
      NewsModel.fill news._source, record
  return record

module.exports =
  result: result
  list: list
  load: load
