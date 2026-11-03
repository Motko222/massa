sudo apt install pkg-config curl git build-essential libssl-dev libclang-dev cmake
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustc --version
rustup toolchain install 1.74.1
rustup default 1.74.1
rustc --version
