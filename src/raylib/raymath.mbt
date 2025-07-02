pub fn vector_substruct(
  v1 : Vector2,
  v2 : Vector2
) -> Vector2 {
  return Vector2::new(v1.x - v2.x, v1.y - v2.y)
}
pub fn vector_add(
  v1 : Vector2,
  v2 : Vector2
) -> Vector2 {
  return Vector2::new(v1.x + v2.x, v1.y + v2.y)
}
pub fn vector_scale(
  v : Vector2,
  scale : Float
) -> Vector2 {
  return Vector2::new(v.x * scale, v.y * scale)
}