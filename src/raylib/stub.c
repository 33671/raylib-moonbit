#include "raylib.h"
#include <moonbit.h>
#include <stdint.h>
#include <sys/types.h>

void ffi_clear_background(uint8_t *color) {
  Color c = *(Color *)(color);
  ClearBackground(c);
}
void ffi_draw_text(const char *text, int posX, int posY, int fontSize,
                   void *color) {
  Color c = *(Color *)(color);
  DrawText(text, posX, posY, fontSize, c);
}

void ffi_draw_circle_v(void *ffi_vector2_pos, float radius, uint8_t *color) {
  DrawCircleV(*(Vector2 *)(ffi_vector2_pos), radius, *(Color *)color);
}

float *ffi_get_mouse_position(float *pos) {
  Vector2 v = GetMousePosition();
  (*pos) = v.x;
  (*(pos + 1)) = v.y;
  return pos;
}
void ffi_draw_rectangle(int x,int y,int width,int height,uint8_t* color){
  Color c = *(Color *)(color);
  DrawRectangle(x, y, width, height, c);
}