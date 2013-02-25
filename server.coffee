#!/usr/bin/env coffee

app = module.exports = require('railway').createServer()
WebSocketServer = require('websocket').server;

if not module.parent
    port = process.env.PORT or 9250
    server = app.listen port, "127.0.0.1"
    wsServer = new WebSocketServer
        httpServer: server

    wsServer.on 'request', (request) ->
        connection = request.accept('proto', request.origin);
        connection.on 'message', (message) ->
            console.log('Received Message: ' + message.utf8Data);
            connection.sendUTF(message.utf8Data);
        connection.on 'close', (reasonCode, description) ->
            console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');

    console.log "Railway server listening on port %d within %s environment", port, app.settings.env
