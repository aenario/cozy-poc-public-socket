express = require 'express'

app.configure ->
    cwd = process.cwd()
    
    app.enable 'coffee'

    app.use '/public', express.static(cwd + '/client-public/public', maxAge: 86400000)
    app.use express.static(cwd + '/client/public', maxAge: 86400000)
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
