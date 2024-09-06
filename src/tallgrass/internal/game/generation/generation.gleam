import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type Generation {
  Generation(
    id: Int,
    name: String,
    abilities: List(Affordance),
    main_region: Affordance,
    moves: List(Affordance),
    names: List(Name),
    pokemon_species: List(Affordance),
    types: List(Affordance),
    version_groups: List(Affordance),
  )
}

pub fn generation() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use abilities <- decode.parameter
    use main_region <- decode.parameter
    use moves <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    use types <- decode.parameter
    use version_groups <- decode.parameter
    Generation(
      id,
      name,
      abilities,
      main_region,
      moves,
      names,
      pokemon_species,
      types,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("abilities", decode.list(of: affordance()))
  |> decode.field("main_region", affordance())
  |> decode.field("moves", decode.list(of: affordance()))
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
  |> decode.field("types", decode.list(of: affordance()))
  |> decode.field("version_groups", decode.list(of: affordance()))
}
