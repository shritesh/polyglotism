mod instruction;
mod memory;

use instruction::Instruction;
use memory::Memory;

pub fn run(source: &str, input: &str) -> Option<String> {
    let instructions = instruction::parse(source)?;
    let mut memory = Memory::new();
    let mut output = String::new();

    let mut inputs = input.as_bytes().iter();

    let mut pc = 0;
    loop {
        if pc >= instructions.len() {
            break;
        }

        match instructions[pc] {
            Instruction::MoveRight => memory.move_right(),
            Instruction::MoveLeft => memory.move_left(),
            Instruction::Increment => memory.increment(),
            Instruction::Decrement => memory.decrement(),
            Instruction::Output => output.push(char::from_u32(memory.get() as u32)?),
            Instruction::Input => memory.put(*inputs.next().unwrap_or(&0)),
            Instruction::Open(j) => {
                if memory.get() == 0 {
                    pc += j;
                    continue;
                }
            }
            Instruction::Close(j) => {
                if memory.get() != 0 {
                    pc -= j;
                    continue;
                }
            }
        }

        pc += 1;
    }

    Some(output)
}

#[cfg(test)]
mod test {
    use super::run;

    #[test]
    fn hello_world() {
        assert_eq!(
            run("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.", ""),
            Some("Hello World!\n".into()));
    }

    #[test]
    fn cat() {
        assert_eq!(run(",[.,]", "hello"), Some("hello".into()));
    }

    #[test]
    fn quine() {
        // Written by Erik Bosman
        // https://copy.sh/brainfuck/prog/quine505.b
        let program = r">+++++>+++>+++>+++++>+++>+++>+++++>++++++>+>++>+++>++++>++++>+++>+++>+++++>+>+>++++>+++++++>+>+++++>+>+>+++++>++++++>+++>+++>++>+>+>++++>++++++>++++>++++>+++>+++++>+++>+++>++++>++>+>+>+>+>++>++>++>+>+>++>+>+>++++++>++++++>+>+>++++++>++++++>+>+>+>+++++>++++++>+>+++++>+++>+++>++++>++>+>+>++>+>+>++>++>+>+>++>++>+>+>+>+>++>+>+>+>++++>++>++>+>+++++>++++++>+++>+++>+++>+++>+++>+++>++>+>+>+>+>++>+>+>++++>+++>+++>+++>+++++>+>+++++>++++++>+>+>+>++>+++>+++>+++++++>+++>++++>+>++>+>+++++++>++++++>+>+++++>++++++>+++>+++>++>++>++>++>++>++>+>++>++>++>++>++>++>++>++>++>+>++++>++>++>++>++>++>++>++>+++++>++++++>++++>+++>+++++>++++++>++++>+++>+++>++++>+>+>+>+>+++++>+++>+++++>++++++>+++>+++>+++>++>+>+>+>++++>++++[[>>>+<<<-]<]>>>>[<<[-]<[-]+++++++[>+++++++++>++++++<<-]>-.>+>[<.<<+>>>-]>]<<<[>>+>>>>+<<<<<<-]>++[>>>+>>>>++>>++>>+>>+[<<]>-]>>>-->>-->>+>>+++>>>>+[<<]<[[-[>>+<<-]>>]>.[>>]<<[[<+>-]<<]<<]";
        assert_eq!(run(program, ""), Some(program.into()));
    }
}
