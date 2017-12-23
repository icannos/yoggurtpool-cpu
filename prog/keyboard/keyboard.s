

#DEFINE KEYBOARD_BEGIN 0


wait4key:
  leti r1 KEYBOARD_BEGIN

  infboucle:
    getctr a0 r2
    sub2i r2 284
    cmp r2 r1

    jumpif slt next
      setctr a0 r1
    next:

    readze a0 1 r0
    cmpi r0 0

  jumpif nz infboucle

  getctr a0 r0
  sub2i r0 KEYBOARD_BEGIN
  sub2i r0 1


waitkey:
  leti r1 KEYBOARD_BEGIN

  infboucle:
    getctr a0 r2
    sub2i r2 284
    cmp r1 r2

    jumpif slt next
    readze a0 1 r0

    cmpi r0 0
    jumpif z infboucle

    next:

    getctr a0 r0
    sub2i r0 KEYBOARD_BEGIN
    sub2i r0 1
