$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

load = ->
  params = {}
  for param in decodeURIComponent(location.search).substr(1).split('&')
    params[param.split('=')[0]] = param.split('=')[1]
  if params.code
    $.get parameters.account.host + '/oauth',
      code:  params.code
    , (data)->
      if data.openid
        $.ajax
          type: 'post'
          xhrFields:
            withCredentials: true
          url: parameters.account.host+'/login'
          data:
            weixin_id: data.openid
            _format: 'json'
          success: -> window.location.href='/'
          error:   -> window.location.href='register.html?weixin_id='+data.openid
    .fail ->
      window.location.href = '/'

module.exports =
  load: load