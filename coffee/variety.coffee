$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

# Model = ->
#   id: ko.observable()
#   name: ko.observable()

result = ko.observableArray()

fromJsonToModel = (data)->
    id: data.id
    name: data.cate_name

list = (callback)->
  $.get parameters.search.host + '/variety/_search?size=100&q=!parent_id', (data)->
    for d in data.hits.hits
      result.push fromJsonToModel d._source
    callback() if callback

module.exports =
  result: result
  list: list
