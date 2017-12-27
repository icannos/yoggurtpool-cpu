//
// Created by maxime on 20/12/17.
//

#include "audio.h"
#include <bitset>
#include <math.h>



void simulate_audio(Memory *m) {

    SDL_Init(SDL_INIT_AUDIO);

    double midi[127];

    double a = 440; // a is 440 hz...

    for (int x = 0; x < 127; x++) {
        double puiss = pow( 2.0, ((x - 9.0) / 12.0) );

        midi[x] = ((a / 32) * puiss);

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

        float tempo = 500;

            for (unsigned int i = 0; i < NB_NOTES-70; i++) {
                if ((m->m[((MEM_AUDIO_BEGIN) >> 6)-1] & 1) != 0 || (m->m[((MEM_AUDIO_BEGIN) >> 6)-1] & 2) != 0) {
                    uint64_t mword = m->m[((MEM_AUDIO_BEGIN+64) >> 6) + (i >> 2)];

                    uint16_t beep = (uint16_t) ((mword >> ((63 - 16) - (i & 3) << 4)) & 0xffff);


                    auto duration = (uint16_t) ((beep >> 9) & ((1 << 9) - 1));
                    auto note = (uint16_t) (beep & ((1 << 7) - 1));

/*                   std::cout << "Note: " << note << std::endl;
                    std::cout << "Duree: " << duration << std::endl;
                    std::bitset<16> z(beep);
                    std::cout << "beep: " << z << std::endl;

                    std::bitset<64> x(mword);*/
                    //std::cout << "mword: " << x << std::endl;
                    if (duration == 0) {
                        break;
                    } else {
                        // std::cout << "Note: " << midi[note] << std::endl;
                        // std::cout << "Tempo: " << getTempo(duration) << std::endl;
                        // std::cout << "Effec duration: " << (float) (tempo * getTempo(duration)) << std::endl;
                        b.beep(midi[note], (float) (tempo * getTempo(duration)));
                        b.wait();
                    }

                } else {
                    break;
                }
            }

        //std::bitset<64> x(m->m[((MEM_AUDIO_BEGIN-1) >> 6)] );
        //std::cout << "CTRL: " << x << std::endl;

        //std::cout << (int)(m->m[((MEM_AUDIO_BEGIN-1) >> 6)] & (uword)(((doubleword)(1 << 64) - 1) & ~3)) << std::endl;
        if ((m->m[((MEM_AUDIO_BEGIN) >> 6)-1] & 1) == 1)// Get bit of AUDIO_CTRL
            m->m[((MEM_AUDIO_BEGIN) >> 6)-1] = m->m[((MEM_AUDIO_BEGIN) >> 6)-1] & (uword)(((doubleword)(1 << 64) - 1) & ~3); // Set the last 2 bits to 0



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
            return 0.0;
        case 1:
            return 1.0;
        case 2:
            return 0.3333;
        case 3:
            return 0.6666;
        case 4:
            return 0.5;
        case 5:
            return 0.25;
        case 6:
            return 0.125;
        case 7:
            return 1.5;
        case 8:
            return 0.75;
        case 9:
            return 1.333;
        case 10:
            return 2.5;
        case 11:
            return 2.25;
        case 12: return 1.25;



    }
}
