import Goose

public class Parser {
    let socketReadSize: Int
    let sock: Socket
    let buffer: SocketBuffer

    public init(socketReadSize: Int, sock: Socket) {
        self.socketReadSize = socketReadSize
        self.sock = sock
        self.buffer = SocketBuffer(
            socket: sock,
            socketReadSize: socketReadSize
        )

    }

    func readResponse() {
        let raw = self.buffer.readLine()

    }
}
