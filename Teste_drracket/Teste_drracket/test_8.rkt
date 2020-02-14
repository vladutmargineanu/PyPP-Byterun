(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None))
		#hash((0 . 0) (1 . 1) (2 . 2) (3 . 5) (4 . 4) (5 . 6) (6 . 7) (7 . "tema pp") (8 . "p") (9 . 10.0) (10 . "ana are mere") (11 . (1 2)) (12 . (4 5 6 7)))
		#hash()
		'((LOAD_CONST . 11) (STORE_FAST . 0) (LOAD_CONST . 3) (STORE_FAST . 1) (LOAD_CONST . 12) (STORE_FAST . 2) (LOAD_CONST . 6) (STORE_FAST . 3) (LOAD_CONST . 7) (STORE_FAST . 4) (LOAD_CONST . 8) (STORE_FAST . 5) (LOAD_CONST . 9) (STORE_FAST . 6) (LOAD_CONST . 10) (RETURN_VALUE . 0))
		0))