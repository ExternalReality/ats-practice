datasort rps_s =
  | rock
  | paper
  | scissors

datatype rps_t (rps_s) =
  | rock (rock)
  | paper (paper)
  | scissors (scissors)

stacst beats: (rps_s, rps_s) -> bool

extern praxi paper_bests_rock (): [beats(paper, rock)] void
extern praxi scissors_bests_paper (): [beats(scissors, paper)] void
extern praxi rock_bests_scissors (): [beats(rock, scissors)] void

extern fn determine_superior: {r1:rps_s} rps_t(r1) -> [r2: rps_s | beats (r2,r1)] rps_t(r2)
implement determine_superior rps = let
  prval () = paper_bests_rock()
  prval () = scissors_bests_paper()
  prval () = rock_bests_scissors()
  in
    case rps of
    | rock()     => paper
    | paper()    => scissors
    | scissors() => rock
  end

dataprop BEATS (rps_s, rps_s) =
  | PAPER_BESTS_ROCK (paper, rock)
  | ROCK_BESTS_SCISSORS (rock, scissors)
  | SCISSORS_BESTS_PAPER (scissors, paper)

extern fn determine_superior': {r1:rps_s} rps_t(r1) -> [r2: rps_s] (BEATS (r2,r1) | rps_t(r2))
implement determine_superior' rps =
  case rps of
  | rock()     => (PAPER_BESTS_ROCK | paper)
  | paper()    => (SCISSORS_BESTS_PAPER | scissors)
  | scissors() => (ROCK_BESTS_SCISSORS | rock)