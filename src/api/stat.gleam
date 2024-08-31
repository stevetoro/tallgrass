import api/affordance.{type Affordance, Affordance, affordance}
import decode

pub type Stat {
  Stat(
    id: Int,
    name: String,
    game_index: Int,
    is_battle_only: Bool,
    affecting_moves: AffectingMoves,
    affecting_natures: AffectingNatures,
    move_damage_class: Affordance,
    names: List(Name),
  )
}

pub type Name {
  Name(name: String, language: Affordance)
}

pub type AffectingNatures {
  AffectingNatures(increase: List(Affordance), decrease: List(Affordance))
}

pub type AffectingMoves {
  AffectingMoves(increase: List(Move), decrease: List(Move))
}

pub type Move {
  Move(change: Int, affordance: Affordance)
}

pub fn stat() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use game_index <- decode.parameter
    use is_battle_only <- decode.parameter
    use affecting_moves <- decode.parameter
    use affecting_natures <- decode.parameter
    use move_damage_class <- decode.parameter
    use names <- decode.parameter
    Stat(
      id,
      name,
      game_index,
      is_battle_only,
      affecting_moves,
      affecting_natures,
      move_damage_class,
      names,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("game_index", decode.int)
  |> decode.field("is_battle_only", decode.bool)
  |> decode.field("affecting_moves", affecting_moves())
  |> decode.field("affecting_natures", affecting_natures())
  |> decode.field("move_damage_class", affordance())
  |> decode.field("names", decode.list(of: name()))
}

fn name() {
  decode.into({
    use name <- decode.parameter
    use language <- decode.parameter
    Name(name, language)
  })
  |> decode.field("name", decode.string)
  |> decode.field("language", affordance())
}

fn affecting_natures() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    AffectingNatures(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: affordance()))
  |> decode.field("decrease", decode.list(of: affordance()))
}

fn affecting_moves() {
  decode.into({
    use increase <- decode.parameter
    use decrease <- decode.parameter
    AffectingMoves(increase, decrease)
  })
  |> decode.field("increase", decode.list(of: move()))
  |> decode.field("decrease", decode.list(of: move()))
}

fn move() {
  decode.into({
    use max_change <- decode.parameter
    use affordance <- decode.parameter
    Move(max_change, affordance)
  })
  |> decode.field("change", decode.int)
  |> decode.field("move", affordance())
}