#include "share/atspre_staload.hats"

typedef sizeLt (n:int) = [i:nat | i < n] size_t (i)

extern fn string_find {n: nat} (str: string n, c0: char): Option (sizeLt n)


implement string_find {n} (str, c0) =
  let
    typedef res = sizeLt (n)
    fun loop{i:nat | i <= n}(str: string n, c0: char, i: size_t i): Option res =
    let  
      val isnot = string_isnot_atend (str, i)
    in
      if isnot
        then
          if (c0 = str[i])
            then Some{res}(i)
            else loop(str, c0, succ(i))        
        else
          None ()
    end
  in
    loop (str, c0, i2sz(0))
  end


implement main0 () = {
  val maybe_char = string_find ("hello World", 'w')
  val () = case maybe_char of
    | Some i  => println! i 
    | None () => println! "The character was not found in the string"
}