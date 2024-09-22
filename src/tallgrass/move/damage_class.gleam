import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type MoveDamageClass {
  MoveDamageClass(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
    names: List(Name),
  )
}

const path = "move-damage-class"

/// Fetches a list of move damage class resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.fetch(DefaultPagination, NoCache)
/// let result = damage_class.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a move damage class given a move damage class resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(damage_class.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// damage_class.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, move_damage_class(), cache)
}

/// Fetches a move damage class given the move damage class ID.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, move_damage_class(), cache)
}

/// Fetches a move damage class given the move damage class name.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, move_damage_class(), cache)
}

fn move_damage_class() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveDamageClass(id, name, descriptions, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
