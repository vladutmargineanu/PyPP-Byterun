(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None) (7 . None))
		#hash((0 . 0) (1 . 2) (2 . 3))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (BINARY_SUBTRACT . 0) (STORE_FAST . 2) (LOAD_FAST . 2) (LOAD_FAST . 0) (BINARY_SUBTRACT . 0) (STORE_FAST . 3) (LOAD_FAST . 2) (LOAD_FAST . 1) (BINARY_SUBTRACT . 0) (STORE_FAST . 4) (LOAD_FAST . 3) (LOAD_FAST . 0) (BINARY_SUBTRACT . 0) (STORE_FAST . 5) (LOAD_FAST . 5) (LOAD_FAST . 0) (BINARY_SUBTRACT . 0) (STORE_FAST . 6) (LOAD_FAST . 6) (LOAD_FAST . 1) (BINARY_SUBTRACT . 0) (STORE_FAST . 7) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))