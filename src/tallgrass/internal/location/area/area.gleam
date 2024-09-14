import decode
import tallgrass/internal/common/affordance.{type Affordance, affordance}
import tallgrass/internal/common/name.{type Name, name}

// TODO: Add support for encounter_method_rates and pokemon_encounters.

pub type LocationArea {
  LocationArea(
    id: Int,
    name: String,
    game_index: Int,
    location: Affordance,
    names: List(Name),
  )
}

pub fn location_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use game_index <- decode.parameter
    use location <- decode.parameter
    use names <- decode.parameter
    LocationArea(id, name, game_index, location, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("game_index", decode.int)
  |> decode.field("location", affordance())
  |> decode.field("names", decode.list(of: name()))
}
