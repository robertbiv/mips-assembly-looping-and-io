# MIPS Assembly - Looping and I/O

This repository contains MIPS assembly programs demonstrating looping constructs, recursion, and input/output operations. These programs were developed as part of a computer architecture course assignment.

## Programs

### 1. Ackermann Function (`ackermann.asm`)

Implements the recursive Ackermann function, which is a well-known computationally expensive recursive function.

**Formula:**
```
A(m, n) = n + 1                    if m = 0
A(m, n) = A(m-1, 1)                if m > 0 and n = 0
A(m, n) = A(m-1, A(m, n-1))        if m > 0 and n > 0
```

**Usage:**
- Input: Two non-negative integers m and n
- Output: The value of A(m, n)

**Note:** Due to the rapid growth rate of the Ackermann function, only small values of m and n are practical (e.g., m ≤ 3).

### 2. Combination Calculator (`combination.asm`)

Calculates the binomial coefficient C(n, r), which represents the number of ways to choose r items from n items.

**Formula:**
```
C(n, r) = n! / (r! * (n - r)!)
```

**Implementation:**
- Uses the recursive property: `C(n, r) = C(n-1, r-1) + C(n-1, r)`
- Base cases: `C(n, 0) = 1` and `C(n, n) = 1`

**Usage:**
- Input: Two integers n and r (where 0 ≤ r ≤ n)
- Output: The value of C(n, r)

### 3. Matrix Multiplication (`matrix.asm`)

Performs matrix multiplication on two matrices and stores the result.

**Features:**
- Implements the standard matrix multiplication algorithm
- Validates that matrices can be multiplied (columns of A = rows of B)
- Includes test cases for both valid and invalid multiplications
- Pre-loaded test matrices:
  - Matrix A: 2×2 matrix
  - Matrix B: 2×2 matrix
  - Matrix C: 2×3 matrix
  - Matrix D: (another test matrix)

**Usage:**
- Matrices are pre-defined in the data section
- Program demonstrates multiplication and error handling

### 4. Prime Number Checker (`prime.asm`)

Determines whether a given number is prime.

**Algorithm:**
- Numbers ≤ 1 are not prime
- 2 is prime
- Even numbers (except 2) are not prime
- For odd numbers, check divisibility by odd numbers from 3 to √n

**Usage:**
- Input: An integer
- Output: Indicates whether the number is prime or not prime

## Running the Programs

These programs are written in MIPS assembly language and can be run using a MIPS simulator such as:
- **MARS** (MIPS Assembler and Runtime Simulator)
- **SPIM** (MIPS Simulator)
- **QtSpim** (GUI version of SPIM)

### Steps to Run:

1. Download and install a MIPS simulator (e.g., MARS)
2. Open the desired `.asm` file in the simulator
3. Assemble the program
4. Run the program
5. Provide input when prompted (for interactive programs)
6. View the output in the console

## Program Features

All programs demonstrate:
- **Input/Output operations** using MIPS syscalls
- **Looping constructs** (both iterative and recursive)
- **Stack management** for function calls and register preservation
- **Proper register usage** following MIPS calling conventions
- **Error handling** where applicable (e.g., invalid matrix dimensions)

## Technical Details

- **Language:** MIPS Assembly
- **Architecture:** MIPS32
- **Conventions:** Standard MIPS calling conventions with stack-based parameter passing
- **Registers:**
  - `$a0-$a3`: Argument registers
  - `$v0-$v1`: Return value registers
  - `$s0-$s7`: Saved registers (preserved across calls)
  - `$t0-$t9`: Temporary registers
  - `$ra`: Return address
  - `$sp`: Stack pointer

## Author

Developed as part of Computer Architecture coursework.

## References

- Homework_3.pdf: Contains the original assignment specifications
