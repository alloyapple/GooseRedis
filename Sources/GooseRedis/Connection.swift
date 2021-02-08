import Foundation
import Glibc
public class Connection {
    
}

public class ConnectionPool {
    let pid: Int32

    public init() {
        self.pid = getpid()
    }

    public func makeConnection() {
        
    }
}