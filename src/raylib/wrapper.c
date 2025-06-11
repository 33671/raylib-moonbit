#include "raylib.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

void ffi_clear_background(void *color) {
  Color c = *(Color *)(color);
  ClearBackground(c);
}
void ffi_draw_text(const char *text, int posX, int posY, int fontSize,
                   void *color) {
  Color c = *(Color *)(color);
  DrawText(text, posX, posY, fontSize, c);
}
void *make_color(uint8_t *color) {
  Color *c = (Color *)malloc(sizeof(Color));
  memcpy(c, color, sizeof(Color));
  return color;
}