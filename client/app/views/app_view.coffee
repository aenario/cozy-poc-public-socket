View      = require '../lib/view'
AppRouter = require '../routers/app_router'

module.exports = class AppView extends View
    el: 'body.application'


    template: ->
        require('./templates/home')

    initialize: ->
        @router = CozyApp.Routers.AppRouter = new AppRouter()
        url = window.location.href.replace 'http' , 'ws'
        @socket = new WebSocket url, 'proto'
        @socket.onopen = -> $('#test-socket').html('Test Socket Ready')
        @socket.onerror = (err) -> console.log 'Error', err
        @socket.onmessage = (e) -> console.log 'Server', e.data

    events:
        'click #test-socket': 'testSockets'
                                     
    testSockets: ->
        @socket.send("this is a test from the client")