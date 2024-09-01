# tallgrass

[![Package Version](https://img.shields.io/hexpm/v/tallgrass)](https://hex.pm/packages/tallgrass)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/tallgrass/)

The `tallgrass` package is a Gleam wrapper for the [PokeAPI](https://pokeapi.co).

It doesn't currently support paginated resource lists nor the majority of endpoints outside
of the `Pokemon` endpoint group, such as berries, items, machines, et al.

As such, the `tallgrass` package is not yet at v1.0.0, and breaking changes should be expected
until it is.

```sh
gleam add tallgrass
```
```gleam
import tallgrass/client/pokemon

pub fn main() {
  let assert Ok(ditto) = pokemon.fetch_by_id(132)
}
```

Further documentation can be found at <https://hexdocs.pm/tallgrass>.

## Development

```sh
gleam test  # Run the tests
```
