absviewtype timer_vtype
viewtypedef timer = timer_vtype

extern fn timer_new (): timer
extern fn timer_free: timer -> void

typedef timer_struct = @{ started = bool }

dataviewtype timer = TIMER of (timer_struct)

assume timer_vtype = timer

implement timer_new () = 
  let
    val timer = TIMER (_)
    val TIMER(x) = timer
    val () = x.started := false
    prval () = fold@ (timer)
  in
    timer
  end

implement timer_free (timer) =
  let val ~TIMER _ = timer in end 

implement main0 (argc, argv) = {
  val timer = timer_new ()
  val () = timer_free (timer)
}