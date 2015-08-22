$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
list = ->
  $.get params.search.host + '/site_ads/_search?q=place_id.id:11'
  .done (data) ->
    for record in data.hits.hits
      record =
        id: record._source.id
        link: record._source.linkurl
        picture: params.www.host+record._source.pictureurl
        place_id: record._source.place_id?.id
        ifcheck: record._source.status
      records.push record

module.exports =
  records: records
  list: list
