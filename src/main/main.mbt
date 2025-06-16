///|
fn main {
}

///|
test "mouse_input" {
  let screen_width : Int = 800
  let screen_height : Int = 450
  @rl.init_window(
    screen_width, screen_height, "raylib [core] example - mouse input",
  )
  let mut ball_position = @rl.Vector2::new(-100, 100)
  let mut ballColor = @rl.Color::DarkBlue
  let mut is_CursorHidden = false
  @rl.set_target_fps(60)
  while not(@rl.window_should_close()) {
    if @rl.is_key_down(H) {
      if is_CursorHidden {
        @rl.hide_cursor()
        is_CursorHidden = false
      } else {
        @rl.show_cursor()
        is_CursorHidden = true
      }
    }
    ball_position = @rl.get_mouse_position()
    ball_position = @rl.get_mouse_position()
    if @rl.is_mouse_button_pressed(Left) {
      ballColor = Maroon
    } else if @rl.is_mouse_button_pressed(Middle) {
      ballColor = Lime
    } else if @rl.is_mouse_button_pressed(Right) {
      ballColor = DarkBlue
    } else if @rl.is_mouse_button_pressed(Side) {
      ballColor = Purple
    } else if @rl.is_mouse_button_pressed(Extra) {
      ballColor = Yellow
    } else if @rl.is_mouse_button_pressed(Forward) {
      ballColor = Orange
    } else if @rl.is_mouse_button_pressed(Back) {
      ballColor = Beige
    }
    @rl.begin_drawing()
    @rl.clear_background(RayWhite)
    @rl.draw_circle_v(ball_position, 40, ballColor)
    @rl.draw_text(
      "move ball with mouse and click mouse button to change color",
      10,
      10,
      20,
      DarkGray,
    )
    @rl.draw_text("Press 'H' to toggle cursor visibility", 10, 30, 20, DarkGray)
    if is_CursorHidden {
      @rl.draw_text("CURSOR HIDDEN", 20, 60, 20, Red)
    } else {
      @rl.draw_text("CURSOR VISIBLE", 20, 60, 20, Lime)
    }
    @rl.end_drawing()
  }
}
test "mouse_wheel"{
  let screen_width : Int = 800
  let screen_height : Int = 450
  @rl.init_window(
    screen_width, screen_height, "raylib [core] example - mouse input",
  )
  let ball_position = @rl.Vector2::new(screen_width.to_float()/2 - 40, screen_height.to_float()/2 - 40)
  let scroll_speed = 4;
   @rl.set_target_fps(60)
  while not(@rl.window_should_close()) {
    ball_position.y -= @rl.get_mouse_wheel_move() * scroll_speed.to_float();
    @rl.begin_drawing()
    @rl.clear_background(RayWhite)
    @rl.draw_rectangle(ball_position.x.to_int(),ball_position.y.to_int(),80,80,Maroon);
    @rl.draw_text("Use mouse wheel to move the cube up and down!", 10, 10, 20, Gray)
    @rl.draw_text(ball_position.y.to_string(), 10, 40, 20, LightGray)
    @rl.end_drawing()
  }
  @rl.close_window()
}