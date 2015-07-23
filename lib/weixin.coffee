$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'

APP_ID = 'wx6bcdccdd8918f357'
APP_SC = '14ddc63ca4beea033f67e4b894717735'
load = ->
  params = {}
  for param in decodeURIComponent(location.search).substr(1).split('&')
    params[param.split('=')[0]] = param.split('=')[1]
  if params.code
    $.get 'https://api.weixin.qq.com/sns/oauth2/access_token',
      appid: APP_ID
      secret:APP_SC
      code:  params.code
      grant_type:'authorization_code'
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
      else
        window.location.href = '/'

module.exports =
  load: load
