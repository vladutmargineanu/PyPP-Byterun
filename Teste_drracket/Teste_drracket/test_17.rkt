(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 3) (2 . 10))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (BINARY_ADD . 0) (STORE_FAST . 2) (LOAD_FAST . 2) (LOAD_FAST . 0) (BINARY_ADD . 0) (STORE_FAST . 1) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))