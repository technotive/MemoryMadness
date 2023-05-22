# Readme file for Memory Madness
This is an example project to demonstrate things that can go wrong with memory management in several languages. This repository is a work in progress meant for educational purposes.

WARNING: The code within this repository is purposefully written in a sloppy way and should never be used in any production system.

# Toolchain
**OS: Debian 11 - WSL2**
- C#
  - dotnet SDK: 7.0.201
- C
  - gcc: 8.3.0 (Debian 8.3.0-6)
  - make: 4.2.1 (GNU Make)
- JS
  - node: 18.15.0
  - npm: 9.5.0
- Haskell
  - ghcup: 0.1.19.2
  - ghc: 9.2.5
  - cabal: 3.6.2.0
  - hls: 1.9.1.0
- Rust
  - rustup: 1.25.2 (17db695f1 2023-02-01)
  - rustc 1.68.0 (2c8cc3432 2023-03-06)

**OS: Ubuntu 20.04.5 LTS - GitHub Codespaces**
- C#
  - dotnet SDK: 7.0.203
- C
  - gcc: 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
  - make: 4.2.1 (GNU Make)
- JS
  - node: 19.9.0
  - npm: 9.6.3
- Haskell
  - ghcup: 0.1.19.2
  - ghc: 9.2.7
  - cabal: 3.6.2.0
  - hls: 1.10.0.0
- Rust
  - rustup: 1.26.0 (5af9b9484 2023-04-05)
  - rustc: 1.69.0 (84c898d65 2023-04-16)

# Pseudo code
- Listen on port 9001 on any interface
  - receive a request, expecting `{word}:{word_size}`
  - log the request
  - take `word_size` characters from `word`
  - send the resulting string back to the client
