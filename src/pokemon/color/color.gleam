import common/affordance.{type Affordance, Affordance, affordance}
import common/name.{type Name, Name, name}
import decode

pub type Color {
  Color(
    id: Int,
    name: String,
    names: List(Name),
    pokemon_species: List(Affordance),
  )
}

pub fn color() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use pokemon_species <- decode.parameter
    Color(id, name, names, pokemon_species)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("pokemon_species", decode.list(of: affordance()))
}
