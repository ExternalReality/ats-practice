#include "share/atspre_staload.hats"

extern fun ipow: (int, int) -> int
implement ipow (base, power)  =
  if power = 0
    then 1
    else base * ipow(base, power - 1)