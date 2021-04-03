import Goose

public let defaultConfig = RedisConfig()

public class Redis {
    public let connection: Connection
    public init(
        host: String = "localhost", port: UInt16 = 6379,
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {
        self.connection = try Connection(
            host: host, port: port, db: db, password: password, config: config)
    }

    public init(
        unixpath: String = "localhost",
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) throws {
        self.connection = try Connection(
            unixpath: unixpath, db: db, password: password, config: config)
    }

    public func get<T: RedisData>(name: String, default: T) -> T {
        return get(name: name) ?? `default`
    }

    public func get<T: RedisData>(name: String) -> T? {
        return T.fromBytes(self.executeCommand(name: "GET", args: []))
    }

    public func set<T: RedisData>(
        name: String, value: T, ex: Int? = nil, px: Int? = nil, nx: Bool = false, xx: Bool = false,
        keepttl: Bool = false
    ) {
        let pieces: [RedisData] = [name, value]
        self.executeCommand(name: "SET", args: pieces)
    }

    func parseResponse(name: String) -> Bytes {
        let response = connection.readResponse()

        // if command_name in self.response_callbacks:
        //     return self.response_callbacks[command_name](response, **options)

        return response
    }

    @discardableResult
    public func executeCommand(name: String, args: [RedisData]) -> Bytes {
        connection.sendCommand(name: name, args: args)
        return self.parseResponse(name: name)
    }
}

public class PubSub {

}

public class Pipeline: Redis {

}

public protocol RedisData {
    static func fromBytes(_ bytes: Bytes) -> Self?
    var len: Int { get }
}

extension Int: RedisData {
    public static func fromBytes(_ bytes: Bytes) -> Self? {
        return nil
    }

    public var len: Int {
        let v = "\(self)"
        return v.count
    }
}

extension String: RedisData {
    public static func fromBytes(_ bytes: Bytes) -> Self? {
        return nil
    }
    public var len: Int {
        return self.utf8.count
    }
}
