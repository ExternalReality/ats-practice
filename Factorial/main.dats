
#include "share/atspre_define.hats"
(* #include "share/atspre_staload.hats" *)
(* #include "{$LIBATSCC2JS}/staloadall.hats" *)

(* #include "prelude/DATS/integer.dats" *)

staload "{$LIBATSCC2JS}/SATS/print.sats"
staload "{$LIBATSCC2JS}/DATS/print.dats"

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

extern fn clear_result_field: () -> void = "mac#"
extern fn get_input: () -> int = "mac#"
extern fn display_result: int -> void = "mac#"

dataprop FACT (int, int) =
  | FACTbase (0,1)
  | {n: nat}{r1, r:int} FACTind (n, r) of (FACT(n-1,r1), MUL(n, r1, r))

extern fn ifact2: {n: nat} (int(n)) -> [r:int] (FACT(n, r) | int(r))
implement ifact2 {n} x = let
  fun loop {i:nat | i <= n} {r:int} .<n-i>. 
           (prf: FACT(i,r) | n:int(n), i:int(i), r:int(r)):
           [r:int] (FACT (n,r) | int r) =
    if n - i > 0 then
      let
        val (p | r1) = g1int_mul2 (i+1, r)
      in
        loop (FACTind(prf, p) | n, i+1, r1)
    end else (prf | r)
    in
      loop (FACTbase () | x, 0, 1)
    end

extern fn run_ifact (): void = "mac#"
implement run_ifact () = {
  val input = get_input ();
  val input = g1ofg0 (input)
  val () = assert_errmsg (input >= 0, "Bad input value.")
  val () = assert_errmsg (input <= 30, "Bad input value.")
  val (_ | res) = ifact2(input)
  val () = display_result (res)
}

val () = run_ifact ()

%{$
$("#factorial-form").submit(function(e){
  e.preventDefault();
});

function atspre_g1int_mul_int(x1, x2) { return (x1 * x2) ; }

function get_input(){
  return $("#natural").val();
}

function display_result(result){
  var field = $("#natural").parsley();
  if (field.isValid())
    $("#factorial-result").val(result);
}
%} // end of [%{$]