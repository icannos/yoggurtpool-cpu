#define KEYBOARD_BEGIN 1073349796

#include <keyboard.s>

;; Musique:

#define AUDIO_CTRL 0x3FF9F77E
#define PTR_FILE 0x3FF9F780
#define BEGIN_QUEUE 0x3FF9F7C0

call lockaudio
leti r0 4172
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2117
call beep
leti r0 2117
call beep
leti r0 2120
call beep
leti r0 2124
call beep
leti r0 2122
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 4172
call beep
leti r0 4168
call beep
leti r0 2629
call beep
leti r0 3653
call beep
leti r0 2122
call beep
leti r0 2125
call beep
leti r0 2129
call beep
leti r0 2127
call beep
leti r0 2125
call beep
leti r0 588
call beep
leti r0 2120
call beep
leti r0 2124
call beep
leti r0 2122
call beep
leti r0 2120
call beep
leti r0 2119
call beep
leti r0 2120
call beep
leti r0 4170
call beep
leti r0 4172
call beep
leti r0 4168
call beep
leti r0 2117
call beep
leti r0 581
call beep
call unlockaudioloop

boucle:
call keyboard.waitkey
cmpi r0 -1
jumpif eq boucle

jump -13



lockaudio:
; Stop audio play and go back at the begining of the queue.
  push 64 r0
  push 64 r1

  leti r0 PTR_FILE
  setctr a0 r0
  leti r0 BEGIN_QUEUE
  write a0 64 r0

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 0
  write a0 1 r1
  leti r1 0
  write a0 1 r1

  pop 64 r1
  pop 64 r0

  return


unlockaudio:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 0
  write a0 1 r1
  leti r1 1
  write a0 1 r1

  pop 64 r1
  pop 64 r0

  return


unlockaudioloop:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  setctr a0 r0

  leti r1 1
  write a0 1 r1
  leti r1 0
  write a0 1 r1


  pop 64 r1
  pop 64 r0

  return


beep:
    push 64 r1
    push 64 r2
		push 64 r3


; On regarde ou en est la file
    leti r3 PTR_FILE
    setctr a0 r3
    readze a0 64 r1
; On se place au bon endroit
    setctr a0 r1
; On ecrit la note
    write a0 16 r0

; On met le ptr de file au bon endroit
    getctr a0 r1
    setctr a0 r3
    write a0 64 r1

		pop 64 r3
    pop 64 r2
    pop 64 r1

    return

endmusicfile:
