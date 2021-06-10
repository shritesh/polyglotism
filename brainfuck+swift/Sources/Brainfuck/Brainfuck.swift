enum Brainfuck {
    static func run(_ source: String, input: String = "") -> String? {
        guard let instructions = parse(source) else {
            return nil
        }
        let memory = Memory()
        var output = String.init()
        var inputIdx = input.startIndex
        
        var pc = 0
        loop: while (pc < instructions.count) {
            switch instructions[pc] {
            case .moveRight:
                memory.moveRight()
            case .moveLeft:
                memory.moveLeft()
            case .increment:
                memory.increment()
            case .decrement:
                memory.decrement()
            case .output:
                output.append(Character(UnicodeScalar(memory.get())))
            case .input:
                if inputIdx == input.endIndex {
                    memory.put(0)
                } else {
                    memory.put(input[inputIdx].asciiValue!)
                    inputIdx = input.index(after: inputIdx)
                }
            case .open(let j):
                if memory.get() == 0 {
                    pc += j
                    continue loop
                }
            case .close(let j):
                if memory.get() != 0 {
                    pc -= j
                    continue loop
                }
            }
            pc += 1
        }
    return output
    }
}
