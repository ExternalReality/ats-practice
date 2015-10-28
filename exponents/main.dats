#include "share/atspre_staload.hats"

abst@ype E (a:t@ype, x:int) = a //I don't know what is meant by  x:elt is a stamp

extern fun ipow: (int, int) -> int
implement ipow (base, power)  =
  if power = 0
    then 1
    else base * ipow(base, power - 1)
    
dataprop POW (int , int , int) =
 | {x: int} POWbas (x, 0, 1)
 | {x: int} {n:nat} {p,p1:int}
   POWind (x, n+1, p1) of (POW (x, n, p), MUL (x, p, p1))
    
extern fun fastpow{a:t@ype}: {x: int} {n:nat} (E (a, x), int) 
                          -> [p:int] (POW (x, p, n) | E (a, p))
implement{a} fastpow (x, n) =
                           
(* implement fastpow (x, n) =  *)
(*   if n > 0  *)
(*     then *)
(*       let  *)
(*         val n2 = n/2 *)
(*         val i = n-(2*n2) *)
(*       in *)
(*         if i > 0 then fastpow (x*x, n2) else x * fastpow (x*x, n2) *)
(*       end  *)
(*     else 1  *)


implement main0 () = {
}