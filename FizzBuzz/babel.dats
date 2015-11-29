#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "babel.sats"

implement calculate_fizzbuzz i =
  let
   val (pf1 | x) = g1int_nmod2(i, 3)
   val (pf2 | y) = g1int_nmod2(i, 5)
  in
    case+ (x,y) of
     | (0l,0l) => (FIZZBUZZ(pf1, pf2) | fizzbuzz)
     | (0l,_) => (FIZZ(pf1) | fizz)
     | (_,0l) => (BUZZ(pf2) | buzz)
     | (_,_) => (NUM | number)
  end

implement show_fizzbuzz i = let
  val (_ | babel) = calculate_fizzbuzz(i)
 in
  case+ babel of
   | fizzbuzz() => "FizzBuzz"
   | fizz()     => "Fizz"
   | buzz()     => "Buzz"
   | number()   => tostring_int(i)
 end

implement main0(argc, argv)  =
  let
    val () = assert_errmsg (argc = 2, "wrong usage. <Int>")
    val s  = g0string2int(argv[1])
    val i  = g1ofg0 (s)
    val () = assert( i >= 0)
    val s  = show_fizzbuzz(i)
  in
    println! s
  end