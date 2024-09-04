import decode
import tallgrass/internal/common/name.{type Name, name}

pub type EncounterMethod {
  EncounterMethod(id: Int, name: String, order: Int, names: List(Name))
}

pub fn encounter_method() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use names <- decode.parameter
    EncounterMethod(id, name, order, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("names", decode.list(of: name()))
}
