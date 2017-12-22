//
// Created by maxime on 20/12/17.
//

#ifndef ASR1_AUDIO_H
#define ASR1_AUDIO_H

#include "memory.h"
#include "beeper.h"

#define NB_NOTES 200



void simulate_audio(Memory* m);

float getTempo(uint16_t duration);


#endif //ASR1_AUDIO_H
