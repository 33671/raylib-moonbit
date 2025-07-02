///|
pub(all) struct Matrix {
  // First Row: 0 4 8 12
  // Second Row: 1 5 9 13
  // Third Row: 2 6 10 14
  // Fourth Row: 3 7 11 15 
  mut m0 : Float
  mut m1 : Float
  mut m2 : Float
  mut m3 : Float
  mut m4 : Float
  mut m5 : Float
  mut m6 : Float
  mut m7 : Float
  mut m8 : Float
  mut m9 : Float
  mut m10 : Float
  mut m11 : Float
  mut m12 : Float
  mut m13 : Float
  mut m14 : Float
  mut m15 : Float
}

///|
pub(all) struct Vector4 {
  x : Float
  y : Float
  z : Float
  w : Float
}

///|
pub typealias Vector4 as Quaternion

///|
pub fn Vector4::new(x : Float, y : Float, z : Float, w : Float) -> Vector4 {
  Vector4::{ x, y, z, w }
}

///|
pub fn vector2_substruct(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(v1.x - v2.x, v1.y - v2.y)
}

///|
pub fn vector2_add(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(v1.x + v2.x, v1.y + v2.y)
}

///|
pub fn vector2_scale(v : Vector2, scale : Float) -> Vector2 {
  return Vector2::new(v.x * scale, v.y * scale)
}

///|
pub fn vector2_lerp(v1 : Vector2, v2 : Vector2, a : Float) -> Vector2 {
  let result = Vector2::new(0, 0)
  result.x = v1.x + a * (v2.x - v1.x)
  result.y = v1.y + a * (v2.y - v1.y)
  return result
}

///|
pub fn vector2_length(v : Vector2) -> Float {
  return (v.x * v.x + v.y * v.y).sqrt()
}

///|
pub fn vector2_length_sqr(v : Vector2) -> Float {
  return v.x * v.x + v.y * v.y
}

///|
pub fn vector2_dot(v1 : Vector2, v2 : Vector2) -> Float {
  return v1.x * v2.x + v1.y * v2.y
}

///|
pub fn vector2_distance(v1 : Vector2, v2 : Vector2) -> Float {
  let dx = v1.x - v2.x
  let dy = v1.y - v2.y
  return (dx * dx + dy * dy).sqrt()
}

///|
pub fn vector2_distance_sqr(v1 : Vector2, v2 : Vector2) -> Float {
  let dx = v1.x - v2.x
  let dy = v1.y - v2.y
  return dx * dx + dy * dy
}

///|
pub fn vector2_angle(v1 : Vector2, v2 : Vector2) -> Float {
  let dot = v1.x * v2.x + v1.y * v2.y
  let det = v1.x * v2.y - v1.y * v2.x
  return det.atan2(dot)
}

///|
pub fn vector2_line_angle(start : Vector2, end : Vector2) -> Float {
  return -(end.y - start.y).atan2(end.x - start.x)
}

///|
pub fn vector2_multiply(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(v1.x * v2.x, v1.y * v2.y)
}

///|
pub fn vector2_negate(v : Vector2) -> Vector2 {
  return Vector2::new(-v.x, -v.y)
}

///|
pub fn vector2_divide(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(v1.x / v2.x, v1.y / v2.y)
}

///|
pub fn vector2_normalize(v : Vector2) -> Vector2 {
  let length = (v.x * v.x + v.y * v.y).sqrt()
  if length > 0 {
    let inv = 1.0 / length.to_double()
    return Vector2::new(v.x * inv.to_float(), v.y * inv.to_float())
  }
  return Vector2::new(0, 0)
}

///|
pub fn vector2_reflect(v : Vector2, normal : Vector2) -> Vector2 {
  let dot = v.x * normal.x + v.y * normal.y
  return Vector2::new(v.x - 2.0 * normal.x * dot, v.y - 2.0 * normal.y * dot)
}

///|
pub fn vector2_min(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(@math.minimum(v1.x, v2.x), @math.minimum(v1.y, v2.y))
}

///|
pub fn vector2_max(v1 : Vector2, v2 : Vector2) -> Vector2 {
  return Vector2::new(@math.maximum(v1.x, v2.x), @math.maximum(v1.y, v2.y))
}

///|
pub fn vector2_rotate(v : Vector2, angle : Float) -> Vector2 {
  let cos_a = angle.cos()
  let sin_a = angle.sin()
  return Vector2::new(v.x * cos_a - v.y * sin_a, v.x * sin_a + v.y * cos_a)
}

///|
pub fn vector2_move_towards(
  v : Vector2,
  target : Vector2,
  max_distance : Float
) -> Vector2 {
  let dx = target.x - v.x
  let dy = target.y - v.y
  let dist_sqr = dx * dx + dy * dy
  if dist_sqr == 0 || dist_sqr <= max_distance * max_distance {
    return target
  }
  let dist = dist_sqr.sqrt()
  return Vector2::new(
    v.x + dx / dist * max_distance,
    v.y + dy / dist * max_distance,
  )
}

///|
pub fn vector2_invert(v : Vector2) -> Vector2 {
  return Vector2::new(1.0 / v.x, 1.0 / v.y)
}

///|
pub fn vector2_clamp(v : Vector2, min_v : Vector2, max_v : Vector2) -> Vector2 {
  return Vector2::new(
    @math.minimum(max_v.x, @math.maximum(min_v.x, v.x)),
    @math.minimum(max_v.y, @math.maximum(min_v.y, v.y)),
  )
}

///|
pub fn vector2_clamp_value(
  v : Vector2,
  min_len : Float,
  max_len : Float
) -> Vector2 {
  let len_sqr = v.x * v.x + v.y * v.y
  if len_sqr > 0 {
    let len = len_sqr.sqrt()
    let scale = if len < min_len {
      min_len / len
    } else if len > max_len {
      max_len / len
    } else {
      1.0
    }
    return Vector2::new(v.x * scale, v.y * scale)
  }
  return v
}

///|
pub fn vector2_equals(p : Vector2, q : Vector2) -> Bool {
  let eps = 0.000001
  let equal_x = (p.x - q.x).abs() <=
    eps.to_float() * @math.maximum(1.0, @math.maximum(p.x.abs(), q.x.abs()))
  let equal_y = (p.y - q.y).abs() <=
    eps.to_float() * @math.maximum(1.0, @math.maximum(p.y.abs(), q.y.abs()))
  return equal_x && equal_y
}

///|
pub fn vector2_refract(v : Vector2, n : Vector2, r : Float) -> Vector2 {
  let dot = v.x * n.x + v.y * n.y
  let d : Float = 1.0 - r * r * (1.0 - dot * dot)
  if d >= 0 {
    let sqrt_d = d.sqrt()
    let x = r * v.x - (r * dot + sqrt_d) * n.x
    let y = r * v.y - (r * dot + sqrt_d) * n.y
    return Vector2::new(x, y)
  }
  return Vector2::new(0, 0)
}

///| Creates a Vector3 with all components set to 0.0
pub fn vector3_zero() -> Vector3 {
  return Vector3::new(0.0, 0.0, 0.0)
}

///| Creates a Vector3 with all components set to 1.0
pub fn vector3_one() -> Vector3 {
  return Vector3::new(1.0, 1.0, 1.0)
}

///| Adds two Vector3s
pub fn vector3_add(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
}

///| Adds a scalar value to a Vector3
pub fn vector3_add_value(v : Vector3, add : Float) -> Vector3 {
  return Vector3::new(v.x + add, v.y + add, v.z + add)
}

///| Subtracts two Vector3s
pub fn vector3_subtract(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
}

///| Subtracts a scalar value from a Vector3
pub fn vector3_subtract_value(v : Vector3, sub : Float) -> Vector3 {
  return Vector3::new(v.x - sub, v.y - sub, v.z - sub)
}

///| Scales a Vector3 by a scalar
pub fn vector3_scale(v : Vector3, scale : Float) -> Vector3 {
  return Vector3::new(v.x * scale, v.y * scale, v.z * scale)
}

///| Multiplies two Vector3s component-wise
pub fn vector3_multiply(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)
}

///| Calculates the cross product of two Vector3s
pub fn vector3_cross_product(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(
    v1.y * v2.z - v1.z * v2.y,
    v1.z * v2.x - v1.x * v2.z,
    v1.x * v2.y - v1.y * v2.x,
  )
}

///| Calculates a perpendicular vector to the given Vector3
pub fn vector3_perpendicular(v : Vector3) -> Vector3 {
  let min = v.x.abs()
  let mut cardinal_axis = Vector3::new(1.0, 0.0, 0.0)
  if v.y.abs() < min {
    cardinal_axis = Vector3::new(0.0, 1.0, 0.0)
  }
  if v.z.abs() < min {
    cardinal_axis = Vector3::new(0.0, 0.0, 1.0)
  }
  return Vector3::new(
    v.y * cardinal_axis.z - v.z * cardinal_axis.y,
    v.z * cardinal_axis.x - v.x * cardinal_axis.z,
    v.x * cardinal_axis.y - v.y * cardinal_axis.x,
  )
}

///| Calculates the length of a Vector3
pub fn vector3_length(v : Vector3) -> Float {
  return (v.x * v.x + v.y * v.y + v.z * v.z).sqrt()
}

///| Calculates the squared length of a Vector3
pub fn vector3_length_sqr(v : Vector3) -> Float {
  return v.x * v.x + v.y * v.y + v.z * v.z
}

///| Calculates the dot product of two Vector3s
pub fn vector3_dot_product(v1 : Vector3, v2 : Vector3) -> Float {
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
}

///| Calculates the distance between two Vector3s
pub fn vector3_distance(v1 : Vector3, v2 : Vector3) -> Float {
  let dx = v2.x - v1.x
  let dy = v2.y - v1.y
  let dz = v2.z - v1.z
  return (dx * dx + dy * dy + dz * dz).sqrt()
}

///| Calculates the squared distance between two Vector3s
pub fn vector3_distance_sqr(v1 : Vector3, v2 : Vector3) -> Float {
  let dx = v2.x - v1.x
  let dy = v2.y - v1.y
  let dz = v2.z - v1.z
  return dx * dx + dy * dy + dz * dz
}

///| Calculates the angle between two Vector3s
pub fn vector3_angle(v1 : Vector3, v2 : Vector3) -> Float {
  let cross = vector3_cross_product(v1, v2)
  let len = vector3_length(cross)
  let dot = vector3_dot_product(v1, v2)
  return len.atan2(dot)
}

///| Negates a Vector3
pub fn vector3_negate(v : Vector3) -> Vector3 {
  return Vector3::new(-v.x, -v.y, -v.z)
}

///| Divides two Vector3s component-wise
pub fn vector3_divide(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z)
}

///| Normalizes a Vector3
pub fn vector3_normalize(v : Vector3) -> Vector3 {
  let length = vector3_length(v)
  if length > 0.0 {
    let inv = 1.0 / length.to_double()
    return Vector3::new(
      v.x * inv.to_float(),
      v.y * inv.to_float(),
      v.z * inv.to_float(),
    )
  }
  return Vector3::new(0.0, 0.0, 0.0)
}

///| Calculates the projection of v1 onto v2
pub fn vector3_project(v1 : Vector3, v2 : Vector3) -> Vector3 {
  let v1dv2 = vector3_dot_product(v1, v2)
  let v2dv2 = vector3_dot_product(v2, v2)
  let mag = v1dv2 / v2dv2
  return Vector3::new(v2.x * mag, v2.y * mag, v2.z * mag)
}

///| Calculates the rejection of v1 from v2
pub fn vector3_reject(v1 : Vector3, v2 : Vector3) -> Vector3 {
  let v1dv2 = vector3_dot_product(v1, v2)
  let v2dv2 = vector3_dot_product(v2, v2)
  let mag = v1dv2 / v2dv2
  return Vector3::new(v1.x - v2.x * mag, v1.y - v2.y * mag, v1.z - v2.z * mag)
}

///| Orthonormalizes two Vector3s
pub fn vector3_ortho_normalize(
  v1 : Vector3,
  v2 : Vector3
) -> (Vector3, Vector3) {
  let length = vector3_length(v1)
  let ilength : Float = if length == 0.0 { 1.0 } else { 1.0 / length }
  let norm_v1 = Vector3::new(v1.x * ilength, v1.y * ilength, v1.z * ilength)
  let vn1 = vector3_cross_product(norm_v1, v2)
  let length_vn1 = vector3_length(vn1)
  let ilength_vn1 : Float = if length_vn1 == 0.0 {
    1.0
  } else {
    1.0 / length_vn1
  }
  let norm_vn1 = Vector3::new(
    vn1.x * ilength_vn1,
    vn1.y * ilength_vn1,
    vn1.z * ilength_vn1,
  )
  let norm_v2 = vector3_cross_product(norm_vn1, norm_v1)
  return (norm_v1, norm_v2)
}

///| Reflects a Vector3 over a normal
pub fn vector3_reflect(v : Vector3, normal : Vector3) -> Vector3 {
  let dot = vector3_dot_product(v, normal)
  return Vector3::new(
    v.x - 2.0 * normal.x * dot,
    v.y - 2.0 * normal.y * dot,
    v.z - 2.0 * normal.z * dot,
  )
}

///| Gets the minimum components of two Vector3s
pub fn vector3_min(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(
    @math.minimum(v1.x, v2.x),
    @math.minimum(v1.y, v2.y),
    @math.minimum(v1.z, v2.z),
  )
}

///| Gets the maximum components of two Vector3s
pub fn vector3_max(v1 : Vector3, v2 : Vector3) -> Vector3 {
  return Vector3::new(
    @math.maximum(v1.x, v2.x),
    @math.maximum(v1.y, v2.y),
    @math.maximum(v1.z, v2.z),
  )
}

///| Moves a Vector3 towards a target with a maximum distance
pub fn vector3_move_towards(
  v : Vector3,
  target : Vector3,
  max_distance : Float
) -> Vector3 {
  let dx = target.x - v.x
  let dy = target.y - v.y
  let dz = target.z - v.z
  let dist_sqr = dx * dx + dy * dy + dz * dz
  if dist_sqr == 0.0 ||
    (max_distance >= 0.0 && dist_sqr <= max_distance * max_distance) {
    return target
  }
  let dist = dist_sqr.sqrt()
  return Vector3::new(
    v.x + dx / dist * max_distance,
    v.y + dy / dist * max_distance,
    v.z + dz / dist * max_distance,
  )
}

///| Linearly interpolates between two Vector3s
pub fn vector3_lerp(v1 : Vector3, v2 : Vector3, amount : Float) -> Vector3 {
  return Vector3::new(
    v1.x + amount * (v2.x - v1.x),
    v1.y + amount * (v2.y - v1.y),
    v1.z + amount * (v2.z - v1.z),
  )
}

///| Inverts a Vector3 component-wise
pub fn vector3_invert(v : Vector3) -> Vector3 {
  return Vector3::new(1.0 / v.x, 1.0 / v.y, 1.0 / v.z)
}

///| Clamps a Vector3 between min and max vectors
pub fn vector3_clamp(v : Vector3, min_v : Vector3, max_v : Vector3) -> Vector3 {
  return Vector3::new(
    @math.minimum(max_v.x, @math.maximum(min_v.x, v.x)),
    @math.minimum(max_v.y, @math.maximum(min_v.y, v.y)),
    @math.minimum(max_v.z, @math.maximum(min_v.z, v.z)),
  )
}

///| Clamps the magnitude of a Vector3 between two values
pub fn vector3_clamp_value(
  v : Vector3,
  min_len : Float,
  max_len : Float
) -> Vector3 {
  let len_sqr = vector3_length_sqr(v)
  if len_sqr > 0.0 {
    let len = len_sqr.sqrt()
    let scale = if len < min_len {
      min_len / len
    } else if len > max_len {
      max_len / len
    } else {
      1.0
    }
    return Vector3::new(v.x * scale, v.y * scale, v.z * scale)
  }
  return v
}

///| Checks if two Vector3s are approximately equal
pub fn vector3_equals(p : Vector3, q : Vector3) -> Bool {
  let eps = 0.000001
  let equal_x = (p.x - q.x).abs() <=
    eps.to_float() * @math.maximum(1.0, @math.maximum(p.x.abs(), q.x.abs()))
  let equal_y = (p.y - q.y).abs() <=
    eps.to_float() * @math.maximum(1.0, @math.maximum(p.y.abs(), q.y.abs()))
  let equal_z = (p.z - q.z).abs() <=
    eps.to_float() * @math.maximum(1.0, @math.maximum(p.z.abs(), q.z.abs()))
  return equal_x && equal_y && equal_z
}

///| Computes the direction of a refracted ray
pub fn vector3_refract(v : Vector3, n : Vector3, r : Float) -> Vector3 {
  let dot = vector3_dot_product(v, n)
  let d : Float = 1.0 - r * r * (1.0 - dot * dot)
  if d >= 0.0 {
    let sqrt_d = d.sqrt()
    return Vector3::new(
      r * v.x - (r * dot + sqrt_d) * n.x,
      r * v.y - (r * dot + sqrt_d) * n.y,
      r * v.z - (r * dot + sqrt_d) * n.z,
    )
  }
  return Vector3::new(0.0, 0.0, 0.0)
}

///| Transforms a Vector3 by a given Matrix
pub fn vector3_transform(v : Vector3, mat : Matrix) -> Vector3 {
  let x = v.x
  let y = v.y
  let z = v.z
  return Vector3::new(
    mat.m0 * x + mat.m4 * y + mat.m8 * z + mat.m12,
    mat.m1 * x + mat.m5 * y + mat.m9 * z + mat.m13,
    mat.m2 * x + mat.m6 * y + mat.m10 * z + mat.m14,
  )
}

///| Rotates a Vector3 by a Quaternion
pub fn vector3_rotate_by_quaternion(v : Vector3, q : Quaternion) -> Vector3 {
  return Vector3::new(
    v.x * (q.x * q.x + q.w * q.w - q.y * q.y - q.z * q.z) +
    v.y * (2.0 * q.x * q.y - 2.0 * q.w * q.z) +
    v.z * (2.0 * q.x * q.z + 2.0 * q.w * q.y),
    v.x * (2.0 * q.w * q.z + 2.0 * q.x * q.y) +
    v.y * (q.w * q.w - q.x * q.x + q.y * q.y - q.z * q.z) +
    v.z * (-2.0 * q.w * q.x + 2.0 * q.y * q.z),
    v.x * (-2.0 * q.w * q.y + 2.0 * q.x * q.z) +
    v.y * (2.0 * q.w * q.x + 2.0 * q.y * q.z) +
    v.z * (q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z),
  )
}

///| Rotates a Vector3 around an axis by an angle
pub fn vector3_rotate_by_axis_angle(
  v : Vector3,
  axis : Vector3,
  angle : Float
) -> Vector3 {
  let length = vector3_length(axis)
  let ilength : Float = if length == 0.0 { 1.0 } else { 1.0 / length }
  let norm_axis = Vector3::new(
    axis.x * ilength,
    axis.y * ilength,
    axis.z * ilength,
  )
  let half_angle = angle / 2.0
  let a = half_angle.cos()
  let b = norm_axis.x * half_angle.sin()
  let c = norm_axis.y * half_angle.sin()
  let d = norm_axis.z * half_angle.sin()
  let w = Vector3::new(b, c, d)
  let wv = vector3_cross_product(w, v)
  let wwv = vector3_cross_product(w, wv)
  let wv_scaled = vector3_scale(wv, 2.0 * a)
  let wwv_scaled = vector3_scale(wwv, 2.0)
  return Vector3::new(
    v.x + wv_scaled.x + wwv_scaled.x,
    v.y + wv_scaled.y + wwv_scaled.y,
    v.z + wv_scaled.z + wwv_scaled.z,
  )
}

///| Performs cubic Hermite interpolation between two Vector3s
pub fn vector3_cubic_hermite(
  v1 : Vector3,
  tangent1 : Vector3,
  v2 : Vector3,
  tangent2 : Vector3,
  amount : Float
) -> Vector3 {
  let amount_pow2 = amount * amount
  let amount_pow3 = amount * amount * amount
  return Vector3::new(
    (2.0 * amount_pow3 - 3.0 * amount_pow2 + 1.0) * v1.x +
    (amount_pow3 - 2.0 * amount_pow2 + amount) * tangent1.x +
    (-2.0 * amount_pow3 + 3.0 * amount_pow2) * v2.x +
    (amount_pow3 - amount_pow2) * tangent2.x,
    (2.0 * amount_pow3 - 3.0 * amount_pow2 + 1.0) * v1.y +
    (amount_pow3 - 2.0 * amount_pow2 + amount) * tangent1.y +
    (-2.0 * amount_pow3 + 3.0 * amount_pow2) * v2.y +
    (amount_pow3 - amount_pow2) * tangent2.y,
    (2.0 * amount_pow3 - 3.0 * amount_pow2 + 1.0) * v1.z +
    (amount_pow3 - 2.0 * amount_pow2 + amount) * tangent1.z +
    (-2.0 * amount_pow3 + 3.0 * amount_pow2) * v2.z +
    (amount_pow3 - amount_pow2) * tangent2.z,
  )
}

///| Computes barycenter coordinates for a point with respect to a triangle
pub fn vector3_barycenter(
  p : Vector3,
  a : Vector3,
  b : Vector3,
  c : Vector3
) -> Vector3 {
  let v0 = vector3_subtract(b, a)
  let v1 = vector3_subtract(c, a)
  let v2 = vector3_subtract(p, a)
  let d00 = vector3_dot_product(v0, v0)
  let d01 = vector3_dot_product(v0, v1)
  let d11 = vector3_dot_product(v1, v1)
  let d20 = vector3_dot_product(v2, v0)
  let d21 = vector3_dot_product(v2, v1)
  let denom = d00 * d11 - d01 * d01
  let v = (d11 * d20 - d01 * d21) / denom
  let w = (d00 * d21 - d01 * d20) / denom
  let u : Float = 1.0 - (w + v)
  return Vector3::new(u, v, w)
}

///| Projects a Vector3 from screen space to object space
pub fn vector3_unproject(
  source : Vector3,
  projection : Matrix,
  view : Matrix
) -> Vector3 {
  // Calculate view-projection matrix
  let mat_view_proj = Matrix::{
    m0: view.m0 * projection.m0 +
    view.m1 * projection.m4 +
    view.m2 * projection.m8 +
    view.m3 * projection.m12,
    m1: view.m0 * projection.m1 +
    view.m1 * projection.m5 +
    view.m2 * projection.m9 +
    view.m3 * projection.m13,
    m2: view.m0 * projection.m2 +
    view.m1 * projection.m6 +
    view.m2 * projection.m10 +
    view.m3 * projection.m14,
    m3: view.m0 * projection.m3 +
    view.m1 * projection.m7 +
    view.m2 * projection.m11 +
    view.m3 * projection.m15,
    m4: view.m4 * projection.m0 +
    view.m5 * projection.m4 +
    view.m6 * projection.m8 +
    view.m7 * projection.m12,
    m5: view.m4 * projection.m1 +
    view.m5 * projection.m5 +
    view.m6 * projection.m9 +
    view.m7 * projection.m13,
    m6: view.m4 * projection.m2 +
    view.m5 * projection.m6 +
    view.m6 * projection.m10 +
    view.m7 * projection.m14,
    m7: view.m4 * projection.m3 +
    view.m5 * projection.m7 +
    view.m6 * projection.m11 +
    view.m7 * projection.m15,
    m8: view.m8 * projection.m0 +
    view.m9 * projection.m4 +
    view.m10 * projection.m8 +
    view.m11 * projection.m12,
    m9: view.m8 * projection.m1 +
    view.m9 * projection.m5 +
    view.m10 * projection.m9 +
    view.m11 * projection.m13,
    m10: view.m8 * projection.m2 +
    view.m9 * projection.m6 +
    view.m10 * projection.m10 +
    view.m11 * projection.m14,
    m11: view.m8 * projection.m3 +
    view.m9 * projection.m7 +
    view.m10 * projection.m11 +
    view.m11 * projection.m15,
    m12: view.m12 * projection.m0 +
    view.m13 * projection.m4 +
    view.m14 * projection.m8 +
    view.m15 * projection.m12,
    m13: view.m12 * projection.m1 +
    view.m13 * projection.m5 +
    view.m14 * projection.m9 +
    view.m15 * projection.m13,
    m14: view.m12 * projection.m2 +
    view.m13 * projection.m6 +
    view.m14 * projection.m10 +
    view.m15 * projection.m14,
    m15: view.m12 * projection.m3 +
    view.m13 * projection.m7 +
    view.m14 * projection.m11 +
    view.m15 * projection.m15,
  }

  // Cache matrix values for inversion
  let a00 = mat_view_proj.m0
  let a01 = mat_view_proj.m1
  let a02 = mat_view_proj.m2
  let a03 = mat_view_proj.m3
  let a10 = mat_view_proj.m4
  let a11 = mat_view_proj.m5
  let a12 = mat_view_proj.m6
  let a13 = mat_view_proj.m7
  let a20 = mat_view_proj.m8
  let a21 = mat_view_proj.m9
  let a22 = mat_view_proj.m10
  let a23 = mat_view_proj.m11
  let a30 = mat_view_proj.m12
  let a31 = mat_view_proj.m13
  let a32 = mat_view_proj.m14
  let a33 = mat_view_proj.m15
  let b00 = a00 * a11 - a01 * a10
  let b01 = a00 * a12 - a02 * a10
  let b02 = a00 * a13 - a03 * a10
  let b03 = a01 * a12 - a02 * a11
  let b04 = a01 * a13 - a03 * a11
  let b05 = a02 * a13 - a03 * a12
  let b06 = a20 * a31 - a21 * a30
  let b07 = a20 * a32 - a22 * a30
  let b08 = a20 * a33 - a23 * a30
  let b09 = a21 * a32 - a22 * a31
  let b10 = a21 * a33 - a23 * a31
  let b11 = a22 * a33 - a23 * a32
  let inv_det : Float = 1.0 /
    (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)
  let mat_view_proj_inv = Matrix::{
    m0: (a11 * b11 - a12 * b10 + a13 * b09) * inv_det,
    m1: (-a01 * b11 + a02 * b10 - a03 * b09) * inv_det,
    m2: (a31 * b05 - a32 * b04 + a33 * b03) * inv_det,
    m3: (-a21 * b05 + a22 * b04 - a23 * b03) * inv_det,
    m4: (-a10 * b11 + a12 * b08 - a13 * b07) * inv_det,
    m5: (a00 * b11 - a02 * b08 + a03 * b07) * inv_det,
    m6: (-a30 * b05 + a32 * b02 - a33 * b01) * inv_det,
    m7: (a20 * b05 - a22 * b02 + a23 * b01) * inv_det,
    m8: (a10 * b10 - a11 * b08 + a13 * b06) * inv_det,
    m9: (-a00 * b10 + a01 * b08 - a03 * b06) * inv_det,
    m10: (a30 * b04 - a31 * b02 + a33 * b00) * inv_det,
    m11: (-a20 * b04 + a21 * b02 - a23 * b00) * inv_det,
    m12: (-a10 * b09 + a11 * b07 - a12 * b06) * inv_det,
    m13: (a00 * b09 - a01 * b07 + a02 * b06) * inv_det,
    m14: (-a30 * b03 + a31 * b01 - a32 * b00) * inv_det,
    m15: (a20 * b03 - a21 * b01 + a22 * b00) * inv_det,
  }
  let quat = Vector4::new(source.x, source.y, source.z, 1.0)
  let qtransformed = Vector4::new(
    mat_view_proj_inv.m0 * quat.x +
    mat_view_proj_inv.m4 * quat.y +
    mat_view_proj_inv.m8 * quat.z +
    mat_view_proj_inv.m12 * quat.w,
    mat_view_proj_inv.m1 * quat.x +
    mat_view_proj_inv.m5 * quat.y +
    mat_view_proj_inv.m9 * quat.z +
    mat_view_proj_inv.m13 * quat.w,
    mat_view_proj_inv.m2 * quat.x +
    mat_view_proj_inv.m6 * quat.y +
    mat_view_proj_inv.m10 * quat.z +
    mat_view_proj_inv.m14 * quat.w,
    mat_view_proj_inv.m3 * quat.x +
    mat_view_proj_inv.m7 * quat.y +
    mat_view_proj_inv.m11 * quat.z +
    mat_view_proj_inv.m15 * quat.w,
  )
  return Vector3::new(
    qtransformed.x / qtransformed.w,
    qtransformed.y / qtransformed.w,
    qtransformed.z / qtransformed.w,
  )
}

///| Creates a zero Vector4
pub fn vector4_zero() -> Vector4 {
  return Vector4::new(0.0, 0.0, 0.0, 0.0)
}

///| Creates a Vector4 with all components set to one
pub fn vector4_one() -> Vector4 {
  return Vector4::new(1.0, 1.0, 1.0, 1.0)
}

///| Adds two Vector4s
pub fn vector4_add(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w)
}

///| Adds a scalar value to each component of a Vector4
pub fn vector4_add_value(v : Vector4, add : Float) -> Vector4 {
  return Vector4::new(v.x + add, v.y + add, v.z + add, v.w + add)
}

///| Subtracts two Vector4s
pub fn vector4_subtract(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)
}

///| Subtracts a scalar value from each component of a Vector4
pub fn vector4_subtract_value(v : Vector4, sub : Float) -> Vector4 {
  return Vector4::new(v.x - sub, v.y - sub, v.z - sub, v.w - sub)
}

///| Calculates the length of a Vector4
pub fn vector4_length(v : Vector4) -> Float {
  return (v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w).sqrt()
}

///| Calculates the squared length of a Vector4
pub fn vector4_length_sqr(v : Vector4) -> Float {
  return v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w
}

///| Calculates the dot product of two Vector4s
pub fn vector4_dot_product(v1 : Vector4, v2 : Vector4) -> Float {
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w
}

///| Calculates the distance between two Vector4s
pub fn vector4_distance(v1 : Vector4, v2 : Vector4) -> Float {
  let dx = v1.x - v2.x
  let dy = v1.y - v2.y
  let dz = v1.z - v2.z
  let dw = v1.w - v2.w
  return (dx * dx + dy * dy + dz * dz + dw * dw).sqrt()
}

///| Calculates the squared distance between two Vector4s
pub fn vector4_distance_sqr(v1 : Vector4, v2 : Vector4) -> Float {
  let dx = v1.x - v2.x
  let dy = v1.y - v2.y
  let dz = v1.z - v2.z
  let dw = v1.w - v2.w
  return dx * dx + dy * dy + dz * dz + dw * dw
}

///| Scales a Vector4 by a scalar
pub fn vector4_scale(v : Vector4, scale : Float) -> Vector4 {
  return Vector4::new(v.x * scale, v.y * scale, v.z * scale, v.w * scale)
}

///| Multiplies two Vector4s component-wise
pub fn vector4_multiply(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z, v1.w * v2.w)
}

///| Negates a Vector4
pub fn vector4_negate(v : Vector4) -> Vector4 {
  return Vector4::new(-v.x, -v.y, -v.z, -v.w)
}

///| Divides one Vector4 by another component-wise
pub fn vector4_divide(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z, v1.w / v2.w)
}

///| Normalizes a Vector4
pub fn vector4_normalize(v : Vector4) -> Vector4 {
  let length = vector4_length(v)
  if length > 0.0 {
    let inv : Float = 1.0 / length
    return Vector4::new(v.x * inv, v.y * inv, v.z * inv, v.w * inv)
  }
  return vector4_zero()
}

///| Returns the minimum component-wise values between two Vector4s
pub fn vector4_min(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(
    @math.minimum(v1.x, v2.x),
    @math.minimum(v1.y, v2.y),
    @math.minimum(v1.z, v2.z),
    @math.minimum(v1.w, v2.w),
  )
}

///| Returns the maximum component-wise values between two Vector4s
pub fn vector4_max(v1 : Vector4, v2 : Vector4) -> Vector4 {
  return Vector4::new(
    @math.maximum(v1.x, v2.x),
    @math.maximum(v1.y, v2.y),
    @math.maximum(v1.z, v2.z),
    @math.maximum(v1.w, v2.w),
  )
}

///| Linearly interpolates between two Vector4s
pub fn vector4_lerp(v1 : Vector4, v2 : Vector4, amount : Float) -> Vector4 {
  return Vector4::new(
    v1.x + amount * (v2.x - v1.x),
    v1.y + amount * (v2.y - v1.y),
    v1.z + amount * (v2.z - v1.z),
    v1.w + amount * (v2.w - v1.w),
  )
}

///| Moves a Vector4 towards a target by maxDistance
pub fn vector4_move_towards(
  v : Vector4,
  target : Vector4,
  maxDistance : Float
) -> Vector4 {
  let dx = target.x - v.x
  let dy = target.y - v.y
  let dz = target.z - v.z
  let dw = target.w - v.w
  let sqrDist = dx * dx + dy * dy + dz * dz + dw * dw
  if sqrDist == 0.0 || sqrDist <= maxDistance * maxDistance {
    return target
  }
  let dist = sqrDist.sqrt()
  let ratio = maxDistance / dist
  return Vector4::new(
    v.x + dx * ratio,
    v.y + dy * ratio,
    v.z + dz * ratio,
    v.w + dw * ratio,
  )
}

///| Inverts each component of a Vector4
pub fn vector4_invert(v : Vector4) -> Vector4 {
  return Vector4::new(1.0 / v.x, 1.0 / v.y, 1.0 / v.z, 1.0 / v.w)
}

///| Checks whether two Vector4s are approximately equal
pub fn vector4_equals(p : Vector4, q : Vector4) -> Bool {
  let eps : Float = 0.000001
  return (p.x - q.x).abs() <=
    eps * @math.maximum(1.0, @math.maximum(p.x.abs(), q.x.abs())) &&
    (p.y - q.y).abs() <=
    eps * @math.maximum(1.0, @math.maximum(p.y.abs(), q.y.abs())) &&
    (p.z - q.z).abs() <=
    eps * @math.maximum(1.0, @math.maximum(p.z.abs(), q.z.abs())) &&
    (p.w - q.w).abs() <=
    eps * @math.maximum(1.0, @math.maximum(p.w.abs(), q.w.abs()))
}

///| Computes the determinant of a Matrix
pub fn matrix_determinant(mat : Matrix) -> Float {
  let a00 = mat.m0
  let a01 = mat.m1
  let a02 = mat.m2
  let a03 = mat.m3
  let a10 = mat.m4
  let a11 = mat.m5
  let a12 = mat.m6
  let a13 = mat.m7
  let a20 = mat.m8
  let a21 = mat.m9
  let a22 = mat.m10
  let a23 = mat.m11
  let a30 = mat.m12
  let a31 = mat.m13
  let a32 = mat.m14
  let a33 = mat.m15
  return a30 * a21 * a12 * a03 -
    a20 * a31 * a12 * a03 -
    a30 * a11 * a22 * a03 +
    a10 * a31 * a22 * a03 +
    a20 * a11 * a32 * a03 -
    a10 * a21 * a32 * a03 -
    a30 * a21 * a02 * a13 +
    a20 * a31 * a02 * a13 +
    a30 * a01 * a22 * a13 -
    a00 * a31 * a22 * a13 -
    a20 * a01 * a32 * a13 +
    a00 * a21 * a32 * a13 +
    a30 * a11 * a02 * a23 -
    a10 * a31 * a02 * a23 -
    a30 * a01 * a12 * a23 +
    a00 * a31 * a12 * a23 +
    a10 * a01 * a32 * a23 -
    a00 * a11 * a32 * a23 -
    a20 * a11 * a02 * a33 +
    a10 * a21 * a02 * a33 +
    a20 * a01 * a12 * a33 -
    a00 * a21 * a12 * a33 -
    a10 * a01 * a22 * a33 +
    a00 * a11 * a22 * a33
}

///| Computes the trace of the Matrix (sum of diagonal elements)
pub fn matrix_trace(mat : Matrix) -> Float {
  return mat.m0 + mat.m5 + mat.m10 + mat.m15
}

///| Transposes a Matrix
pub fn matrix_transpose(mat : Matrix) -> Matrix {
  return Matrix::{
    m0: mat.m0,
    m1: mat.m4,
    m2: mat.m8,
    m3: mat.m12,
    m4: mat.m1,
    m5: mat.m5,
    m6: mat.m9,
    m7: mat.m13,
    m8: mat.m2,
    m9: mat.m6,
    m10: mat.m10,
    m11: mat.m14,
    m12: mat.m3,
    m13: mat.m7,
    m14: mat.m11,
    m15: mat.m15,
  }
}

///| Inverts a Matrix
pub fn matrix_invert(mat : Matrix) -> Matrix {
  let a00 = mat.m0
  let a01 = mat.m1
  let a02 = mat.m2
  let a03 = mat.m3
  let a10 = mat.m4
  let a11 = mat.m5
  let a12 = mat.m6
  let a13 = mat.m7
  let a20 = mat.m8
  let a21 = mat.m9
  let a22 = mat.m10
  let a23 = mat.m11
  let a30 = mat.m12
  let a31 = mat.m13
  let a32 = mat.m14
  let a33 = mat.m15
  let b00 = a00 * a11 - a01 * a10
  let b01 = a00 * a12 - a02 * a10
  let b02 = a00 * a13 - a03 * a10
  let b03 = a01 * a12 - a02 * a11
  let b04 = a01 * a13 - a03 * a11
  let b05 = a02 * a13 - a03 * a12
  let b06 = a20 * a31 - a21 * a30
  let b07 = a20 * a32 - a22 * a30
  let b08 = a20 * a33 - a23 * a30
  let b09 = a21 * a32 - a22 * a31
  let b10 = a21 * a33 - a23 * a31
  let b11 = a22 * a33 - a23 * a32
  let inv_det : Float = 1.0 /
    (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)
  return Matrix::{
    m0: (a11 * b11 - a12 * b10 + a13 * b09) * inv_det,
    m1: (-a01 * b11 + a02 * b10 - a03 * b09) * inv_det,
    m2: (a31 * b05 - a32 * b04 + a33 * b03) * inv_det,
    m3: (-a21 * b05 + a22 * b04 - a23 * b03) * inv_det,
    m4: (-a10 * b11 + a12 * b08 - a13 * b07) * inv_det,
    m5: (a00 * b11 - a02 * b08 + a03 * b07) * inv_det,
    m6: (-a30 * b05 + a32 * b02 - a33 * b01) * inv_det,
    m7: (a20 * b05 - a22 * b02 + a23 * b01) * inv_det,
    m8: (a10 * b10 - a11 * b08 + a13 * b06) * inv_det,
    m9: (-a00 * b10 + a01 * b08 - a03 * b06) * inv_det,
    m10: (a30 * b04 - a31 * b02 + a33 * b00) * inv_det,
    m11: (-a20 * b04 + a21 * b02 - a23 * b00) * inv_det,
    m12: (-a10 * b09 + a11 * b07 - a12 * b06) * inv_det,
    m13: (a00 * b09 - a01 * b07 + a02 * b06) * inv_det,
    m14: (-a30 * b03 + a31 * b01 - a32 * b00) * inv_det,
    m15: (a20 * b03 - a21 * b01 + a22 * b00) * inv_det,
  }
}

///| Returns the identity Matrix
pub fn matrix_identity() -> Matrix {
  return Matrix::{
    m0: 1.0,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: 1.0,
    m6: 0.0,
    m7: 0.0,
    m8: 0.0,
    m9: 0.0,
    m10: 1.0,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Adds two Matrices
pub fn matrix_add(left : Matrix, right : Matrix) -> Matrix {
  return Matrix::{
    m0: left.m0 + right.m0,
    m1: left.m1 + right.m1,
    m2: left.m2 + right.m2,
    m3: left.m3 + right.m3,
    m4: left.m4 + right.m4,
    m5: left.m5 + right.m5,
    m6: left.m6 + right.m6,
    m7: left.m7 + right.m7,
    m8: left.m8 + right.m8,
    m9: left.m9 + right.m9,
    m10: left.m10 + right.m10,
    m11: left.m11 + right.m11,
    m12: left.m12 + right.m12,
    m13: left.m13 + right.m13,
    m14: left.m14 + right.m14,
    m15: left.m15 + right.m15,
  }
}

///| Subtracts two Matrices (left - right)
pub fn matrix_subtract(left : Matrix, right : Matrix) -> Matrix {
  return Matrix::{
    m0: left.m0 - right.m0,
    m1: left.m1 - right.m1,
    m2: left.m2 - right.m2,
    m3: left.m3 - right.m3,
    m4: left.m4 - right.m4,
    m5: left.m5 - right.m5,
    m6: left.m6 - right.m6,
    m7: left.m7 - right.m7,
    m8: left.m8 - right.m8,
    m9: left.m9 - right.m9,
    m10: left.m10 - right.m10,
    m11: left.m11 - right.m11,
    m12: left.m12 - right.m12,
    m13: left.m13 - right.m13,
    m14: left.m14 - right.m14,
    m15: left.m15 - right.m15,
  }
}

///| Multiplies two Matrices
pub fn matrix_multiply(left : Matrix, right : Matrix) -> Matrix {
  return Matrix::{
    m0: left.m0 * right.m0 +
    left.m1 * right.m4 +
    left.m2 * right.m8 +
    left.m3 * right.m12,
    m1: left.m0 * right.m1 +
    left.m1 * right.m5 +
    left.m2 * right.m9 +
    left.m3 * right.m13,
    m2: left.m0 * right.m2 +
    left.m1 * right.m6 +
    left.m2 * right.m10 +
    left.m3 * right.m14,
    m3: left.m0 * right.m3 +
    left.m1 * right.m7 +
    left.m2 * right.m11 +
    left.m3 * right.m15,
    m4: left.m4 * right.m0 +
    left.m5 * right.m4 +
    left.m6 * right.m8 +
    left.m7 * right.m12,
    m5: left.m4 * right.m1 +
    left.m5 * right.m5 +
    left.m6 * right.m9 +
    left.m7 * right.m13,
    m6: left.m4 * right.m2 +
    left.m5 * right.m6 +
    left.m6 * right.m10 +
    left.m7 * right.m14,
    m7: left.m4 * right.m3 +
    left.m5 * right.m7 +
    left.m6 * right.m11 +
    left.m7 * right.m15,
    m8: left.m8 * right.m0 +
    left.m9 * right.m4 +
    left.m10 * right.m8 +
    left.m11 * right.m12,
    m9: left.m8 * right.m1 +
    left.m9 * right.m5 +
    left.m10 * right.m9 +
    left.m11 * right.m13,
    m10: left.m8 * right.m2 +
    left.m9 * right.m6 +
    left.m10 * right.m10 +
    left.m11 * right.m14,
    m11: left.m8 * right.m3 +
    left.m9 * right.m7 +
    left.m10 * right.m11 +
    left.m11 * right.m15,
    m12: left.m12 * right.m0 +
    left.m13 * right.m4 +
    left.m14 * right.m8 +
    left.m15 * right.m12,
    m13: left.m12 * right.m1 +
    left.m13 * right.m5 +
    left.m14 * right.m9 +
    left.m15 * right.m13,
    m14: left.m12 * right.m2 +
    left.m13 * right.m6 +
    left.m14 * right.m10 +
    left.m15 * right.m14,
    m15: left.m12 * right.m3 +
    left.m13 * right.m7 +
    left.m14 * right.m11 +
    left.m15 * right.m15,
  }
}

///| Creates a translation Matrix
pub fn matrix_translate(x : Float, y : Float, z : Float) -> Matrix {
  return Matrix::{
    m0: 1.0,
    m1: 0.0,
    m2: 0.0,
    m3: x,
    m4: 0.0,
    m5: 1.0,
    m6: 0.0,
    m7: y,
    m8: 0.0,
    m9: 0.0,
    m10: 1.0,
    m11: z,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix around an axis
pub fn matrix_rotate(axis : Vector3, angle : Float) -> Matrix {
  let x = axis.x
  let y = axis.y
  let z = axis.z
  let length_squared = x * x + y * y + z * z
  let (x, y, z) = if length_squared != 1.0 && length_squared != 0.0 {
    let ilength : Float = 1.0 / length_squared.sqrt()
    (x * ilength, y * ilength, z * ilength)
  } else {
    (x, y, z)
  }
  let sinres = angle.sin()
  let cosres = angle.cos()
  let t : Float = 1.0 - cosres
  return Matrix::{
    m0: x * x * t + cosres,
    m1: y * x * t + z * sinres,
    m2: z * x * t - y * sinres,
    m3: 0.0,
    m4: x * y * t - z * sinres,
    m5: y * y * t + cosres,
    m6: z * y * t + x * sinres,
    m7: 0.0,
    m8: x * z * t + y * sinres,
    m9: y * z * t - x * sinres,
    m10: z * z * t + cosres,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix around the X axis
pub fn matrix_rotate_x(angle : Float) -> Matrix {
  let cosres = angle.cos()
  let sinres = angle.sin()
  return Matrix::{
    m0: 1.0,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: cosres,
    m6: sinres,
    m7: 0.0,
    m8: 0.0,
    m9: -sinres,
    m10: cosres,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix around the Y axis
pub fn matrix_rotate_y(angle : Float) -> Matrix {
  let cosres = angle.cos()
  let sinres = angle.sin()
  return Matrix::{
    m0: cosres,
    m1: 0.0,
    m2: -sinres,
    m3: 0.0,
    m4: 0.0,
    m5: 1.0,
    m6: 0.0,
    m7: 0.0,
    m8: sinres,
    m9: 0.0,
    m10: cosres,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix around the Z axis
pub fn matrix_rotate_z(angle : Float) -> Matrix {
  let cosres = angle.cos()
  let sinres = angle.sin()
  return Matrix::{
    m0: cosres,
    m1: sinres,
    m2: 0.0,
    m3: 0.0,
    m4: -sinres,
    m5: cosres,
    m6: 0.0,
    m7: 0.0,
    m8: 0.0,
    m9: 0.0,
    m10: 1.0,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix for XYZ Euler angles
pub fn matrix_rotate_xyz(angle : Vector3) -> Matrix {
  let cosz = (-angle.z).cos()
  let sinz = (-angle.z).sin()
  let cosy = (-angle.y).cos()
  let siny = (-angle.y).sin()
  let cosx = (-angle.x).cos()
  let sinx = (-angle.x).sin()
  return Matrix::{
    m0: cosz * cosy,
    m1: cosz * siny * sinx - sinz * cosx,
    m2: cosz * siny * cosx + sinz * sinx,
    m3: 0.0,
    m4: sinz * cosy,
    m5: sinz * siny * sinx + cosz * cosx,
    m6: sinz * siny * cosx - cosz * sinx,
    m7: 0.0,
    m8: -siny,
    m9: cosy * sinx,
    m10: cosy * cosx,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a rotation Matrix for ZYX Euler angles
pub fn matrix_rotate_zyx(angle : Vector3) -> Matrix {
  let cz = angle.z.cos()
  let sz = angle.z.sin()
  let cy = angle.y.cos()
  let sy = angle.y.sin()
  let cx = angle.x.cos()
  let sx = angle.x.sin()
  return Matrix::{
    m0: cz * cy,
    m1: cy * sz,
    m2: -sy,
    m3: 0.0,
    m4: cz * sy * sx - cx * sz,
    m5: cz * cx + sz * sy * sx,
    m6: cy * sx,
    m7: 0.0,
    m8: sz * sx + cz * cx * sy,
    m9: cx * sz * sy - cz * sx,
    m10: cy * cx,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a scaling Matrix
pub fn matrix_scale(x : Float, y : Float, z : Float) -> Matrix {
  return Matrix::{
    m0: x,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: y,
    m6: 0.0,
    m7: 0.0,
    m8: 0.0,
    m9: 0.0,
    m10: z,
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a perspective projection Matrix
pub fn matrix_frustum(
  left : Float,
  right : Float,
  bottom : Float,
  top : Float,
  near_plane : Float,
  far_plane : Float
) -> Matrix {
  let rl = right - left
  let tb = top - bottom
  let fn1 = far_plane - near_plane
  return Matrix::{
    m0: near_plane * 2.0 / rl,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: near_plane * 2.0 / tb,
    m6: 0.0,
    m7: 0.0,
    m8: (right + left) / rl,
    m9: (top + bottom) / tb,
    m10: -(far_plane + near_plane) / fn1,
    m11: -1.0,
    m12: 0.0,
    m13: 0.0,
    m14: -(far_plane * near_plane * 2.0) / fn1,
    m15: 0.0,
  }
}

///| Creates a perspective projection Matrix from field of view
pub fn matrix_perspective(
  fov_y : Float,
  aspect : Float,
  near_plane : Float,
  far_plane : Float
) -> Matrix {
  let top = near_plane * (fov_y * 0.5).tan()
  let bottom = -top
  let right = top * aspect
  let left = -right
  let rl = right - left
  let tb = top - bottom
  let fn1 = far_plane - near_plane
  return Matrix::{
    m0: near_plane * 2.0 / rl,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: near_plane * 2.0 / tb,
    m6: 0.0,
    m7: 0.0,
    m8: (right + left) / rl,
    m9: (top + bottom) / tb,
    m10: -(far_plane + near_plane) / fn1,
    m11: -1.0,
    m12: 0.0,
    m13: 0.0,
    m14: -(far_plane * near_plane * 2.0) / fn1,
    m15: 0.0,
  }
}

///| Creates an orthographic projection Matrix
pub fn matrix_ortho(
  left : Float,
  right : Float,
  bottom : Float,
  top : Float,
  near_plane : Float,
  far_plane : Float
) -> Matrix {
  let rl = right - left
  let tb = top - bottom
  let fn1 = far_plane - near_plane
  return Matrix::{
    m0: 2.0 / rl,
    m1: 0.0,
    m2: 0.0,
    m3: 0.0,
    m4: 0.0,
    m5: 2.0 / tb,
    m6: 0.0,
    m7: 0.0,
    m8: 0.0,
    m9: 0.0,
    m10: -2.0 / fn1,
    m11: 0.0,
    m12: -(left + right) / rl,
    m13: -(top + bottom) / tb,
    m14: -(far_plane + near_plane) / fn1,
    m15: 1.0,
  }
}

///| Creates a camera look-at Matrix (view matrix)
pub fn matrix_look_at(eye : Vector3, target : Vector3, up : Vector3) -> Matrix {
  let vz = vector3_subtract(eye, target)
  let length = vector3_length(vz)
  let ilength : Float = if length == 0.0 { 1.0 } else { 1.0 / length }
  let vz_norm = Vector3::new(vz.x * ilength, vz.y * ilength, vz.z * ilength)
  let vx = vector3_cross_product(up, vz_norm)
  let vx_length = vector3_length(vx)
  let vx_ilength : Float = if vx_length == 0.0 { 1.0 } else { 1.0 / vx_length }
  let vx_norm = Vector3::new(
    vx.x * vx_ilength,
    vx.y * vx_ilength,
    vx.z * vx_ilength,
  )
  let vy = vector3_cross_product(vz_norm, vx_norm)
  return Matrix::{
    m0: vx_norm.x,
    m1: vy.x,
    m2: vz_norm.x,
    m3: 0.0,
    m4: vx_norm.y,
    m5: vy.y,
    m6: vz_norm.y,
    m7: 0.0,
    m8: vx_norm.z,
    m9: vy.z,
    m10: vz_norm.z,
    m11: 0.0,
    m12: -(vx_norm.x * eye.x + vx_norm.y * eye.y + vx_norm.z * eye.z),
    m13: -(vy.x * eye.x + vy.y * eye.y + vy.z * eye.z),
    m14: -(vz_norm.x * eye.x + vz_norm.y * eye.y + vz_norm.z * eye.z),
    m15: 1.0,
  }
}

///| Adds two quaternions
pub fn quaternion_add(q1 : Quaternion, q2 : Quaternion) -> Quaternion {
  vector4_add(q1, q2)
}

///| Adds a scalar value to each component of a quaternion
pub fn quaternion_add_value(q : Quaternion, add : Float) -> Quaternion {
  vector4_add_value(q, add)
}

///| Subtracts two quaternions
pub fn quaternion_subtract(q1 : Quaternion, q2 : Quaternion) -> Quaternion {
  vector4_subtract(q1, q2)
}

///| Subtracts a scalar value from each component of a quaternion
pub fn quaternion_subtract_value(q : Quaternion, sub : Float) -> Quaternion {
  vector4_subtract_value(q, sub)
}

///| Creates an identity quaternion
pub fn quaternion_identity() -> Quaternion {
  Vector4::new(0.0, 0.0, 0.0, 1.0)
}

///| Computes the length of a quaternion
pub fn quaternion_length(q : Quaternion) -> Float {
  vector4_length(q)
}

///| Normalizes a quaternion
pub fn quaternion_normalize(q : Quaternion) -> Quaternion {
  let length = vector4_length(q)
  let ilength : Float = if length == 0.0 { 1.0 } else { 1.0 / length }
  Vector4::new(q.x * ilength, q.y * ilength, q.z * ilength, q.w * ilength)
}

///| Inverts a quaternion
pub fn quaternion_invert(q : Quaternion) -> Quaternion {
  let length_sqr = vector4_length_sqr(q)
  if length_sqr != 0.0 {
    let inv_length : Float = 1.0 / length_sqr
    Vector4::new(
      -q.x * inv_length,
      -q.y * inv_length,
      -q.z * inv_length,
      q.w * inv_length,
    )
  } else {
    q
  }
}

///| Multiplies two quaternions
pub fn quaternion_multiply(q1 : Quaternion, q2 : Quaternion) -> Quaternion {
  Vector4::new(
    q1.x * q2.w + q1.w * q2.x + q1.y * q2.z - q1.z * q2.y,
    q1.y * q2.w + q1.w * q2.y + q1.z * q2.x - q1.x * q2.z,
    q1.z * q2.w + q1.w * q2.z + q1.x * q2.y - q1.y * q2.x,
    q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z,
  )
}

///| Scales a quaternion by a scalar
pub fn quaternion_scale(q : Quaternion, mul : Float) -> Quaternion {
  vector4_scale(q, mul)
}

///| Divides two quaternions component-wise
pub fn quaternion_divide(q1 : Quaternion, q2 : Quaternion) -> Quaternion {
  vector4_divide(q1, q2)
}

///| Linearly interpolates between two quaternions
pub fn quaternion_lerp(
  q1 : Quaternion,
  q2 : Quaternion,
  amount : Float
) -> Quaternion {
  vector4_lerp(q1, q2, amount)
}

///| Normalizes linear interpolation between two quaternions
pub fn quaternion_nlerp(
  q1 : Quaternion,
  q2 : Quaternion,
  amount : Float
) -> Quaternion {
  let result = quaternion_lerp(q1, q2, amount)
  quaternion_normalize(result)
}

///| Spherical linear interpolation between two quaternions
pub fn quaternion_slerp(
  q1 : Quaternion,
  q2 : Quaternion,
  amount : Float
) -> Quaternion {
  let cos_half_theta = vector4_dot_product(q1, q2)
  let q2_adjusted = if cos_half_theta < 0.0 { vector4_negate(q2) } else { q2 }
  let cos_half_theta_adj = if cos_half_theta < 0.0 {
    -cos_half_theta
  } else {
    cos_half_theta
  }
  if cos_half_theta_adj.abs() >= 1.0 {
    q1
  } else if cos_half_theta_adj > 0.95 {
    quaternion_nlerp(q1, q2_adjusted, amount)
  } else {
    let half_theta = cos_half_theta_adj.acos()
    let sin_half_theta : Double = (1.0 -
    cos_half_theta_adj.to_double() * cos_half_theta_adj.to_double()).sqrt()
    if sin_half_theta.abs() < 0.000001 {
      Vector4::new(
        (q1.x + q2_adjusted.x) * 0.5,
        (q1.y + q2_adjusted.y) * 0.5,
        (q1.z + q2_adjusted.z) * 0.5,
        (q1.w + q2_adjusted.w) * 0.5,
      )
    } else {
      let ratio_a : Float = ((1.0 - amount.to_double()) * half_theta.to_double())
        .sin()
        .to_float() /
        sin_half_theta.to_float()
      let ratio_b = (amount * half_theta).sin() / sin_half_theta.to_float()
      Vector4::new(
        q1.x * ratio_a + q2_adjusted.x * ratio_b,
        q1.y * ratio_a + q2_adjusted.y * ratio_b,
        q1.z * ratio_a + q2_adjusted.z * ratio_b,
        q1.w * ratio_a + q2_adjusted.w * ratio_b,
      )
    }
  }
}

///| Cubic Hermite spline interpolation between two quaternions
pub fn quaternion_cubic_hermite_spline(
  q1 : Quaternion,
  out_tangent1 : Quaternion,
  q2 : Quaternion,
  in_tangent2 : Quaternion,
  t : Float
) -> Quaternion {
  let t2 = t * t
  let t3 = t2 * t
  let h00 : Float = 2.0 * t3 - 3.0 * t2 + 1.0
  let h10 = t3 - 2.0 * t2 + t
  let h01 : Float = -2.0 * t3 + 3.0 * t2
  let h11 = t3 - t2
  let p0 = quaternion_scale(q1, h00)
  let m0 = quaternion_scale(out_tangent1, h10)
  let p1 = quaternion_scale(q2, h01)
  let m1 = quaternion_scale(in_tangent2, h11)
  let result = quaternion_add(quaternion_add(p0, m0), quaternion_add(p1, m1))
  quaternion_normalize(result)
}

///| Creates a quaternion from one vector to another
pub fn quaternion_from_vector3_to_vector3(
  from : Vector3,
  to : Vector3
) -> Quaternion {
  let cos2_theta = vector4_dot_product(
    Vector4::new(from.x, from.y, from.z, 0.0),
    Vector4::new(to.x, to.y, to.z, 0.0),
  )
  let cross = Vector3::{
    x: from.y * to.z - from.z * to.y,
    y: from.z * to.x - from.x * to.z,
    z: from.x * to.y - from.y * to.x,
  }
  let result = Vector4::new(cross.x, cross.y, cross.z, 1.0 + cos2_theta)
  quaternion_normalize(result)
}

///| Creates a quaternion from a rotation matrix
pub fn quaternion_from_matrix(mat : Matrix) -> Quaternion {
  let four_w_sqr_minus1 = mat.m0 + mat.m5 + mat.m10
  let four_x_sqr_minus1 = mat.m0 - mat.m5 - mat.m10
  let four_y_sqr_minus1 = mat.m5 - mat.m0 - mat.m10
  let four_z_sqr_minus1 = mat.m10 - mat.m0 - mat.m5
  let mut biggest_index = 0
  let mut four_biggest_sqr_minus1 = four_w_sqr_minus1
  if four_x_sqr_minus1 > four_biggest_sqr_minus1 {
    four_biggest_sqr_minus1 = four_x_sqr_minus1
    biggest_index = 1
  }
  if four_y_sqr_minus1 > four_biggest_sqr_minus1 {
    four_biggest_sqr_minus1 = four_y_sqr_minus1
    biggest_index = 2
  }
  if four_z_sqr_minus1 > four_biggest_sqr_minus1 {
    four_biggest_sqr_minus1 = four_z_sqr_minus1
    biggest_index = 3
  }
  let biggest_val = (four_biggest_sqr_minus1 + 1.0).sqrt() * 0.5
  let mult : Float = 0.25 / biggest_val
  match biggest_index {
    0 =>
      Vector4::new(
        (mat.m6 - mat.m9) * mult,
        (mat.m8 - mat.m2) * mult,
        (mat.m1 - mat.m4) * mult,
        biggest_val,
      )
    1 =>
      Vector4::new(
        biggest_val,
        (mat.m1 + mat.m4) * mult,
        (mat.m8 + mat.m2) * mult,
        (mat.m6 - mat.m9) * mult,
      )
    2 =>
      Vector4::new(
        (mat.m1 + mat.m4) * mult,
        biggest_val,
        (mat.m6 + mat.m9) * mult,
        (mat.m8 - mat.m2) * mult,
      )
    3 =>
      Vector4::new(
        (mat.m8 + mat.m2) * mult,
        (mat.m6 + mat.m9) * mult,
        biggest_val,
        (mat.m1 - mat.m4) * mult,
      )
    _ => Vector4::new(0.0, 0.0, 0.0, 0.0)
  }
}

///| Creates a matrix from a quaternion
pub fn quaternion_to_matrix(q : Quaternion) -> Matrix {
  let a2 = q.x * q.x
  let b2 = q.y * q.y
  let c2 = q.z * q.z
  let ac = q.x * q.z
  let ab = q.x * q.y
  let bc = q.y * q.z
  let ad = q.w * q.x
  let bd = q.w * q.y
  let cd = q.w * q.z
  Matrix::{
    m0: 1.0 - 2.0 * (b2 + c2),
    m1: 2.0 * (ab + cd),
    m2: 2.0 * (ac - bd),
    m3: 0.0,
    m4: 2.0 * (ab - cd),
    m5: 1.0 - 2.0 * (a2 + c2),
    m6: 2.0 * (bc + ad),
    m7: 0.0,
    m8: 2.0 * (ac + bd),
    m9: 2.0 * (bc - ad),
    m10: 1.0 - 2.0 * (a2 + b2),
    m11: 0.0,
    m12: 0.0,
    m13: 0.0,
    m14: 0.0,
    m15: 1.0,
  }
}

///| Creates a quaternion from axis and angle (in radians)
pub fn quaternion_from_axis_angle(axis : Vector3, angle : Float) -> Quaternion {
  let axis_length = (axis.x * axis.x + axis.y * axis.y + axis.z * axis.z).sqrt()
  if axis_length == 0.0 {
    quaternion_identity()
  } else {
    let half_angle = angle * 0.5
    let ilength : Float = 1.0 / axis_length
    let sinres = half_angle.sin()
    let cosres = half_angle.cos()
    let result = Vector4::new(
      axis.x * ilength * sinres,
      axis.y * ilength * sinres,
      axis.z * ilength * sinres,
      cosres,
    )
    quaternion_normalize(result)
  }
}

///| Gets the rotation angle and axis for a quaternion
pub fn quaternion_to_axis_angle(q : Quaternion) -> (Vector3, Float) {
  let q_normalized = if q.w.abs() > 1.0 { quaternion_normalize(q) } else { q }
  let angle : Float = 2.0 * q_normalized.w.acos()
  let den : Float = (1.0 -
    q_normalized.w.to_double() * q_normalized.w.to_double())
    .sqrt()
    .to_float()
  let axis = if den > 0.000001 {
    Vector3::{
      x: q_normalized.x / den,
      y: q_normalized.y / den,
      z: q_normalized.z / den,
    }
  } else {
    Vector3::{ x: 1.0, y: 0.0, z: 0.0 }
  }
  (axis, angle)
}

///| Creates a quaternion from Euler angles (pitch, yaw, roll) in radians, ZYX order
pub fn quaternion_from_euler(
  pitch : Float,
  yaw : Float,
  roll : Float
) -> Quaternion {
  let x0 = (pitch * 0.5).cos()
  let x1 = (pitch * 0.5).sin()
  let y0 = (yaw * 0.5).cos()
  let y1 = (yaw * 0.5).sin()
  let z0 = (roll * 0.5).cos()
  let z1 = (roll * 0.5).sin()
  Vector4::new(
    x1 * y0 * z0 - x0 * y1 * z1,
    x0 * y1 * z0 + x1 * y0 * z1,
    x0 * y0 * z1 - x1 * y1 * z0,
    x0 * y0 * z0 + x1 * y1 * z1,
  )
}

///| Gets Euler angles (roll, pitch, yaw) in radians from a quaternion, ZYX order
pub fn quaternion_to_euler(q : Quaternion) -> Vector3 {
  let x0 : Float = 2.0 * (q.w * q.x + q.y * q.z)
  let x1 : Float = 1.0 - 2.0 * (q.x * q.x + q.y * q.y)
  let roll = x0.atan2(x1)
  let y0 : Float = 2.0 * (q.w * q.y - q.z * q.x)
  let pitch = if y0 > 1.0 {
    1.0.asin()
  } else if y0 < -1.0 {
    (-1.0).asin()
  } else {
    y0.asin().to_double()
  }
  let z0 : Float = 2.0 * (q.w * q.z + q.x * q.y)
  let z1 : Float = 1.0 - 2.0 * (q.y * q.y + q.z * q.z)
  let yaw = z0.atan2(z1)
  Vector3::{ x: roll, y: pitch.to_float(), z: yaw }
}

///| Transforms a quaternion by a transformation matrix
pub fn quaternion_transform(q : Quaternion, mat : Matrix) -> Quaternion {
  Vector4::new(
    mat.m0 * q.x + mat.m4 * q.y + mat.m8 * q.z + mat.m12 * q.w,
    mat.m1 * q.x + mat.m5 * q.y + mat.m9 * q.z + mat.m13 * q.w,
    mat.m2 * q.x + mat.m6 * q.y + mat.m10 * q.z + mat.m14 * q.w,
    mat.m3 * q.x + mat.m7 * q.y + mat.m11 * q.z + mat.m15 * q.w,
  )
}

///| Checks whether two quaternions are almost equal
pub fn quaternion_equals(p : Quaternion, q : Quaternion) -> Bool {
  let eps : Float = 0.000001
  let check = fn(x1 : Float, x2 : Float) -> Bool {
    (x1 - x2).abs() <=
    eps * @math.maximum(1.0, @math.maximum(x1.abs(), x2.abs()))
  }
  (check(p.x, q.x) && check(p.y, q.y) && check(p.z, q.z) && check(p.w, q.w)) ||
  (check(p.x, -q.x) && check(p.y, -q.y) && check(p.z, -q.z) && check(p.w, -q.w))
}

///| Decomposes a transformation matrix into translation, rotation, and scale components
pub fn matrix_decompose(mat : Matrix) -> (Vector3, Quaternion, Vector3) {
  // Extract translation
  let translation = Vector3::{ x: mat.m12, y: mat.m13, z: mat.m14 }

  // Extract upper-left 3x3 for scale and rotation
  let a = mat.m0
  let b = mat.m4
  let c = mat.m8
  let d = mat.m1
  let e = mat.m5
  let f = mat.m9
  let g = mat.m2
  let h = mat.m6
  let i = mat.m10

  // Compute determinant components
  let a1 = e * i - f * h
  let b1 = f * g - d * i
  let c1 = d * h - e * g
  let det = a * a1 + b * b1 + c * c1

  // Extract scale
  let scale_x = (a * a + b * b + c * c).sqrt()
  let scale_y = (d * d + e * e + f * f).sqrt()
  let scale_z = (g * g + h * h + i * i).sqrt()
  let scale = if det < 0.0 {
    Vector3::{ x: -scale_x, y: -scale_y, z: -scale_z }
  } else {
    Vector3::{ x: scale_x, y: scale_y, z: scale_z }
  }

  // Extract rotation by removing scale
  let rotation = if scale_x.abs() > 0.000001 &&
    scale_y.abs() > 0.000001 &&
    scale_z.abs() > 0.000001 {
    let clone = Matrix::{
      m0: mat.m0 / scale.x,
      m1: mat.m1 / scale.y,
      m2: mat.m2 / scale.z,
      m4: mat.m4 / scale.x,
      m5: mat.m5 / scale.y,
      m6: mat.m6 / scale.z,
      m8: mat.m8 / scale.x,
      m9: mat.m9 / scale.y,
      m10: mat.m10 / scale.z,
      m3: mat.m3,
      m7: mat.m7,
      m11: mat.m11,
      m12: mat.m12,
      m13: mat.m13,
      m14: mat.m14,
      m15: mat.m15,
    }
    quaternion_from_matrix(clone)
  } else {
    quaternion_identity()
  }
  (translation, rotation, scale)
}
