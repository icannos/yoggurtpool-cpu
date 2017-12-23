
from music21 import midi
import music21
import os

from numpy import binary_repr


def duration(n):
    if n == 1.0:
        return 1
    elif n == 1.5:
        return 7
    elif n == 0:
        return 0
    elif n == 2:
        return 2
    elif n == 4:
        return 3
    elif n == 0.25:
        return 5
    elif n == 1/8:
        return 6
    elif n == 1/2:
        return 6
    else: return 1


def buildAsmMusic(filename):
    s = midi.translate.midiFilePathToStream(filename)

    asm = "call lockaudio" + "\n"


    for p in s[1][3]:
        if(isinstance(p, music21.chord.Chord)):
            d = p.duration.quarterLength
            p_nb = p.root().midi

        elif (isinstance(p, music21.pitch.Pitch)):
            p_nb = p.midi
            d = p.duration.quarterLength

        asm += "leti r0 " +  str((duration(d) << 7) + p_nb) + "\n"
        asm += "call beep \n"


    asm += "call unlockaudio \n"

    print(asm)






buildAsmMusic("music-a-2-.mid")