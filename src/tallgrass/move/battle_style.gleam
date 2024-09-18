import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource

pub type MoveBattleStyle {
  MoveBattleStyle(id: Int, name: String, names: List(Name))
}

const path = "move-battle-style"

/// Fetches a move battle style by the move battle style ID.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_battle_style())
}

/// Fetches a move battle style by the move battle style name.
///
/// # Example
///
/// ```gleam
/// let result = battle_style.fetch_by_name("attack")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_battle_style())
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
