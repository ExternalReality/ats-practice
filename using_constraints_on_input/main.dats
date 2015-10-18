// #include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef SNat = [a:nat | 1 < a; a < 55] int(a)

extern fn addTwoNats : (SNat, Nat) -> Nat
implement addTwoNats (x, y) = x + y

extern fn read_nat : string -> Nat
implement read_nat s =
  let
    val nat     = g0string2int_int (s)
    val nat     = g1ofg0 (nat)
    val err_msg = "Invalid input: expecting natural number.\n"
    val ()      = assert_errmsg (nat >= 0, err_msg)
  in
    nat
  end

extern fn read_snat : string -> SNat
implement read_snat s =
  let
    val snat    = read_nat (s)
    val err_msg = "Invalid input: expecting number to be greater than 1 but less than 55.\n"
    val ()      = assert_errmsg ((1 < snat), err_msg)
    val ()      = assert_errmsg ((snat < 55), err_msg)
  in
    snat
  end

implement main0 (argc, argv) =
{
  val () = if (argc != 3)
           then prerrln! ("Usage: ", argv[0], " <number > 0> <1 < number > 55>")

  val ()  = assert (argc >= 3)
  val n0  = read_snat(argv[1])
  val n1  = read_nat(argv[2])
  val res = addTwoNats(n0, n1)
  val ()  = println! ("The result of addition is: ", res)
}