import decode
import gleam/option.{type Option}
import tallgrass/resource.{type NamedResource, named_resource}

pub type EvolutionChain {
  EvolutionChain(
    id: Int,
    baby_trigger_item: Option(NamedResource),
    chain: ChainLink,
  )
}

pub type ChainLink {
  ChainLink(
    is_baby: Bool,
    species: NamedResource,
    evolution_details: List(EvolutionDetail),
    // TODO: Figure out how to decode a recursive type.
    // evolves_to: List(ChainLink),
  )
}

pub type EvolutionDetail {
  EvolutionDetail(
    item: Option(NamedResource),
    trigger: NamedResource,
    gender: Int,
    held_item: Option(NamedResource),
    known_move: Option(NamedResource),
    known_move_type: Option(NamedResource),
    location: Option(NamedResource),
    min_level: Int,
    min_happiness: Option(Int),
    min_beauty: Option(Int),
    min_affection: Option(Int),
    needs_overworld_rain: Bool,
    party_species: Option(NamedResource),
    party_type: Option(NamedResource),
    relative_physical_stats: Int,
    time_of_day: String,
    trade_species: Option(NamedResource),
    turn_upside_down: Bool,
  )
}

const path = "evolution-chain"

/// Fetches an evolution chain by ID.
///
/// # Example
///
/// ```gleam
/// let result = evolution_chain.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  resource.fetch_by_id(id, path, evolution_chain())
}

fn evolution_chain() {
  decode.into({
    use id <- decode.parameter
    use baby_trigger_item <- decode.parameter
    use chain <- decode.parameter
    EvolutionChain(id, baby_trigger_item, chain)
  })
  |> decode.field("id", decode.int)
  |> decode.field("baby_trigger_item", decode.optional(named_resource()))
  |> decode.field("chain", chain_link())
}

fn chain_link() {
  decode.into({
    use is_baby <- decode.parameter
    use species <- decode.parameter
    use evolution_details <- decode.parameter
    // TODO: Figure out how to decode a recursive type.
    // use evolves_to <- decode.parameter
    ChainLink(is_baby, species, evolution_details)
  })
  |> decode.field("is_baby", decode.bool)
  |> decode.field("species", named_resource())
  |> decode.field("evolution_details", decode.list(of: evolution_details()))
  // TODO: Figure out how to decode a recursive type.
  // |> decode.field("evolves_to", decode.list(of: chain_link()))
}

fn evolution_details() {
  decode.into({
    use item <- decode.parameter
    use trigger <- decode.parameter
    use gender <- decode.parameter
    use held_item <- decode.parameter
    use known_move <- decode.parameter
    use known_move_type <- decode.parameter
    use location <- decode.parameter
    use min_level <- decode.parameter
    use min_happiness <- decode.parameter
    use min_beauty <- decode.parameter
    use min_affection <- decode.parameter
    use needs_overworld_rain <- decode.parameter
    use party_species <- decode.parameter
    use party_type <- decode.parameter
    use relative_physical_stats <- decode.parameter
    use time_of_day <- decode.parameter
    use trade_species <- decode.parameter
    use turn_upside_down <- decode.parameter
    EvolutionDetail(
      item,
      trigger,
      gender,
      held_item,
      known_move,
      known_move_type,
      location,
      min_level,
      min_happiness,
      min_beauty,
      min_affection,
      needs_overworld_rain,
      party_species,
      party_type,
      relative_physical_stats,
      time_of_day,
      trade_species,
      turn_upside_down,
    )
  })
  |> decode.field("item", decode.optional(named_resource()))
  |> decode.field("trigger", named_resource())
  |> decode.field("gender", decode.int)
  |> decode.field("held_item", decode.optional(named_resource()))
  |> decode.field("known_move", decode.optional(named_resource()))
  |> decode.field("known_move_type", decode.optional(named_resource()))
  |> decode.field("location", decode.optional(named_resource()))
  |> decode.field("min_level", decode.int)
  |> decode.field("min_happiness", decode.optional(decode.int))
  |> decode.field("min_beauty", decode.optional(decode.int))
  |> decode.field("min_affection", decode.optional(decode.int))
  |> decode.field("needs_overworld_rain", decode.bool)
  |> decode.field("party_species", decode.optional(named_resource()))
  |> decode.field("party_type", decode.optional(named_resource()))
  |> decode.field("relative_physical_stats", decode.int)
  |> decode.field("time_of_day", decode.string)
  |> decode.field("trade_species", decode.optional(named_resource()))
  |> decode.field("turn_upside_down", decode.bool)
}
