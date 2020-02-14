(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None))
		#hash((0 . 0) (1 . 1) (2 . 2) (3 . "pp") (4 . 7) (5 . (1 2)))
		#hash()
		'((LOAD_CONST . 5) (STORE_FAST . 0) (LOAD_CONST . 3) (STORE_FAST . 1) (LOAD_CONST . 4) (STORE_FAST . 2) (LOAD_CONST . 0) (STORE_FAST . 3) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))