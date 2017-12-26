
from music21 import midi
import music21
import os

from numpy import binary_repr


def duration(n):
    if n == 1.0:
        return 1
    elif n == 1/3:
        return 2
    elif n == 2/3:
        return 3
    elif n == 0.5:
        return 4
    elif n == 0.25:
        return 5
    elif n == 1/8:
        return 6
    elif n == 1.5:
        return 7
    elif n == 0.75:
        return 8
    else:
        return 4


def buildAsmMusic(filename):
    s = midi.translate.midiFilePathToStream(filename)

    asm = "call lockaudio" + "\n"

    for p in s[0]:
        if(isinstance(p, music21.chord.Chord)):
            d = p.duration.quarterLength
            p_nb = p.root().midi
            asm += "leti r0 " + str((duration(d) << 8) + p_nb) + "\n"
            asm += "call beep \n"


        elif (isinstance(p, music21.note.Note)):
            p_nb = p.midi


            d = p.duration.quarterLength
            print(d)
            print(p_nb)
            asm += "leti r0 " + str((duration(d) << 9) + p_nb) + "\n"
            asm += "call beep \n"


    asm += "call unlockaudio \n"


    print(asm)











buildAsmMusic("tetris_feat_avalade.midi")