import Foundation

struct GooseRedis {
    var text = "Hello, World!"
}

extension Array where Element == UInt8 {
    func endswith(_ a: [Element]) -> Bool {
        if a.count > self.count {
            return false
        }
        let index = self.count - a.count
        let subArray = self[index...]
        return Array(subArray) == a
    }

    var toInt: Int {
        let bigEndianValue = self.withUnsafeBufferPointer {
            ($0.baseAddress!.withMemoryRebound(to: Int.self, capacity: 1) { $0 })
        }.pointee
        return Int(bigEndian: bigEndianValue)
    }
}
