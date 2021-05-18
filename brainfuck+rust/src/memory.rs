const SIZE: usize = 30_000;
type TYPE = u8;

pub struct Memory {
    index: usize,
    store: [TYPE; SIZE],
}

impl Memory {
    pub fn new() -> Self {
        Self {
            index: 0,
            store: [0; SIZE],
        }
    }

    pub fn increment(&mut self) {
        self.store[self.index] += 1;
    }

    pub fn decrement(&mut self) {
        self.store[self.index] -= 1;
    }

    pub fn move_left(&mut self) {
        self.index = if self.index == 0 {
            SIZE - 1
        } else {
            self.index - 1
        };
    }
    pub fn move_right(&mut self) {
        self.index = if self.index == SIZE - 1 {
            0
        } else {
            self.index + 1
        }
    }

    pub fn put(&mut self, value: TYPE) {
        self.store[self.index] = value;
    }

    pub fn get(&self) -> TYPE {
        self.store[self.index]
    }
}

#[cfg(test)]
mod tests {
    use super::Memory;

    #[test]
    fn sample_run() {
        let mut memory = Memory::new();

        // index: 0
        assert_eq!(0, memory.get());
        memory.move_right();

        // index: 1
        memory.put(42);
        assert_eq!(42, memory.get());
        memory.move_left();

        // index: 0
        assert_eq!(0, memory.get());
        memory.put(24);
        memory.increment();
        assert_eq!(25, memory.get());
        memory.move_left();

        // index: 29_999
        memory.put(14);
        memory.decrement();
        assert_eq!(13, memory.get());
        memory.move_right();

        // index: 0
        assert_eq!(25, memory.get());
        memory.move_right();

        // index: 1
        assert_eq!(42, memory.get());

        // index: 2
        memory.move_right();
        assert_eq!(0, memory.get());
    }
}
