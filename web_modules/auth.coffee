$ = require 'script!jquery/dist/jquery.js'


module.exports =
  login: (username, password) -> $.post http://test.account.zhaomw.cn/login
    _username: username
    _passowrd: password
  (data) -> alert data
