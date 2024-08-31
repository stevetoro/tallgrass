import common/affordance.{type Affordance, Affordance, affordance}
import common/name.{type Name, Name, name}
import decode

pub type PokeathlonStat {
  PokeathlonStat(
    id: Int,
    name: String,
    names: List(Name),
    affecting_natures: AffectingNatures,
  )
}

pub type AffectingNatures {
  AffectingNatures(increase: List(Nature), decrease: List(Nature))
}

pub type Nature {
  Nature(max_change: Int, affordance: Affordance)
}

pub fn pokeathlon_stat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use names <- decode.parameter
    use affecting_natures <- decode.parameter
    PokeathlonStat(id, name, names, affecting_natures)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("names", decode.list(of: name()))
  |> decode.field("affecting_natures", affecting_natures())
}

fn affecting_natures() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    AffectingNatures(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: nature()))
  |> decode.field("decrease", decode.list(of: nature()))
}

fn nature() {
  decode.into({
    use max_change <- decode.parameter
    use affordance <- decode.parameter
    Nature(max_change, affordance)
  })
  |> decode.field("max_change", decode.int)
  |> decode.field("nature", affordance())
}
