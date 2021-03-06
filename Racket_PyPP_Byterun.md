`Introducere`

Din punctul de vedere al modului de execuție, un limbaj poate fi:

- compilat = codul sursă este transformat în cod mașină, dependent de arhitectură
- interpretat = codul sursă este executat direct de către un intepretor
Unele interpretoare își creează intern propriul cod binar. Acesta nu este cod mașină și nu poate fi rulat pe mașina fizică 
(direct de către CPU), dar este rulat mai departe pe o mașină virtuală. Această metodă a fost popularizată de către Java și 
prezintă două avantaje:

 Separă conceptele de parsare și execuție, astfel codul sursă fiind mai ușor de înțeles.
În multe cazuri, utilizatorul final nu va modifica niciodată codul, deci se poate instala doar partea care execută codul.
Este normal ca aceste lucruri să creeze confuzie, după cum puteți observa. Deși în teorie conceptele de interpretare/compilare sunt 
ușor de separat, în industrie programatorii aleg să facă proiecte care le rezolvă nevoile, mai degrabă decât sa facă proiecte care respectă în tocmai guideline-uri. Astfel, au apărut tot felul de interpretoare pentru tot felul de limbaje.

Pentru Python avem: CPython, PyPy, MicroPython, Jython, etc. Toate au fost create din nevoi diferite și nu respectă cu strictețe un standard când vine vorba de modul în care codul rulează.

În acestă temă vom aprofunda CPython, prima implementare de Python și cea mai folosită, care creează ceea ce se numește python byte 
code și mai apoi este executat de ceea ce se numește byterun.

Din tot interpretorul dorim să implementăm doar un byterun minimalist în Racket.

`CPython`

CPython folosește un model numit stack machine model: pentru a opera instrucțiuni se folosește de o stivă. Pe lângă această stivă, interpretorul are nevoie să țină mai multe dicționare pentru a putea încărca valori imediate. Vom simplifica și vom folosi doar:

- co_varnames = asocierea dintre numele variabilelor și valorile acestora din program care se schimbă la un moment dat în timp
- co_constants = dicționar cu valorile constante
- co_names = dicționar cu nume de funcții (pentru bonus)
Pentru bucle, CPython for se folosește de iteratori. Un iterator este un obiect pentru care poate fi apelată o funcție de next care să întoarcă valoarea la pasul curent și valoarea următorului iterator. Vezi exemplu iterator in racket.

`CPython ByteCode`

- TOS = capătul stivei (top of stack).

- TOS1 = elementul dinainte de capătul stivei (de pe poziția top of stack - 1).

Subsetul de instrucțiuni pe care le vom întâlni este:

`Opcode	Definiţie	Descriere`

1	POP_TOP	Apelează operația de pop pe stiva de execuție.

100	LOAD_CONST(const_i)	Face push elementului de la co_consts[const_i] pe stiva de execuție.

116	LOAD_GLOBAL(func_i)	Face push elementului de la co_names[func_i] pe stiva de execuție.

125	STORE_FAST(var_i)	Stocheaza TOS în co_varnames[var_i] și face pop de pe stivă.

124	LOAD_FAST(var_i)	Face push elementului de la co_varnames[var_i]pe stiva de execuție

22	BINARY_MODULO	Operează TOS = TOS1 % TOS

23	BINARY_ADD	Operează TOS = TOS1 + TOS

24	BINARY_SUBTRACT	Operează TOS = TOS1 - TOS

55	INPLACE_ADD	Aceeași operație ca BINARY_ADD (eg operație în Python: x += 3)

56	INPLACE_SUBTRACT	Aceeași operație ca BINARY_SUBTRACT

59	INPLACE_MODULO	Aceeași operație ca BINARY_MODULO

113	JUMP_ABSOLUTE(target)	Sare la instrucțiunea de pe bytecode-ul target

107	COMPARE_OP(i)	Face o operatie booleană între TOS1 și TOS. Operația se afla la cmp_op[i]. Operanzii sunt scoși de pe stivă, iar 
rezultatul operației va fi pus pe stivă.

114	POP_JUMP_IF_FALSE(target)	Dacă TOS e fals, sare la target, dacă nu, se va continua cu următoarea instrucțiune - se face pop la 
element

115	POP_JUMP_IF_TRUE(target)	Dacă TOS e true, sare la target, dacă nu, se va continua cu următoarea instrucțiune - se face pop la 
element

68	GET_ITER	Implementează TOS = iter(TOS)

93	FOR_ITER(delta)	Este garantat că TOS este iterator. Va face next(TOS). Dacă se întoarce o valoare, va pune valoarea pe stivă şi
dedesubt noul iterator. Dacă iteratorul e gol, îl va scoate de pe stivă și va sari cu delta + 2 bytes

131	CALL_FUNCTION(argc)	Apelează o funcție. Pe stivă se află un număr de argc argumente, urmat de numele funcției. CALL_FUNCTION le 
va scoate de pe stivă, va apela funcția (definită în Racket) și va pune rezultatul pe stivă.

120	SETUP_LOOP(delta)	O puteți ignora pentru această temă Pushează un bloc pentru o buclă pe stiva de blocuri. Blocul începe de la
instrucțiunea curentă și are lungimea delta

87	POP_BLOCK	O puteți ignora pentru această temă Apelează operația de pop pe stiva de execuție

83	RETURN_VALUE	S-a terminat execuția funcției - nu ar trebui făcut nimic

`Exemple`

Exemplu #1
Pentru a înțelege mai bine bytecode-ul, vom urmări următorul exemplu:

`add.py
def main():
    a = 2
    b = 3
    c = a + b`

În Python nu este nevoie să definim o funcție main ca în C, dar vom face asta pentru simplitate. Pachetul dis poate dezasambla o
funcție:

$ python3
Python 3.6.7 (default, Oct 15 2018, 11:32:17) 
[GCC 8.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import dis
>>> import add # (fișierul unde s-a creat funcția main se numește add.py
>>> dis.dis(add.main)
  2           0 LOAD_CONST               1 (2)
              3 STORE_FAST               0 (a)
 
  3           6 LOAD_CONST               2 (3)
              9 STORE_FAST               1 (b)
 
  4          12 LOAD_FAST                0 (a)
             15 LOAD_FAST                1 (b)
             18 BINARY_ADD          
             19 STORE_FAST               2 (c)
             22 LOAD_CONST               0 (None)
             25 RETURN_VALUE       

`Indecși în co-varnames`

Să luam ca exemplu primele 4 instrucțiuni:

`LOAD_CONST 1
STORE_FAST 0 ( a este înlocuit cu 0 )
LOAD_CONST 2 
STORE_FAST 1 ( b este înlocuit cu 1 )`

La început este co-varnames = {a=None, b=None, c=None} și co-consts { 0=None, 1=2, 2=3} Atenție: None este echivalentul pentru null in
Python și va fi mereu găsit pe co-consts[0].

Observați că, atunci când generează codul, Python înlocuiește numele variabilelor cu numere, în cazul nostru, ‘’a’’ este înlocuit cu
0, b cu 1 și c cu 2. Face această optimizare pentru a putea folosi vectori (buffere), în loc de dicționare.

Implementarea voastră nu se va schimba (noi vom folosi dicționare). Scheletul de cod ia în calcul acest lucru, trebuie doar să țineți
minte că, atunci când vedeți 0, 1, etc… în byte-code, este vorba despre prima variabilă, a doua variabilă, etc.

LOAD_CONST și STORE_FAST
LOAD_CONST 1 va pune valoarea de la co_consts[1] pe stivă:

2			
STORE_FAST 0 va pune în co-varnames[0] 2 (valoarea de pe stivă) și va face pop la element.

LOAD_CONST 2 va pune valoarea de la co_consts[2] pe stivă:

3			
STORE_FAST 1 va pune în co-varnames[1] 3 (valoarea de pe stivă) și va face pop la element.

Astfel, la finalul primei secvențe: co-varnames = {0=2, 1=3, 2=None}, adică {a=2, b=3, c=None}.

LOAD_FAST
LOAD_FAST                0
LOAD_FAST                1
LOAD_FAST pune valoarea de la co-varnames[i] în capătul stivei: LOAD_FAST 0 va pune pe stivă co-varnames[0]:

2	3	2	
LOAD_FAST 1 va pune pe stivă co-varnames[1]:

3	2	3	2	
BINARY_ADD
BINARY_ADD 0
Stiva utilizată pentru BINARY_ADD este cea de sus.

BINARY_ADD va face TOS = TOS1 + TOS (TOS si TOS1 vor fi eliminați de pe stivă și se va face push la rezultatul operației). 
Stiva va deveni:

5	3	2
Exemplu #2
$ python3
Python 3.6.7 (default, Oct 22 2018, 11:32:17) 
[GCC 8.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> def main():
...     a = 2
...     if a < 2:
...             a = 3
... 
>>> import dis
>>> dis.dis(main)
  2           0 LOAD_CONST               1 (2)
              2 STORE_FAST               0 (a)
 
  3           4 LOAD_FAST                0 (a)
              6 LOAD_CONST               1 (2)
              8 COMPARE_OP               0 (<)
             10 POP_JUMP_IF_FALSE       16
 
  4          12 LOAD_CONST               2 (3)
             14 STORE_FAST               0 (a)
        >>   16 LOAD_CONST               0 (None)
             18 RETURN_VALUE
 
COMPARE_OP
COMPARE_OP  0 (0 este numărul operației)
COMPARE_OP face o operație booleană cu între TOS şi TOS1, apoi pune rezultatul pe stivă.

Operațiile posibile sunt:

>>> dis.cmp_op
('<', '<=', '==', '!=', '>', '>=', 'in', 'not in', 'is', 'is not', 'exception match', 'BAD') 
Le puteți ignora pe ultimele 4.

După load-uri, stiva devine:

2	2		
COMPARE_OP 0 va evalua 2 < 2 (fals) și va pune rezultatul pe stivă:

False			
POP_JUMP_IF_FALSE / POP_JUMP_IF_TRUE
POP_JUMP_IF_FALSE 0
POP_JUMP_IF_FALSE verifică TOS, iar dacă e fals, va sări la bytecode-ul dat ca argument, echivalent pentru POP_JUMP_IF_TRUE

Exemplu #3
>>> def main():
...     a = 2
...     while a > 42:
...             a = a + 1
... 
>>> dis.dis(main)
  2           0 LOAD_CONST               1 (2)
              2 STORE_FAST               0 (a)
 
  3           4 SETUP_LOOP              20 (to 26)
        >>    6 LOAD_FAST                0 (a) (byte-ul 6, aici va ajunge după JUMP_ABSOLUTE 6)
              8 LOAD_CONST               2 (42)
             10 COMPARE_OP               4 (>)
             12 POP_JUMP_IF_FALSE       24
 
  4          14 LOAD_FAST                0 (a)
             16 LOAD_CONST               3 (1)
             18 BINARY_ADD
             20 STORE_FAST               0 (a)
             22 JUMP_ABSOLUTE            6
        >>   24 POP_BLOCK
        >>   26 LOAD_CONST               0 (None)
             28 RETURN_VALUE
>>> 
După cum am menționat, SETUP_LOOP și POP_BLOCK pot fi ignorate. Folosindu-se de COMPARE_OP, urmatoarea bucată verifică condiția
pentru while (a > 42) :

LOAD_FAST 0 
LOAD_CONST 2 
COMPARE_OP 4 
POP_JUMP_IF_FALSE 24
Urmatoarele instrucţiuni sunt pentru blocul while-ului: a = a + 1

LOAD_FAST 0 
LOAD_CONST 3 
BINARY_ADD
STORE_FAST 0
JUMP_ABSOLUTE
JUMP_ABSOLUTE va face jump la byte-ul aflat la indexul dat ca parametru. În cazul nostru, lista de bytes este:

>>> list(main.__code__.co_code)
[100, 1, 125, 0, 120, 16, 124, 0, 100, 2, 107, 4, 114, 20, 100, 1, 125, 0, 113, 6, 87, 0, 100, 0, 83, 0]
În cazul nostru, parametrul este 6, deci va sări la byte-ul:

>>> list(main.__code__.co_code)[6]
124 (LOAD_FAST)
Atenție: Al 6-lea byte din listă este reprezentat de a treia instrucțiune, deoarece fiecare instrucțiune are 2 bytes. 
(opcode și parametru)

Exemplu #4
>>> def main():
...     a = 0
...     for b in [1,2]:
...             a = a + b
... 
>>> import dis
>>> dis.dis(main)
  2           0 LOAD_CONST               1 (0)
              2 STORE_FAST               0 (a)
 
  3           4 SETUP_LOOP              20 (to 26)
              6 LOAD_CONST               4 ((1, 2))
              8 GET_ITER
        >>   10 FOR_ITER                12 (to 24) (JUMP_ABSOLUTE va sări aici)
             12 STORE_FAST               1 (b)
 
  4          14 LOAD_FAST                0 (a)
             16 LOAD_FAST                1 (b)
             18 BINARY_ADD
             20 STORE_FAST               0 (a)
             22 JUMP_ABSOLUTE           10
        >>   24 POP_BLOCK
        >>   26 LOAD_CONST               0 (None)
             28 RETURN_VALUE
GET_ITER / FOR_ITER
În secvența urmatoare puteți ignora SETUP_LOOP:

LOAD_CONST 1
STORE_FAST 0
SETUP_LOOP 20
LOAD_CONST 4
GET_ITER
FOR_ITER 12
STORE_FAST 1
LOAD_FAST 0
LOAD_CONST 3
BINARY_ADD 0
STORE_FAST 0
JUMP_ABSOLUT 10
POP_BLOCK 0
LOAD_CONST 0
RETURN_VALUE 0
LOAD_CONST 4 va pune pe stivă co-consts[4], adică lista [1, 2]:

[1, 2]	
GET_ITER va fi de asemenea ignorat.

FOR_ITER va verifica dacă se poate face next pe iterator, iar în acest caz se va face push pe stiva la noul iterator (fără primul
element) și la primul element (top-ul stivei este reprezentat de element).

După execuția primul FOR_ITER, stiva va arăta:

1	[2]	
După a doua iterație, stiva va arăta:

2	[]
La a treia iterație, iteratorul este gol și se va sări la instrucțiunea POP_BLOCK (care este ignorată).

Exemplu #5 (pentru bonus)
>>> def main():
...     print("Hello world")
... 
>>> dis.dis(main)
  2           0 LOAD_GLOBAL              0 (print)
              2 LOAD_CONST               1 ('Hello world')
              4 CALL_FUNCTION            1
              6 POP_TOP
              8 LOAD_CONST               0 (None)
             10 RETURN_VALUE
LOAD_GLOBAL
LOAD_GLOBAL 0 va pune pe stivă funcția de la co-names[0]

print		
LOAD_CONST 0 va pune pe stivă valoarea de la co-consts[0]

„Hello world“	print	
CALL_FUNCTION
'CALL_FUNCTION n' va scoate de pe stivă primele n valori, în cazul nostru (n = 1), string-ul „Hello world“. După aceea, va scoate
funcția print, va apela print(„Hello world“) și va pune rezultatul (void) pe stivă:

void			
POP_TOP
POP_TOP va aplica operația pop pe stivă și stiva va deveni goală:

Observați că dacă rezultatul funcției este void/nefolosit deloc, se va genera automat un POP_TOP.

Detalii de implementare în Racket
Dicționare
În Racket puteți implementa dicționarele cu hash

> (define dict (hash "key1" 2))
> dict
'#hash(("key1" . 2))
> (hash-ref dict "key1"); hash lookup
2
> (hash-set dict "key1" 42); hash update
'#hash(("key1" . 42))
Mai multe detalii in documentația de racket

`Iteratori`

O variantă de a implementa iteratori este folosind liste: elementul curent este primul element din list şi next este restul listei.

(define current car)
(define next cdr)
 
(current (next (next (next '(1 2 3 4)))))
4
Dacă alegeți să implementați așa, puteți ignora instrucțiunea 'GET_ITER', care face TOS = iter(TOS), deoarce orice listă este un 
iterator.

`Jump la target`

Python generează o lista de byte-codes:

>>> list(main.__code__.co_code)
[100 1 125 0 100 2 125 1 124 0 100 3 107 5 114 24 100 3 125 1 100 4 125 0 100 0 83 0]
Aceasta este parsată în scheletul de cod și devine:

> (co-code (cadddr arguments))
'((LOAD_CONST . 1)
  (STORE_FAST . 0)
  (LOAD_CONST . 2)
  (STORE_FAST . 1)
  (LOAD_FAST . 0)
  (LOAD_CONST . 3)
  (COMPARE_OP . 5)
  (POP_JUMP_IF_FALSE . 24)
  (LOAD_CONST . 3)
  (STORE_FAST . 1)
  (LOAD_CONST . 4)
  (STORE_FAST . 0)
  (LOAD_CONST . 0)
  (RETURN_VALUE . 0))
Astfel, byte-ul de la indexul n apare în lista noastră pe poziția n/2

`Punctaje`

[20p] - Checker intern în Racket pentru reprezentarea entităților (stack, stack-machine)
[20p] - Teste cu load-store exceptând LOAD_GLOBAL
[20p] - Teste cu operații binare: +, -, %
[20p] - Teste cu structuri if
[20p] - Teste cu structuri while şi for

`Bonus:`

[5p] - Teste CALL_FUNCTION cu funcția print
[5p] - Teste CALL_FUNCTION cu funcția range
[5p] - Teste CALL_FUNCTION cu funcția sqrt
[5p] - Teste CALL_FUNCTION cu funcția prod
Generare cod
Testele vor fi pregenerate. Dacă doriți să rulați propriul fișier Python, o puteți face folosind comanda ./run

./run fisier.py
Dacă doriți să generați din nou bytecode-ul unui fişier, puteți şterge fişier-ul .pyppc care are numele identic cu fișierul de Python 
sau puteţi rula testul cu flagul –clear-cache.

./run fisier.py --clear-cache
Atenție! Bytecode-ul prezentat este cel generat de Python 3.6.7, pentru alte versiuni s-ar putea să difere.

`Rulare`

Puteți rula codul vostru folosindu-vă de fisierul .pyppc (generat de ./run):

$ racket byterun.rkt tests/smaller/if_smaller_true_prog.pyppc
Atenție scheletul a fost dezvoltat pentru Linux, s-ar putea sa aveți probleme la rularea pe Windows.

`Precizări`

Sunt interzise efectele laterale de orice fel (set!, set-car! etc.).
Arhiva trebuie să conțină fișierele opcodes.rkt și stack-machine.rkt.
