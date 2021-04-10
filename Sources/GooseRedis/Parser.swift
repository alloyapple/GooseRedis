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

    func readResponse() -> Bytes {
        let raw = self.buffer.readLine()
        let byte = String(format: "%c", raw[0])
        let response = Array(raw[1...])

        switch byte {
        case "-":
            return response
        case "+":
            return response
        case ":":
            return response
        case "$":
            let l = Int.fromBytes(response) ?? 0
            return self.buffer.read(length: l).bytes
        case "*":
            return response
        default:
            return response
        }

    }
}
