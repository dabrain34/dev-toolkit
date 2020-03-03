#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
int main(void) {
   Display *d;
   Window w;
   XEvent e;
   const char *msg = "Hello, World!";
   int s;
   int running=1;
 
   d = XOpenDisplay(NULL);
   if (d == NULL) {
      fprintf(stderr, "Cannot open display\n");
      exit(1);
   }
 
   s = DefaultScreen(d);
   w = XCreateSimpleWindow(d, RootWindow(d, s), 10, 10, 100, 100, 1,
                           BlackPixel(d, s), WhitePixel(d, s));
   XSelectInput(d, w, ExposureMask | KeyPressMask | PointerMotionMask | ButtonPressMask | ButtonReleaseMask);
   XMapWindow(d, w);
 
   while (running) {
      XNextEvent(d, &e);
      if (e.type == Expose) {
         XFillRectangle(d, w, DefaultGC(d, s), 20, 20, 10, 10);
         XDrawString(d, w, DefaultGC(d, s), 10, 50, msg, strlen(msg));
      }
      switch (e.type) {
        case MotionNotify:
          fprintf(stdout, "Button pressed %d %d\n", e.xmotion.x, e.xmotion.y);
          break;
        case ButtonPress:
          fprintf(stdout, "Button pressed\n");
          break;
        case ButtonRelease:
          fprintf(stdout, "Button released\n");
          break;
        case KeyPress:
           fprintf(stdout, "key pressed\n");
           running = 0; 
           break;
       }
   }
 
   XCloseDisplay(d);
   return 0;
}
