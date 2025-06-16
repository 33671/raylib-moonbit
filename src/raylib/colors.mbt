pub(all) enum Color {
  RGBA(Byte, Byte, Byte, Byte)
  LightGray
  Gray
  DarkGray
  Yellow
  Gold
  Orange
  Pink
  Red
  Maroon
  Green
  Lime
  DarkGreen
  SkyBlue
  Blue
  DarkBlue
  Purple
  Violet
  DarkPurple
  Beige
  Brown
  DarkBrown
  White
  Black
  Blank
  Magenta
  RayWhite
} derive(Show,Eq)

fn Color::to_rgba(self: Color) -> FixedArray[Byte] {
  match self {
    RGBA(r, g, b, a) => [r, g, b, a]
    LightGray => [200, 200, 200, 255]
    Gray => [130, 130, 130, 255]
    DarkGray => [80, 80, 80, 255]
    Yellow => [253, 249, 0, 255]
    Gold => [255, 203, 0, 255]
    Orange => [255, 161, 0, 255]
    Pink => [255, 109, 194, 255]
    Red => [230, 41, 55, 255]
    Maroon => [190, 33, 55, 255]
    Green => [0, 228, 48, 255]
    Lime => [0, 158, 47, 255]
    DarkGreen => [0, 117, 44, 255]
    SkyBlue => [102, 191, 255, 255]
    Blue => [0, 121, 241, 255]
    DarkBlue => [0, 82, 172, 255]
    Purple => [200, 122, 255, 255]
    Violet => [135, 60, 190, 255]
    DarkPurple => [112, 31, 126, 255]
    Beige => [211, 176, 131, 255]
    Brown => [127, 106, 79, 255]
    DarkBrown => [76, 63, 47, 255]
    White => [255, 255, 255, 255]
    Black => [0, 0, 0, 255]
    Blank => [0, 0, 0, 0]
    Magenta => [255, 0, 255, 255]
    RayWhite => [245, 245, 245, 255]
  }
}