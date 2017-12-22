#DEFINE PTR_FILE 0x3FF9F780
#DEFINE BEGIN_QUEUE 0x3FF9F7C0

lockaudio:
; Stop audio play and go back at the begining of the queue.
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  leti r1 0
  setctr a0 r0
  write a0 2 r1

  pop 64 r1
  pop 64 r0


unlockaudio:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  leti r1 1
  setctr a0 r0
  write a0 2 r1

  pop 64 r1
  pop 64 r0

unlockaudioloop:
; Start Playing
  push 64 r0
  push 64 r1

  leti r0 AUDIO_CTRL
  leti r1 2
  setctr a0 r0
  write a0 2 r1

  pop 64 r1
  pop 64 r0


beep:
    push 64 r0
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
    pop 64 r0
