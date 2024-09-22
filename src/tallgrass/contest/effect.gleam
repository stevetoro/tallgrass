import decode
import tallgrass/cache.{type Cache}
import tallgrass/common/effect.{type Effect, effect}
import tallgrass/common/flavor_text.{type FlavorText, flavor_text}
import tallgrass/resource.{type PaginationOptions, type Resource}

pub type ContestEffect {
  ContestEffect(
    id: Int,
    appeal: Int,
    jam: Int,
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorText),
  )
}

const path = "contest-effect"

/// Fetches a list of contest effect resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = effect.fetch(DefaultPagination)
/// let result = effect.fetch(Paginate(limit: 100, offset: 0))
/// ```
pub fn fetch(options: PaginationOptions, cache: Cache) {
  resource.fetch_resources(path, options, cache)
}

/// Fetches a contest effect given a contest effect resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(effect.fetch(DefaultPagination))
/// let assert Ok(first) = res.results |> list.first
/// effect.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource, cache: Cache) {
  resource.fetch_resource(resource, contest_effect(), cache)
}

/// Fetches a contest effect given the contest effect ID.
///
/// # Example
///
/// ```gleam
/// let result = effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int, cache: Cache) {
  resource.fetch_by_id(id, path, contest_effect(), cache)
}

fn contest_effect() {
  decode.into({
    use id <- decode.parameter
    use appeal <- decode.parameter
    use jam <- decode.parameter
    use effects <- decode.parameter
    use flavor_text <- decode.parameter
    ContestEffect(id, appeal, jam, effects, flavor_text)
  })
  |> decode.field("id", decode.int)
  |> decode.field("appeal", decode.int)
  |> decode.field("jam", decode.int)
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field("flavor_text_entries", decode.list(of: flavor_text()))
}
