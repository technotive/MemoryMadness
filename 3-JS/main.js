const net = require('node:net')
const header = require('./header')

const PORT = 9001

let listener = new net.Server(listening)
listener.listen(PORT, '127.0.0.1', () => {
    console.log(`Listening on port ${PORT} on any interface.`)
})


function listening(handler) {
    console.log(header.color.green)
    console.log(`Client ${handler.remoteAddress} connected`)
    console.log(header.color.blue)

    handler.on("data", (data) => {
        let response = data.toString()
        console.log(`Received ${response.length} bytes\n${response}`)
        let contents = response.split(':')
        let size = parseInt(contents[1])
        let reply = contents[0].substring(0, size) + '\n'
        handler.write(reply)
    })

    handler.on("end", () => {
        console.log(header.color.red)
        console.log(`Client ${handler.remoteAddress} disconnected`)
        console.log(header.color.reset)
    })
}