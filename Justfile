set shell := ["bash", "-c"]
container := "paritytech/ink-ci-linux:production"

# Compile an ink! contract
compile workdir:
  podman run --userns=keep-id --rm -it -v \
    {{workdir}}:/sources:Z {{container}} \
    cargo contract build --optimization-passes=0 --manifest-path=/sources/Cargo.toml

# Expand the contract macros
expand:
  cargo expand \
    --no-default-features --target=wasm32-unknown-unknown \
    | bat --language rust -n
