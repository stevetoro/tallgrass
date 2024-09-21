import decode
import tallgrass/common/name.{type Name, name}
import tallgrass/resource.{type Resource, resource}

pub type PokeathlonStat {
  PokeathlonStat(
    id: Int,
    name: String,
    names: List(Name),
    affecting_natures: NaturePokeathlonStatAffectSets,
  )
}

pub type NaturePokeathlonStatAffectSets {
  NaturePokeathlonStatAffectSets(
    increase: List(NaturePokeathlonStatAffect),
    decrease: List(NaturePokeathlonStatAffect),
  )
}

pub type NaturePokeathlonStatAffect {
  NaturePokeathlonStatAffect(max_change: Int, nature: Resource)
}

const path = "pokeathlon-stat"

/// Fetches a pokemon pokeathlon stat by the pokeathlon stat ID.
///
/// # Example
///
/// ```gleam
/// let result = pokeathlon_stat.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, pokeathlon_stat())
}

/// Fetches a pokemon pokeathlon stat by the pokeathlon stat name.
///
/// # Example
///
/// ```gleam
/// let result = pokeathlon_stat.fetch_by_name("skill")
/// ```
pub fn fetch_by_name(name: String) {
  resource.fetch_by_name(name, path, pokeathlon_stat())
}

fn pokeathlon_stat() {
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
  |> decode.field("affecting_natures", nature_pokeathlon_stat_affect_sets())
}

fn nature_pokeathlon_stat_affect_sets() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    NaturePokeathlonStatAffectSets(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: nature_pokeathlon_stat_affect()))
  |> decode.field("decrease", decode.list(of: nature_pokeathlon_stat_affect()))
}

fn nature_pokeathlon_stat_affect() {
  decode.into({
    use max_change <- decode.parameter
    use nature <- decode.parameter
    NaturePokeathlonStatAffect(max_change, nature)
  })
  |> decode.field("max_change", decode.int)
  |> decode.field("nature", resource())
}
