# Moonbit Binding for Raylib (WIP)

### example:

```Moonbit
test {
  ffi_init_window(500, 500, to_cstr("Hello"))
  ffi_set_target_fps(30)
  while not(ffi_window_should_close()) {
    ffi_begin_drawing()
    ffi_clear_background(make_color([0,0,255,255]));
    ffi_draw_text(to_cstr("RAYLIB & MOONBIT"),10,10,40,make_color([255,255,255,255]));
    ffi_end_drawing()
  }
}
```
