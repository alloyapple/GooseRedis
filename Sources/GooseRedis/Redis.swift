import Goose

public let defaultConfig = RedisConfig()

public class Redis {
    public let connection: Connection
    public init(
        host: String = "localhost", port: UInt16 = 6379,
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {
        self.connection = try Connection(host: host, port: port, db: db, password: password, config: config)
    }

    public init(
        unixpath: String = "localhost",
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {
        self.connection = try Connection(unixpath: unixpath, db: db, password: password, config: config)
    }

    public func get<T>(name: String) -> T? {
        return nil
    }

    public func set<T: RedisData>(
        name: String, value: T, ex: Int? = nil, px: Int? = nil, nx: Bool = false, xx: Bool = false,
        keepttl: Bool = false
    ) {
        let pieces: [RedisData] = [name, value]
        self.executeCommand(name: "SET", args: pieces)
    }

    public func executeCommand(name: String, args: [RedisData]) {
        let commandName = args[0]
        connection.sendCommand(name: name, args: args)
        //return self.parseResponse(commandName)
    }
}

public class PubSub {

}

public class Pipeline: Redis {

}

public protocol RedisData {
    var len: Int { get }
}

extension Int: RedisData {
    public var len: Int {
        let v = "\(self)"
        return v.count
    }
}

extension String: RedisData {
    public var len: Int {
        return self.utf8.count
    }
}
