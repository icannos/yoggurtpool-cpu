#DEFINE AUDIO_CTRL 0x3FF9F77E
#DEFINE PTR_FILE 0x3FF9F780
#DEFINE BEGIN_QUEUE 0x3FF9F7C0


call lockaudio
leti r0 197
call beep
call beep
call beep
call unlockaudio
leti r0 542
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
