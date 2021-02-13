import Foundation
import Goose

class SocketBuffer {
    var buffer: Data
    let socket: Socket
    let socketReadSize: Int
    let socketTimeout: Float = 1.0
    var bytesWritten: Int32 = 0
    var bytesRead: Int32 = 0

    var length: Int32 {
        self.bytesWritten - self.bytesRead
    }

    init(socket: Socket, socketReadSize: Int) {
        self.buffer = Data()
        self.socket = socket
        self.socketReadSize = socketReadSize
    }

    func readFromSocket(length: Int32?) throws {
        var marker = 0
        while true {
            let data = try self.socket.read(self.socketReadSize)
            self.buffer.append(data)
            marker += data.count
            if let l = length, l > marker {
                continue
            } else {
                return
            }

        }
    }

    func read(length: Int) -> Data {
        let result = self.buffer.prefix(length)
        self.buffer = self.buffer.dropFirst(length)
        return result
    }

    func readLine() -> Data {
        if let data = self.buffer.readLine(), data.endswith(Array("\r\n".utf8)) {

        }
        return Data()
    }
}
