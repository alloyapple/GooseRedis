import Foundation
import Goose

public class SocketBuffer {
    var buffer: Data
    let socket: Socket
    let socketReadSize: Int
    let socketTimeout: Float = 1.0
    var bytesWritten: Int32 = 0
    var bytesRead: Int32 = 0

    var length: Int32 {
        self.bytesWritten - self.bytesRead
    }

    public init(socket: Socket, socketReadSize: Int) {
        self.buffer = Data()
        self.socket = socket
        self.socketReadSize = socketReadSize
    }

    func readFromSocket(length: Int?) throws {
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
        purge(len: length)
        return result
    }

    func readLine() -> [UInt8] {
        var result = [UInt8]()
        while true {
            if let data = self.buffer.readLine(), data.endswith("\r\n".bytes) {
                let lastIndex = data.count - 2
                result = Array(data[..<lastIndex])
                break
            } else {
                try? self.readFromSocket(length: nil)
            }
        }

        purge(len: result.count + 2)
        return result
    }

    func purge(len: Int) {
        self.buffer = self.buffer.dropFirst(len)
    }
}
