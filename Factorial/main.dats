#include "share/atspre_define.hats"

#include "{$LIBATSCC2JS}/staloadall.hats"

staload "{$LIBATSCC2JS}/SATS/print.sats"
staload "{$LIBATSCC2JS}/DATS/print.dats"

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

extern fn clear_result_field: () -> void = "mac#"
extern fn get_input: () -> int = "mac#"
extern fn display_result: int -> void = "mac#"

extern fn ifact2:<> int -> int
implement ifact2 x = let
  fun loop (n:int, i:int, r:int): int =
    if n - i > 0 then let
      val r1 = (i+1) * r in loop (n, i+1, r1)
    end else r
    in
      loop (x, 0, 1)
    end

extern fn run_ifact (): void = "mac#"
implement run_ifact () = {
  val input = get_input ();
  val input = g1ofg0 (input)
  val () = assert_errmsg (input >= 0, "Bad input value.")
  val () = display_result (ifact2(input))
}

val () = run_ifact ()

%{$
$("#factorial-form").submit(function(e){
    e.preventDefault();
});

function get_input(){
    return $("#natural").val(); 
}

function display_result(result){
  var field = $("#natural").parsley();
  if (field.isValid())
    $("#factorial-result").val(result);
}
%} // end of [%{$]
