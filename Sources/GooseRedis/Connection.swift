import Foundation
import Glibc
import Goose

public class Connection {
    public let pid: Int32
    public let host: String
    public let port: UInt16
    public let db: UInt8
    public let password: String?
    public var sock: Socket
    public let config: RedisConfig
    public let parser: Parser = Parser(socketReadSize: 10)

    public init(
        host: String = "localhost", port: UInt16 = 6379,
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) {
        self.pid = getpid()
        self.host = host
        self.port = port
        self.db = db
        self.password = password
        self.config = config
    }

    public func connect() {
        guard let sock = self.sock else {
            return
        }

        try? self._connect()
    }

    public func _connect() throws -> Socket {
        var addrList = try getAddrinfo(
            host: self.host, port: self.port, family: self.config.socketFamily,
            type: SockType.tcp)

        for addr in addrList {
            let sock = Socket(
                family: addr.pointee.family,
                type: addr.pointee.type,
                proto: addr.pointee.prot)
            sock.options.noDelay = true
            sock.options.keepAlive = true

            try sock.connect(addr: addr)
            // sock.settimeout(self.socket_timeout)

            return sock
        }
        throw GooseError.error()
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

    func sendPackedCommand(bytes: Bytes, checkHealth: Bool) {
        if checkHealth {

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
