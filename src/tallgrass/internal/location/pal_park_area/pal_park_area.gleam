import decode
import tallgrass/internal/common/name.{type Name, name}

// TODO: Add support for pokemon_encounters.

pub type PalParkArea {
  PalParkArea(id: Int, name: String, names: List(Name))
}

pub fn pal_park_area() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    PalParkArea(id, name, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
}
