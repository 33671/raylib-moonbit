///|
pub(all) struct Camera2D {
  mut target : Vector2
  mut offset : Vector2
  mut rotation : Float
  mut zoom : Float
  mut ffi_ptr : FFI_Camera2d?
}

///|
pub fn Camera2D::new(
  target : Vector2,
  offset : Vector2,
  rotation : Float,
  zoom : Float
) -> Camera2D {
  let ptr = make_camera2d(target.to_array(), offset.to_array(), rotation, zoom)
  return Camera2D::{ offset, target, rotation, zoom, ffi_ptr: Some(ptr) }
}
pub fn Camera2D::set_target(self : Camera2D, target : Vector2) -> Unit {
  self.target = target
  let ptr = make_camera2d(
    target.to_array(),
    self.offset.to_array(),
    self.rotation,
    self.zoom,
  )
  self.ffi_ptr = Some(ptr)
}
pub fn Camera2D::set_offset(self : Camera2D, offset : Vector2) -> Unit {
  self.offset = offset
  let ptr = make_camera2d(
    self.target.to_array(),
    offset.to_array(),
    self.rotation,
    self.zoom,
  )
  self.ffi_ptr = Some(ptr)
}
pub fn Camera2D::set_rotation(self : Camera2D, rotation : Float) -> Unit {
  self.rotation = rotation
  let ptr = make_camera2d(
    self.target.to_array(),
    self.offset.to_array(),
    rotation,
    self.zoom,
  )
  self.ffi_ptr = Some(ptr)
}
pub fn Camera2D::set_zoom(self : Camera2D, zoom : Float) -> Unit {
  self.zoom = zoom
  let ptr = make_camera2d(
    self.target.to_array(),
    self.offset.to_array(),
    self.rotation,
    zoom,
  )
  self.ffi_ptr = Some(ptr)
}