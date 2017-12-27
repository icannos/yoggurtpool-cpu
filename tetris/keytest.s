#define KEYBOARD_BEGIN 1073349796

#include <keyboard.s>

boucle:
call keyboard.waitkey
cmpi r0 -1
jumpif eq boucle

jump -13
