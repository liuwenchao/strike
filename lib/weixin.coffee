$ = require 'jquery'
ko = require 'knockout'
params = require 'parameters'

APP_ID = 'wx6bcdccdd8918f357'
APP_SC = '14ddc63ca4beea033f67e4b894717735'

params = {}
for param in decodeURIComponent(location.search).substr(1).split('&')
  params[param.split('=')[0]] = param.split('=')[1]
if params.code
  $.get 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code='+params.code+'&grant_type=authorization_code', (data)->
    data.openid

module.exports =
