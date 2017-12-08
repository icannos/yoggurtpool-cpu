#include "processor.h"

#include <vector>

using namespace std;

char t[39][10] = {"add2", "add2i", "sub2", "sub2i", "cmp", "cmpi", "let", "leti", "shift", "tsnh", "jump", "jumpif",
                 "readze", "readse",
                 "or2", "or2i", "and2", "and2i", "write", "call", "setctr", "getctr", "push", "return", "add3", "add3i",
                 "sub3", "sub3i",
                 "and3", "and3i", "or3", "or3i", "xor3", "xor3i", "asr3", "jumpreg", "jumpifreg", "?", "???",

                  "addr_8", "addr_16", "addr_32","addr_64",
                  "shift_val_1","shift_val_6",

                  "cstalu_1", "cstalu_8", "cstalu_32","cstalu_64"
                  "size_1", "size_4","size_8","size_16","size_32","size_64"


                 };

YogurtPool::YogurtPool(Memory *m) : m(m) {
    pc = 0;

    sp = (1 << 30) - 1; // Début de notre pile (On a 1000 mots de 64 bits)
    m->set_counter(SP, (uword) sp);

    a1 = 0;
    a2 = 0;


    for (int i = 0; i < nb_reg; i++)
        r[i] = 0;
}

YogurtPool::~YogurtPool() {}


void YogurtPool::von_Neuman_step(bool debug, bool &stop) {
    // numbers read from the binary code
    int opcode = 0;
    int regnum1 = 0;
    int regnum2 = 0;

    int regnum3 = 0; // Utile pour les instructions à 3 opérandes

    uword *cptr = 0;
    uword addr = 0;

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


    if ((sword) pc < 0) {

        // Surtout ne pas toucher au pc là dedans ni au r[7] !

        switch ((sword) pc) {

            case -1:

                stop = true;

                pc = r[7];

                cout << "Instruction: " << dec << opcode << " | 0x" << hex << setw(8) << setfill('0') << opcode << endl;
                cout << "At pc= " << dec << instr_pc << " | 0x" << hex << setw(8) << setfill('0') << instr_pc << endl;
                cout << "pc after instr = " << dec << pc << " | 0x" << hex << setw(8) << setfill('0') << pc << endl;
                cout << "flags: zcn = " << (zflag ? 1 : 0) << (cflag ? 1 : 0) << (nflag ? 1 : 0);
                cout << endl;

                cout << "Registre       Hexa      Dec" << endl;
                for (int i = 0; i < 8; i++) {
                    cout << "|";
                    cout << " r" << dec << i << "= 0x" << hex << setw(8) << setfill('0') << r[i];
                    cout << "        ";
                    cout << dec << (sword) r[i]; // Valeur en décimal par que c'est bien aussi !
                    cout << "|";
                    cout << endl;
                }
                cout << endl;
                cout << "===============================" << endl;


                break;

                // Place pour d'autres instructions.
        }


        //On retourne au pc d'avant ici:
        pc = r[7];
    } else {
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
                manage_addvflag(uop1, uop2, ur);
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
                manage_addvflag(uop1, uop2, ur);
                break;

            case 0x2: // sub2
                read_reg_from_pc(regnum1);
                read_reg_from_pc(regnum2);
                uop1 = r[regnum1];
                uop2 = r[regnum2];
                fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags
                ur = uop1 - uop2;
                r[regnum1] = ur;
                manage_flags = true;
                manage_subvflag(uop1, uop2, ur);
                break;

            case 0x3: //sub2i
                read_reg_from_pc(regnum1);
                read_const_from_pc(constop);
                uop1 = r[regnum1];
                uop2 = constop;
                fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags
                ur = uop1 - uop2;
                r[regnum1] = ur;
                manage_flags = true;
                manage_subvflag(uop1, uop2, ur);
                break;

            case 0x4: //cmp
                read_reg_from_pc(regnum1);
                read_reg_from_pc(regnum2);
                uop1 = r[regnum1];
                uop2 = r[regnum2];
                fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags
                ur = uop1 - uop2;
                manage_flags = true;
                manage_subvflag(uop1, uop2, ur);
                break;

            case 0x5: //cmpi
                read_reg_from_pc(regnum1);
                read_sconst_from_pc(constop);
                uop1 = r[regnum1];
                uop2 = constop;
                fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags

                ur = uop1 - uop2;

                manage_flags = true;
                manage_subvflag(uop1, uop2, ur);
                break;

            case 0x6: //let
                read_reg_from_pc(regnum1);
                read_reg_from_pc(regnum2);

                r[regnum1] = r[regnum2];

                break;

            case 0x7: //leti
                read_reg_from_pc(regnum1);
                read_sconst_from_pc(constop);
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


            case 0x9:
                read_bit_from_pc(opcode);

                switch (opcode) {
                    case 0x12: //readze
                        read_counter_from_pc(counter);
                        read_size_from_pc(size);
                        read_reg_from_pc(regnum1);

                        cptr = getPtrToCounter(counter);
                        ur = 0;
                        for (int i = 0; i < size; i++) {
                            ur = (ur << 1) + m->read_bit(counter);
                            (*cptr)++;
                            bitsFromRam++;
                        }
                        r[regnum1] = ur;
                        manage_flags = false;
                        break;

                    case 0x13: //readse
                        read_counter_from_pc(counter);
                        read_size_from_pc(size);
                        read_reg_from_pc(regnum1);

                        cptr = getPtrToCounter(counter);

                        ur = 0;

                        for (int i = 0; i < size; i++) {
                            ur = (ur << 1) + m->read_bit(counter);
                            (*cptr)++;
                            bitsFromRam++;
                        }


                        uword sign = (ur >> (size - 1)) & 1;
                        for (int i = size; i < WORDSIZE; i++)
                            ur += sign << i;

                        r[regnum1] = ur;
                        manage_flags = false;
                        break;
                }
                break;


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
                    case 0x30: //or2

                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        uop1 = r[regnum1];
                        uop2 = r[regnum2];

                        ur = uop1 | uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x31: //or2i

                        read_reg_from_pc(regnum1);
                        read_sconst_from_pc(constop);
                        uop1 = r[regnum1];
                        uop2 = constop;

                        ur = uop1 | uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x32: //and2

                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        uop1 = r[regnum1];
                        uop2 = r[regnum2];

                        ur = uop1 & uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;

                    case 0x33://and2i
                        read_reg_from_pc(regnum1);
                        read_sconst_from_pc(constop);
                        uop1 = r[regnum1];
                        uop2 = r[constop];

                        ur = uop1 & uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;


                    case 0x34: // write
                        read_counter_from_pc(counter);
                        read_size_from_pc(size);
                        read_reg_from_pc(regnum1);

                        write(counter, size, r[regnum1]);
                        manage_flags = false;
                        break;

                    case 0x35: //call
                        read_addr_from_pc(addr);

                        r[7] = pc;

                        pc = addr;
                        m->set_counter(PC, (uword) pc);
                        break;

                    case 0x36: //setctr
                        read_counter_from_pc(counter);
                        read_reg_from_pc(regnum1);

                        cptr = getPtrToCounter(counter);
                        *cptr = r[regnum1];
                        m->set_counter(counter, r[regnum1]);
                        break;

                    case 0x37: //getctr
                        read_counter_from_pc(counter);
                        read_reg_from_pc(regnum1);

                        cptr = getPtrToCounter(counter);
                        r[regnum1] = *cptr;
                        break;

                }
                break; // Do not forget this break!

            case 0xe:
            case 0xf:
                //read 3 more bits
                read_bit_from_pc(opcode);
                read_bit_from_pc(opcode);
                read_bit_from_pc(opcode);

                switch (opcode) {
                    case 0x70://push
                        read_size_from_pc(size);
                        read_reg_from_pc(regnum1);

                        sp -= size;

                        m->set_counter(SP, (uword) sp);

                        for (int i = size - 1; i >= 0; i--) {
                            write_toRam(SP, (r[regnum1] >> i) & 1);
                            sp++;
                        }

                        sp -= size;

                        m->set_counter(SP, (uword) sp);

                        break;
                    case 0x71://return
                        pc = r[7];
                        m->set_counter(PC, (uword) pc);
                        break;
                    case 0x72://add3
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_reg_from_pc(regnum3);
                        uop1 = r[regnum2];
                        uop2 = r[regnum3];
                        fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
                        ur = uop1 + uop2;
                        r[regnum1] = ur;
                        manage_flags = true;
                        manage_addvflag(uop1, uop2, ur);


                        break;

                    case 0x73://add3i
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_sconst_from_pc(constop);
                        uop1 = r[regnum2];
                        uop2 = constop;
                        fullr = ((doubleword) uop1) + ((doubleword) uop2); // for flags
                        ur = uop1 + uop2;
                        r[regnum1] = ur;
                        manage_flags = true;
                        manage_addvflag(uop1, uop2, ur);
                        break;
                    case 0x74://sub3
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_reg_from_pc(regnum3);
                        uop1 = r[regnum2];
                        uop2 = r[regnum3];
                        fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags
                        ur = uop1 - uop2;
                        r[regnum1] = ur;
                        manage_flags = true;
                        manage_subvflag(uop1, uop2, ur);
                        break;
                    case 0x75://sub3i
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_const_from_pc(constop);
                        uop1 = r[regnum2];
                        uop2 = constop;
                        fullr = ((doubleword) uop1) - ((doubleword) uop2); // for flags
                        ur = uop1 - uop2;
                        r[regnum1] = ur;
                        manage_flags = true;
                        manage_subvflag(uop1, uop2, ur);
                        break;
                    case 0x76: //and3
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_reg_from_pc(regnum3);
                        uop1 = r[regnum2];
                        uop2 = r[regnum3];

                        ur = uop1 & uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x77: //and3i
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_sconst_from_pc(constop);
                        uop1 = r[regnum2];
                        uop2 = constop;

                        ur = uop1 & uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x78: //or3
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_reg_from_pc(regnum3);

                        uop1 = r[regnum2];
                        uop2 = r[regnum3];

                        ur = uop1 | uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;

                    case 0x79: //or3i
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_sconst_from_pc(constop);

                        uop1 = r[regnum2];
                        uop2 = constop;

                        ur = uop1 | uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.

                        break;
                    case 0x7a: //xor3
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_reg_from_pc(regnum3);

                        uop1 = r[regnum2];
                        uop2 = r[regnum3];

                        ur = uop1 ^ uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x7b: //xor3i
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_sconst_from_pc(constop);

                        uop1 = r[regnum2];
                        uop2 = constop;

                        ur = uop1 ^ uop2;
                        r[regnum1] = ur;

                        if (ur == 0) {
                            zflag = true;
                        } else {
                            zflag = false;
                        }

                        manage_flags = false; // On ne touche pas aux autres flags.
                        break;
                    case 0x7c: //asr3
                        read_bit_from_pc(dir);
                        read_reg_from_pc(regnum1);
                        read_reg_from_pc(regnum2);
                        read_shiftval_from_pc(shiftval);
                        uop1 = r[regnum2];
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


                        // ============ Pour les trucs en plus =============== \\

                    case 0x7d: //Jump reg
                        jumpreg(regnum1, manage_flags);
                        break;
                    case 0x7e: //Jumpifreg
                        jumpifreg(regnum1, manage_flags);
                        break;
                    case 0x7f: //img print
                        break;

                }
                break;
        }

    }

    // flag management
    if (manage_flags) {
        zflag = (ur == 0);
        cflag = (fullr > ((doubleword) 1) << WORDSIZE);
        nflag = (0 > (sword) ur);
    }

    if (debug) {
        cout << "after instr: " << (int) opcode
             << " at pc=" << hex << setw(8) << setfill('0') << instr_pc
             << " (newpc=" << hex << setw(8) << setfill('0') << pc
             << " mpc=" << hex << setw(8) << setfill('0') << m->counter[0]
             << " msp=" << hex << setw(8) << setfill('0') << m->counter[1]
             << " ma0=" << hex << setw(8) << setfill('0') << m->counter[2]
             << " ma1=" << hex << setw(8) << setfill('0') << m->counter[3] << ") ";
        //				 << " newpc=" << hex << setw(9) << setfill('0') << pc;
        cout << " zcnv = " << (zflag ? 1 : 0) << (cflag ? 1 : 0) << (nflag ? 1 : 0) << (vflag ? 1 : 0);
        for (int i = 0; i < 8; i++) {
            cout << " r" << dec << i << "=" << hex << setw(8) << setfill('0') << r[i];
            cout << " dec-r" << dec << i << "=" << r[i]; // Valeur en décimal par que c'est bien aussi !
        }
        cout << endl;
    }



    // My debug print:


    if (debug) {
        cout << "Instruction: " << dec << opcode << " | 0x" << hex << setw(8) << setfill('0') << opcode << endl;
        cout << "At pc= " << dec << instr_pc << " | 0x" << hex << setw(8) << setfill('0') << instr_pc << endl;
        cout << "pc after instr = " << dec << pc << " | 0x" << hex << setw(8) << setfill('0') << pc << endl;
        cout << "flags: zcn = " << (zflag ? 1 : 0) << (cflag ? 1 : 0) << (nflag ? 1 : 0);
        cout << endl;

        cout << "Registre       Hexa      Dec" << endl;
        for (int i = 0; i < 8; i++) {
            cout << "|";
            cout << " r" << dec << i << "= 0x" << hex << setw(8) << setfill('0') << r[i];
            cout << "        ";
            cout << dec << (sword) r[i]; // Valeur en décimal par que c'est bien aussi !
            cout << "|";
            cout << endl;
        }
        cout << endl;
        cout << "===============================" << endl;
    }

}


// form now on, helper methods. Read and understand...

void YogurtPool::read_bit_from_pc(int &var) {
    var = (var << 1) + m->read_bit(PC); // the read_bit updates the memory's PC
    pc++;// this updates the processor's PC

    // This is for evaluation of the ASM, it count the total number of bits which are read during the execution

    nb_read_bits_frompc++;

}

void YogurtPool::read_reg_from_pc(int &var) {
    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}


//unsigned
void YogurtPool::read_const_from_pc(uint64_t &var) {
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

void YogurtPool::read_sconst_from_pc(uint64_t &var) {
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
    if (header != 0) {
        uword sign = (var >> (size - 1)) & 1;
        for (int i = size; i < WORDSIZE; i++)
            var += sign << i;
    }

}


// Beware, this one is sign-extended
void YogurtPool::read_addr_from_pc(uword &var) {
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
    uword sign = (var >> (size - 1)) & 1;
    for (int i = size; i < WORDSIZE; i++)
        var += sign << i;
    // cerr << "after signext " << var << " " << (int)var << endl;

}


void YogurtPool::read_shiftval_from_pc(int &var) {
    int bit = 0;
    var = 0;
    read_bit_from_pc(bit);

    switch (bit) {
        case 1:
            var = 1;
            break;
        case 0:
            read_bit_from_pc(var);
            read_bit_from_pc(var);
            read_bit_from_pc(var);
            read_bit_from_pc(var);
            read_bit_from_pc(var);
            read_bit_from_pc(var);
            break;
        default:
            break;

    }
}

void YogurtPool::read_cond_from_pc(int &var) {
    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}


bool YogurtPool::cond_true(int cond) {
    switch (cond) {
        case 0 : // Egalité
            return (zflag);
            break;
        case 0x1 : // Différent
            return (!zflag);

        case 0x2: // op1 > op2 (version signée, complément à 2)
            return (!zflag) && (nflag && vflag) || (!(nflag) && !vflag);
            break;

        case 0x3: // op1 < op2 (version signée, complément à 2)
            return (nflag && !vflag) || (!nflag && vflag);
            break;

        case 0x4: //op1 > op2 non signée
            return (!cflag) && (!zflag);
            break;

        case 0x5: //op1 >= op2 non signée
            return !cflag;
            break;

        case 0x6:
            return (cflag); // <
            break;

        case 0x7: // <=
            return vflag;
            break;

    }
    throw "Unexpected condition code";
}


void YogurtPool::read_counter_from_pc(int &var) {

    var = 0;
    read_bit_from_pc(var);
    read_bit_from_pc(var);
}

uword *YogurtPool::getPtrToCounter(int counter) {
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

void YogurtPool::read_size_from_pc(int &size) {
    int header = 0;
    size = 0;

    read_bit_from_pc(header);
    read_bit_from_pc(header);

    switch (header) {
        case 0x0: // 1 bit
            size = 1;
            break;
        case 0x1: // 4 bits
            size = 4;
            break;
        case 0x3:
        case 0x2: // Changement de taille d'opcode dans hamming
            read_bit_from_pc(header); // On lit un bit de plus

            switch (header) {
                case 0x4: // 8 bits
                    size = 8;
                    break;
                case 0x5: // 16 bits
                    size = 16;
                    break;
                case 0x6: //32 bits
                    size = 32;
                    break;
                case 0x7: // 64 bits
                    size = 64;
                    break;
            }

            break;
    }


}

void YogurtPool::manage_addvflag(uword &uop1, uword &uop2, uword &ur) {
    if (((int) uop1 >= 0 && (int) uop2 <= 0) ||
        ((int) uop2 >= 0 && (int) uop1 <= 0)) // Si les 2 sont pas de même signes: pas d'overflow
        vflag = false;
    else {
        if (((int) uop1 >= 0 && (int) uop2 >= 0) && (int) ur <= 0)
            vflag = true;
        if (((int) uop1 <= 0 && (int) uop2 >= 0) && (int) ur <= 0)
            vflag = true;
    }

}

void YogurtPool::manage_subvflag(uword &uop1, uword &uop2, uword &ur) {
    if (((int) uop1 >= 0 && (int) uop2 >= 0) ||
        ((int) uop2 <= 0 && (int) uop1 <= 0)) // Si les 2 sont pas de même signes: pas d'overflow
        vflag = false;
    else {
        if (((int) uop1 > 0 && (int) uop2 < 0) && (int) ur <= 0)
            vflag = true;
        if (((int) uop1 < 0 && (int) uop2 > 0) && (int) ur >= 0)
            vflag = true;
    }

}


// ==================== Instructions ======================= \\

void YogurtPool::jump(uword &offset, bool &manage_flags) {

    read_addr_from_pc(offset);

    pc += (sword) offset;
    m->set_counter(PC, (uword) pc);


    manage_flags = false;


}

void YogurtPool::jumpreg(int &regnum1, bool &manage_flags) {
    read_reg_from_pc(regnum1);
    pc += (sword) r[regnum1];
    m->set_counter(PC, (uword) pc);
    manage_flags = false;
}

void YogurtPool::jumpifreg(int &regnum1, bool &manage_flags) {
    int cond = 0;
    read_cond_from_pc(cond);
    read_reg_from_pc(regnum1);
    if (cond_true(cond)) {
        pc += (sword) r[regnum1];
        m->set_counter(PC, (uword) pc);
    }
    manage_flags = false;
}

void YogurtPool::jumpif(uword &offset, bool &manage_flags) {
    int cond = 0;

    read_cond_from_pc(cond);
    read_addr_from_pc(offset);

    if (cond_true(cond)) {
        pc += (sword) offset;
        m->set_counter(PC, (uword) pc);
    }
    manage_flags = false;


}

void YogurtPool::write(int &counter, int &size, uword &val) {

    // On récupère un pointeur vers l'attribut correspond au bon counter.
    uword *p_Counter = getPtrToCounter(counter);

    uword val1 = (val << (WORDSIZE - size));

    for (int i = WORDSIZE - 1;
         i >= WORDSIZE - size; i--) { // On écrit le bon nombre de bits, à partir de l'adresse du counter donné.
        write_toRam(counter, (val1 >> i) & 1);
        (*p_Counter)++;
    }

}

// ================= Encapsulation pour pouvoir suivre le trajet des bits et les compter  ========================= \\

void YogurtPool::write_toRam(int counter, int bit) {
    m->write_bit(counter, bit);
    bitsToram++;
}

// ================= Getters && Setters ========================= \\

int YogurtPool::getNb_readbits() const {
    return nb_read_bits_frompc;
}






