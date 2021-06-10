enum Instruction: Equatable {
    case moveRight
    case moveLeft
    case increment
    case decrement
    case output
    case input
    case open(Int)
    case close(Int)
}

func parse(_ source: String) -> [Instruction]? {
    let ops = source.filter { [">", "<", "+", "-", ".", ",", "[", "]"].contains($0) }
    
    var instructions = [Instruction]()
    
    for index in ops.indices {
        switch ops[index] {
        case ">":
            instructions.append(.moveRight)
        case "<":
            instructions.append(.moveLeft)
        case "+":
            instructions.append(.increment)
        case "-":
            instructions.append(.decrement)
        case ".":
            instructions.append(.output)
        case ",":
            instructions.append(.input)
        case "[":
            guard let closing = findClosingBracket(of: ops, starting: index) else {
                return nil
            }
            let distance = ops.distance(from: index, to: closing)
            instructions.append(.open(distance))
        case "]":
            guard let opening = findOpeningBracket(of: ops, starting: index) else {
                return nil
            }
            let distance = ops.distance(from: opening, to: index)
            instructions.append(.close(distance))
        default:
            break
        }
    }
    
    return instructions
}

fileprivate func findClosingBracket(of string: String, starting: String.Index) -> String.Index? {
    precondition(string[starting] == "[")
    var count = 1
    let starting = string.index(after: starting)
    for i in string[starting...].indices {
        if string[i] == "[" {
            count += 1
        } else if string[i] == "]" {
            count -= 1
        }
        if count == 0 {
            return i
        }
    }
    return nil
}

fileprivate func findOpeningBracket(of string: String, starting: String.Index) -> String.Index? {
    precondition(string[starting] == "]")
    var count = 1
    for i in string[..<starting].indices.reversed() {
        if string[i] == "[" {
            count -= 1
        } else if string[i] == "]" {
            count += 1
        }
        if count == 0 {
            return i
        }
    }
    return nil
}

