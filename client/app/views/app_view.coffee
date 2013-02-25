View      = require '../lib/view'
AppRouter = require '../routers/app_router'

module.exports = class AppView extends View
    el: 'body.application'


    template: ->
        require('./templates/home')

    initialize: ->
        @router = CozyApp.Routers.AppRouter = new AppRouter()

        @socket = io.connect('http://127.0.0.1:9104/apps/poc-public-socket');
        @socket.on 'connection', -> $('#test-socket').html('Test Socket Ready')
        @socket.on 'message', (data) -> console.log 'Server', data

    events:
        'click #test-socket': 'testSockets'
                                     
    testSockets: ->
        @socket.emit 'message', "this is a test from the client"