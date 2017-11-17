#include "memory.h" 

class YogurtPool {
 public:
	YogurtPool(Memory* m);
	~YogurtPool();
	void von_Neuman_step(bool debug, bool &stop);

	int getNb_readbits() const;

private:
	void read_bit_from_pc(int& var);
	void read_reg_from_pc(int& var);
	void read_const_from_pc(uint64_t& var);
    void read_sconst_from_pc(uint64_t &var);


	void read_addr_from_pc(uword& var);
	void read_shiftval_from_pc(int& var);

	void read_counter_from_pc(int& var);
	uword* getPtrToCounter(int counter);

	void read_size_from_pc(int& var);

	void read_cond_from_pc(int& var);
	bool cond_true(int cond);

	// ======== Instructions =========== \\


	void jump(uword& offset, bool& manage_flags);
	void jumpif(uword& offset, bool& manage_flags);
    void jumpifreg(int &regnum1, bool &manage_flags);

	void write(int& counter, int& size, uword& val);
    void jumpreg(int &regnum1, bool &manage_flags);


    // ======== Functions for Stats Gathering =========== \\

    void write_toRam(int counter, int bit);



	Memory *m;
	uword pc;
	uword sp;
	uword a1;
	uword a2;
	// The registers. Beware, they are defined as unsigned integers:
	// they should be cast to signed when needed

	// On avait pas dit 16 registres ?
	uword r[8];

    int nb_reg = 8;

	// the flags
	bool zflag;
	bool cflag;
	bool nflag;
    bool vflag;


	// ============= Data Simulation ========== \\

	int nb_read_bits_frompc = 0;
	int bitsToram = 0;
	int bitsFromRam = 0;

};
