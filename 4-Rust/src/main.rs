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
            my_listen(&listener);
        }
    } else {
        println!("Binding to interface failed");
    }
}

fn my_listen(listener: &TcpListener) {
    if let Ok((mut stream, info)) = listener.accept() {
        log_connected(info);
        while communicate(&mut stream) {}
        log_disconnected(info);
        if let Err(_) = stream.shutdown(std::net::Shutdown::Both) {
            println!("Failed to close stream after response");
        }
    } else {
        println!("Client connection failed");
    }
}

fn communicate(stream: &mut TcpStream) -> bool {
    let mut buffer = [0;256];
    let Ok(byte_count) = stream.read(&mut buffer) else { return false; };
    if byte_count == 0 {
        return false;
    }
    log_request(&buffer, byte_count);
    let Some(response) = process_request(&buffer, byte_count) else { return false; };
    let Ok(_) = stream.write(response.as_bytes()) else { return false; };
    return true;
}

fn process_request(buffer: &[u8], length: usize) -> Option<String> {
    let Ok(request) = str::from_utf8(&buffer[..length]) else { return None };
    let Some(contents) = request.split_once(':') else { return None };
    let Ok(size) = contents.1.trim().parse() else { return None };
    let mut response = contents.0.chars().take(size).collect::<String>();
    response.push('\n');
    return Some(response);
}