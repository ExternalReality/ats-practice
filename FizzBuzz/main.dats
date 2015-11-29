#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

datasort babel =
 | fizz
 | buzz
 | fizzbuzz
 | number

datatype babel(babel) =
 | fizz(fizz)
 | buzz(buzz)
 | fizzbuzz(fizzbuzz)
 | number(number)

dataprop FizzBuzz (int,babel) =
 | {i:int} FIZZBUZZ(i,fizzbuzz) of (MOD(i,3,0), MOD(i,5,0))
 | {i:int} FIZZ(i,fizz) of (MOD(i,3,0))
 | {i:int} BUZZ(i,buzz) of (MOD(i,5,0))
 | {i:int} NUM(i,number)

extern fn calculate_fizzbuzz: {i:nat} int(i) -> [b:babel] (FizzBuzz(i,b) | babel(b))
implement calculate_fizzbuzz i =
  let
   val (pf1 | x) = g1int_nmod2(i, 3)
   val (pf2 | y) = g1int_nmod2(i, 5)
  in
    case+ (x,y) of
     | (0,0) => (FIZZBUZZ(pf1, pf2) | fizzbuzz)
     | (0,_) => (FIZZ(pf1) | fizz)
     | (_,0) => (BUZZ(pf2) | buzz)
     | (_,_) => (NUM | number)
  end

extern fn show_fizzbuzz: {i:nat} int(i) -> string = "mac#"
implement show_fizzbuzz i = let
  val (_ | babel) = calculate_fizzbuzz(i)
 in
  case+ babel of
   | fizzbuzz() => "FizzBuzz"
   | fizz()     => "Fizz"
   | buzz()     => "Buzz"
   | number()   => tostring_int(i)
 end

(* implement main0(argc, argv)  = *)
(*   let  *)
(*     val () = assert_errmsg (argc = 1, "wrong usage. <Int>") *)
(*     val s = g0string2int(argv[0]) *)
(*     val i = g1ofg0 (s) *)
(*     val () = assert( i >= 0) *)
(*     val s = show_fizzbuzz(i) *)
(*   in *)
(*     println! s *)
(*   end *)