# tallgrass

[![Package Version](https://img.shields.io/hexpm/v/tallgrass)](https://hex.pm/packages/tallgrass)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/tallgrass/)

The `tallgrass` package is a Gleam wrapper for the [PokeAPI](https://pokeapi.co) and is installable via hex.

```sh
gleam add tallgrass
```

Get started with the examples below. Further documentation can be found at <https://hexdocs.pm/tallgrass>.

## Examples

### Fetching resources by name or ID

The majority of PokeAPI resources can be fetched directly by either name or ID. Only a few
(`characteristic`, `contest-effect`, `evolution-chain`, `machine`, and `super-contest-effect`)
need to be fetched by ID.

```gleam
import tallgrass/cache.{NoCache}
import tallgrass/machine
import tallgrass/pokemon

fn example() {
  // Pokemon can be fetched by name or ID.
  let assert Ok(ditto) = pokemon.fetch_by_id("ditto", NoCache)
  let assert Ok(ditto) = pokemon.fetch_by_id(132, NoCache)

  // Machines can only be fetched by ID.
  let assert Ok(tm_01) = machine.fetch_by_id(2, NoCache)
}
```

### Paginated resources

You can also fetch (and traverse) paginated resources. The returned resources will only contain
the name of the resource (if available) and its corresponding PokeAPI URL.

Pagination options (limit and offset) need to be specified for these requests. Specify one
or both of these options using `resource.PaginationOptions`.

```gleam
import gleam/list
import tallgrass/cache.{NoCache}
import tallgrass/resource.{DefaultPagination, Limit, Paginate, Offset, next, previous}
import tallgrass/pokemon

fn example() {
  // fetches a page with the first twenty pokemon resources
  let assert Ok(page) = pokemon.fetch(DefaultPagination, NoCache)

  // or specify a larger limit or offset, or both
  let assert Ok(page) = pokemon.fetch(Limit(100), NoCache)
  let assert Ok(page) = pokemon.fetch(Offset(20), NoCache)
  let assert Ok(page) = pokemon.fetch(Paginate(limit: 100, offset: 20), NoCache)

  // the returned resources can then be fetched directly
  let assert Ok(resource) = page.results |> list.first
  let assert Ok(bulbsaur) = pokemon.fetch_resource(resource, NoCache)

  // or you can move on to the next or previous page
  let assert Ok(next_page) = page |> next(NoCache)
  let assert Ok(previous_page) = next_page |> previous(NoCache)
}
```

### Caching

Every request response can be cached so that subsequent requests for the same resource
can be served without sending an additional HTTP request.

```gleam
import tallgrass/cache.{Hours}
import tallgrass/pokemon

fn example() {
  // Initialize a new cache with a unique name and the expiration interval.
  let assert Ok(cache) = cache.new("unique-cache-name", Hours(4))
  let assert Ok(ditto) = pokemon.fetch_by_id("ditto", cache)

  // Subsequent requests will be served from cache/memory instead of the API.
  let assert Ok(ditto) = pokemon.fetch_by_id("ditto", cache)
}
```
