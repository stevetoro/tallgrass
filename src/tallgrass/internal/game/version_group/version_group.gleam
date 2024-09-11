import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}

pub type VersionGroup {
  VersionGroup(
    id: Int,
    name: String,
    order: Int,
    generation: Affordance,
    move_learn_methods: List(Affordance),
    pokedexes: List(Affordance),
    regions: List(Affordance),
    versions: List(Affordance),
  )
}

pub fn version_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use generation <- decode.parameter
    use move_learn_methods <- decode.parameter
    use pokedexes <- decode.parameter
    use regions <- decode.parameter
    use versions <- decode.parameter
    VersionGroup(
      id,
      name,
      order,
      generation,
      move_learn_methods,
      pokedexes,
      regions,
      versions,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("generation", affordance())
  |> decode.field("move_learn_methods", decode.list(of: affordance()))
  |> decode.field("pokedexes", decode.list(of: affordance()))
  |> decode.field("regions", decode.list(of: affordance()))
  |> decode.field("versions", decode.list(of: affordance()))
}
