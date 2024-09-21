import decode
import gleam/option.{type Option}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type PaginationOptions, type Resource, resource}

pub type MoveLearnMethod {
  MoveLearnMethod(
    id: Int,
    name: String,
    descriptions: List(Description),
    names: List(Name),
    version_groups: List(Resource),
  )
}

const path = "move-learn-method"

/// Fetches a list of move learn method resources.
/// Optionally accepts pagination options `limit` and `offset`.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.fetch(options: None)
/// let result = learn_method.fetch(options: Some(PaginationOptions(limit: 100, offset: 0)))
/// ```
pub fn fetch(options options: Option(PaginationOptions)) {
  resource.fetch_resources(path, options)
}

/// Fetches a move learn method given a move learn method resource.
///
/// # Example
///
/// ```gleam
/// use res <- result.try(learn_method.fetch(options: None))
/// let assert Ok(first) = res.results |> list.first
/// learn_method.fetch_resource(first)
/// ```
pub fn fetch_resource(resource: Resource) {
  resource.fetch_resource(resource, using: move_learn_method())
}

/// Fetches a move learn method given the move learn method ID.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, move_learn_method())
}

/// Fetches a move learn method given the move learn method name.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.fetch_by_name("ailment")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, move_learn_method())
}

fn move_learn_method() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use descriptions <- decode.parameter
    use names <- decode.parameter
    use version_groups <- decode.parameter
    MoveLearnMethod(id, name, descriptions, names, version_groups)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("version_groups", decode.list(of: resource()))
}
