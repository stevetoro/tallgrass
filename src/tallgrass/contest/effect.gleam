import decode
import tallgrass/client.{type Client}
import tallgrass/common/effect.{type Effect, effect}
import tallgrass/common/flavor_text.{type FlavorText, flavor_text}
import tallgrass/client/resource.{type Resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of contest effect resources.
///
/// # Example
///
/// ```gleam
/// let result = effect.new() |> effect.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a contest effect given a contest effect resource.
///
/// # Example
///
/// ```gleam
/// let client = effect.new()
/// use res <- result.try(client |> effect.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> effect.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, contest_effect())
}

/// Fetches a contest effect given the contest effect ID.
///
/// # Example
///
/// ```gleam
/// let result = effect.new() |> effect.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, contest_effect())
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
