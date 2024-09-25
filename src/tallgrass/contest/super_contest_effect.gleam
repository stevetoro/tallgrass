import decode
import tallgrass/client.{type Client}
import tallgrass/common/flavor_text.{type FlavorText, flavor_text}
import tallgrass/common/resource.{type Resource, resource}

pub type SuperContestEffect {
  SuperContestEffect(
    id: Int,
    appeal: Int,
    flavor_text_entries: List(FlavorText),
    moves: List(Resource),
  )
}

const path = "super-contest-effect"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of super contest effect resources.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.new() |> super_contest_effect.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a super contest effect given a super contest effect resource.
///
/// # Example
///
/// ```gleam
/// let client = super_contest_effect.new()
/// use res <- result.try(client |> super_contest_effect.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> super_contest_effect.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, super_contest_effect())
}

/// Fetches a super contest effect given the super contest effect ID.
///
/// # Example
///
/// ```gleam
/// let result = super_contest_effect.new() |> super_contest_effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, super_contest_effect())
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
