pub(all) enum MouseButton {
  Left
  Right
  Middle
  Side
  Extra
  Forward
  Back
} derive(Show, Eq)

fn MouseButton::to_int(self: MouseButton) -> Int {
  match self {
    Left => 0
    Right => 1
    Middle => 2
    Side => 3
    Extra => 4
    Forward => 5
    Back => 6
  }
}

fn MouseButton::from_int(value: Int) -> Option[MouseButton] {
  match value {
    0 => Some(Left)
    1 => Some(Right)
    2 => Some(Middle)
    3 => Some(Side)
    4 => Some(Extra)
    5 => Some(Forward)
    6 => Some(Back)
    _ => None
  }
}