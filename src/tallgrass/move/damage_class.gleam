import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type NamedResource, named_resource}

pub type MoveDamageClass {
  MoveDamageClass(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(NamedResource),
    names: List(Name),
  )
}

const path = "move-damage-class"

/// Fetches a move damage class by the move damage class ID.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_damage_class())
}

/// Fetches a move damage class by the move damage class name.
///
/// # Example
///
/// ```gleam
/// let result = damage_class.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_damage_class())
}

fn move_damage_class() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    MoveDamageClass(id, name, descriptions, moves, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: named_resource()))
  |> decode.field("names", decode.list(of: name()))
}
