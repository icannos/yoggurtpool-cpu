from tatsu.walkers import NodeWalker


class CalcWalker(NodeWalker):
    def __init__(self, mem_addr=1073343332, vars_addr=1072703332):
        NodeWalker.__init__(self)
        self.memory_addr = mem_addr

        self.vars_list = {}
        self.vars_addr = vars_addr

        self.while_deph = 0

    def walk__object(self, node):
        return node

    def walk__litteral(self, node):
        return "leti r0 " + str(int(node.litt)) + "\n"

    def walk__identifier(self, node):
        string = ""
        if str(node.varname) not in self.vars_list:
            raise Exception("Undefinded var")
        else:
            if hasattr(node, "ptr"):
                if self.vars_list[self.vars_list[str(node.varname)]]["varorptr"] == "ptr":
                    string += "leti r0 " + str(self.vars_list[str(node.varname)]["addr"]) + "\n"
                    string += "setctr a1 r0 \n"
                    string += "readze a1 " + str(self.vars_list[str(node.varname)]["len"]) + " r0 \n"
                    string += "setctr a1 r0 \n"
                    string += "readze a1 " + str(self.vars_list[str(node.varname)]["len_ptr"]) + " r0 \n"

                if self.vars_list[self.vars_list[str(node.varname)]]["varorptr"] == "var":
                    string += "leti r0 " + str(self.vars_list[str(node.varname)]["addr"]) + "\n"


            else:
                string += "leti r0 " + str(self.vars_list[str(node.varname)]["addr"]) + "\n"
                string += "setctr a1 r0 \n"

                if self.vars_list[str(node.varname)]["type"] == "signed":
                    string += "readse a1 " + str(self.vars_list[str(node.varname)]["len"]) + " r0 \n"
                else:
                    string += "readze a1 " + str(self.vars_list[str(node.varname)]["len"]) + " r0 \n"

        return string

    def walk__multiply(self, node):
        string = "" + str(self.walk(node.left))     On construit l'assembleur pour le membre de gauche
        string += "leti r3 " + str(self.memory_addr) + "\n"
        string += "setctr a0 r3 \n"

        addr_left = self.memory_addr

        string += "write a0 64 r0 \n"
        self.memory_addr += 64

        string += str(self.walk(node.right))

        string += "leti r3 " + str(addr_left) + "\n"
        string += "setctr a0 r3 \n"
        string += "readze a0 64 r1 " + "\n"
        string += "setctr a0 r3 \n"

        string += "call    mult \n"
        string += "let r0 r2 \n"

        self.memory_addr = addr_left

        return string

    def walk__orop(self, node):
        string = "" + str(self.walk(node.left))     #On construit l'assembleur pour le membre de gauche
        string += "leti r3 " + str(self.memory_addr) + "\n"
        string += "setctr a0 r3 \n"

        addr_left = self.memory_addr

        string += "write a0 64 r0 \n"
        self.memory_addr += 64

        string += str(self.walk(node.right))

        string += "leti r3 " + str(addr_left) + "\n"
        string += "setctr a0 r3 \n"
        string += "readze a0 64 r1 " + "\n"
        string += "setctr a0 r3 \n"

        string += "or2 r1 r0 \n"
        string += "let r0 r1 \n"

        self.memory_addr = addr_left

        return string

    def walk__divide(self, node):
        string = "" + str(self.walk(node.left))
        string += "leti r3 " + str(self.memory_addr) + "\n"
        string += "setctr a0 r3\n"

        addr_left = self.memory_addr

        string += "write a0 64 r0 \n"
        self.memory_addr += 64

        string += str(self.walk(node.right))
        string += "let r1 r0 \n"

        string += "leti r3" + str(addr_left) + "\n"
        string += "setctr a0 r3 \n"
        string += "readze a0 64 r0" + "\n"
        string += "setctr a0 r3 \n"

        string += "call div \n"
        string += "let r0 r2 \n"

        self.memory_addr = addr_left

        return string

    def walk__add(self, node):
        string = "" + str(self.walk(node.left))
        string += "leti r3 " + str(self.memory_addr) + "\n"
        string += "setctr a0 r3 \n"

        addr_left = self.memory_addr

        string += "write a0 64 r0 \n"
        self.memory_addr += 64

        string += str(self.walk(node.right))

        string += "leti r3 " + str(addr_left) + "\n"
        string += "setctr a0 r3 \n"
        string += "readze a0 64 r1 " + "\n"
        string += "setctr a0 r3 \n"

        string += "add2 r0 r1 \n"
        self.memory_addr = addr_left

        return string

    def walk__subtract(self, node):
        string = "" + str(self.walk(node.left))
        string += "setctr a0 " + str(self.memory_addr) + "\n"

        addr_left = self.memory_addr

        string += "write a0 64 r0 \n"
        self.memory_addr += 64

        string += str(self.walk(node.right))
        string += "let r1 r0 \n"

        string += "leti r3 " + str(addr_left) + "\n"
        string += "setctr a0 r3 \n"
        string += "readze a0 64 r0" + "\n"
        string += "setctr a0 r3 \n"

        string += "sub2 r0 r1 \n"

        self.memory_addr = addr_left

        return string

    def walk__shiftl(self, node):
        string = ""

        string += str(self.walk(node.left))
        string += "shift left r0 " + str(self.walk(node.left)) + "\n"

        return string

    def walk__shiftr(self, node):
        string = ""

        string += str(self.walk(node.left))
        string += "shift right r0 " + str(self.walk(node.left)) + "\n"

        return string

    def uniqid(self):
        from time import time
        return hex(int(time() * 10000000))[2:]

    def cmp(self, node):
        string = ""

        string += str(self.walk(node.left))
        string += "let r1 r0 \n"
        string += str(self.walk(node.right)) + "\n"

        string += "cmp r1 r0 \n"

        return string

    def walk__equality(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif neq elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok"+jumplabel + ':\n'

        return string

    def walk__nequality(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif eq   elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok" + jumplabel + ':\n'

        return string

    def walk__loweroreq(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif gt   elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok" + jumplabel + ':\n'

        return string

    def walk__lowerthan(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif ge   elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok" + jumplabel + ':\n'

        return string

    def walk__greateroreq(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif lt   elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok" + jumplabel + ':\n'

        return string

    def walk__greaterthan(self, node):
        string = ""
        string += self.cmp(node)

        jumplabel = self.uniqid()
        string += "jumpif leq   elseok" + jumplabel + "\n"
        string += "leti r0 1 \n"
        string += "jump   ifok" + jumplabel + "\n"
        string += "elseok" + jumplabel + ':\n'
        string += "leti r0 0 \n"
        string += "ifok" + jumplabel + ':\n'

        return string

    def walk__declarationp(self, node):
        string = ""
        length = 64

        len_ptr = 0
        varorptr = ""
        if node.t.len == "int8":
            length = 8
            varorptr = "var"
        elif node.t.len == "int16":
            length = 16
            varorptr = "var"
        elif node.t.len == "int32":
            length = 32
            varorptr = "var"
        elif node.t.len == "int64":
            length = 64
            varorptr = "var"


        elif node.l.len == "int8*":
            length = 64
            len_ptr = 8
            varorptr = "ptr"
        elif node.t.len == "int16*":
            length = 64
            len_ptr = 16
            varorptr = "ptr"
        elif node.t.len == "int32*":
            length = 64
            len_ptr = 32
            varorptr = "ptr"
        elif node.t.len == "int64*":
            len_ptr = 64
            length = 64
            varorptr = "ptr"

        if node.id.varname in self.vars_list:
            raise Exception("Cannot redeclare a var")

        self.vars_list[node.id.varname] = {'len': length, 'type':'signed', 'addr': self.vars_addr, 'varorname': varorptr
                                           'len_ptr':len_ptr}
        self.vars_addr += length

        return string


    def walk__affectp(self, node):
        if node.id.varname not in self.vars_list:
            raise Exception("Var doesnt exists")

        string = ""
        string += str(self.walk(node.expr))

        if hasattr(node.id, "ptr"):
            if self.vars_list[self.vars_list[str(node.varname)]]["varorptr"] == "ptr":
                string += "leti r3 " + str(self.vars_list[str(node.varname)]["addr"]) + "\n"
                string += "setctr a1 r3 \n"
                string += "readze a1 " + str(self.vars_list[str(node.varname)]["len"]) + " r3 \n"
                string += "setctr a1 r3 \n"
                string += "write a1 " + str(self.vars_list[str(node.varname)]["len_ptr"]) + " r0 \n"
            else:
                raise Exception("Nope")

        else:
            string += "leti r3 " + str(self.vars_list[node.id.varname]["addr"]) + "\n"
            string += "setctr a1 r3 \n"
            string += "write a1 " + str(self.vars_list[node.id.varname]["len"]) + " r0 \n"

        return string

    def walk__passp(self, node):
        return ""

    def walk__deffunp(self, node):
        string = ""

        string += "jump   funend" + str(node.funname.varname) + ": \n"
        string += "funbegin" + str(node.funname.varname) + ": \n"

        string += str(self.walk(node.prog))

        string += "return \n"

        string += "funend" + str(node.funname.varname) + ": \n"

        return string

    def walk__callfunp(self, node):
        string = ""

        string += "call    funbegin"+ node.id.varname + "\n"

        return string

    def walk__returnp(self, node):
        string = ""

        if hasattr(node, "id"):
            string += str(self.walk(node.id))

        elif hasattr(node, "nb"):
            string += "leti r0 " + str(node.nb) + "\n"

        return string

    def walk__seqp(self, node):
        string = ""

        string += str(self.walk(node.prog1))
        string += str(self.walk(node.prog2))

        return string

    def walk__ifelsep(self, node):
        string = ""

        ifid = self.uniqid()

        string += str(self.walk(node.t))

        string += "cmpi r0 1 \n"
        string += "jumpif neq   ifelse" + ifid + "\n"

        string += str(self.walk(node.prog1))

        string += "jump   ifend"+ifid + "\n"
        string += "ifelse" + ifid  + ": \n"

        string += str(self.walk(node.prog2))

        string += "ifend" + ifid + ": \n"

        return string

    def walk__ifp(self, node):
        string = ""

        ifid = self.uniqid()

        string += str(self.walk(node.t))

        string += "cmpi r0 1 \n"
        string += "jumpif neq   ifend" + ifid + "\n"

        string += str(self.walk(node.prog))

        string += "ifend" + ifid + ": \n"

        return string

    def walk__whilep(self, node):
        string = ""

        ifid = self.uniqid()

        string += "whilebegin" + ifid + ": \n"
        string += str(self.walk(node.t))

        string += "cmpi r0 1 \n"
        
        if self.while_deph == 0:
            string += "letiaj r5 whileend" + ifid + "\n"
            string += "jumpifreg neq r5"
        else:
            string += "jumpif neq whileend" + ifid + "\n"

        string += str(self.walk(node.prog))

        if self.while_deph == 0:
            string += "letiaj r5 whilebegin" + ifid + "\n"
            string += "jumpreg neq r5"
        else:
            string += "jump whilebegin" + ifid + "\n"


        string += "whileend" + ifid + ": \n"

        return string






