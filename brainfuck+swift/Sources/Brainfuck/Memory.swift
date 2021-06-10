class Memory {
static let size = 30_000
    
    var index = 0
    var store = Array(repeating: UInt8(0), count: Memory.size)
    
    func increment() {
        store[index] += 1
    }
    
    func decrement() {
        store[index] -= 1
    }
    
    func moveLeft() {
        if index == 0 {
            index = Memory.size - 1
        } else {
            index -= 1
        }
    }
    
    func moveRight() {
        if index == Memory.size - 1 {
            index = 0
        } else {
            index += 1
        }
    }
    
    func put(_ value: UInt8) {
        store[index] = value
    }
    
    func get() -> UInt8 {
        store[index]
    }
}
