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


implement main0 (argc, argv) =
  if (argc != 3)
    then
      println! ("Usage: ", argv[0], " <string> <char>")
    else
      let
        val string_to_search = argv[1]
        val string_to_search = g1ofg0_string(string_to_search)
        val search_char = argv[2] 
        val search_char = let val m = g1ofg0_string(search_char)
                              val () = assert (string_length(m) = 1)
                          in m[0] end
                          
        val maybe_pos = string_find (string_to_search, search_char)
      in
       case maybe_pos of
         | Some i  => println! ("The character was found at string postion ", i)
         | None () => println! "The character was not found in the string"
       end