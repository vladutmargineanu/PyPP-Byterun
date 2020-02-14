(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None) (7 . None))
		#hash((0 . 0) (1 . "ana") (2 . 1) (3 . 2) (4 . 3) (5 . 4) (6 . 5) (7 . (1 2 3)) (8 . 5))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 7) (STORE_FAST . 1) (LOAD_CONST . 8) (STORE_FAST . 2) (LOAD_CONST . 5) (STORE_FAST . 3) (LOAD_CONST . 6) (STORE_FAST . 4) (LOAD_FAST . 3) (LOAD_FAST . 4) (BINARY_ADD . 0) (STORE_FAST . 5) (LOAD_FAST . 3) (LOAD_FAST . 4) (BINARY_SUBTRACT . 0) (STORE_FAST . 6) (LOAD_FAST . 4) (LOAD_FAST . 3) (BINARY_MODULO . 0) (STORE_FAST . 7) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))