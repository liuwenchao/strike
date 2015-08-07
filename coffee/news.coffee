$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

Model = ->
  id: ko.observable()
  title: ko.observable()
  summary: ko.observable()
  content: ko.observable()
  addtime: ko.observable(new Date())

records = ko.observableArray()

fill = (data, model) ->
  model = new Model() if not model
  model.id data.news_id
  model.title data.title.substr 0,12
  model.summary data.summary
  model.content data.content
  model.addtime new Date data.addtime*1000
  return model

list = ->
  $.get params.search.host + '/news/_search?size=10', (data) ->
    for news in data.hits.hits
      records.push fill news._source

more = (from) ->
  $.get params.search.host + '/news/_search?size=10&from='+from, (data) ->
    for news in data.hits.hits
      records.push fill news._source

load = (id) ->
  record = new Model()
  if id
    $.get params.search.host + '/news/' + id, (news) ->
      fill news._source, record
  return record

module.exports =
  records: records
  list: list
  more: more
  load: load
