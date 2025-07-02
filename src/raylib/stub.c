#include "raylib.h"
#include <math.h>
#include <moonbit.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

void ffi_clear_background(Color *color) { ClearBackground(*color); }
void ffi_draw_text(const char *text, int posX, int posY, int fontSize,
                   Color *color) {
  DrawText(text, posX, posY, fontSize, *color);
}

void ffi_draw_circle_v(Vector2 *ffi_vector2_pos, float radius, Color *color) {
  DrawCircleV(*ffi_vector2_pos, radius, *color);
}
void ffi_draw_circle(int posX, int posY, float radius, Color *color) {
  DrawCircle(posX, posY, radius, *color);
}
float *ffi_get_mouse_position(float *pos) {
  Vector2 v = GetMousePosition();
  (*pos) = v.x;
  (*(pos + 1)) = v.y;
  return pos;
}
void ffi_draw_rectangle(int x, int y, int width, int height, Color *color) {
  DrawRectangle(x, y, width, height, *color);
}

void finalize_placeholder(void *ptr) {}

Camera2D *ffi_make_camera2d(Vector2 *target, Vector2 *offset, float ratation,
                            float zoom) {
  Camera2D *cam2d = (Camera2D *)moonbit_make_external_object(
      finalize_placeholder, sizeof(Camera2D));
  // printf("Creating Camera2D object at %p\n", cam2d);
  cam2d->target = *target;
  cam2d->offset = *offset;
  cam2d->rotation = ratation;
  cam2d->zoom = zoom;
  return cam2d;
}

void ffi_begin_mode_2d(Camera2D *cam) { BeginMode2D(*cam); }

void ffi_draw_rectangle_lines(int x, int y, int w, int h, Color *color) {
  DrawRectangleLines(x, y, w, h, *color);
}

void ffi_draw_rectangle_rec(Rectangle *rec, Color *color) {
  DrawRectangleRec(*rec, *color);
}

void ffi_draw_line(int x, int y, int endx, int endy, Color *color) {
  DrawLine(x, y, endx, endy, *color);
}

float *ffi_get_screen_to_world_2d(Vector2 *p, Camera2D *cam) {
  Vector2 v = GetScreenToWorld2D(*p, *cam);
  float *arr = moonbit_make_float_array(2, 0);
  arr[0] = v.x;
  arr[1] = v.y;
  return arr;
}

Vector2 *ffi_get_mouse_delta() {
  float *v = moonbit_make_float_array(2, 0);
  Vector2 p = GetMouseDelta();
  v[0] = p.x;
  v[1] = p.y;
  return (Vector2 *)v;
}