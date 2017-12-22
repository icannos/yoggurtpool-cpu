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
                if (!escape && m->m[(MEM_AUDIO_BEGIN >> 6)] != 0) {


                    uint64_t tempo_word = m->m[(MEM_AUDIO_BEGIN >> 6) + 1];
                    auto tempo = (uint16_t) ((tempo_word >> ((63 - 16))) & 0xffff);


                    uint64_t mword = m->m[((MEM_AUDIO_BEGIN) >> 6) + 1 + (i >> 2)];
                    auto beep = (uint16_t) ((mword >> ((63 - 16) - (i & 3) << 4)) & 0xffff);

                    __uint128_t mask = ~(__uint128_t) ((((1 << 64) - 1) &
                                                        (((1 << 16) - 1)) << ((63 - 16) - (i % 3) << 16)));

                    m->m[((MEM_AUDIO_BEGIN) >> 6) + (i >> 2)] = mword & (uint64_t) mask;

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

        if (m->m[(MEM_AUDIO_BEGIN >> 6)] != 0)
            m->m[(MEM_AUDIO_BEGIN >> 6)] = 0;
        if (m->m[(MEM_AUDIO_BEGIN >> 6)] != 1)
            m->m[(MEM_AUDIO_BEGIN >> 6)] = MEM_AUDIO_BEGIN+64;



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
