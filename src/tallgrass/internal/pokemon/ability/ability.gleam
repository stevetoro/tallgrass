import decode
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/name.{type Name, Name, name}
import tallgrass/internal/common/pokemon.{
  type PokemonWithHidden, PokemonWithHidden, pokemon_with_hidden,
}

pub type Ability {
  Ability(
    id: Int,
    name: String,
    is_main_series: Bool,
    generation: Affordance,
    names: List(Name),
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorText),
    pokemon: List(PokemonWithHidden),
  )
}

pub type Effect {
  Effect(effect: String, short_effect: String, language: Affordance)
}

pub type FlavorText {
  FlavorText(text: String, language: Affordance, version_group: Affordance)
}

pub fn ability() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use is_main_series <- decode.parameter
    use generation <- decode.parameter
    use names <- decode.parameter
    use effect_entries <- decode.parameter
    use flavor_texts <- decode.parameter
    use pokemon <- decode.parameter
    Ability(
      id,
      name,
      is_main_series,
      generation,
      names,
      effect_entries,
      flavor_texts,
      pokemon,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("is_main_series", decode.bool)
  |> decode.field("generation", affordance())
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("effect_entries", decode.list(of: effect()))
  |> decode.field("flavor_text_entries", decode.list(of: flavor_text()))
  |> decode.field("pokemon", decode.list(of: pokemon_with_hidden()))
}

fn effect() {
  decode.into({
    use effect <- decode.parameter
    use short_effect <- decode.parameter
    use language <- decode.parameter
    Effect(effect, short_effect, language)
  })
  |> decode.field("effect", decode.string)
  |> decode.field("short_effect", decode.string)
  |> decode.field("language", affordance())
}

fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    use version_group <- decode.parameter
    FlavorText(text, language, version_group)
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.field("language", affordance())
  |> decode.field("version_group", affordance())
}
