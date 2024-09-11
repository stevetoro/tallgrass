import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}

pub type Pokemon {
  Pokemon(slot: Int, pokemon: Affordance)
}

pub type PokemonWithHidden {
  PokemonWithHidden(is_hidden: Bool, slot: Int, affordance: Affordance)
}

pub type PokemonEntry {
  PokemonEntry(entry: Int, species: Affordance)
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

pub fn pokemon_entry() {
  decode.into({
    use entry <- decode.parameter
    use species <- decode.parameter
    PokemonEntry(entry, species)
  })
  |> decode.field("entry_number", decode.int)
  |> decode.field("pokemon_species", affordance())
}
