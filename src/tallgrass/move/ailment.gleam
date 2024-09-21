import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type MoveAilment {
  MoveAilment(id: Int, name: String, moves: List(Resource), names: List(Name))
}

const path = "move-ailment"

/// Fetches a move ailment by the move ailment ID.
///
/// # Example
///
/// ```gleam
/// let result = ailment.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_ailment())
}

/// Fetches a move ailment by the move ailment name.
///
/// # Example
///
/// ```gleam
/// let result = ailment.fetch_by_name("paralysis")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_ailment())
}

fn move_ailment() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveAilment(id, name, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
