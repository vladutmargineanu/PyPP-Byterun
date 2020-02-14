#lang racket
(require "opcodes.rkt")
(provide make-stack-machine)
(provide run-stack-machine)
(provide get-stack)
(provide get-varnames)
(provide get-consts)
(provide get-names)
(provide get-code)
(provide get-IC)
(provide empty-stack)
(provide make-stack)
(provide push)
(provide pop)
(provide top)

;; TODO 1:
;; Alegeți metoda de reprezentarea a unei stive.
;; cons( x, list) => stiva va fi o lista cu capul stivei in stanga
;; Implementați:

;; empty-stack este o lista goala (o variabila)
(define empty-stack
  '())

;; Facem o stiva goala dintr-o lista.
(define (make-stack)
  empty-stack)

;; Intoarce o noua stiva cu un element in plus.
(define (push element stack)
  (cons element stack))

;; Intoarce primul element din stiva.
(define (top stack)
  (if (null? stack)
      stack
      (car stack)))

;; Intoarce o noua stiva cu un element in minus.
(define (pop stack)
  (cdr stack))

;; TODO 2:
;; Alegeți metoda de reprezentare a unei mașini stivă.
;; Definiți make-stack-machine, acesta trebuie sa primeasca cele 4 segmente de date
;; Veți avea nevoie de o stivă pentru execuție și un counter ca să stiți
;; la ce instrucțiune sunteți.
(define (make-stack-machine stack co-varnames co-consts co-names co-code IC)
  (list stack co-varnames co-consts co-names co-code IC))

;; Definiți funcțiile `get-varnames`, `get-consts`, `get-names`,
;; `get-code`, `get-stack`, `get-IC` care primesc o mașina stivă și întorc
;; componenta respectivă

;; ex:
;; > (get-varnames (make-stack-machine empty-stack 'dummy-co-varnames (hash) (hash) (list) 0))
;; 'dummy-co-varnames
;; numaram de la indicele 0
(define (get-varnames stack-machine)
  (list-ref stack-machine 1))

;; ex:
;; > (get-consts (make-stack-machine empty-stack (hash) 'dummy-co-consts (hash) (list) 0))
;; 'dummy-co-consts
(define (get-consts stack-machine)
  (list-ref stack-machine 2))

;; ex:
;; > (get-names (make-stack-machine empty-stack (hash) (hash) 'dummy-co-names (list) 0))
;; 'dummy-co-names
(define (get-names stack-machine)
  (list-ref stack-machine 3))

;; ex:
;; > (get-code (make-stack-machine empty-stack (hash) (hash) (hash) 'dummy-co-code 0))
;; dummy-co-code
(define (get-code stack-machine)
  (list-ref stack-machine 4))

;; Întoarce stiva de execuție.
;; ex:
;; > (get-code (make-stack-machine 'dummy-exec-stack (hash) (hash) (hash) (list) 0))
;; dummy-exec-stack
(define (get-stack stack-machine)
 (list-ref stack-machine 0))

;; Întoarce instruction counterul.
;; ex:
;; > (get-code (make-stack-machine empty-stack (hash) (hash) (hash) (list) 0))
;; 0
(define (get-IC stack-machine)
   (list-ref stack-machine 5))


(define symbols (list 'STACK 'CO-VARNAMES 'CO-CONSTS 'CO-NAMES 'CO-CODE 'INSTRUCTION-COUNTER))

;; TODO 3:
;; Definiți funcția get-symbol-index care gasește index-ul simbolului in listă.
(define (get-symbol-index symbol)
 (index-of symbols symbol))

;; Definiți funcția update-stack-machine care intoarce o noua mașina stivă
;; înlocuind componenta corespondentă simbolului cu item-ul dat în paremetri.
;; > (get-varnames (update-stack-machine "new-varnames" 'CO-VARNAMES stack-machine))
;; "new-varnames"
;; > (get-varnames (update-stack-machine "new-names" 'CO-NAMES stack-machine))
;; "new-names"
(define (update-stack-machine item symbol stack-machine)
  (list-set stack-machine (get-symbol-index symbol) item))

;; Definiți funcția push-exec-stack care primește o masină stivă și o valoare
;; și intoarce o noua mașina unde valoarea este pusă pe stiva de execuție
;; facem push pe stiva de executie din stack-machine si facem update la stack-machine
(define (push-exec-stack value stack-machine)
  (update-stack-machine (push value (get-stack stack-machine)) 'STACK stack-machine))

;; Definiți funcția pop-exec-stack care primește o masină stivă
;; și intoarce o noua mașina aplicând pop pe stiva de execuție.
;; facem pop pe stiva de executie din stack-machine si facem update la stack-machine
(define (pop-exec-stack stack-machine)
  (update-stack-machine (pop (get-stack stack-machine)) 'STACK stack-machine))

;; Definim subsetul de instrucțiuni pe care le vom întâlni:

;; Functia pop-top apelează operația de pop pe stiva de execuție
;; Este chiar pop-exec-stack
(define (pop-top stack-machine)
  (let ([stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine)])
  (pop-exec-stack stack-machine-new)))

;; Functia binary-operator pentru: binary-modulo, binary-add, binary-subtract.
;; Operator poate fi: +, -, modulo.
;; Functia binary-operator operează TOS = TOS1 operator TOS, are doi parametri
;; TOS si TOS1 vor fi eliminați de pe stivă și
;; Se va face push la rezultatul operației
(define (binary-operator operator stack-machine)
  ;; aplicam push-exec-stack pe cei doi parametrii astfel:
  ;; 1 => TOS1 operator TOS, pe TOS1 il obtinem facand pop-exec-stack, apoi top pe stiva de executie
  ;; 2 => am facut pop la TOS in primul argument, acum facem si la TOS1
  ;; stiva de executie va retine noul rezultat, fara TOS si TOS1
  ;; crestem IC si facem update la stack-machine
  (let* ((tos (top (get-stack stack-machine)))
         (stack-machine-new1 (pop-exec-stack stack-machine))
         (tos1 (top (get-stack stack-machine-new1)))
         (stack-machine-new2 (update-stack-machine (+ 1 (get-IC stack-machine-new1)) 'INSTRUCTION-COUNTER stack-machine-new1)))
    (push-exec-stack
     (operator tos1 tos)
     (pop-exec-stack stack-machine-new2) 
     )))

;; Functia binary-modulo operează TOS = TOS1 % TOS
;; TOS si TOS1 vor fi eliminați de pe stivă și
;; Se va face push la rezultatul operație
;; Ne folosim de functia binary-operator pentru reutilizare de cod
(define (binary-modulo stack-machine)
  (binary-operator modulo stack-machine))

;; Functia binary-add operează TOS = TOS1 + TOS
;; TOS si TOS1 vor fi eliminați de pe stivă și
;; Se va face push la rezultatul operației
;; Ne folosim de functia binary-operator pentru reutilizare de cod
(define (binary-add stack-machine)
  (binary-operator + stack-machine))
  
;; Functia binary-subtract operează TOS = TOS1 - TOS
;; TOS si TOS1 vor fi eliminați de pe stivă și
;; Se va face push la rezultatul operației
;; Ne folosim de functia binary-operator pentru reutilizare de cod
(define (binary-subtract stack-machine)
  (binary-operator - stack-machine))

;; Aceeași operație ca BINARY_ADD
(define (inplace-add stack-machine)
  (binary-add stack-machine))

;; Aceeași operație ca BINARY_SUBTRACT
(define (inplace-subtract stack-machine)
  (binary-subtract stack-machine))

;; Aceeași operație ca BINARY_MODULO
(define (inplace-modulo stack-machine)
  (binary-modulo stack-machine))

;; Implementează TOS = iter(TOS), il ignoram, dar crestem IC
(define (get-iter stack-machine)
  (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine))

;; S-a terminat execuția funcției - nu ar trebui făcut nimic (returnam stack-machine)
(define (return-value stack-machine)
  (let ([stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine)])
    stack-machine-new))

;;Apelează operația de pop pe stiva de execuție, il ignoram, dar crestem IC
(define (pop-block stack-machine)
  (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine))
   
;; Iterator folosind liste
(define current car)
(define next cdr)

;; Se face next pe iterator, iar în acest caz se va face push pe stiva la noul iterator (fără primul element)
;; și la primul element (top-ul stivei este reprezentat de element).
(define (next-iter stack-machine)
  (let* ((list_it (top (get-stack stack-machine)))  ;; iteratorul listă
         (stack-machine-new1 (pop-exec-stack stack-machine))  ;; facem pop la lista iterator
         ;; punem lista iterator pe stiva de executie fara primul element
         (stack-machine-new2 (push-exec-stack (next list_it) stack-machine-new1)))
    ;; punem primul element din iteratorul listă pe stiva de executie
    (push-exec-stack (current list_it) stack-machine-new2)))

;; Este garantat că TOS este iterator. Va face next(TOS).
;; Dacă se întoarce o valoare, va pune valoarea pe stivă şi dedesubt noul iterator.
;; Dacă iteratorul e gol, îl va scoate de pe stivă și va sari cu delta + 2 bytes
(define (for-iter delta stack-machine)
  ;; Extragem lista iterator din stiva de executie
  (let ([list_it (top (get-stack stack-machine))])
    (if (null? list_it)
        ;; daca iteratorul e gol, il scoatem de pe stiva si sarim cu delta + 2 
        (jump-absolute (+ (+ delta 2) (* 2 (get-IC (pop-exec-stack stack-machine)))) (pop-exec-stack stack-machine))
        ;; daca se intoarce o valoare, apelam functia next-iter si crestem IC cu 1
        (update-stack-machine (+ 1 (get-IC (next-iter stack-machine))) 'INSTRUCTION-COUNTER (next-iter stack-machine)))))

;; Face push elementului de la co_consts[const_i] pe stiva de execuție.
;; hash-ref returneaza valoarea pentru const_i in hash
;; crestem IC si facem update la stack-machine
(define (load-const const_i stack-machine)
  (let ([stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine)])
    (push-exec-stack
     (hash-ref (get-consts stack-machine-new) const_i)
     stack-machine-new)))

;; Face o operatie booleană între TOS și TOS1. Operația se afla la cmp_op[i].
;; Operanzii sunt scoși de pe stivă, iar rezultatul operației va fi pus pe stivă.
;; Ne folosim de functia binary-operator pentru reutilizare de cod
(define (compare-op op_i stack-machine)
  (binary-operator (get-cmpop op_i) stack-machine))

;; Sare la instrucțiunea de pe bytecode-ul target
;; Facem update la IC 
(define (jump-absolute bytecode stack-machine)
  (update-stack-machine (quotient bytecode 2) 'INSTRUCTION-COUNTER stack-machine))

;; Dacă TOS e fals, sare la target, dacă nu, se va continua cu următoarea instrucțiune
;; Se face pop la element
;; Daca este false pe stiva de executie vom updata IC, adica toata stack-machine si vom face pop-top
;; Altfel vom returna stack-machine nemodificata
(define (pop-jump-if-false bytecode stack-machine)
  (let ((value-bool (top (get-stack stack-machine)))
        (stack-machine-new1 (pop-exec-stack stack-machine)))
    (if (boolean=? #f value-bool)
        (jump-absolute bytecode stack-machine-new1)
        (update-stack-machine (+ 1 (get-IC stack-machine-new1)) 'INSTRUCTION-COUNTER stack-machine-new1))))

;; Face push elementului de la co_names[func_i] pe stiva de execuție.
(define (load-global func_i stack-machine)
   (let ([stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine)])
    (push-exec-stack
     (hash-ref (get-names stack-machine-new) func_i)
     stack-machine-new)))

;; Pushează un bloc pentru o buclă pe stiva de blocuri.
;; Blocul începe de la instrucțiunea curentă și are lungimea delta (il ignoram, dar crestem IC)
(define (setup-loop delta stack-machine)
  (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine))

;; Face push elementului de la co_varnames[var_num] pe stiva de execuție.
;; hash-ref returneaza valoarea pentru var_num in hash
;; Functia primeste si parametrul stack-machine deoarece trebuie
;; sa o updatam dupa adaugarea unui element in stiva de executie.
;; push-exec-stack updateaza stack-machine in implementare
;; crestem IC si facem update la stack-machine
(define (load-fast var_num stack-machine)
  (let ([stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine)])
    (push-exec-stack
     (hash-ref (get-varnames stack-machine-new) var_num)
     stack-machine-new)))

;; Stocheaza TOS în co_varnames[var_i] și face pop de pe stivă.
;; hash-set = extinde hash-ul co_varnames prin maparea cheii var_i cu tos
;; hash-set returneaza hash-code-ul extins
;; trebuie sa updatam machine-stack
;; crestem IC si facem update la stack-machine
;; facem pop pe stiva de executie la final (corpul let-ul)
(define (store-fast var_i stack-machine)
  (let* ((tos (top (get-stack stack-machine)))
         (stack-machine-new (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine))
         (stack-machine-new2 (update-stack-machine (hash-set (get-varnames stack-machine-new) var_i tos) 'CO-VARNAMES stack-machine-new)))
    (pop-exec-stack stack-machine-new2)))

;; Apelează o funcție. Pe stivă se află un număr de argc argumente, urmat de numele funcției.
;; CALL_FUNCTION le va scoate de pe stivă, va apela funcția (definită în Racket) și va pune rezultatul pe stivă.
(define (call-functions argc stack-machine)
  (let* ((list_argc (take (get-stack stack-machine) argc)) ;; extragem din stiva de executie lista argumentelor
         (co-names (get-names stack-machine)) ;; extragem hash-ul co-codes cu numele functiilor
         (apply_func (get-function (hash-ref co-names 0))) ;; extragem functia din hash-ul co-code 
         (stack-machine-new1 (update-stack-machine (+ 1 (get-IC stack-machine)) 'INSTRUCTION-COUNTER stack-machine))
         ;; facem pop pe stiva de executie la lista argumentelor cu list-tail
         (stack-machine-new2 (update-stack-machine (list-tail (get-stack stack-machine-new1) (+ 1 argc)) 'STACK stack-machine-new1)))
    ;;Apply returnează rezultatul aplicării unei funcții f cu argumente elementele din lista L
    (push-exec-stack (apply apply_func list_argc) stack-machine-new2)))

;; TODO 4
;; Definiți funcția run-stack-machine care execută operații pană epuizează co-code.
;; let* = domeniul de vizibilitate al variabilelor începe imediat după definire.
;; Trebuie sa cresc IC pentru fiecare apel al functiei pe operatii (in fiecare functie definita mai sus)
;; IC reprezinta numarul de operatii din co-code care creste pe parcurs.
(define (run-stack-machine stack-machine)
  ;; Daca am terminat de iterat prin lista co-code (am terminat instructiunile)
  ;; returnez stack-machine, altfel continui de iterat
  (if (= (length  (get-code stack-machine)) (get-IC stack-machine))
      stack-machine
      (let* ((co-code (get-code stack-machine))
             ;; extrag operatia din lista co-code pentru prelucrare
             (operation (car (list-ref co-code (get-IC stack-machine))))
             ;; extrag al doilea element din perechea data de indexul IC din co-code
             (var_i (cdr (list-ref co-code (get-IC stack-machine)))))
        (cond 
          [(eq? operation (get-opname 1)) (run-stack-machine (pop-top stack-machine))]
          [(eq? operation (get-opname 22)) (run-stack-machine (binary-modulo stack-machine))]
          [(eq? operation (get-opname 23)) (run-stack-machine (binary-add stack-machine))]
          [(eq? operation (get-opname 24)) (run-stack-machine (binary-subtract stack-machine))]
          [(eq? operation (get-opname 55)) (run-stack-machine (inplace-add stack-machine))]
          [(eq? operation (get-opname 56)) (run-stack-machine (inplace-subtract stack-machine))]
          [(eq? operation (get-opname 59)) (run-stack-machine (inplace-modulo stack-machine))]
          [(eq? operation (get-opname 68)) (run-stack-machine (get-iter stack-machine))]
          [(eq? operation (get-opname 83)) (run-stack-machine (return-value stack-machine))]
          [(eq? operation (get-opname 87)) (run-stack-machine (pop-block stack-machine))]
          [(eq? operation (get-opname 93)) (run-stack-machine (for-iter var_i stack-machine))]
          [(eq? operation (get-opname 100)) (run-stack-machine (load-const var_i stack-machine))]
          [(eq? operation (get-opname 107)) (run-stack-machine (compare-op var_i stack-machine))]
          [(eq? operation (get-opname 113)) (run-stack-machine (jump-absolute var_i stack-machine))]
          [(eq? operation (get-opname 114)) (run-stack-machine (pop-jump-if-false var_i stack-machine))]
          [(eq? operation (get-opname 116)) (run-stack-machine (load-global var_i stack-machine))]
          [(eq? operation (get-opname 120)) (run-stack-machine (setup-loop var_i stack-machine))]
          [(eq? operation (get-opname 124)) (run-stack-machine (load-fast var_i stack-machine))]
          [(eq? operation (get-opname 125)) (run-stack-machine (store-fast var_i stack-machine))]
          ;; 131 'CALL_FUNCTION
          [else  (run-stack-machine (call-functions var_i stack-machine))]
          ))))