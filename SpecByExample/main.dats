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

stacst free_delivery: (customer, int, bool) -> bool

extern praxi vip_with_10_books (): [free_delivery(vip, 10, true)] void
extern praxi vip_with_9_books (): [free_delivery(vip, 9, false)] void
extern praxi regular_with_10_books (): [free_delivery(regular, 10, false)] void

extern fn should_get_free_delivery': {c:customer}{i:int} (customer(c), int(i)) -> [b:bool | free_delivery(c,i,b) ] bool(b)
implement should_get_free_delivery' (c, i) = let
  prval () = vip_with_10_books()
  prval () = vip_with_9_books()
  prval () = regular_with_10_books()
  in
    case+ (c,i) of
    | (vip(),10)      => true
    | (vip(),9)       => false
    | (regular(), 10) => false
  end 