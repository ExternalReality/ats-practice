%{^
#include "parson.h"
%}

#include "share/atspre_staload.hats"
#include "prelude/DATS/filebas.dats"

extern fun json_parse_file: String -> [l:addr] ptr(l) = "mac#json_parse_file"
extern fun json_value_free: {l:addr} ptr(l) -> void = "mac#json_value_free"
extern fun json_object_get_array : {l:addr} (ptr(l), string) 
                                 -> [l:addr] ptr(l) = "mac#json_object_get_array"

implement main0 (argc, argv) = {
  val () = assert_errmsg(argc = 2, "Incorrect usage.")
  val file_name = g1ofg0_string(argv[1])
  val json_data = json_parse_file (file_name)
  val () = assert_errmsg( json_data != 0, "Could not parse file")
  val tag_data = json_object_get_array(json_data, "tagentarr")
  val () = assert_errmsg( tag_data != 0, "Could not read tag data")
  
  // TODO: PARSE THE DATA PUT IN WRITE TO ETAGS FORMAT FILE
  
  val () = json_value_free(json_data)
  val () = json_value_free(tag_data)
  
  // TODO: ADD THE ETAGS HEADERS TO RESULT FILE
}
