import Foundation
import Glibc
import Goose

public class Connection {
    public let pid: Int32
    public let host: String
    public let port: UInt16
    public let db: UInt8
    public let password: String?
    public var sock: Socket?
    public let config: RedisConfig

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
    }

    public func _connect() {
        
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
