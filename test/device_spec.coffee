Device = require '../src/device'
fs = require 'fs'

describe 'Device', ->
  describe '-> register', ->
    it 'should call register on meshblu with the owner id', ->
      fakeMeshblu = new FakeMeshblu
      @sut = new Device fakeMeshblu
      @sut.register('fu-uuid')
      expect(fakeMeshblu.register.calledWith[0]).to.equal 'fu-uuid'

    describe 'when fakeMeshblu.register returns', ->
      beforeEach (done) ->
        fakeMeshblu = new FakeMeshblu
        @sut = new Device fakeMeshblu
        @sut.register('', => done())

        fakeMeshblu.register.resolve({uuid: 1, token: 3})
        
      it 'should set the uuid and token', ->
        expect(@sut.uuid).to.eq 1
        expect(@sut.token).to.eq 3

    describe 'when fakeMeshblu.register returns', ->
      beforeEach (done) ->
        fakeMeshblu = new FakeMeshblu
        @sut = new Device fakeMeshblu
        @sut.register('', => done())

        fakeMeshblu.register.resolve({uuid: 5, token: 9})
        
      it 'should set the uuid and token', ->
        expect(@sut.uuid).to.eq 5
        expect(@sut.token).to.eq 9

  describe '-> persist', ->
    describe 'when uuid and token are not set', ->
      beforeEach ->
        fakeMeshblu = new FakeMeshblu
        @sut = new Device fakeMeshblu
        @sut.persist 'test/test-file.txt'

      it 'should write an empty hash to the file', ->
        expect(JSON.parse(fs.readFileSync('test/test-file.txt'))).to.deep.eq {}

    describe 'when uuid and token are set', ->
      beforeEach ->
        fakeMeshblu = new FakeMeshblu
        @sut = new Device fakeMeshblu, {uuid: 'my-uuid', token: 'my-token'}
        @sut.persist 'test/test-file.txt'

      it 'should write the uuid and token to the file', ->
        expect(JSON.parse(fs.readFileSync('test/test-file.txt'))).to.deep.eq {uuid: 'my-uuid', token: 'my-token'}

    afterEach ->
      fs.unlink 'test/test-file.txt'

class FakeMeshblu
  register: (owner_id, callback) =>
    @register.calledWith = _.values arguments
    @register.resolve = callback
