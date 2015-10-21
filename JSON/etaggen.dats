%{^
#include "parson.h"
%}

#include "share/atspre_staload.hats"
#include "prelude/DATS/filebas.dats"

extern fun json_object_get_number: {l:addr} (ptr l, String) -> double = "mac#json_object_get_number"
extern fun json_object: {l:addr} (ptr l) -> [l:addr] ptr l = "mac#json_object"
extern fun json_value_get_array: {l:addr} (ptr l) -> [l:addr] ptr l = "mac#json_value_get_array"
extern fun json_value_get_type: {l:addr} ptr l -> int = "mac#json_value_get_type"
extern fun json_object_get_string: {l:addr} (ptr l, String) -> String = "mac#json_object_get_string"
extern fun json_array_get_object: {l:addr} (ptr l , size_t) -> [l:addr] ptr l = "mac#json_array_get_object"
extern fun json_parse_file: String -> [l:addr] ptr(l) = "mac#json_parse_file"
extern fun json_value_free: {l:addr} ptr(l) -> void = "mac#json_value_free"
extern fun json_array_get_count: {l:addr} ptr(l) -> size_t = "mac#json_array_get_count"
extern fun json_object_get_array: {l:addr} (ptr(l), string) -> [l:addr] ptr(l) = "mac#json_object_get_array"

extern fn convert_json_to_etags: {l:addr} (ptr l) -> void
implement convert_json_to_etags (taggen_array) =
  let fun loop {n : nat} .<n>. (i: int(n)) : void =
    if (i > 0)
      then let
        val tag_object = json_array_get_object(taggen_array, i2sz(i))
        val name = json_object_get_string(tag_object, "name")
        val line = g0float2int_double_int (json_object_get_number(tag_object, "nline"))
        val column = g0float2int_double_int (json_object_get_number(tag_object, "nchar"))
        val () = println! (name, " ", line, " ", column)
      in
        loop (i - 1)
      end
    val count = json_array_get_count(taggen_array)
    val count = sz2i(g1ofg0 count)
  in
    loop (count)
  end

implement main0 (argc, argv) = {
  val () = assert_errmsg(argc = 2, "Incorrect usage.")
  val file_name = g1ofg0_string(argv[1])
  val json_data = json_parse_file (file_name)
  val () = assert_errmsg( json_data != 0, "Could not parse file\n")
  val () = println! (json_value_get_type(json_data))
  val tag_data = json_object_get_array(json_object(json_data), "tagentarr")
  val () = assert_errmsg( tag_data != 0, "Could not read tag data\n")

  val () = convert_json_to_etags(tag_data)

  val () = json_value_free(json_data)
  val () = json_value_free(tag_data)

  // TODO: ADD THE ETAGS HEADERS TO RESULT FILE
}
