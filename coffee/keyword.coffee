$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

Model = ->
  name: ko.observable()

result = ko.observableArray()
list = (callback)->
  $.get parameters.search.host + '/keyword/_search?size=100&sort=id', (data)->
    for record in data.hits.hits
      _new = new Model()
      _new.name record._source.name
      result.push _new

    callback() if callback

module.exports =
  result: result
  list: list
