import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type BerryFlavor {
  BerryFlavor(
    id: Int,
    name: String,
    berries: List(FlavorBerryMap),
    contest_type: Resource,
    names: List(Name),
  )
}

pub type FlavorBerryMap {
  FlavorBerryMap(potency: Int, berry: Resource)
}

const path = "berry-flavor"

/// Fetches a list of berry flavor resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = flavor.fetch(DefaultPagination, NoCache)
/// let result = flavor.fetch(Paginate(limit: 100, offset: 0), NoCache)
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a berry flavor given a berry flavor resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(flavor.fetch(DefaultPagination, NoCache))
/// let assert Ok(first) = res.results |> list.first
/// flavor.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, berry_flavor(), cache)
}

/// Fetches a berry flavor given the berry flavor ID.
///
/// # Example
///
/// ```gleam
/// let result = flavor.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, berry_flavor(), cache)
}

/// Fetches a berry flavor given the berry flavor name.
///
/// # Example
///
/// ```gleam
/// let result = flavor.fetch_by_name("spicy")
/// ```
pub fn fetch_by_name(name: String, cache: Cache) {
  resource.fetch_by_name(name, path, berry_flavor(), cache)
}

fn berry_flavor() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use berries <- decode.parameter
    use contest_type <- decode.parameter
    use names <- decode.parameter
    BerryFlavor(id, name, berries, contest_type, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("berries", decode.list(of: flavor_berry_map()))
  |> decode.field("contest_type", resource())
  |> decode.field("names", decode.list(of: name()))
}

fn flavor_berry_map() {
  decode.into({
    use potency <- decode.parameter
    use berry <- decode.parameter
    FlavorBerryMap(potency, berry)
  })
  |> decode.field("potency", decode.int)
  |> decode.field("berry", resource())
}
