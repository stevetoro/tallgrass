import common/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Pokemon {
  Pokemon(slot: Int, pokemon: Affordance)
}

pub type PokemonWithHidden {
  PokemonWithHidden(is_hidden: Bool, slot: Int, affordance: Affordance)
}

pub fn pokemon() {
  decode.into({
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    Pokemon(slot, pokemon)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", affordance())
}

pub fn pokemon_with_hidden() {
  decode.into({
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    use pokemon <- decode.parameter
    PokemonWithHidden(is_hidden, slot, pokemon)
  })
  |> decode.field("is_hidden", decode.bool)
  |> decode.field("slot", decode.int)
  |> decode.field("pokemon", affordance())
}
