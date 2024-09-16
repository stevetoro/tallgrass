import decode
import tallgrass/common/pokemon_type.{type PokemonType, pokemon_type}
import tallgrass/resource.{type NamedResource, named_resource}

pub type PokemonForm {
  PokemonForm(
    id: Int,
    name: String,
    order: Int,
    form_order: Int,
    is_default: Bool,
    is_battle_only: Bool,
    is_mega: Bool,
    form_name: String,
    pokemon: NamedResource,
    types: List(PokemonType),
    version_group: NamedResource,
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
  resource.fetch_by_id(id, path, pokemon_form())
}

/// Fetches a pokemon form by the form name.
///
/// # Example
///
/// ```gleam
/// let result = form.fetch_by_name("mewtwo-mega-x")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokemon_form())
}

fn pokemon_form() {
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
    PokemonForm(
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
  |> decode.field("pokemon", named_resource())
  |> decode.field("types", decode.list(of: pokemon_type()))
  |> decode.field("version_group", named_resource())
}
