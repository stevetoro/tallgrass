import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/description.{type Description, description}
import tallgrass/internal/common/name.{type Name, name}
import tallgrass/internal/common/pokemon.{type PokemonEntry, pokemon_entry}

pub type Pokedex {
  Pokedex(
    id: Int,
    name: String,
    is_main_series: Bool,
    descriptions: List(Description),
    names: List(Name),
    pokemon_entries: List(PokemonEntry),
    region: Affordance,
    version_groups: List(Affordance),
  )
}

pub fn pokedex() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use is_main_series <- decode.parameter
    use descriptions <- decode.parameter
    use names <- decode.parameter
    use pokemon_entries <- decode.parameter
    use region <- decode.parameter
    use version_groups <- decode.parameter
    Pokedex(
      id,
      name,
      is_main_series,
      descriptions,
      names,
      pokemon_entries,
      region,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("is_main_series", decode.bool)
  |> decode.field("descriptions", decode.list(of: description()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_entries", decode.list(of: pokemon_entry()))
  |> decode.field("region", affordance())
  |> decode.field("version_groups", decode.list(of: affordance()))
}
