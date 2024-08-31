import common/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Type {
  Type(slot: Int, affordance: Affordance)
}

pub fn types() {
  decode.into({
    use slot <- decode.parameter
    use affordance <- decode.parameter
    Type(slot, affordance)
  })
  |> decode.field("slot", decode.int)
  |> decode.field("type", affordance())
}
