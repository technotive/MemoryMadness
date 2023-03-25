const ANSI_COLOR_RED   = "\x1b[31m"
const ANSI_COLOR_GREEN = "\x1b[32m"
const ANSI_COLOR_BLUE  = "\x1b[34m"
const ANSI_COLOR_RESET = "\x1b[0m"

function r() { console.log(ANSI_COLOR_RED) }
function g() { console.log(ANSI_COLOR_RED) }
function b() { console.log(ANSI_COLOR_RED) }
function rst() { console.log(ANSI_COLOR_RED) }


module.exports = {
    color: {
        red: r,
        green: g,
        blue: b,
        reset: rst
    }
}