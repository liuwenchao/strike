$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

records = ko.observableArray()
list = ->
  $.get params.search.host + '/site_chip/_search?size=5'
  .done (data) ->
    for hangqing in data.hits.hits
      record =
        id: hangqing._source.chip_id
        title: hangqing._source.chip_title
        url: hangqing._source.chip_url
        children: ko.observableArray()
        addtime: new Date hangqing._source.addtime*1000
      records.push record
      for child in hangqing._source.content
        if child.field_one
          c =
            title: child.field_one
            weight: child.field_two
            frl: child.field_three
            price: child.field_four
            fudong: child.field_five
          if child.field_six == '+1'
            c.upordown = 'up'
            c.fudong = "+#{child.field_five}"
          else if child.field_six == '0'
            c.upordown = ''
          else
            c.upordown = 'down'
            c.fudong = "-#{child.field_five}"
          record.children.push c

module.exports =
  records: records
  list: list
