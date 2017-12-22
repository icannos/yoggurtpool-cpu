

#DEFINE KEYBOARD_BEGIN 0


get_c:
  leti r1 KEYBOARD_BEGIN
  let  r1 r0

  setctr a0 r1
  readze a0 1 r3
