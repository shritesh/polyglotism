    import XCTest
    @testable import Brainfuck
    
    final class MemoryTests: XCTestCase {
        func testSampleRun() {
            let memory = Memory()
            
            // index: 0
            XCTAssertEqual(memory.get(), 0)
            memory.moveRight()

            // index: 1
            memory.put(42);
            XCTAssertEqual(memory.get(), 42)
            memory.moveLeft()

            // index: 0
            XCTAssertEqual(memory.get(), 0)
            memory.put(24)
            memory.increment()
            XCTAssertEqual(memory.get(), 25)
            memory.moveLeft()

            // index: 29_999
            memory.put(14)
            memory.decrement()
            XCTAssertEqual(memory.get(), 13)
            memory.moveRight()

            // index: 0
            XCTAssertEqual(memory.get(), 25)
            memory.moveRight()

            // index: 1
            XCTAssertEqual(memory.get(), 42)

            // index: 2
            memory.moveRight()
            XCTAssertEqual(memory.get(), 0)
        }
    }
