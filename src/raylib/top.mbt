///|
fn to_cstr(s : String) -> Bytes {
  let s = s.to_array()
  s.push('\u{0000}')
  s.map(fn(c) { c.to_int().to_byte() }) |> Bytes::from_array
}

///|
pub(all) struct Vector2 {
  mut x : Float
  mut y : Float
}

///|
pub fn Vector2::new(x : Float, y : Float) -> Vector2 {
  Vector2::{ x, y }
}

///|
pub fn Vector2::to_array(self : Vector2) -> FixedArray[Float] {
  return [self.x, self.y]
}

///|
#borrow(title)
pub extern "C" fn ffi_init_window(
  width : Int,
  height : Int,
  title : Bytes
) -> Unit = "InitWindow"

///|
pub fn init_window(width : Int, height : Int, title : String) -> Unit {
  ffi_init_window(width, height, to_cstr(title))
}

///|
pub extern "C" fn set_target_fps(fps : Int) -> Unit = "SetTargetFPS"

///|
pub extern "C" fn window_should_close() -> Bool = "WindowShouldClose"

///|
pub extern "C" fn begin_drawing() = "BeginDrawing"

///|
extern "C" fn ffi_clear_background(color : FixedArray[Byte]) = "ffi_clear_background"

///|
pub fn clear_background(color : Color) -> Unit {
  // let c = ffi_make_color(color.to_rgba())
  ffi_clear_background(color.to_rgba())
}

///|
#borrow(chars)
extern "C" fn ffi_draw_text(
  chars : Bytes,
  posX : Int,
  posY : Int,
  fontSize : Int,
  color : FixedArray[Byte]
) = "ffi_draw_text"

///|
pub fn draw_text(
  title : String,
  posX : Int,
  posY : Int,
  fontSize : Int,
  color : Color
) -> Unit {
  // let c = ffi_make_color(color.to_rgba())
  ffi_draw_text(to_cstr(title), posX, posY, fontSize, color.to_rgba())
}

///|
pub extern "C" fn end_drawing() = "EndDrawing"

///|
extern "C" fn ffi_draw_circle_v(
  pos : FixedArray[Float],
  r : Float,
  color : FixedArray[Byte]
) = "ffi_draw_circle_v"

///|
pub fn draw_circle_v(pos : Vector2, radius : Float, color : Color) -> Unit {
  // let v = ffi_make_vector2([pos.x, pos.y])
  // let c = ffi_make_color(color.to_rgba())
  ffi_draw_circle_v(pos.to_array(), radius, color.to_rgba())
}

///|
pub extern "C" fn close_window() = "CloseWindow"

///|
extern "C" fn ffi_is_key_down(keycode : Int) -> Bool = "IsKeyDown"

///|
pub fn is_key_down(key : KeyboardKey) -> Bool {
  ffi_is_key_down(key.to_keycode())
}

///|
extern "C" fn ffi_is_key_pressed(keycode : Int) -> Bool = "IsKeyPressed"

///|
pub fn is_key_pressed(key : KeyboardKey) -> Bool {
  ffi_is_key_pressed(key.to_keycode())
}

///|
pub extern "C" fn hide_cursor() = "HideCursor"

///|
pub extern "C" fn show_cursor() = "ShowCursor"

///|
extern "C" fn ffi_get_mouse_position(pos : FixedArray[Float]) = "ffi_get_mouse_position"

///|
pub fn get_mouse_position() -> Vector2 {
  let pos : FixedArray[Float] = FixedArray::make(2, 0.0)
  ffi_get_mouse_position(pos)
  Vector2::new(pos[0], pos[1])
}

///|
extern "C" fn ffi_is_mouse_button_pressed(button : Int) -> Bool = "IsMouseButtonPressed"

///|
pub fn is_mouse_button_pressed(button : MouseButton) -> Bool {
  ffi_is_mouse_button_pressed(button.to_int())
}

///|
extern "C" fn ffi_draw_rectangle(
  x : Int,
  y : Int,
  width : Int,
  height : Int,
  color : FixedArray[Byte]
) = "ffi_draw_rectangle"

///|
pub fn draw_rectangle(
  x : Int,
  y : Int,
  width : Int,
  height : Int,
  color : Color
) -> Unit {
  ffi_draw_rectangle(x, y, width, height, color.to_rgba())
}
pub extern "C" fn get_mouse_wheel_move() -> Float= "GetMouseWheelMove"