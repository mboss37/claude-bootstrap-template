---
paths:
  - "**/*.rs"
---

# Rust Rules

<!-- TODO: Delete this file if your project doesn't use Rust. -->

- Use `thiserror` for defining error types, `anyhow` for propagating in application code
- Prefer `?` operator over `.unwrap()` — never use `.unwrap()` outside tests
- All public types and functions must have `///` doc comments
- Use `#[cfg(test)]` modules for unit tests, separate `tests/` for integration
- Run `cargo clippy -- -D warnings` before considering any Rust code complete
- Run `cargo fmt` after every file change
- Use `Arc<RwLock<T>>` for shared state, not global mutables
- All async functions use `tokio` runtime
