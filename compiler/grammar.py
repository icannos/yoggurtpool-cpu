

GRAMMAR = '''
@@grammar::Calc

@@comments :: /\(\*.*?\*\)/

start
    =
    programme $
    ;


expression
    =
    | addition
    | subtraction
    | term
    ;


addition::Add
    =
    left:term op:'+' ~ right:expression
    ;


subtraction::Subtract
    =
    left:term op:'-' ~ right:expression
    ;


term
    =
    | multiplication
    | division
    | orop
    | andop
    | nonop
    | factor
    ;


multiplication::Multiply
    =
    left:factor op:'*' ~ right:term
    ;


division::Divide
    =
    left:factor '/' ~ right:term
    ;

orop::Orop
    =
    left:factor '|' ~ right:term
    ;

andop::Andop
    =
    left:factor '&' ~ right:term
    ;

nonop::Nonop
    =
    '~' ~ right:factor
    ;

shiftleft::Shiftl = left:factor '<<' right:constant;
shiftright::Shiftr = left:factor '>>' right:constant;


factor
    =
    | subexpression
    | number
    | identifier
    | callfun
    ;


subexpression
    =
    '(' ~ @:expression ')'
    ;

    identifier::Identifier = varname:/(?!\d)\w+/ |   ptr:'*' varname:/(?!\d)\w+/;

    boolean = '0'|'1'|'true'|'false';
    number::Litteral=litt:/\d+/;

    constant::int = /\d+/;

test
    =
    |test_eq
    |test_neq
    |test_leq
    |test_lt
    |test_ge
    |test_gt
    ;

test_eq::Equality = left:expression '==' right:expression;
test_neq::Nequality = left:expression '!=' right:expression;
test_leq::Loweroreq = left:expression '<=' right:expression;
test_lt::Lowerthan = left:expression '<' right:expression;
test_ge::Greateroreq = left:expression '>=' right:expression;
test_gt::Greaterthan = left:expression '>' right:expression;


programme
    =
    |seq
    |instruction
    ;


instruction
    =
    |declaration
    |return
    |callfun
    |affect
    |pass
    |ifelse
    |if
    |while
    |deffun
    ;


return::Returnp =
                |'return' id:identifier
                |'return' nb:constant
                ;

varornb::Varornb =
                |id:identifier
                |nb:constant
                ;

ifelse::Ifelsep = 'if' '(' t:test ')' '{' prog1:programme '}'  'else' '{' prog2:programme '}';
if::IfP = 'if' '(' t:test ')' '{' prog:programme '}';
while::Whilep = 'while' '(' t:test ')' '{' prog:programme '}';

seq::Seqp = prog1:programme ';' prog2:programme;

pass::Passp = 'pass;';

affect::Affectp = id:identifier '=' ~ expr:expression ;
affect_p::Affectp = id:identifier '=' ~ expr:expression ;

declaration::Declarationp = t:type id:identifier;


deffun::Deffunp = 'def' funname:identifier '()' '{' prog:programme '}';
callfun::Callfunp = '$' id:identifier '()';

callroutine::Callroutine = '@' id:identifier '('  [varornb] [',' varornb]* ')' ;

type = len:'int8*' | len:'int16*' | len:'int32*' | len:'int64*' | len:'int8' | len:'int16' | len:'int32' | len:'int64' ;


'''









