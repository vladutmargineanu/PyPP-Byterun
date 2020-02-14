(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 3) (2 . 1) (3 . 2) (4 . (1 2 3)))
		#hash((0 . "print"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (SETUP_LOOP . 36) (LOAD_CONST . 4) (GET_ITER . 0) (FOR_ITER . 28) (STORE_FAST . 1) (LOAD_FAST . 1) (LOAD_FAST . 0) (BINARY_ADD . 0) (STORE_FAST . 2) (LOAD_GLOBAL . 0) (LOAD_FAST . 2) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_FAST . 0) (LOAD_CONST . 2) (INPLACE_SUBTRACT . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 10) (POP_BLOCK . 0) (LOAD_GLOBAL . 0) (LOAD_FAST . 2) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))