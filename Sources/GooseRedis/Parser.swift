import Goose
public class Parser {
    let socketReadSize: Int32
    let sock: Socket
    let buffer: SocketBuffer

    public init(socketReadSize: Int32, sock: Socket, buffer: SocketBuffer) {
        self.socketReadSize = socketReadSize
        self.sock = sock
        self.buffer = buffer

    }

    func readResponse() {
        let raw = self.buffer.readLine()
        
    }
}