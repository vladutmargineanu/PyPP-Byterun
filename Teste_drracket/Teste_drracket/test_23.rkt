(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None) (7 . None) (8 . None) (9 . None) (10 . None) (11 . None) (12 . None))
		#hash((0 . 0) (1 . 2) (2 . 3) (3 . 5) (4 . 20) (5 . 21) (6 . 22) (7 . 23))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_CONST . 3) (STORE_FAST . 2) (LOAD_CONST . 4) (STORE_FAST . 3) (LOAD_CONST . 5) (STORE_FAST . 4) (LOAD_CONST . 6) (STORE_FAST . 5) (LOAD_CONST . 7) (STORE_FAST . 6) (LOAD_FAST . 3) (LOAD_FAST . 0) (BINARY_MODULO . 0) (STORE_FAST . 7) (LOAD_FAST . 4) (LOAD_FAST . 1) (BINARY_MODULO . 0) (STORE_FAST . 8) (LOAD_FAST . 5) (LOAD_FAST . 2) (BINARY_MODULO . 0) (STORE_FAST . 9) (LOAD_FAST . 6) (LOAD_FAST . 1) (BINARY_MODULO . 0) (STORE_FAST . 10) (LOAD_FAST . 3) (LOAD_FAST . 1) (BINARY_MODULO . 0) (STORE_FAST . 11) (LOAD_FAST . 4) (LOAD_FAST . 0) (BINARY_MODULO . 0) (STORE_FAST . 12) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))