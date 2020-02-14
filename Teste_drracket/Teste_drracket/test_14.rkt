(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None))
		#hash((0 . 0) (1 . 3) (2 . 2))
		#hash()
		'((LOAD_FAST . 1) (STORE_FAST . 2) (LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (BINARY_ADD . 0) (STORE_FAST . 3) (LOAD_FAST . 3) (LOAD_FAST . 0) (BINARY_SUBTRACT . 0) (STORE_FAST . 2) (LOAD_FAST . 3) (RETURN_VALUE . 0))
		0))