$ = require 'jquery'
ko = require 'knockout'

form =
  standard_cate_one: ko.observable()
  caigou_content: ko.observable()
  pay_price: ko.observable()
  pay_weight: ko.observable()

save = ->
  $.ajax
    type: 'post'
    xhrFields:
      withCredentials: true
    url: 'http://test.api.zhaomw.cn/caigouses'
    data: ko.toJS(form)
    success: -> window.alert '发布成功'
    # window.location.href='index.html'

ko.applyBindings
  form: form
  save: save
