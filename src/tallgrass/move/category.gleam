import decode
import tallgrass/common/description.{type Description, description}
import tallgrass/resource.{type NamedResource, named_resource}

pub type MoveCategory {
  MoveCategory(
    id: Int,
    name: String,
    descriptions: List(Description),
    moves: List(NamedResource),
  )
}

const path = "move-category"

/// Fetches a move category by the move category ID.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_category())
}

/// Fetches a move category by the move category name.
///
/// # Example
///
/// ```gleam
/// let result = category.fetch_by_name("ailment")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_category())
}

fn move_category() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use moves <- decode.parameter
    MoveCategory(id, name, descriptions, moves)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("moves", decode.list(of: named_resource()))
}
