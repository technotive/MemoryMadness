using System.Net;

namespace Helper {
    public class Logger {
        public static void LogConnected(EndPoint? ip) {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine($"Client {ip} connected");
            Console.ForegroundColor = ConsoleColor.White;
        }
        public static void LogDisonnected(EndPoint? ip) {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Client {ip} disconnected");
            Console.ForegroundColor = ConsoleColor.White;
        }
        public static void LogRequest(byte[] buffer, int length) {
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.WriteLine($"Received {length} raw bytes");
            Console.ForegroundColor = ConsoleColor.White;
            Console.WriteLine(buffer);
        }
    }
}