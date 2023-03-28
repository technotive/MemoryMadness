module.exports = {
    logConnected: function(ip) {
        console.log(`\x1b[32mClient ${ip} connected\x1b[0m`)
    },
    logDisonnected: function(ip) {
        console.log(`\x1b[31mClient ${ip} disconnected\x1b[0m`)
    },
    logRequest: function(data) {
        console.log(`\x1b[34mReceived ${data.length} raw bytes\x1b[0m`)
        console.log(data)
    }
}