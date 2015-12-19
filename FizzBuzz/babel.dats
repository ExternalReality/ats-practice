#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "babel.sats"

implement calculate_fizzbuzz i =
  let
   val (pf1 | x) = g1uint_mod2(i, 3u)
   val (pf2 | y) = g1uint_mod2(i, 5u)
  in
    case+ (x,y) of
     | (0u,0u) => (FIZZBUZZ(pf1, pf2) | fizzbuzz)
     | (0u,_) => (FIZZ(pf1) | fizz)
     | (_,0u) => (BUZZ(pf2) | buzz)
     | (_,_) => (NUM | number)
  end

implement show_fizzbuzz i = let
  val (_ | babel) = calculate_fizzbuzz(i)
 in
  case+ babel of
   | fizzbuzz() => "FizzBuzz"
   | fizz()     => "Fizz"
   | buzz()     => "Buzz"
   | number()   => tostring_uint(i)
 end

implement main0(argc, argv)  =
  let
    val () = assert_errmsg (argc = 2, "wrong usage. <Int >= 0>")
    val s  = g0string2uint (argv[1])
    val i  = g1ofg0 (s)
    val () = assert_errmsg (i >= 0u, "wrong usage. <Int >= 0>")
    val s  = show_fizzbuzz (i)
  in
    println! s
  end