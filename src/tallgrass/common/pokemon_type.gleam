import decode
import tallgrass/resource.{type Resource, resource}

pub type PokemonType {
  PokemonType(slot: Int, pokemon_type: Resource)
}

@internal
pub fn pokemon_type() {
  decode.into({
    use slot <- decode.parameter
    use pokemon_type <- decode.parameter
    PokemonType(slot, pokemon_type)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("type", resource())
}
