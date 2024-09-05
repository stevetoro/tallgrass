import decode
import gleam/option.{type Option}
import tallgrass/internal/common/affordance.{type Affordance, affordance}

pub type EvolutionChain {
  EvolutionChain(
    id: Int,
    baby_trigger_item: Option(Affordance),
    chain: ChainLink,
  )
}

pub type ChainLink {
  ChainLink(
    is_baby: Bool,
    species: Affordance,
    evolution_details: List(EvolutionDetails),
    // TODO: Figure out how to decode a recursive type.
    // evolves_to: List(ChainLink),
  )
}

pub type EvolutionDetails {
  EvolutionDetails(
    item: Option(Affordance),
    trigger: Affordance,
    gender: Int,
    held_item: Option(Affordance),
    known_move: Option(Affordance),
    known_move_type: Option(Affordance),
    location: Option(Affordance),
    min_level: Int,
    min_happiness: Option(Int),
    min_beauty: Option(Int),
    min_affection: Option(Int),
    needs_overworld_rain: Bool,
    party_species: Option(Affordance),
    party_type: Option(Affordance),
    relative_physical_stats: Int,
    time_of_day: String,
    trade_species: Option(Affordance),
    turn_upside_down: Bool,
  )
}

pub fn evolution_chain() {
  decode.into({
    use id <- decode.parameter
    use baby_trigger_item <- decode.parameter
    use chain <- decode.parameter
    EvolutionChain(id, baby_trigger_item, chain)
  })
  |> decode.field("id", decode.int)
  |> decode.field("baby_trigger_item", decode.optional(affordance()))
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
  |> decode.field("species", affordance())
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
    EvolutionDetails(
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
  |> decode.field("item", decode.optional(affordance()))
  |> decode.field("trigger", affordance())
  |> decode.field("gender", decode.int)
  |> decode.field("held_item", decode.optional(affordance()))
  |> decode.field("known_move", decode.optional(affordance()))
  |> decode.field("known_move_type", decode.optional(affordance()))
  |> decode.field("location", decode.optional(affordance()))
  |> decode.field("min_level", decode.int)
  |> decode.field("min_happiness", decode.optional(decode.int))
  |> decode.field("min_beauty", decode.optional(decode.int))
  |> decode.field("min_affection", decode.optional(decode.int))
  |> decode.field("needs_overworld_rain", decode.bool)
  |> decode.field("party_species", decode.optional(affordance()))
  |> decode.field("party_type", decode.optional(affordance()))
  |> decode.field("relative_physical_stats", decode.int)
  |> decode.field("time_of_day", decode.string)
  |> decode.field("trade_species", decode.optional(affordance()))
  |> decode.field("turn_upside_down", decode.bool)
}
