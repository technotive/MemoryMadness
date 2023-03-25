// This code is based on Microsoft's socket example code:
// https://learn.microsoft.com/en-us/dotnet/fundamentals/networking/sockets/socket-services
using System.Net;
using System.Net.Sockets;
using System.Text;

const int MAX_CONNECTIONS_PENDING = 8;
const int PORT = 9001;
var endpoint = new IPEndPoint(IPAddress.Any, PORT);

var buffer = new byte[256];

using Socket listener = new(endpoint.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
listener.Bind(endpoint);
listener.Listen(MAX_CONNECTIONS_PENDING);
Console.WriteLine($"Listening on port {PORT} on any interface.");

var listening = true;
while (listening)
{
    var handler = await listener.AcceptAsync();

    Console.ForegroundColor = ConsoleColor.Green;
    Console.WriteLine($"Client {handler.RemoteEndPoint} connected");
    Console.ForegroundColor = ConsoleColor.Blue;
    
    var connected = true;
    while(connected)
    {
        var byteCount = await handler.ReceiveAsync(buffer, SocketFlags.None);
        var response = Encoding.UTF8.GetString(buffer, 0, byteCount);

        if(byteCount > 0)
        {
            Console.WriteLine($"\nReceived {response.Length} bytes\n{response}");
            var contents = response.Split(':');
            var text = contents[0];
            var size = int.Parse(contents[1]);
            var reply = text.Substring(0, size) + "\n";
            await handler.SendAsync(Encoding.UTF8.GetBytes(reply));
        }
        else
        {
            Console.WriteLine($"Received nothing\n");
            connected = false;
        }
    }

    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine($"\nClient {handler.RemoteEndPoint} disconnected");
    handler.Close();
    Console.ForegroundColor = ConsoleColor.White;
}