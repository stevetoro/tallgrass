import decode
import tallgrass/internal/common/affordance.{type Affordance, Affordance, affordance}

pub type LocationArea {
  LocationArea(location_area: Affordance, version_details: List(VersionDetail))
}

pub type VersionDetail {
  VersionDetail(
    max_chance: Int,
    encounter_details: List(EncounterDetail),
    version: Affordance,
  )
}

pub type EncounterDetail {
  EncounterDetail(
    min_level: Int,
    max_level: Int,
    chance: Int,
    method: Affordance,
    condition_values: List(Affordance),
  )
}

pub fn location_area() {
  decode.into({
    use location_area <- decode.parameter
    use version_details <- decode.parameter
    LocationArea(location_area, version_details)
  })
  |> decode.field("location_area", affordance())
  |> decode.field("version_details", decode.list(of: version_detail()))
}

fn version_detail() {
  decode.into({
    use max_chance <- decode.parameter
    use encounter_details <- decode.parameter
    use version <- decode.parameter
    VersionDetail(max_chance, encounter_details, version)
  })
  |> decode.field("max_chance", decode.int)
  |> decode.field("encounter_details", decode.list(of: encounter_detail()))
  |> decode.field("version", affordance())
}

fn encounter_detail() {
  decode.into({
    use min_level <- decode.parameter
    use max_level <- decode.parameter
    use chance <- decode.parameter
    use method <- decode.parameter
    use condition_values <- decode.parameter
    EncounterDetail(min_level, max_level, chance, method, condition_values)
  })
  |> decode.field("min_level", decode.int)
  |> decode.field("max_level", decode.int)
  |> decode.field("chance", decode.int)
  |> decode.field("method", affordance())
  |> decode.field("condition_values", decode.list(of: affordance()))
}
