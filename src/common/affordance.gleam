import decode

pub type Affordance {
  Affordance(name: String, url: String)
}

pub fn affordance() {
  decode.into({
    use name <- decode.parameter
    use url <- decode.parameter
    Affordance(name, url)
  })
  |> decode.field("name", decode.string)
  |> decode.field("url", decode.string)
}
