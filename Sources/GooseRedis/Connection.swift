import Foundation
import Glibc
import Goose

public class Connection {
    public let pid: Int32
    public let db: UInt8
    public let password: String?
    public var sock: Socket
    public let config: RedisConfig
    public let parser: Parser

    public init(
        host: String = "localhost", port: UInt16 = 6379,
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {
        func _connect() throws -> Socket {
            let addrList = try getAddrinfo(
                host: host, port: port, family: config.socketFamily,
                type: SockType.tcp)

            for addr in addrList {
                do {
                    let sock = Socket(
                        family: addr.pointee.family,
                        type: addr.pointee.type,
                        proto: addr.pointee.prot)
                    sock.options.noDelay = true
                    sock.options.keepAlive = true

                    try sock.connect(addr: addr)
                    return sock
                }
            }
            throw GooseError.error()
        }

        self.pid = getpid()
        self.sock = try _connect()
        self.parser = Parser(socketReadSize: Int32, sock: self.sock, buffer: SocketBuffer)
        self.db = db
        self.password = password
        self.config = config
    }

    public init(
        unixpath: String = "localhost",
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {

        self.pid = getpid()
        self.sock = Socket()
        try self.sock.connect(path: unixpath)
        self.db = db
        self.password = password
        self.config = config
    }

    func onConnect() {

    }

    func packCommand(args: Bytes...) {

    }

    func packCommand(name: String, args: [RedisData]) -> Bytes {

        let nameArray = name.components(separatedBy: " ")
        var newArgs: [RedisData] = []
        if nameArray.count > 1 {
            newArgs = nameArray + args
        } else {
            newArgs = [name] + args
        }

        var buffer = "*\(newArgs.count)\r\n"

        for arg in newArgs {
            let argLength = arg.len
            buffer += "$\(argLength)\r\n\(arg)\r\n"
        }

        return Array(buffer.utf8)
    }

    func readResponse() -> Bytes {
        let raw = self.buffer.readLine()

    }

    func sendPackedCommand(bytes: Bytes, checkHealth: Bool) {
        if checkHealth {
            //  self.checkHealth()
        }

        do {
            try self.sock.sendall(bytes)
        } catch let error {

        }

    }

    func sendCommand(name: String, args: [RedisData]) {
        self.sendPackedCommand(
            bytes: self.packCommand(name: name, args: args),
            checkHealth: true)
    }
}

public class ConnectionPool {
    let pid: Int32

    public init() {
        self.pid = getpid()
    }

    public func makeConnection() {

    }
}
