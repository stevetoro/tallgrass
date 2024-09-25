import decode
import tallgrass/client.{type Client}
import tallgrass/common/description.{type Description, description}
import tallgrass/common/name.{type Name, name}
import tallgrass/client/resource.{type Resource, resource}

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

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of move learn method resources.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.new() |> learn_method.fetch()
/// ```
pub fn fetch(client: Client) {
  resource.fetch_resources(client, path)
}

/// Fetches a move learn method given a move learn method resource.
///
/// # Example
///
/// ```gleam
/// let client = learn_method.new()
/// use res <- result.try(client |> learn_method.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> learn_method.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  resource.fetch_resource(client, resource, move_learn_method())
}

/// Fetches a move learn method given the move learn method ID.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.new() |> learn_method.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  resource.fetch_by_id(client, path, id, move_learn_method())
}

/// Fetches a move learn method given the move learn method name.
///
/// # Example
///
/// ```gleam
/// let result = learn_method.new() |> learn_method.fetch_by_name("level-up")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  resource.fetch_by_name(client, path, name, move_learn_method())
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
