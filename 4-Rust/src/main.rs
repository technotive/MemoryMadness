// Based on the Rust documentation:
// https://doc.rust-lang.org/std/net/struct.TcpListener.html

/**
 * Note how we are forced by the return type `Result<T, U>` to acknowledge every step that could go wrong
 * This is a completely different flow as compared to throwing exceptions.
 */

use std::net::{TcpListener, TcpStream, SocketAddr};

mod helper;

const MAX_CONNECTIONS_PENDING: i32 = 8;
const PORT: u32 = 9001;

fn main() {
    let some_listener = TcpListener::bind(SocketAddr::from((helper::IN_ADDR_ANY, PORT)));
    if let Ok(listener) = some_listener {
        println!("Listening on port {PORT} on any interface.");
        loop {
            listening(&listener);
        }
    } else {
        println!("Something went wrong");
    }
}

fn listening(listener: &TcpListener) {
    let some_connection = listener.accept();
    if let Ok(connection) = some_connection {
        let (stream, info) = connection;
        println!("Client {} connected", info.ip());
        
    } else {
        println!("Client connection failed");
    }
}

fn process_data(stream: &TcpStream) {

}