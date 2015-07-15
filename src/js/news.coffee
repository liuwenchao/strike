$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
$.get params.search.host + '/news/_search?size=10'
.done (data) ->
  for news in data.hits.hits
    records.push
      id: news._source.news_id
      title: news._source.title.substr 0,14
      summary: news._source.summary
      addtime: new Date news._source.addtime*1000

ko.applyBindings
  records: records
