import decode
import gleam/option.{type Option}
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}

pub type EvolutionChain {
  EvolutionChain(id: Int, baby_trigger_item: Option(Resource), chain: ChainLink)
}

pub type ChainLink {
  ChainLink(
    is_baby: Bool,
    species: Resource,
    evolution_details: List(EvolutionDetail),
    // TODO: Figure out how to decode a recursive type.
    // evolves_to: List(ChainLink),
  )
}

pub type EvolutionDetail {
  EvolutionDetail(
    item: Option(Resource),
    trigger: Resource,
    gender: Int,
    held_item: Option(Resource),
    known_move: Option(Resource),
    known_move_type: Option(Resource),
    location: Option(Resource),
    min_level: Int,
    min_happiness: Option(Int),
    min_beauty: Option(Int),
    min_affection: Option(Int),
    needs_overworld_rain: Bool,
    party_species: Option(Resource),
    party_type: Option(Resource),
    relative_physical_stats: Int,
    time_of_day: String,
    trade_species: Option(Resource),
    turn_upside_down: Bool,
  )
}

const path = "evolution-chain"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of evolution chain resources.
///
/// # Example
///
/// ```gleam
/// let result = chain.new() |> chain.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches an evolution chain given an evolution chain resource.
///
/// # Example
///
/// ```gleam
/// let client = chain.new()
/// use res <- result.try(client |> chain.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> chain.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, evolution_chain())
}

/// Fetches an evolution chain given the evolution chain ID.
///
/// # Example
///
/// ```gleam
/// let result = chain.new() |> chain.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, evolution_chain())
}

fn evolution_chain() {
  decode.into({
    use id <- decode.parameter
    use baby_trigger_item <- decode.parameter
    use chain <- decode.parameter
    EvolutionChain(id, baby_trigger_item, chain)
  })
  |> decode.field("id", decode.int)
  |> decode.field("baby_trigger_item", decode.optional(resource()))
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
  |> decode.field("species", resource())
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
  |> decode.field("item", decode.optional(resource()))
  |> decode.field("trigger", resource())
  |> decode.field("gender", decode.int)
  |> decode.field("held_item", decode.optional(resource()))
  |> decode.field("known_move", decode.optional(resource()))
  |> decode.field("known_move_type", decode.optional(resource()))
  |> decode.field("location", decode.optional(resource()))
  |> decode.field("min_level", decode.int)
  |> decode.field("min_happiness", decode.optional(decode.int))
  |> decode.field("min_beauty", decode.optional(decode.int))
  |> decode.field("min_affection", decode.optional(decode.int))
  |> decode.field("needs_overworld_rain", decode.bool)
  |> decode.field("party_species", decode.optional(resource()))
  |> decode.field("party_type", decode.optional(resource()))
  |> decode.field("relative_physical_stats", decode.int)
  |> decode.field("time_of_day", decode.string)
  |> decode.field("trade_species", decode.optional(resource()))
  |> decode.field("turn_upside_down", decode.bool)
}
