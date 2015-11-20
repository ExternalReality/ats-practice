#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

datasort customer =
  | vip
  | regular

datatype customer(customer) =
 | vip (vip)
 | regular (regular)

dataprop FREE_DELIVERY (customer, int, bool) =
 | VIP_WITH_10_BOOKS (vip, 10, true)
 | VIP_WITH_9_BOOKS (vip, 9, false)
 | REGULAR_WITH_10_BOOKS (regular, 10, false)

extern fn should_get_free_delivery:
  {c: customer}{i: int} (customer c, int i) -> [b:bool] (FREE_DELIVERY(c,i,b) | bool b)

implement should_get_free_delivery(c, i) =
   case (c, i) of
   | (vip(), 10)     => (VIP_WITH_10_BOOKS | true)
   | (vip(), 9)      => (VIP_WITH_9_BOOKS | false)
   | (regular(), 10) => (REGULAR_WITH_10_BOOKS | false)

extern fn read_customer: string -> [c:customer] customer(c)
implement read_customer s =
  case+ s of
  | "vip"     => vip()
  | "regular" => regular()
  | _         => vip()

implement main0 (argc, argv) = {
  val () = assert_errmsg (argc = 3, "usage: <customer> <int> \n")
  val customer_type = read_customer (g1ofg0_string(argv[1]))
  val num_books = g0string2int_int(argv[2])
  val num_books = g1ofg0(num_books)
  val (_ | free) = should_get_free_delivery (customer_type, num_books)
  val () = println! ("Customer get free delivery: ", free)
}