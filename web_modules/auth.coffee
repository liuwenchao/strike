$ = require 'script!jquery/dist/jquery.min.js'
Cookies = require 'script!cookies-js/dist/cookies.min.js'

module.exports =
  # login: (username, password) -> $.post http://test.account.zhaomw.cn/login
  #   _username: username
  #   _passowrd: password
  # (data) -> alert data
  logout: -> Cookies.expire ''
  isLoggedin: -> true
