import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

pub type Region {
  Region(
    id: Int,
    name: String,
    locations: List(Affordance),
    main_generation: Affordance,
    names: List(Name),
    pokedexes: List(Affordance),
    version_groups: List(Affordance),
  )
}

pub fn region() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use locations <- decode.parameter
    use main_generation <- decode.parameter
    use names <- decode.parameter
    use pokedexes <- decode.parameter
    use version_groups <- decode.parameter
    Region(
      id,
      name,
      locations,
      main_generation,
      names,
      pokedexes,
      version_groups,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("locations", decode.list(of: affordance()))
  |> decode.field("main_generation", affordance())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokedexes", decode.list(of: affordance()))
  |> decode.field("version_groups", decode.list(of: affordance()))
}
