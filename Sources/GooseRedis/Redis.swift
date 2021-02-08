import Goose

public let defaultConfig = RedisConfig()

public class Redis {

    public init(
        host: String = "localhost", port: UInt16 = 6379,
        db: UInt8 = 0, password: String? = nil, config: RedisConfig = defaultConfig
    ) {

    }
}

public class PubSub {

}

public class Pipeline: Redis {
    
}