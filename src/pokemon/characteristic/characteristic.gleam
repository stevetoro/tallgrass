import affordance/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Characteristic {
  Characteristic(
    id: Int,
    gene_modulo: Int,
    possible_values: List(Int),
    highest_stat: Affordance,
    descriptions: List(Description),
  )
}

pub type Description {
  Description(text: String, language: Affordance)
}

pub fn characteristic() {
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

fn description() {
  decode.into({
    use text <- decode.parameter
    use language <- decode.parameter
    Description(text, language)
  })
  |> decode.field("description", decode.string)
  |> decode.field("language", affordance())
}
