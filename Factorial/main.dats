#include "share/atspre_staload.hats"

extern fn factorial: {n : nat} int(n) -> int
implement factorial n =
  let
    fun loop {n:nat}{l:addr} .<n>. (pf: !int@l | n: int n, res: ptr l): void =
      if n > 0
        then
          let val () = !res := n * !res in loop (pf | n-1, res)
        end
    var res: int with pf = 1
    val () = loop (pf | n, addr@res)
  in
    res
  end

implement main0 (argc, argv) = {
  val () = if (argc != 2)
    then prerrln! ("useage: ", argv[0], " <integer >= 0>")
    else {
      val num     = g0string2int_int (argv[1])
      val num     = g1ofg0 (num)
      val err_msg = "Invalid input: expecting natural number.\n"
      val ()      = assert_errmsg (num >= 0, err_msg)
      val res     = factorial(num)
      val ()      = println! ("The factorial of ", num, " is: ", res)
    }
}
