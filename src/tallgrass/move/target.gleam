import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type MoveTarget {
  MoveTarget(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(Resource),
    names: List(Name),
  )
}

const path = "move-target"

/// Fetches a move target by the move target ID.
///
/// # Example
///
/// ```gleam
/// let result = target.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_target())
}

/// Fetches a move target by the move target name.
///
/// # Example
///
/// ```gleam
/// let result = target.fetch_by_name("specific-move")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_target())
}

fn move_target() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveTarget(id, name, descriptions, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
