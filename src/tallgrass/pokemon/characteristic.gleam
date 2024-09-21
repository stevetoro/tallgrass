import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Characteristic {
  Characteristic(
    id: Int,
    gene_modulo: Int,
    possible_values: List(Int),
    highest_stat: Resource,
    descriptions: List(Description),
  )
}

const path = "characteristic"

/// Fetches a list of pokemon characteristic resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.fetch(options: Default)
/// let result = characteristic.fetch(options: Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a pokemon characteristic given a pokemon characteristic resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(characteristic.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// characteristic.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: characteristic())
}

/// Fetches a pokemon characteristic given the pokemon characteristic ID.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, characteristic())
}

fn characteristic() {
  decode.into({
    use id <- decode.parameter
    use gene_modulo <- decode.parameter
    use possible_values <- decode.parameter
    use highest_stat <- decode.parameter
    use descriptions <- decode.parameter
    Characteristic(id, gene_modulo, possible_values, highest_stat, descriptions)
  })
  |> decode.field("id", decode.int)
  |> decode.field("gene_modulo", decode.int)
  |> decode.field("possible_values", decode.list(of: decode.int))
  |> decode.field("highest_stat", resource())
  |> decode.field("descriptions", decode.list(of: description()))
}
