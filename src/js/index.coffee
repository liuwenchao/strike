$ = require 'jquery'
ko = require 'knockout'
auth = require 'auth'

ko.applyBindings
  loggedin: true
  name: 'test user'
  logout: -> true
