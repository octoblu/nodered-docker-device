fs = require 'fs'
winston = require 'winston'
Meshblu = require './src/meshblu'
Device = require './src/device'

meshblu = new Meshblu =>
  device = new Device meshblu

  owner_uuid = process.env.OWNER_UUID

  winston.info 'Starting registration for %s...', owner_uuid
  device.register owner_uuid, =>
    device.persist process.env.FILENAME
    meshblu.close()
