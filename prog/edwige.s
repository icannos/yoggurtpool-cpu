#define AUDIO_CTRL 0x3FF9F77E
#define PTR_FILE 0x3FF9F780
#define BEGIN_QUEUE 0x3FF9F7C0

#include <graph.sl>

call lockaudio
leti r0 4167
call beep
leti r0 6220
call beep
leti r0 2127
call beep
leti r0 4174
call beep
leti r0 2124
call beep
leti r0 4179
call beep
leti r0 5713
call beep
leti r0 5710
call beep
leti r0 588
call beep
leti r0 2127
call beep
leti r0 4174
call beep
leti r0 2123
call beep
leti r0 4174
call beep
leti r0 2119
call beep
leti r0 4167
call beep
leti r0 588
call beep
leti r0 2127
call beep
leti r0 4174
call beep
leti r0 3660
call beep
leti r0 4179
call beep
leti r0 2134
call beep
leti r0 4181
call beep
leti r0 2132
call beep
leti r0 4176
call beep
leti r0 6228
call beep
leti r0 2131
call beep
leti r0 4178
call beep
leti r0 2118
call beep
leti r0 4175
call beep
leti r0 5196
call beep
call unlockaudioloop

.char 65535 20 100 EDWIGE
.char 65535 50 70 Theme

jump -13




jump endmusicfile



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

    pop 64 r2
    pop 64 r1

    return

endmusicfile:
