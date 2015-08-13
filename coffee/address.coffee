$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

# Model = ->
#   id: ko.observable()
#   name: ko.observable()

area_list = ko.observableArray()
city_list = ko.observableArray()
area = ko.observable()
area.subscribe (area_id)->
  listCity area_id

fromJsonToModel = (data)->
    id: data.id
    name: data.name

listArea = (callback)->
  $.get parameters.search.host + '/city/_search?size=100&q=parent_id:0', (data)->
    for area in data.hits.hits
      area_list.push fromJsonToModel area._source
    callback() if callback

listCity = (area_id, callback) ->
  if area_id
    $.get parameters.search.host+'/city/_search?size=100&q=parent_id:'+area_id, (data)->
      city_list.removeAll()
      for city in data.hits.hits
        city_list.push fromJsonToModel city._source
      callback() if callback

module.exports =
  area: area
  area_list: area_list
  city_list: city_list
  listArea: listArea
  listCity: listCity
