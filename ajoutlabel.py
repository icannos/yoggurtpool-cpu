#!/usr/bin/env python

# This program assembles source assembly code into a bit string.
# The bit string includes spaces and newlines for readability,
# these should be ignored by the simulator when it reads the corresponding file.

import os
import sys
import re
import string
import argparse
from numpy import binary_repr

line = 0  # global variable to make error reporting easier
current_addr = 0  # idem
labels = {}  # global because shared between the two passe


def error(e):
    raise BaseException("Error at line " + str(line) + " : " + e)

def list_to_str(l):
	rep = ""
	for i in l :
		rep += i + ' '
	return rep

from time import time

def built_includes(s_file, directory) :
	code = ""
	a_inclure = []
	current_address = 0
	source = open(s_file)
	for source_line in source:
		# if there is a comment, get rid of it
		index = source_line.find(';')
		print(index)
		if index != -1:
			print("hey")
			source_line = source_line[:index]
		# split the non-comment part of the line into tokens (thanks Stack Overflow) 
		tokens = re.findall('[\S]+', source_line)  # \S means: any non-whitespace
		print(tokens)  # to debug

        # if there is a label, consume it
		if tokens:
			if tokens[0] == "#include":  # last character
				a_inclure.append(tokens[1]+'.s')
			else :
				for i in tokens :
					code+= i + ' '
				code+= '\n'
	print(a_inclure)
	return (code, a_inclure)


def asm_bitsload(bitfile, directory):
    f = open(directory + '/' + bitfile, "r")
    bits = f.read()
    f.close()
    return bits

def asm_addr_signed(prefixe,s, c, let=0):
	if s[0:2] == '0x' or s[0:3] == '+0x' or s[0:3] == '-0x':
		val = s 
	elif (s[0] >= '0' and s[0] <= '9') or s[0] == '-' or s[0] == '+': 
		val = s
	else :
		val = prefixe + "_" + s
	return val


def prefixage(iteration, s_file, directory, prefixe):
    global line
    global labels
    global current_address

    global current_address_for_label

    code = []  # array of strings, one entry per instruction
    print("\n PASS " + str(iteration))
    current_address = 0
    source = open(s_file)
    for source_line in source:
        reecrit = ""
        print("processing " + source_line[0:-1])  # just to get rid of the final newline
		
		# if there is a comment, get rid of it
        index = source_line.find(';')
        print(index)
        if index != -1:
            print("hey")
            source_line = source_line[:index]

        # split the non-comment part of the line into tokens (thanks Stack Overflow) 
        tokens = re.findall('[\S]+', source_line)  # \S means: any non-whitespace
        print(tokens)  # to debug

        # if there is a label, consume it
        if tokens:
            token = tokens[0]
            if token[-1] == ":":  # last character
				reecrit = prefixe + "_" + token

        # now all that remains should be an instruction... or nothing
        if tokens:
            opcode = tokens[0]
            token_count = len(tokens)
            if opcode == "add2" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "add2i" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "sub2" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "sub2i" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "cmp" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "cmpi" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "let" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "leti" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "letiaj" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "letiac" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "shift" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "readze" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "readse" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "jump" and token_count == 2:
                reecrit = "jump " + asm_addr_signed(prefixe,tokens[1], "jump")
            if opcode == "jumpif" and token_count == 3:
                reecrit = "jumpif " + tokens[1]+" " + asm_addr_signed(prefixe,tokens[2], "jump")
            if opcode == "or2" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "or2i" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "and2" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "and2i" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "write" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "call" and token_count == 2:
                reecrit= "call " + asm_addr_signed(prefixe,tokens[1], "call")
            if opcode == "setctr" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "getctr" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "push" and token_count == 3:
                reecrit = list_to_str(tokens)
            if opcode == "return" and token_count == 1:
                reecrit = list_to_str(tokens)
            if opcode == "add3" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "add3i" and token_count == 4:  
                reecrit = list_to_str(tokens)
            if opcode == "sub3" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "sub3i" and token_count == 4: 
                reecrit = list_to_str(tokens)
            if opcode == "and3" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "and3i" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "or3" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "or3i" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "xor3" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "xor3i" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "asr3" and token_count == 4: 
                reecrit = list_to_str(tokens)
            if opcode == "jumpreg" and token_count == 2:
                reecrit = list_to_str(tokens)
            if opcode == "jumpifreg" and token_count == 3:
                reecrit = list_to_str(tokens)

            if opcode == "pop" and token_count == 3:
                reecrit = list_to_str(tokens)

            if opcode == "load" and token_count == 2:
                reecrit = list_to_str(tokens)

			#le const que nous n'avions pas lu:
            if opcode == ".const" and token_count == 3:
                reecrit = list_to_str(tokens)

			#du sucre
            if opcode == ".plot" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == ".draw" and token_count == 6:
                reecrit = list_to_str(tokens)
            if opcode == ".fill" and token_count == 6:
                reecrit = list_to_str(tokens)
            if opcode == ".char" and token_count == 5:
#on se met la ou est la premiere lettre et on se deplace vers la gauche de 10 a chaque fois
                reecrit = list_to_str(tokens)
                


                # If the line wasn't assembled:
            if reecrit == "":
                error("don't know what to do with: " + source_line)
            else:
                # Debug output
                print("... @" + str(current_address) + " " + binary_repr(current_address,
                                                                         16) + "  :  ")
                print("                          " + reecrit )
                #current_address += instr_size

        line += 1
        code.append(reecrit)
    source.close()
    return code


# /* main */
if __name__ == '__main__':

	argparser = argparse.ArgumentParser(description='This is the assembler for the ASR2017 processor @ ENS-Lyon')
	argparser.add_argument('filename',
                           help='name of the source file.  "python asm.py toto.s" assembles toto.s into toto.obj')

	argparser.add_argument('--output',
                           help='Name and where the output should be put.')

	options = argparser.parse_args()
	filename = options.filename
	basefilename, extension = os.path.splitext(filename)
	SRC, include_liste = built_includes(filename, directory = os.path.dirname(filename))
	for i in include_liste :
		SRC+= prefixage(1, i, "/prog", prefixe = str(i))
	print(SRC)

