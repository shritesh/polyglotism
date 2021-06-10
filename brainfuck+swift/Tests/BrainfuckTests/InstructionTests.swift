    import XCTest
    @testable import Brainfuck
    
    final class InstructionTests: XCTestCase {
        func testParseMatchingClose() {
            let source = "Hello[[][[]][]]Goodbye"
            let expectation: [Instruction] = [
                .open(9),
                .open(1),
                .close(1),
                .open(3),
                .open(1),
                .close(1),
                .close(3),
                .open(1),
                .close(1),
                .close(9)
            ]
            XCTAssertEqual(parse(source)!, expectation)
        }
        
        func testParseMismatchedParen() {
            XCTAssertNil(parse("[[]"))
            XCTAssertNil(parse("[]]"))
        }
    }
