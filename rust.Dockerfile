# Select the Rust image
FROM rust:1.70

RUN apt update && apt upgrade
RUN apt install -y python3 iproute2 nmap nettle-dev dnsutils net-tools jq vim
RUN git clone --depth 1 https://github.com/sheerun/vim-polyglot \
      ~/.vim/pack/plugins/start/vim-polyglot

COPY fnd_ngh.sh /usr/local/bin/fnd_ngh
RUN chmod +x /usr/local/bin/*


ARG RUST_APP
WORKDIR /app
RUN cargo new --bin ${RUST_APP}
WORKDIR /app/${RUST_APP}
COPY ./${RUST_APP}/Cargo.toml /app/${RUST_APP}/
RUN sed -i '/^\[\[bench\]\]/,/^$/d' /app/${RUST_APP}/Cargo.toml
RUN echo 'fn main() {println!("to cache the changes")}' > src/main.rs
RUN cargo build --release
RUN rm -fr src/main.rs

COPY ./${RUST_APP} /app/${RUST_APP}
# RUN cargo fix --lib -p blockchain --allow-dirty
RUN cargo build --release

ENV RUST_LOG=info
CMD ["/bin/bash"]
# CMD ["cargo", "run", "--release"]
