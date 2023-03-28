// This code is based on Microsoft's socket example code:
// https://learn.microsoft.com/en-us/dotnet/fundamentals/networking/sockets/socket-services
using System.Net;
using System.Net.Sockets;
using System.Text;
using Helper;

const int MAX_CONNECTIONS_PENDING = 8;
const int PORT = 9001;

var endpoint = new IPEndPoint(IPAddress.Any, PORT);

using Socket listener = new(endpoint.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
listener.Bind(endpoint);
listener.Listen(MAX_CONNECTIONS_PENDING);
Console.WriteLine($"Listening on port {PORT} on any interface.");

var listening = true;
while (listening)
{
    var handler = await listener.AcceptAsync();
    Helper.Logger.LogConnected(handler.RemoteEndPoint);
    
    var connected = true;
    while(connected)
    {
        var buffer = new byte[256];
        var byteCount = await handler.ReceiveAsync(buffer, SocketFlags.None);
        if(byteCount > 0)
        {
            Helper.Logger.LogRequest(buffer, byteCount);
            var response = processRequest(buffer, byteCount);
            await handler.SendAsync(response);
        }
        else
        {
            connected = false;
        }
    }

    Helper.Logger.LogDisonnected(handler.RemoteEndPoint);
    handler.Close();
}

byte[] processRequest(byte[] buffer, int length) {
    var request = Encoding.UTF8.GetString(buffer, 0, length);
    var contents = request.Split(':');
    var text = contents[0];
    var size = int.Parse(contents[1]);
    var response = text.Substring(0, size) + "\n";
    return Encoding.UTF8.GetBytes(response);
}