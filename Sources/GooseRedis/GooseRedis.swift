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
}
