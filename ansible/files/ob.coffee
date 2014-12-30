# Description:
#   Manipulate the Objective EDRMS
#
# Commands:
#   hubot ob

Tedious = require 'tedious'

Connection = Tedious.Connection
Request = Tedious.Request

  #server: '10.44.1.100',
  #userName: 'objprod_readonly',
  #password: 'bold_new_ventur3',

config =
  server: '192.168.200.199'
  userName: 'some_user'
  password: 'some_pwd'
  options:
    debug:
      packet: true
      data: true
      payload: true
      token: false
      log: true
    database: 'some_db'
    encrypt: false

getConnected = () ->
  connection = new Connection config
  connection.on 'connect', (err) ->
    if err
      console.log 'Connection error ' + err
    else
      # console.log 'Connected ...'
      executeStatement()
  connection.on 'debug', (text) ->
     console.log 'Failed connection ...' + text

executeStatement = () ->
  request = new Request "select 42, 'hello world'", (err, rowCount) ->
    if err
      console.log err
    else
      console.log rowCount + ' rows'
    connection.close
  request.on 'row', (columns) ->
    columns.forEach (column) ->
      if column.value is null
        console.log 'NULL'
      else
        console.log column.value
  request.on 'done', (rowCount, more) ->
    console.log rowCount + ' rows returned'
  connection.execSql(request);

module.exports = (robot) ->
  robot.respond /ob/i, (msg) ->
    console.log "Started !"
    getConnected()
    console.log 'Got a connection object'
