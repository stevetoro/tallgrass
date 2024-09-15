import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/pokemon_type.{type Type, Type, types}

pub type Form {
  Form(
    id: Int,
    name: String,
    order: Int,
    form_order: Int,
    is_default: Bool,
    is_battle_only: Bool,
    is_mega: Bool,
    form_name: String,
    pokemon: Affordance,
    types: List(Type),
    version_group: Affordance,
  )
}

const path = "pokemon-form"

/// Fetches a pokemon form by the form ID.
///
/// # Example
///
/// ```gleam
/// let result = form.fetch_by_id(10143)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, form())
}

/// Fetches a pokemon form by the form name.
///
/// # Example
///
/// ```gleam
/// let result = form.fetch_by_name("mewtwo-mega-x")
/// ```
pub fn fetch_by_name(name: String) {
  fetch.resource_by_name(name, path, form())
}

fn form() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use form_order <- decode.parameter
    use is_default <- decode.parameter
    use is_battle_only <- decode.parameter
    use is_mega <- decode.parameter
    use form_name <- decode.parameter
    use pokemon <- decode.parameter
    use types <- decode.parameter
    use version_group <- decode.parameter
    Form(
      id,
      name,
      order,
      form_order,
      is_default,
      is_battle_only,
      is_mega,
      form_name,
      pokemon,
      types,
      version_group,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("form_order", decode.int)
  |> decode.field("is_default", decode.bool)
  |> decode.field("is_battle_only", decode.bool)
  |> decode.field("is_mega", decode.bool)
  |> decode.field("form_name", decode.string)
  |> decode.field("pokemon", affordance())
  |> decode.field("types", decode.list(of: types()))
  |> decode.field("version_group", affordance())
}
