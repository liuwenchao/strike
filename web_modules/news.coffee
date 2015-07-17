$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

Model =
  id: ko.observable()
  title: ko.observable()
  summary: ko.observable()
  addtime: ko.observable()

records = ko.observableArray()

fill = (data) ->
  new Model
    id: data.news_id
    title: data.title.substr 0,14
    summary: data.summary
    addtime: new Date data.addtime*1000

list = ->
  $.get params.search.host + '/news/_search?size=10', (data) ->
    for news in data.hits.hits
      records.push fill news._source

more = (from) ->
  $.get params.search.host + '/news/_search?size=10&from='+from, (data) ->
    for news in data.hits.hits
      records.push fill news._source

module.exports =
  records: records
  list: list
  more: more
