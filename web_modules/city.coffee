$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

area_list: ko.observableArray()
city_list: ko.observableArray()
Model:
  id: ko.observable()
  name: ko.observable()

fromJsonToModel: (data)->
  new Model
    id: record._source.city_id
    name: record._source.city_name

listArea: (callback)->
  $.get parameters.search.host + '/city/_search?size=100&q=parent_id:0', (data)->
    for area in data.hits.hits
      model.area_list.push fromJsonToModel area._source
    callback()

listCity: (area_id, callback) ->
  if area_id
    $.get parameters.search.host+'/city/_search?size=100&q=parent_id:'+area_id, (data)->
      model.city_list.removeAll()
      for city in data.hits.hits
        model.city_list.push fromJsonToModel city._source
      callback()

module.exports =
  Model: Model
  area_list: area_list
  city_list: city_list
  listArea: listArea
  listCity: listCity
