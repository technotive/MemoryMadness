const net = require('node:net')
const helper = require('./helper')

const PORT = 9001

let listener = new net.Server(listening)
listener.listen(PORT, '127.0.0.1', () => {
    console.log(`Listening on port ${PORT} on any interface.`)
})


function listening(handler) {
    console.log(helper.color.green)
    console.log(`Client ${handler.remoteAddress} connected`)
    console.log(helper.color.blue)

    handler.on("data", (data) => {
        let request = data.toString()
        console.log(`Received ${request.length} bytes\n${request}`)
        let contents = request.split(':')
        let size = parseInt(contents[1])
        let response = contents[0].substring(0, size) + '\n'
        handler.write(response)
    })

    handler.on("end", () => {
        console.log(helper.color.red)
        console.log(`Client ${handler.remoteAddress} disconnected`)
        console.log(helper.color.reset)
    })
}