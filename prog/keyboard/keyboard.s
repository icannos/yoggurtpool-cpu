; Il faut #define KEYBOARD_BEGIN 1073349796 dans le fichier appelant

jump keyboardend


waitkey:
  push 64 r1
  push 64 r2
  push 64 r3

  leti r1 KEYBOARD_BEGIN
  setctr a0 r1
  leti r0 -1
  infboucle:
    getctr a0 r2
    sub2i r2 284
    cmp r1 r2

    jumpif eq nextkeyboard
    readze a0 1 r3

    cmpi r3 0
    jumpif eq infboucle

    getctr a0 r0
    sub2i r0 KEYBOARD_BEGIN
    sub2i r0 1

    nextkeyboard:

    pop 64 r3
    pop 64 r2
    pop 64 r1

    return

keyboardend:

