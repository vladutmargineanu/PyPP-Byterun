(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None))
		#hash((0 . 0) (1 . 5) (2 . 7) (3 . 3) (4 . 2) (5 . 10))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 3) (LOAD_FAST . 0) (STORE_FAST . 1) (LOAD_CONST . 3) (STORE_FAST . 0) (LOAD_CONST . 4) (STORE_FAST . 2) (LOAD_FAST . 2) (STORE_FAST . 4) (LOAD_CONST . 2) (STORE_FAST . 2) (LOAD_FAST . 4) (STORE_FAST . 3) (LOAD_FAST . 0) (STORE_FAST . 5) (LOAD_FAST . 1) (STORE_FAST . 6) (LOAD_CONST . 5) (RETURN_VALUE . 0))
		0))