$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

record =
  id: ko.observable()
  title: ko.observable()
  content: ko.observable()
  addtime: ko.observable()

id = window.location.search.substr(4)
if id
  $.get params.search.host + '/news/' + id
  .done (news) ->
      record.id news._source.news_id
      record.title news._source.title.substr 0,14
      record.content news._source.content
      record.addtime new Date news._source.addtime*1000

ko.applyBindings record
