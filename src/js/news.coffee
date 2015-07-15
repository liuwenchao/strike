$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
$.get params.search.host + '/news/_search?size=10'
.done (data) ->
  for news of data.hists.hits
    records.push
      id: _source.id
      title: _source.title
      summary: _source.summary
      time: addtime

ko.applyBindings
  records: records
