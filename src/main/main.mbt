///|
// fn main {

// }

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

///|
test "mouse_input" {
  let screen_width : Int = 800
  let screen_height : Int = 450
  @rl.init_window(
    screen_width, screen_height, "raylib [core] example - mouse input",
  )
  let ball_position = @rl.Vector2::new(
    screen_width.to_float() / 2 - 40,
    screen_height.to_float() / 2 - 40,
  )
  let scroll_speed = 0.1
  @rl.set_target_fps(60)
  let target = @rl.Vector2::new(250, 250)
  let off = @rl.Vector2::new(400, 250)
  let cam = @rl.Camera2D::new(target, off, 0, 1)
  // let mut previous_mouse_position = @rl.get_mouse_position()
  while not(@rl.window_should_close()) {
    let mousewheel_move = @rl.get_mouse_wheel_move()
    println("Mouse wheel move: \{mousewheel_move}")
    if mousewheel_move != 0 {
      println("Mouse wheel moved: \{mousewheel_move}")
      let mouse_world_position = @rl.get_screen_to_world_2d(
        @rl.get_mouse_position(),
        cam,
      ).unwrap()
      println("Mouse world position: \{mouse_world_position}")
      cam.set_zoom(cam.zoom + mousewheel_move * scroll_speed.to_float())
      if cam.zoom < 0.1 {
        cam.set_zoom(0.1)
      }
      if cam.zoom > 3.0 {
        cam.set_zoom(3.0)
      }
      cam.set_target(mouse_world_position)
      cam.set_offset(@rl.get_mouse_position())
    }
    // let current_mouse_position = @rl.get_mouse_position()
    // let mouse_delta = @rl.vector_substruct(
    //   previous_mouse_position,current_mouse_position
    // )
    // previous_mouse_position = current_mouse_position
    if @rl.is_mouse_button_down(@rl.MouseButton::Left) {
      let mut delta = @rl.get_mouse_delta();
      delta = @rl.vector2_scale(delta, -1.0/cam.zoom)
      cam.set_target(@rl.vector2_add(cam.target, delta))
    }
    @rl.begin_drawing()
    @rl.clear_background(RayWhite)
    @rl.begin_mode_2d(cam)
    // let grid_size = 5000;
    // for i = -grid_size;i <= grid_size;i = i + 50 {
    //   @rl.draw_line(i, -grid_size, i, grid_size, LightGray)
    //   @rl.draw_line(-grid_size, i, grid_size, i, LightGray)
    // }
    // // draw axis
    // @rl.draw_line(-grid_size, 0, grid_size, 0, Red)
    // @rl.draw_line(0, -grid_size, 0, grid_size, Green)

    @rl.draw_rectangle(
      ball_position.x.to_int(),
      ball_position.y.to_int(),
      80,
      80,
      @rl.Color::DarkBlue,
    )
    @rl.end_mode_2d()
    @rl.draw_text("Scroll mouse wheel to zoom in/out", 10, 10, 20, DarkGray)
    @rl.draw_text(
      "Drag with left mouse button to move camera",
      10,
      30,
      20,
      DarkGray,
    )
    @rl.end_drawing()
  }
  @rl.close_window()
}
fn main {


}