$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
list = ->
  $.get params.search.host + '/site_ads/_search?q=place_id:2'
  .done (data) ->
    for record in data.hits.hits
      record =
        id: record._source.ads_id
        link: record._source.linkurl
        picture: record._source.pictureurl
        place_id: record._source.place_id
        ifcheck: record._source.ifcheck
      records.push record

module.exports =
  records: records
  list: list
