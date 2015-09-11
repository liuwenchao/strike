Model = ->
  id: ko.observable()
  title: ko.observable()
  summary: ko.observable()
  content: ko.observable()
  addtime: ko.observable(new Date().toISOString())

fill = (data, model) ->
  model = new Model() if not model
  model.id data.id
  model.title data.title.substr 0,12
  model.summary data.summary
  model.content data.content?[0]?.content
  model.addtime data.created_time
  return model

module.exports =
  Model:  Model
  fill:   fill
