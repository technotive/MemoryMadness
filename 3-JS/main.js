const net = require('node:net')
const h = require('./header')

const PORT = 9001

let listener = new net.Server(listening)
listener.listen(PORT, '127.0.0.1', () => {
    console.log(`Listening on port ${PORT} on any interface.`)
})


function listening(handler) {
    h.color.green()
    console.log(`Client ${handler.remoteAddress} connected`)
    h.color.blue()

    
}