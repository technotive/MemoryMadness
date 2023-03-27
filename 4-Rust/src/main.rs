// Based on the Rust documentation:
// https://doc.rust-lang.org/std/net/struct.TcpListener.html

use std::net::{TcpListener, TcpStream, SocketAddr};

mod helper; // See helper.rs for more information

const MAX_CONNECTIONS_PENDING: i32 = 8;
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

fn receive_data_on(stream: &TcpStream) {

}