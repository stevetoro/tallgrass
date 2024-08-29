import api/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Ability {
  Ability(
    id: Int,
    name: String,
    is_main_series: Bool,
    generation: Affordance,
    names: List(Name),
    effect_entries: List(Effect),
    flavor_text_entries: List(FlavorText),
    pokemon: List(Pokemon),
  )
}

pub type Name {
  Name(name: String, language: Affordance)
}

pub type Effect {
  Effect(effect: String, short_effect: String, language: Affordance)
}

pub type FlavorText {
  FlavorText(text: String, language: Affordance, version_group: Affordance)
}

pub type Pokemon {
  Pokemon(is_hidden: Bool, slot: Int, affordance: Affordance)
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
  |> decode.field("pokemon", decode.list(of: pokemon()))
}

fn name() {
  decode.into({
    use name <- decode.parameter
    use language_name <- decode.parameter
    use language_url <- decode.parameter
    Name(name, Affordance(language_name, language_url))
  })
  |> decode.field("name", decode.string)
  |> decode.subfield(["language", "name"], decode.string)
  |> decode.subfield(["language", "url"], decode.string)
}

fn effect() {
  decode.into({
    use effect <- decode.parameter
    use short_effect <- decode.parameter
    use language_name <- decode.parameter
    use language_url <- decode.parameter
    Effect(effect, short_effect, Affordance(language_name, language_url))
  })
  |> decode.field("effect", decode.string)
  |> decode.field("short_effect", decode.string)
  |> decode.subfield(["language", "name"], decode.string)
  |> decode.subfield(["language", "url"], decode.string)
}

fn flavor_text() {
  decode.into({
    use text <- decode.parameter
    use language_name <- decode.parameter
    use language_url <- decode.parameter
    use version_group_name <- decode.parameter
    use version_group_url <- decode.parameter
    FlavorText(
      text,
      Affordance(language_name, language_url),
      Affordance(version_group_name, version_group_url),
    )
  })
  |> decode.field("flavor_text", decode.string)
  |> decode.subfield(["language", "name"], decode.string)
  |> decode.subfield(["language", "url"], decode.string)
  |> decode.subfield(["version_group", "name"], decode.string)
  |> decode.subfield(["version_group", "url"], decode.string)
}

fn pokemon() {
  decode.into({
    use is_hidden <- decode.parameter
    use slot <- decode.parameter
    use pokemon_name <- decode.parameter
    use pokemon_url <- decode.parameter
    Pokemon(is_hidden, slot, Affordance(pokemon_name, pokemon_url))
  })
  |> decode.field("is_hidden", decode.bool)
  |> decode.field("slot", decode.int)
  |> decode.subfield(["pokemon", "name"], decode.string)
  |> decode.subfield(["pokemon", "url"], decode.string)
}
