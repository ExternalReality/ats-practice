%{^
#include "SDL2/SDL.h"
%}

#include "share/atspre_staload.hats"

macdef SDL_INIT_VIDEO = $extval (uint, "SDL_INIT_VIDEO")
macdef SDL_WINDOWPOS_UNDEFINED = $extval (int, "SDL_WINDOWPOS_UNDEFINED")
macdef SDL_WINDOW_SHOWN = $extval (uint, "SDL_WINDOW_SHOWN")
macdef SDL_RENDERER_ACCELERATED = $extval (uint, "SDL_RENDERER_ACCELERATED")

extern fun sdl_init: uint -> int = "mac#SDL_Init"
extern fun sdl_create_window: (string, int, int, int, int, uint) -> [l:addr] ptr(l) ="mac#SDL_CreateWindow"
extern fun sdl_destroy_window: {l:addr | l != null} ptr(l) -> void ="mac#SDL_DestroyWindow"
extern fun sdl_delay: {a: int | a < 10000} uint(a) -> void ="mac#SDL_Delay"
extern fun sdl_get_window_surface: {l:addr} ptr(l) -> [l:addr] ptr(l) = "mac#SDL_GetWindowSurface"
extern fun sdl_create_renderer: {n:int | n >= ~1}{l:addr} (ptr(l), int(n), uint) -> [l:addr] ptr(l) = "mac#SDL_CreateRenderer"
extern fun sdl_set_render_draw_color: {l:addr} (ptr(l), uint, uint, uint, uint) -> [r:int | r <= 0] int(r) = "mac#SDL_SetRenderDrawColor"
extern fun sdl_render_clear: {l:addr} ptr(l) -> [r:int | r <= 0] int(r) = "mac#SDL_RenderClear"
extern fun sdl_render_present: {l:addr} ptr(l) -> void = "mac#SDL_RenderPresent"
extern fun sdl_quit: () -> void = "mac#SDL_Quit"

implement main0 (argc, argv) = {
  val () = if (sdl_init (SDL_INIT_VIDEO) != 0)
    then prerrln! "\nUnable to initialize SDL\n"
    else {
      val window = sdl_create_window("Window", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_SHOWN)
      val () = assert_errmsg (window != 0, "\nUnable to create window\n")
      val screen = sdl_get_window_surface(window)
      val () = assert_errmsg (screen != 0, "\nUnable to get screen handle\n")
      val renderer = sdl_create_renderer(window, ~1, SDL_RENDERER_ACCELERATED)
      val () = assert_errmsg (renderer = 0, "\nUnable to get renderer handle\n")
      val res = sdl_set_render_draw_color(renderer, 255u, 0u, 0u, 255u)
      val () = assert_errmsg (res != 0, "\nUnable set background color\n")
      val _ = sdl_render_clear(renderer)
      val _ = sdl_render_present(renderer)
      val () = sdl_delay(5000u)
      val () = sdl_destroy_window(window)
      val () = sdl_quit()
    }
}
