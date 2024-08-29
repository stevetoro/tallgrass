import api/affordance.{type Affordance, Affordance, affordance}
import decode

pub type EggGroup {
  EggGroup(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Affordance),
  )
}

pub type Name {
  Description(name: String, language: Affordance)
}

pub fn egg_group() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    EggGroup(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}

fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Description(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", affordance())
}