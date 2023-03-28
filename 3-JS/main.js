// Based on the Node JS documentation for the net class:
// https://nodejs.org/api/net.html

const net = require('node:net')
const helper = require('./helper')

const PORT = 9001

let listener = new net.Server(onConnection)
listener.listen(PORT, '127.0.0.1', () => {
    console.log(`Listening on port ${PORT} on any interface.`)
})


function onConnection(handler) {
    helper.logConnected(handler.remoteAddress)

    handler.on("data", (data) => {
        helper.logRequest(data);
        let response = processRequest(data)
        handler.write(response)
    })

    handler.on("end", () => helper.logDisonnected(handler.remoteAddress))
}

function processRequest(data) {
    let request = data.toString()
    let contents = request.split(':')
    let size = parseInt(contents[1])
    return contents[0].substring(0, size) + '\n'
}