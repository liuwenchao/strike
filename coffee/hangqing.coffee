$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
list = ->
  $.get params.search.host + '/site_chip/_search?size=5'
  .done (data) ->
    for hangqing in data.hits.hits
      record =
        id: hangqing._source.id
        title: hangqing._source.name
        url: hangqing._source.new_url
        children: ko.observableArray()
        addtime: new Date hangqing._source.created_time
      records.push record
      for child in hangqing._source.indices
        if child.index_name
          c =
            title: child.index_name
            weight: child.weight
            frl: 0
            price: child.price
            fudong: child.wave
          if child.wave > 0
            c.upordown = 'up'
            c.fudong = "+#{child.wave}"
          else if child.field_six == 0
            c.upordown = ''
          else
            c.upordown = 'down'
          record.children.push c

module.exports =
  records: records
  list: list
