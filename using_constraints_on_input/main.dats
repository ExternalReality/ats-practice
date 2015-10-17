// #include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

stadef snat = [a:nat | a > 1; a < 55] int(a)

extern fn addTwoNats {a:int} (x: snat, y: Nat) : Nat
implement addTwoNats (x, y) = x + y

extern fn read_nat (s:string) : Nat
implement read_nat s =
  let
    val nat = g0string2int_int (s)
    val nat = g1ofg0 (nat)
    val () = assert (nat >= 0)
  in
    nat
  end

extern fn read_snat (s:string) : snat
implement read_snat s = 
  let
    val snat = read_nat (s)
    val () = assert (snat > 1)
    val () = assert (snat < 55)
  in
    snat
  end 

implement main0 (argc, argv) =
{
  val () = if (argc != 3)
           then prerrln! ("Usage: ", argv[0], " <integer> <integer>")

  val () = assert (argc >= 3)

  val n1 = read_snat(argv[1])
  
  //read the first Nat
  val n0 = g0string2int_int (argv[2])
  val n0 = g1ofg0 (n0)
  val () = assert (n0 >= 0)
        
  val res = addTwoNats(n1, n0)

  val () = println! ("The result of addition is: ", res)
}