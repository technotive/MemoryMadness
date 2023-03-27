// Based on the Rust documentation:
// https://doc.rust-lang.org/std/net/struct.TcpListener.html

use std::io::prelude::*;
use std::str;
use std::net::{TcpListener, TcpStream, SocketAddr};

mod helper; // See helper.rs for more information
use crate::helper::*;

const PORT: u16 = 9001;

fn main() {
    let address = SocketAddr::from((helper::IN_ADDR_ANY, PORT));
    let some_listener = TcpListener::bind(address);
    if let Ok(listener) = some_listener {
        println!("Listening on port {PORT} on any interface.");
        loop {
            listening(&listener);
        }
    } else {
        println!("Binding to interface failed");
    }
}

fn listening(listener: &TcpListener) {
    let some_connection = listener.accept();
    if let Ok(connection) = some_connection {
        let (mut stream, info) = connection;
        print!("{}", ANSI_COLOR_GREEN);
        println!("Client {} connected", info.ip());
        print!("{}", ANSI_COLOR_BLUE);
        communicate(&mut stream);
        print!("{}", ANSI_COLOR_RED);
        println!("Client {} connected", info.ip());
        print!("{}", ANSI_COLOR_RESET);
    } else {
        println!("Client connection failed");
    }
}

fn communicate(stream: &mut TcpStream) {
    let mut buffer = [0;256];
    let result = stream.read(&mut buffer);
    if let Ok(byte_count) = result {
        if let Ok(request) = str::from_utf8(&buffer) {
            println!("Received {} bytes\n{}", byte_count, request);
            let some_contents = request[0..byte_count].split_once(':');
            if let Some(contents) = some_contents {
                let some_size = contents.1.trim().parse();
                if let Ok(size) = some_size {
                    let mut response = contents.0.chars().take(size).collect::<String>();
                    response.push('\n');
                    if let Ok(_) = stream.write(response.as_bytes()) {
                        // No need to check further
                    } else {
                        println!("Could not respond")
                    }
                } else {
                    println!("Could not parse size");
                }
            } else {
                println!("Could not split request");
            }
        } else {
            println!("Could not decode request");
        }
    } else {
        println!("Error while receiving data");
    }
}