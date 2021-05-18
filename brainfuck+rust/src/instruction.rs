#[derive(Debug, PartialEq)]
pub enum Instruction {
    MoveRight,
    MoveLeft,
    Increment,
    Decrement,
    Output,
    Input,
    Open(usize),
    Close(usize),
}

pub fn parse(source: &str) -> Option<Vec<Instruction>> {
    let ops: Vec<_> = source
        .chars()
        .filter(|c| match c {
            '>' | '<' | '+' | '-' | '.' | ',' | '[' | ']' => true,
            _ => false,
        })
        .collect();

    let mut instructions = Vec::with_capacity(ops.len());
    for (idx, c) in ops.iter().enumerate() {
        let instruction = match c {
            '>' => Instruction::MoveRight,
            '<' => Instruction::MoveLeft,
            '+' => Instruction::Increment,
            '-' => Instruction::Decrement,
            '.' => Instruction::Output,
            ',' => Instruction::Input,
            '[' => {
                let distance = find_matching_close(&ops, idx)?;
                Instruction::Open(distance)
            }
            ']' => {
                let distance = find_matching_open(&ops, idx)?;
                Instruction::Close(distance)
            }
            _ => unreachable!(),
        };
        instructions.push(instruction);
    }
    Some(instructions)
}

fn find_matching_close(ops: &[char], start: usize) -> Option<usize> {
    let mut count = 1;

    for (pos, c) in ops[start + 1..].iter().enumerate() {
        match c {
            '[' => count += 1,
            ']' => count -= 1,
            _ => (),
        }

        if count == 0 {
            return Some(pos + 1);
        }
    }

    None
}

fn find_matching_open(ops: &[char], start: usize) -> Option<usize> {
    let mut count = 1;

    for (pos, c) in ops[..start].iter().rev().enumerate() {
        match c {
            '[' => count -= 1,
            ']' => count += 1,
            _ => (),
        }

        if count == 0 {
            return Some(pos + 1);
        }
    }

    None
}
#[cfg(test)]
mod tests {
    use super::{parse, Instruction::*};

    #[test]
    fn matching_close() {
        assert_eq!(
            parse("Hello[[][[]][]]Goodbye").unwrap(),
            [
                Open(9),
                Open(1),
                Close(1),
                Open(3),
                Open(1),
                Close(1),
                Close(3),
                Open(1),
                Close(1),
                Close(9)
            ]
        );
    }

    #[test]
    fn mismatched_paren() {
        assert!(parse("[[]").is_none());
        assert!(parse("[]]").is_none());
    }
}
