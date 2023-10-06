# Select the Rust image
# FROM paritytech/ink-ci-linux:production
FROM ghcr.io/astarnetwork/swanky-cli/swanky-base:swanky3.0.4_v2.0.3

RUN apt update && apt upgrade -y
RUN apt install -y python3 iproute2 nmap nettle-dev dnsutils net-tools jq vim
RUN git clone --depth 1 https://github.com/sheerun/vim-polyglot \
      ~/.vim/pack/plugins/start/vim-polyglot

WORKDIR /app

ENV RUST_LOG=info
CMD ["/bin/bash"]
# CMD ["cargo", "run", "--release"]
