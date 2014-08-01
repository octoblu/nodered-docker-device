skynet = require 'skynet'

class Meshblu
  constructor: (callback=->) ->
    @connection = skynet.createConnection server: 'http://skynet.im'
    @connection.on 'ready', callback

  register: (owner_id, callback=->) =>
    @connection.register {owner: owner_id, type: 'nodered-docker'}, callback

  close: =>
    @connection.socket.close()
  
module.exports = Meshblu
