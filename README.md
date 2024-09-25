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
import tallgrass/client
import tallgrass/machine
import tallgrass/pokemon

fn example() {
  let client = client.new()

  // Pokemon can be fetched by name or ID.
  let assert Ok(ditto) = pokemon.fetch_by_name(client, "ditto")
  let assert Ok(ditto) = pokemon.fetch_by_id(client, 132)

  // Machines can only be fetched by ID.
  let assert Ok(tm_01) = machine.fetch_by_id(client, 2)
}
```

### Paginated resources

You can also fetch (and traverse) paginated resources. The returned resources will only contain
the name of the resource (if available) and its corresponding PokeAPI URL.

Pagination options (limit and offset) need to be specified for these requests. Specify one
or both of these options using `resource.PaginationOptions`.

```gleam
import gleam/list
import tallgrass/client.{with_pagination}
import tallgrass/client/pagination.{Limit, Offset, Paginate}
import tallgrass/client/resource.{next, previous}
import tallgrass/pokemon

fn example() {
  let client = client.new()

  // default to a limit of 20
  let assert Ok(page) = client |> pokemon.fetch()

  // or specify a different limit or offset, or both
  let assert Ok(page) = client |> with_pagination(Limit(100)) |> pokemon.fetch()
  let assert Ok(page) = client |> with_pagination(Offset(20)) |> pokemon.fetch()
  let assert Ok(page) = client |> with_pagination(Paginate(limit: 100, offset: 20)) |> pokemon.fetch()

  // the returned resources can then be fetched directly
  let assert Ok(resource) = page.results |> list.first
  let assert Ok(pokemon) = pokemon.fetch_resource(client, resource)

  // or you can move on to the next or previous page
  let assert Ok(next_page) = client |> next(page)
  let assert Ok(previous_page) = client |> previous(next_page)
}
```

### Caching

Every request response can be cached so that subsequent requests for the same resource
can be served without sending an additional HTTP request.

```gleam
import tallgrass/client.{with_cache}
import tallgrass/client/cache.{Hours}
import tallgrass/pokemon

fn example() {
  // Initialize a new cache with a unique name and the expiration interval.
  let assert Ok(cache) = cache.new("unique-cache-name", Hours(4))
  let client = client.new() |> with_cache(cache)

  let assert Ok(ditto) = pokemon.fetch_by_name(client, "ditto")

  // Subsequent requests will be served from cache/memory instead of the API.
  let assert Ok(ditto) = pokemon.fetch_by_name(client, "ditto")
}
```
