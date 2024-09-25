import decode
import tallgrass/client.{type Client}
import tallgrass/client/resource.{type Resource}
import tallgrass/common/name.{type Name, name}

pub type MoveBattleStyle {
  MoveBattleStyle(id: Int, name: String, names: List(Name))
}

const path = "move-battle-style"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move battle style resources.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.new() |> battle_style.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a move battle style given a move battle style resource.
///
/// # Example
///
/// ```gleam
/// let client = battle_style.new()
/// use res <- result.try(client |> battle_style.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> battle_style.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, move_battle_style())
}

/// Fetches a move battle style given the move battle style ID.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.new() |> battle_style.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, move_battle_style())
}

/// Fetches a move battle style given the move battle style name.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.new() |> battle_style.fetch_by_name("attack")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, move_battle_style())
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
