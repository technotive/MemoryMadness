/**
 * Note how we are forced by the return type `Result<T, U>` to acknowledge every step that could go wrong
 * This is a completely different flow as compared to throwing exceptions.
 * 
 * Like Haskell, Rust is strongly typed. It also employs Functional paradigmas like Haskell.
 * Unlike Haskell, Rust is procedural and we need no `do` statements and weird `IO ()` constructs.
 */

pub const IN_ADDR_ANY: [u8; 4] = [0, 0, 0, 0];