import decode
import tallgrass/common/flavor_text.{type FlavorText, flavor_text}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type SuperContestEffect {
  SuperContestEffect(
    id: Int,
    appeal: Int,
    flavor_text_entries: List(FlavorText),
    moves: List(Resource),
  )
}

const path = "super-contest-effect"

/// Fetches a list of super contest effect resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.fetch(options: Default)
/// let result = super_contest_effect.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: PaginationOptions) {
  resource.fetch_resources(path, options)
}

/// Fetches a super contest effect given a super contest effect resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(super_contest_effect.fetch(options: Default))
/// let assert Ok(first) = res.results |> list.first
/// super_contest_effect.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: super_contest_effect())
}

/// Fetches a super contest effect given the super contest effect ID.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, super_contest_effect())
}

fn super_contest_effect() {
  decode.into({
    use id <- decode.parameter
    use appeal <- decode.parameter
    use flavor_texts <- decode.parameter
    use moves <- decode.parameter
    SuperContestEffect(id, appeal, flavor_texts, moves)
  })
  |> decode.field("id", decode.int)
  |> decode.field("appeal", decode.int)
  |> decode.field("flavor_text_entries", decode.list(of: flavor_text()))
  |> decode.field("moves", decode.list(of: resource()))
}
