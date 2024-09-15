import decode
import tallgrass/fetch
import tallgrass/internal/common/affordance.{
  type Affordance, Affordance, affordance,
}
import tallgrass/internal/common/description.{type Description, description}

pub type Characteristic {
  Characteristic(
    id: Int,
    gene_modulo: Int,
    possible_values: List(Int),
    highest_stat: Affordance,
    descriptions: List(Description),
  )
}

const path = "characteristic"

/// Fetches a pokemon characteristic by the characteristic ID.
///
/// # Example
///
/// ```gleam
/// let result = characteristic.fetch_by_id(1)
/// ```
pub fn fetch_by_id(id: Int) {
  fetch.resource_by_id(id, path, characteristic())
}

fn characteristic() {
  decode.into({
    use id <- decode.parameter
    use gene_modulo <- decode.parameter
    use possible_values <- decode.parameter
    use highest_stat <- decode.parameter
    use descriptions <- decode.parameter
    Characteristic(id, gene_modulo, possible_values, highest_stat, descriptions)
  })
  |> decode.field("id", decode.int)
  |> decode.field("gene_modulo", decode.int)
  |> decode.field("possible_values", decode.list(of: decode.int))
  |> decode.field("highest_stat", affordance())
  |> decode.field("descriptions", decode.list(of: description()))
}
