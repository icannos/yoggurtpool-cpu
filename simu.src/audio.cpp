//
// Created by maxime on 20/12/17.
//

#include "audio.h"

void simulate_audio(Memory *m) {

    SDL_Init(SDL_INIT_AUDIO);

    float midi[127];

    int a = 440; // a is 440 hz...

    for (int x = 0; x < 127; ++x) {
        midi[x] = (a / 32) * (2 ^ ((x - 9) / 12));
    }


    Beeper b;

    SDL_Event e;

    bool escape = false;

    Uint32 last_time = SDL_GetTicks();;

    while (!escape) {
        /*deal with events*/
        while (SDL_PollEvent(&e) != 0) { // S'il se passe qqchose

            if (e.type == SDL_QUIT) {
                escape = true;
            }
        }

            for (unsigned int i = 1; i < NB_NOTES; i++) {
                if ((m->m[((MEM_AUDIO_BEGIN-1) >> 6)] & 3) != 0) {
                    uint16_t tempo = 1000;


                    uint64_t mword = m->m[((MEM_AUDIO_BEGIN) >> 6) + 1 + (i >> 2)];
                    auto beep = (uint16_t) ((mword >> ((63 - 16) - (i & 3) << 4)) & 0xffff);


                    auto duration = (uint8_t) ((beep >> 8) & ((1 << 8) - 1));
                    auto note = (uint16_t) (beep & ((1 << 8) - 1));

                    if (duration == 0) {
                        break;
                    } else {
                        b.beep(midi[note], (uint16_t) (tempo * getTempo(duration)));
                        b.wait();
                    }

                } else {
                    break;
                }
            }


        if ((m->m[((MEM_AUDIO_BEGIN-1) >> 6)] & 3) == 1)// Get bit of AUDIO_CTRL
            m->m[((MEM_AUDIO_BEGIN-1) >> 6)] = m->m[((MEM_AUDIO_BEGIN-1) >> 6)] & (((1 << 64) - 1) & ~3); // Set the last 2 bits to 0



        Uint32 current = SDL_GetTicks();
        if (current - last_time < (1000.f * 1.f / 60.f)) {
            SDL_Delay((1000.f * 1.f / 60.f) - last_time + current);
        }
        //refresh = false;
        last_time = current;

    }


}

float getTempo(uint16_t duration) {
    switch (duration) {
        case 0:
            return 0;
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 4;
        case 4:
            return 1 / 2;
        case 5:
            return 1 / 4;
        case 6:
            return 1 / 8;


    }
}
