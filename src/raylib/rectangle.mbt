///|
pub(all) struct Rectangle {
  x : Float
  y : Float
  width : Float
  height : Float
}

///|
pub fn Rectangle::to_array(self : Rectangle) -> FixedArray[Float] {
  return [self.x, self.y, self.width, self.height]
}
