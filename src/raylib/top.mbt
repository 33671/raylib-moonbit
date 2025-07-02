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
} derive(Show, Eq)

///|
pub(all) struct Vector3 {
  mut x : Float
  mut y : Float
  mut z : Float
} derive(Show, Eq)

///|
pub fn Vector2::new(x : Float, y : Float) -> Vector2 {
  Vector2::{ x, y }
}

///|
pub fn Vector3::new(x : Float, y : Float, z : Float) -> Vector3 {
  Vector3::{ x, y, z }
}

///|
pub fn Vector3::to_array(self : Vector3) -> FixedArray[Float] {
  return [self.x, self.y, self.z]
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
#borrow(chars, color)
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
#borrow(pos, color)
extern "C" fn ffi_draw_circle_v(
  pos : FixedArray[Float],
  r : Float,
  color : FixedArray[Byte]
) = "ffi_draw_circle_v"

///|
pub fn draw_circle_v(pos : Vector2, radius : Float, color : Color) -> Unit {
  ffi_draw_circle_v(pos.to_array(), radius, color.to_rgba())
}

///|
#borrow(color)
extern "C" fn ffi_draw_circle(
  posX : Int,
  posY : Int,
  radius : Float,
  color : FixedArray[Byte]
) = "ffi_draw_circle"

///|
pub fn draw_circle(
  posX : Int,
  posY : Int,
  radius : Float,
  color : Color
) -> Unit {
  ffi_draw_circle(posX, posY, radius, color.to_rgba())
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
#borrow(pos)
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
extern "C" fn ffi_is_mouse_button_down(button : Int) -> Bool = "IsMouseButtonDown"

///|
pub fn is_mouse_button_pressed(button : MouseButton) -> Bool {
  ffi_is_mouse_button_pressed(button.to_int())
}

///|
pub fn is_mouse_button_down(button : MouseButton) -> Bool {
  ffi_is_mouse_button_down(button.to_int())
}

///|
#borrow(color)
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

///|
pub extern "C" fn get_mouse_wheel_move() -> Float = "GetMouseWheelMove"

///|
pub extern "C" fn get_random_value(min : Int, max : Int) -> Int = "GetRandomValue"

///|
type FFI_Camera2d

///|
#borrow(target, offset)
extern "C" fn make_camera2d(
  target : FixedArray[Float],
  offset : FixedArray[Float],
  ratation : Float,
  zoom : Float
) -> FFI_Camera2d = "ffi_make_camera2d"

///|
extern "C" fn ffi_begin_mode_2D(cam : FFI_Camera2d) = "ffi_begin_mode_2d"

///|
pub fn begin_mode_2d(cam : Camera2D) -> Unit {
  if cam.ffi_ptr is None {
    println("Camera2D not initialized, cannot begin mode 2D")
    panic()
  }
  let ffi_cam = cam.ffi_ptr.unwrap()
  ffi_begin_mode_2D(ffi_cam)
}

///|
pub extern "C" fn end_mode_2d() = "EndMode2D"

///|
#borrow(rec, color)
extern "C" fn ffi_draw_rectangle_rec(
  rec : FixedArray[Float],
  color : FixedArray[Byte]
) = "ffi_draw_rectangle_rec"

///|
pub fn draw_rectangle_rec(rec : Rectangle, color : Color) -> Unit {
  ffi_draw_rectangle_rec(rec.to_array(), color.to_rgba())
}

///|
#borrow(color)
extern "C" fn ffi_draw_line(
  x : Int,
  y : Int,
  endx : Int,
  endy : Int,
  color : FixedArray[Byte]
) = "ffi_draw_line"

///|
pub fn draw_line(
  x : Int,
  y : Int,
  endx : Int,
  endy : Int,
  color : Color
) -> Unit {
  ffi_draw_line(x, y, endx, endy, color.to_rgba())
}

///|
#borrow(color)
extern "C" fn ffi_draw_rectangle_lines(
  x : Int,
  y : Int,
  w : Int,
  h : Int,
  color : FixedArray[Byte]
) = "ffi_draw_rectangle_lines"

///|
pub fn draw_rectangle_lines(
  x : Int,
  y : Int,
  w : Int,
  h : Int,
  color : Color
) -> Unit {
  ffi_draw_rectangle_lines(x, y, w, h, color.to_rgba())
}

///|
extern "C" fn ffi_get_screen_to_world_2d(
  p : FixedArray[Float],
  cam : FFI_Camera2d
) -> FixedArray[Float] = "ffi_get_screen_to_world_2d"

///|
pub fn get_screen_to_world_2d(p : Vector2, cam : Camera2D) -> Vector2? {
  if cam.ffi_ptr is Some(ffi_ptr) {
    let arr = ffi_get_screen_to_world_2d(p.to_array(), ffi_ptr)
    return Some(Vector2::new(arr[0], arr[1]))
  }
  None
}

///|
extern "C" fn ffi_get_mouse_delta() -> FixedArray[Float] = "ffi_get_mouse_delta"

///|
pub fn get_mouse_delta() -> Vector2 {
  let arr = ffi_get_mouse_delta()
  return Vector2::new(arr[0], arr[1])
}
