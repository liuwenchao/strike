result = ->
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

module.exports = result
