

#DEFINE KEYBOARD_BEGIN 0


wait4key:


  leti r1 KEYBOARD_BEGIN


  infboucle:
    getctr a0 r2
    sub2i r2 284
    cmp r1 r2
    jumpif slt next
      setctr a0 r1
    next:



  jumpif z infboucle

  setctr a0 r1
  readze a0 1 r3
