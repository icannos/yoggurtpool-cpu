

#define KEYBOARD_BEGIN 1073349796

wait4key:
  push 64 r1
  push 64 r2
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

  pop 64 r2
  pop 64 r1
  return


waitkey:
  push 64 r1
  push 64 r2

  leti r1 KEYBOARD_BEGIN
  let r0 -1
  infboucle:
    getctr a0 r2
    sub2i r2 284
    cmp r1 r2

    jumpif slt next
    readze a0 1 r0

    cmpi r0 0
    jumpif z infboucle

    getctr a0 r0
    sub2i r0 KEYBOARD_BEGIN
    sub2i r0 1

    next:

    pop 64 r2
    pop 64 r1

    return
