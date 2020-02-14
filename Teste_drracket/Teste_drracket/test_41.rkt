(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None))
		#hash((0 . 0) (1 . 3) (2 . 1) (3 . 2) (4 . 4) (5 . (1 2 3)) (6 . (1 2 3 4)))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (SETUP_LOOP . 20) (LOAD_CONST . 5) (GET_ITER . 0) (FOR_ITER . 12) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_CONST . 3) (BINARY_ADD . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 10) (POP_BLOCK . 0) (SETUP_LOOP . 20) (LOAD_CONST . 6) (GET_ITER . 0) (FOR_ITER . 12) (STORE_FAST . 1) (LOAD_FAST . 1) (LOAD_CONST . 2) (INPLACE_ADD . 0) (STORE_FAST . 1) (JUMP_ABSOLUTE . 32) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))