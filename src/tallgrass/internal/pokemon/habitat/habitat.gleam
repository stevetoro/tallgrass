import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, Name, name}

pub type Habitat {
  Habitat(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Affordance),
  )
}

pub fn habitat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Habitat(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}
