///|
pub fn to_cstr(s : String) -> Bytes {
  let s = s.to_array()
  s.push('\u{0000}')
  return s.map(fn(c) { c.to_int().to_byte() }) |> Bytes::from_array
}

///|
// struct Color {
//   r : Byte
//   g : Byte
//   b : Byte
//   a : Byte
// }
pub extern type Color;

// type Color (Byte,Byte,Byte,Byte);
///|
// extern type Color;

///|
pub extern "C" fn make_color(c:FixedArray[Byte]) -> Color = "make_color"

///|
pub extern "C" fn ffi_init_window(width : Int, height : Int, char : Bytes) -> Unit = "InitWindow"

///|
pub extern "C" fn ffi_set_target_fps(fps : Int) -> Unit = "SetTargetFPS"

///|
pub extern "C" fn ffi_window_should_close() -> Bool = "WindowShouldClose"

///|
pub extern "C" fn ffi_begin_drawing() = "BeginDrawing"

///|
pub extern "C" fn ffi_clear_background(color:Color) = "ffi_clear_background"

///|
pub extern "C" fn ffi_draw_text(
  chars : Bytes,
  posX : Int,
  posY : Int,
  fontSize : Int,
  color : Color
) = "ffi_draw_text"

///|
pub extern "C" fn ffi_end_drawing() = "EndDrawing"


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
