#include "processor.h"

using namespace std;

Processor::Processor(Memory *m) : m(m) {
    pc = 0;
    sp = 0;
    a1 = 0;
    a2 = 0;

    for (int i = 0; i < nb_reg; i++)
        r[i] = 0;
}

Processor::~Processor() {}


void Processor::von_Neuman_step(bool debug) {
    // numbers read from the binary code
    int opcode = 0;
    int regnum1 = 0;
    int regnum2 = 0;

    int regnum3 = 0; // Utile pour les instructions à 3 opérandes

    int shiftval = 0;
    int condcode = 0;
    int counter = 0;
    int size = 0;
    uword offset;
    uint64_t constop = 0;
    int dir = 0;
    // each instruction will use some of the following variables:
    // all unsigned, to be cast to signed when required.
    uword uop1;
    uword uop2;
    uword ur = 0;
    doubleword fullr;
    bool manage_flags = false; // used to factor out the flag management code
    int instr_pc = pc; // for the debug output

    // read 4 bits.
    read_bit_from_pc(opcode);
    read_bit_from_pc(opcode);
    read_bit_from_pc(opcode);
    read_bit_from_pc(opcode);

    switch (opcode) {

        case 0x0: // add2
            read_reg_from_pc(regnum1);
            read_reg_from_pc(regnum2);
            uop1 = r[regnum1];
            uop2 = r[regnum2];
            fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
            ur = uop1 + uop2;
            r[regnum1] = ur;
            manage_flags = true;
            break;

        case 0x1: // add2i
            read_reg_from_pc(regnum1);
            read_const_from_pc(constop);
            uop1 = r[regnum1];
            uop2 = constop;
            fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
            ur = uop1 + uop2;
            r[regnum1] = ur;
            manage_flags = true;
            break;

        case 0x2: // sub2
            break;

        case 0x3: //sub2i
            break;

        case 0x4: //cmp
            break;

        case 0x5: //cmpi
            break;

        case 0x6: //let
            read_reg_from_pc(regnum1);
            read_reg_from_pc(regnum2);

            r[regnum1] = r[regnum2];

            break;

        case 0x7: //leti
            read_reg_from_pc(regnum1);
            read_const_from_pc(constop);

            r[regnum1] = constop;
            break;


        case 0x8: // shift
            read_bit_from_pc(dir);
            read_reg_from_pc(regnum1);
            read_shiftval_from_pc(shiftval);
            uop1 = r[regnum1];
            if (dir == 1) { // right shift
                ur = uop1 >> shiftval;
                cflag = (((uop1 >> (shiftval - 1)) & 1) == 1);
            } else {
                cflag = (((uop1 << (shiftval - 1)) & (1L << (WORDSIZE - 1))) != 0);
                ur = uop1 << shiftval;
            }
            r[regnum1] = ur;
            zflag = (ur == 0);
            // no change to nflag
            manage_flags = false;
            break;

            // begin sabote
            //end sabote


        case 0xa: // jump
            jump(offset, manage_flags);
            break;

        case 0xb: //jump if
            jumpif(offset, manage_flags);
            break;

        case 0xc:
        case 0xd:
            //read two more bits

            read_bit_from_pc(opcode);
            read_bit_from_pc(opcode);



            switch (opcode) {
                case 110000: //or2

                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    uop1 = r[regnum1];
                    uop2 = r[regnum2];

                    ur = uop1 | uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;
                case 11000: //or2

                    read_reg_from_pc(regnum1);
                    read_const_from_pc(constop);
                    uop1 = r[regnum1];
                    uop2 = constop;

                    ur = uop1 | uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;
                case 110010: //and2

                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    uop1 = r[regnum1];
                    uop2 = r[regnum2];

                    ur = uop1 & uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;

                case 110011://and2i
                    read_reg_from_pc(regnum1);
                    read_const_from_pc(constop);
                    uop1 = r[regnum1];
                    uop2 = r[constop];

                    ur = uop1 & uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;

                    break;


                case 110100: // write
                    write(counter, size, regnum1);
                    manage_flags=false;
                    break;

                case 110101: //call
                    break;

                case 110110: //setctr
                    break;

                case 110111: //getctr
                    break;

            }
            break; // Do not forget this break!

        case 0xe:
        case 0xf:
            //read 3 more bits
            read_bit_from_pc(opcode);
            read_bit_from_pc(opcode);
            read_bit_from_pc(opcode);

            switch (opcode)
            {
                case 1110000://push
                    break;
                case 1110001://return
                    break;
                case 1110010://add3
                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    read_reg_from_pc(regnum3);
                    uop1 = r[regnum2];
                    uop2 = r[regnum3];
                    fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
                    ur = uop1 + uop2;
                    r[regnum1] = ur;
                    manage_flags = true;
                    break;

                case 1110011://add3i
                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    read_const_from_pc(constop);
                    uop1 = r[regnum2];
                    uop2 = constop;
                    fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
                    ur = uop1 + uop2;
                    r[regnum1] = ur;
                    manage_flags = true;
                    break;
                case 1110100://sub3
                    break;
                case 1110101://sub3i
                    break;
                case 1110110: //and3
                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    read_reg_from_pc(regnum3);
                    uop1 = r[regnum2];
                    uop2 = r[regnum3];

                    ur = uop1 & uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;
                case 1110111: //and3i
                    break;
                case 1111000: //or3
                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    read_reg_from_pc(regnum3);

                    uop1 = r[regnum2];
                    uop2 = r[regnum3];

                    ur = uop1 | uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.
                    break;

                case 1111001: //or3i
                    read_reg_from_pc(regnum1);
                    read_reg_from_pc(regnum2);
                    read_const_from_pc(constop);

                    uop1 = r[regnum2];
                    uop2 = constop;

                    ur = uop1 | uop2;
                    r[regnum1] = ur;

                    if (ur == 0)
                    {
                        zflag = true;
                    }
                    else
                    {
                        zflag=false;
                    }

                    manage_flags = false; // On ne touche pas aux autres flags.

                    break;
                case 1111010: //xor3
                    break;
                case 1111011: //xor3i
                    break;
                case 1111100: //asr3
                    break;


                // ============ Pour les trucs en plus =============== \\
                case 1111101: //asr3
                    break;
                case 1111110: //asr3
                    break;
                case 1111111: //asr3
                    break;

            }
            break;
    }

    // flag management
    if (manage_flags) {
        zflag = (ur == 0);
        cflag = (fullr > ((doubleword) 1) << WORDSIZE);
        nflag = (0 > (sword) ur);
    }

    if (debug) {
        cout << "after instr: " << opcode
             << " at pc=" << hex << setw(8) << setfill('0') << instr_pc
             << " (newpc=" << hex << setw(8) << setfill('0') << pc
             << " mpc=" << hex << setw(8) << setfill('0') << m->counter[0]
             << " msp=" << hex << setw(8) << setfill('0') << m->counter[1]
             << " ma0=" << hex << setw(8) << setfill('0') << m->counter[2]
             << " ma1=" << hex << setw(8) << setfill('0') << m->counter[3] << ") ";
        //				 << " newpc=" << hex << setw(9) << setfill('0') << pc;
        cout << " zcn = " << (zflag ? 1 : 0) << (cflag ? 1 : 0) << (nflag ? 1 : 0);
        for (int i = 0; i < 8; i++)
            cout << " r" << dec << i << "=" << hex << setw(8) << setfill('0') << r[i];
        cout << endl;
    }
}


// form now on, helper methods. Read and understand...

void Processor::read_bit_from_pc(int &var) {
    var = (var << 1) + m->read_bit(PC); // the read_bit updates the memory's PC
    pc++;// this updates the processor's PC

    // This is for evaluation of the ASM, it count the total number of bits which are read during the execution

    nb_readbits++;

}

void Processor::read_reg_from_pc(int &var) {
    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}


//unsigned
void Processor::read_const_from_pc(uint64_t &var) {
    var = 0;
    int header = 0;
    int size;
    read_bit_from_pc(header);
    if (header == 0)
        size = 1;
    else {
        read_bit_from_pc(header);
        if (header == 2)
            size = 8;
        else {
            read_bit_from_pc(header);
            if (header == 6)
                size = 32;
            else
                size = 64;
        }
    }
    // Now we know the size and we can read all the bits of the constant.
    for (int i = 0; i < size; i++) {
        var = (var << 1) + m->read_bit(PC);
        pc++;
    }
}


// Beware, this one is sign-extended
void Processor::read_addr_from_pc(uword &var) {
    var = 0;
    int header = 0;
    int size;
    var = 0;
    read_bit_from_pc(header);
    if (header == 0)
        size = 8;
    else {
        read_bit_from_pc(header);
        if (header == 2)
            size = 16;
        else {
            read_bit_from_pc(header);
            if (header == 6)
                size = 32;
            else
                size = 64;
        }
    }
    // Now we know the size and we can read all the bits of the constant.
    for (int i = 0; i < size; i++) {
        var = (var << 1) + m->read_bit(PC);
        pc++;
    }
    // cerr << "before signext " << var << endl;
    // sign extension
    int sign = (var >> (size - 1)) & 1;
    for (int i = size; i < WORDSIZE; i++)
        var += sign << i;
    // cerr << "after signext " << var << " " << (int)var << endl;

}


void Processor::read_shiftval_from_pc(int &var) {
    int bit = 0;
    var = 0;
    read_bit_from_pc(bit);

    switch (bit) {
        case 1:
            var = 1;
            break;
        case 0:
            read_bit_from_pc(var);
            break;
        default:
            break;

    }
}

void Processor::read_cond_from_pc(int &var) {
    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}


bool Processor::cond_true(int cond) {
    switch (cond) {
        case 0 : // Egalité
            return (zflag);
            break;
        case 0x1 : // Différent
            return (!zflag);

        case 0x2: // op1 > op2 (version signée, complément à 2

            break;

        case 0x3: // op1 < op2 (version signée, complément à 2)
            break;

        case 0x4: //op1 > op2 non signée
            return (!nflag) | (!zflag);
            break;

        case 0x5: //op1 >= op2 non signée
            return !(nflag);
            break;

        case 0x6: //op1 < op2 non signée
            return (nflag);
            break;

        case 0x7: //op1 <= op2 non signée
            return (nflag) | (zflag);
            break;

    }
    throw "Unexpected condition code";
}


void Processor::read_counter_from_pc(int &var) {

    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}

uword *Processor::getPtrToCounter(int counter) {
    switch (counter) {
        case 0x0:
            return &pc;
            break;
        case 0x1:
            return &sp;
            break;
        case 0x2:
            return &a1;
            break;
        case 0x3:
            return &a2;
            break;
        default:
            return nullptr;
    }
}

void Processor::read_size_from_pc(int &size) {
    int header = 0;
    int toRead = 0;

    read_bit_from_pc(header);
    read_bit_from_pc(header);

    switch (header) {
        case 0x0: // 1 bit
            toRead = 1;
            break;
        case 0x1: // 4 bits
            toRead = 4;
            break;
        case 0x2: // Changement de taille d'opcode dans hamming
            read_bit_from_pc(header); // On lit un bit de plus

            switch (header) {
                case 0x8: // 8 bits
                    toRead = 8;
                    break;
                case 0x9: // 16 bits
                    toRead = 16;
                    break;
                case 0x10: //32 bits
                    toRead = 32;
                    break;
                case 0x11: // 64 bits
                    toRead = 64;
                    break;
            }
            break;
    }

    // Maintenant on sait combien de bits lire pour former notre size

    for (int i = 0; i < toRead; i++) // On lit autant de bits qu'il faut et on les envoie dans size.
    {
        read_bit_from_pc(size);
    }


}

// ==================== Instructions ======================= \\

void Processor::jump(uword &offset, bool &manage_flags) {
    read_addr_from_pc(offset);
    pc += offset;
    m->set_counter(PC, (uword) pc);
    manage_flags = false;
}

void Processor::jumpif(uword &offset, bool &manage_flags) {
    int cond = 0;

    read_cond_from_pc(cond);

    if (cond_true(cond)) {
        jump(offset, manage_flags);
    }

}
void Processor::write(int& counter, int& size, int& regnum1) {
    read_counter_from_pc(counter);
    read_size_from_pc(size);
    read_reg_from_pc(regnum1);

    uword *p_Counter = getPtrToCounter(
            counter); // On récupère un pointeur vers l'attribut correspond au bon counter.

    for (int i = 0; i < size; i++) { // On écrit le bon nombre de bits, à partir de l'adresse du counter donné.
        m->write_bit(counter, (r[regnum1] >> i) & 1);
        (*p_Counter)++;
    }

}

// ================= Getters && Setters ========================= \\

int Processor::getNb_readbits() const {
    return nb_readbits;
}




