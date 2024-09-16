import decode
import tallgrass/resource.{type NamedResource, named_resource}

pub type PokemonType {
  PokemonType(slot: Int, pokemon_type: NamedResource)
}

@internal
pub fn pokemon_type() {
  decode.into({
    use slot <- decode.parameter
    use pokemon_type <- decode.parameter
    PokemonType(slot, pokemon_type)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("type", named_resource())
}
