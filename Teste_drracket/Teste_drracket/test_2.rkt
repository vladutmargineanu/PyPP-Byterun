(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None))
		#hash((0 . 0) (1 . 2) (2 . 3) (3 . 4) (4 . 5))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_CONST . 3) (STORE_FAST . 2) (LOAD_CONST . 4) (STORE_FAST . 3) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))