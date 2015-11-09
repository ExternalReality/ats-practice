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
   case+ (i, c) of
    | (10,vip()) => (VIP_WITH_10_BOOKS | true)
    | (9, vip()) => (VIP_WITH_9_BOOKS | false)
    | (10,regular()) => (REGULAR_WITH_10_BOOKS | false)