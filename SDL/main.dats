%{^
#include "SDL2/SDL.h"
%}

#include "share/atspre_staload.hats"

macdef SDL_INIT_VIDEO = $extval (uint, "SDL_INIT_VIDEO")
macdef SDL_WINDOWPOS_UNDEFINED = $extval (int, "SDL_WINDOWPOS_UNDEFINED")
macdef SDL_WINDOW_SHOWN = $extval (uint, "SDL_WINDOW_SHOWN")

extern fun sdl_init: uint -> int = "mac#SDL_Init"
extern fun sdl_create_window: (string, int, int, int, int, uint) -> [l:addr] ptr(l) ="mac#SDL_CreateWindow"
extern fun sdl_destroy_window: {l:addr | l != null} ptr(l) -> void ="mac#SDL_DestroyWindow"
extern fun sdl_delay: {a: int | a < 5000} uint(a) -> void ="mac#SDL_Delay"
extern fun sdl_get_window_surface: {l:addr} ptr(l) -> [l:addr] ptr(l) = "mac#SDL_GetWindowSurface" 

implement main0 (argc, argv) = {
  val () = if (sdl_init (SDL_INIT_VIDEO) != 0)
    then prerrln! "\nUnable to initialize SDL:  %s\n"
    else {
      val window = sdl_create_window("Window", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_SHOWN)
      val () = assert_errmsg (window != 0, "\nUnable to create window:  %s\n")
      val () = sdl_delay(3000u)
      val () = sdl_destroy_window(window)
    }          
}
