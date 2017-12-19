//
// Created by maxime on 20/12/17.
//

#ifndef ASR1_BEEPER_H
#define ASR1_BEEPER_H


/*  from http://stackoverflow.com/questions/10110905/simple-wave-generator-with-sdl-in-c */

#include <SDL/SDL.h>
#include <SDL/SDL_audio.h>
#include <queue>
#include <cmath>

const int AMPLITUDE = 28000;
const int FREQUENCY = 44100;

struct BeepObject
{
    double freq;
    int samplesLeft;
};

class Beeper
{
private:
    double v;
    std::queue<BeepObject> beeps;
public:
    Beeper();
    ~Beeper();
    void beep(double freq, int duration);
    void generateSamples(Sint16 *stream, int length);
    void wait();
};

void audio_callback(void*, Uint8*, int);



#endif //ASR1_BEEPER_H
