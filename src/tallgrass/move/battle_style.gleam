import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource}

pub type MoveBattleStyle {
  MoveBattleStyle(id: Int, name: String, names: List(Name))
}

const path = "move-battle-style"

/// Fetches a list of move battle style resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.fetch(options: Default)
/// let result = battle_style.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions, cache cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a move battle style given a move battle style resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(battle_style.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// battle_style.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, using: move_battle_style(), cache: cache)
}

/// Fetches a move battle style given the move battle style ID.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, move_battle_style(), cache: cache)
}

/// Fetches a move battle style given the move battle style name.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.fetch_by_name("attack")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, move_battle_style(), cache: cache)
}

fn move_battle_style() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    MoveBattleStyle(id, name, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
}
