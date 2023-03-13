// This code is based on Microsoft's socket example code @ https://learn.microsoft.com/en-us/dotnet/fundamentals/networking/sockets/socket-services
using System.Net;
using System.Net.Sockets;
using System.Text;

const int MAX_CONNECTIONS_PENDING = 8;
const int PORT = 9001;
var endpoint = new IPEndPoint(IPAddress.Any, PORT);

var buffer = new byte[64];

using Socket listener = new(endpoint.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
listener.Bind(endpoint);
listener.Listen(MAX_CONNECTIONS_PENDING);
Console.WriteLine($"Listening on port {PORT} on any interface.");

var listening = true;
while (listening) {
    var handler = await listener.AcceptAsync();
    Console.WriteLine($"Client {handler.RemoteEndPoint} connected");
    var connected = true;
    while(connected) {
        var byte_count = await handler.ReceiveAsync(buffer, SocketFlags.None);
        var response = Encoding.UTF8.GetString(buffer, 0, byte_count); // Memory management: my buffer is filled from 0 through byte_count and I want it as a UTF-8 string.
        Console.WriteLine(response);
        connected = byte_count > 0;
    }
    Console.WriteLine($"Client {handler.RemoteEndPoint} disconnected");
}