fs = require 'fs'
class Device
  constructor: (@meshblu, options={}) ->
    @uuid = options.uuid
    @token = options.token

  register: (@owner_id, callback=->) =>
    @meshblu.register owner_id, ({uuid: @uuid, token: @token}) => callback()

  persist: (filename) =>
    if filename
      data = {uuid: @uuid, token: @token}
      fs.writeFileSync filename, JSON.stringify(data) + "\n"

module.exports = Device
