import decode
import tallgrass/cache.{type Cache}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type Berry {
  Berry(
    id: Int,
    name: String,
    growth_time: Int,
    max_harvest: Int,
    natural_gift_power: Int,
    size: Int,
    smoothness: Int,
    soil_dryness: Int,
    firmness: Resource,
    flavors: List(BerryFlavorMap),
    item: Resource,
    natural_gift_type: Resource,
  )
}

pub type BerryFlavorMap {
  BerryFlavorMap(potency: Int, flavor: Resource)
}

const path = "berry"

/// Fetches a list of berry resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch(DefaultPagination)
/// let result = berry.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a berry given a berry resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(berry.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// berry.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, berry(), cache)
}

/// Fetches a berry given the berry ID.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, berry(), cache)
}

/// Fetches a berry given the berry name.
///
/// # Example
///
/// ```gleam
/// let result = berry.fetch_by_name("cheri")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, berry(), cache)
}

fn berry() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use growth_time <- decode.parameter
    use max_harvest <- decode.parameter
    use natural_gift_power <- decode.parameter
    use size <- decode.parameter
    use smoothness <- decode.parameter
    use soil_dryness <- decode.parameter
    use firmness <- decode.parameter
    use flavors <- decode.parameter
    use item <- decode.parameter
    use natural_gift_type <- decode.parameter
    Berry(
      id,
      name,
      growth_time,
      max_harvest,
      natural_gift_power,
      size,
      smoothness,
      soil_dryness,
      firmness,
      flavors,
      item,
      natural_gift_type,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("growth_time", decode.int)
  |> decode.field("max_harvest", decode.int)
  |> decode.field("natural_gift_power", decode.int)
  |> decode.field("size", decode.int)
  |> decode.field("smoothness", decode.int)
  |> decode.field("soil_dryness", decode.int)
  |> decode.field("firmness", resource())
  |> decode.field("flavors", decode.list(of: berry_flavor_map()))
  |> decode.field("item", resource())
  |> decode.field("natural_gift_type", resource())
}

fn berry_flavor_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    BerryFlavorMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("flavor", resource())
}
