# pokegleam

[![Package Version](https://img.shields.io/hexpm/v/pokegleam)](https://hex.pm/packages/pokegleam)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/pokegleam/)

pokegleam's API is still not finalized. Expect breaking changes prior to version 1.0 release.

```sh
gleam add pokegleam
```
```gleam
import pokegleam/pokemon/pokemon/client as pokemon

pub fn main() {
  let clefairy = pokemon.fetch_by_id(35)
  Ok(clefairy)
}
```

Further documentation can be found at <https://hexdocs.pm/pokegleam>.

## Development

```sh
gleam test  # Run the tests
```
