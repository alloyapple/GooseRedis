import Foundation

public struct RedisConfig {
    let socketTimeout: Float = 0
    let socketConnectTimeout: Float = 0
    let socketKeepalive: Bool = true
    let socketKeepaliveOptions: Int32 = 0
    let connectionPool: Int32 = 0
    let unixSocketPath: Int32 = 0
    let encoding: String = "utf-8"
    let encodingErrors: String = "strict"
    let decodeResponses: Int32 = 0
    let retryOnTimeout: Int32 = 0
    let ssl: Int32 = 0
    let sslKeyfile: String = ""
    let sslCertfile: String = ""
    let sslCertReqs: Int32 = 0
    let sslCaCerts: Int32 = 0
    let sslCheckHostname: Int32 = 0
    let maxConnections: Int32 = 0
    let singleConnectionClient: Int32 = 0
    let healthCheckInterval: Int32 = 0
    let clientName: String = ""
    let username: String = ""
}
