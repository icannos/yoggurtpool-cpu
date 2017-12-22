#!/usr/bin/env python


import os
import sys
import re
import string
import argparse

global exclusions
exclusions = []


def find_includes(source):
    '''

    :param source: A list of str (a src file line per line), the routine update it by removing lines with an include command
    :return: a list of str containing the names of the include1 files
    '''
    regexp = re.compile("#include\s+<(.+)>")

    includes = []
    for i in range(len(source)):

        include = re.findall(regexp, source[i])

        if include != None and include != []:
            source[i] = ""

            includes.append(include[0])

    return includes


def open_include(path):
    '''

    :param path: path to the file
    :return: A list of lines.
    '''
    f = open(path, "r")
    source = f.readlines()
    f.close()
    return source


def build_includes(source, srcpath):
    '''

    :param source: List of lines
    :param srcpath: Where should one look for the include files
    :return: List of lines including the includes.
    '''

    includes = find_includes(source)

    include_src = []

    for i in includes:
        # Open the file of path: srcpath/i
        # prefix: i = path/filename.s => path.filename
        include_src.append(prefixage(open_include(srcpath + i), os.path.splitext(i)[0].replace('/', '.')))

    newsource = source.copy()

    for i in include_src:
        newsource += i

    return newsource


def prefixage(source, prefixe):
    '''

    :param source: List of str (line per line of the source file

    :param prefixe: Prefix to add in the front of the labels
    :return: List of updated str
    '''

    global line
    global labels
    global current_address

    global current_address_for_label

    code = []  # array of strings, one entry per instruction

    for source_line in source:
        reecrit = ""

        # if there is a comment, get rid of it
        index = source_line.find(';')
        if index != -1:
            source_line = source_line[:index]

        # split the non-comment part of the line into tokens (thanks Stack Overflow)
        tokens = re.findall('[\S]+', source_line)  # \S means: any non-whitespace

        # if there is a label, consume it
        if tokens:
            token = tokens[0]
            if token[-1] == ":":  # last character
                if token[:-1] in exclusions:
                    reecrit = token
                else:
                    reecrit = prefixe + "." + token

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
                reecrit = "letiac " + tokens[1] + " " + asm_addr_signed(prefixe, tokens[2], "call")
            if opcode == "shift" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "readze" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "readse" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == "jump" and token_count == 2:
                reecrit = "jump " + asm_addr_signed(prefixe, tokens[1], "jump")
            if opcode == "jumpif" and token_count == 3:
                reecrit = "jumpif " + tokens[1] + " " + asm_addr_signed(prefixe, tokens[2], "jump")
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
                reecrit = "call " + asm_addr_signed(prefixe, tokens[1], "call")
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

            # le const que nous n'avions pas lu:
            if opcode == ".const" and token_count == 3:
                reecrit = list_to_str(tokens)

            # du sucre
            if opcode == ".plot" and token_count == 4:
                reecrit = list_to_str(tokens)
            if opcode == ".draw" and token_count == 6:
                reecrit = list_to_str(tokens)
            if opcode == ".fill" and token_count == 6:
                reecrit = list_to_str(tokens)
            if opcode == ".char" and token_count == 5:
                # on se met la ou est la premiere lettre et on se deplace vers la gauche de 10 a chaque fois
                reecrit = list_to_str(tokens)

        code.append(reecrit)
    return code


def list_to_str(l):
    rep = ""
    for i in l:
        rep += i + ' '
    return rep


def asm_addr_signed(prefixe, s, c, let=0):
    if s[0:2] == '0x' or s[0:3] == '+0x' or s[0:3] == '-0x':
        val = s
    elif (s[0] >= '0' and s[0] <= '9') or s[0] == '-' or s[0] == '+':
        val = s
    else:
        if s in exclusions:
            val = s
        else:
            val = prefixe + "." + s

    return val


if __name__ == '__main__':

    argparser = argparse.ArgumentParser(description='Include managers')

    argparser.add_argument('filename',
                           help='src file that needs to be prefixed', nargs='+')

    argparser.add_argument('--prefix', action='store_false')

    argparser.add_argument('--exclusions', nargs='+')

    argparser.add_argument('--output',
                           help='Name and where the output should be put.')

    options = argparser.parse_args()

    if (options.prefix != None):
        for filename in options.filename:
            basefilename, extension = os.path.splitext(filename)

            if options.output == None:
                processed_file = "p_" + basefilename + ".sp"
            else:
                processed_file = options.output

            f = open(filename, 'r')
            src = f.readlines()
            f.close()

            if options.exclusions != None:
                exclusions = list(options.exclusions)

            for l in prefixage(src, basefilename):
                print(l)

    print(exclusions)
