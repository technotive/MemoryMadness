/**
 * Note (in main.rs) how we are forced by the return type `Result<T, U>` to acknowledge every step that could go
 * wrong. This is a completely different flow as compared to throwing exceptions. It is a little more verbose than just
 * writing your happy flow, but there is a lot less that can accidentally go wrong by forgetting to catch a specific
 * error.
 * Also, you cannot get away with just doing a catch-all. Every Error has a unique type that you have to handle
 * specifically.
 * 
 * Like Haskell, Rust is strongly typed. It also employs Functional paradigmas like Haskell.
 * Unlike Haskell, Rust is procedural and we need no `do` statements and weird `IO ()` constructs.
 */

use std::{net::SocketAddr, io::Write};

pub const IN_ADDR_ANY: [u8; 4] = [0, 0, 0, 0];
const ANSI_COLOR_RED   : &str = "\x1b[31m";
const ANSI_COLOR_GREEN : &str = "\x1b[32m";
const ANSI_COLOR_BLUE  : &str = "\x1b[34m";
const ANSI_COLOR_RESET : &str = "\x1b[0m";

pub fn log_connected(info: SocketAddr) {
    print!("{}", ANSI_COLOR_GREEN);
    println!("Client {} connected", info.ip());
    print!("{}", ANSI_COLOR_RESET);
    flush()
}

pub fn log_disconnected(info: SocketAddr) {
    print!("{}", ANSI_COLOR_RED);
    println!("Client {} disconnected", info.ip());
    print!("{}", ANSI_COLOR_RESET);
    flush()
}

pub fn log_request(buffer: &[u8], length: usize) {
    print!("{}", ANSI_COLOR_BLUE);
    println!("Received {} bytes", length);
    print!("{}", ANSI_COLOR_RESET);
    println!("{:?}", &buffer[..length]);
    flush()
}

fn flush() { // Printing a line is equivalent to flushing for our purpose
    if let Err(_) = std::io::stdout().flush() { println!() } 
}