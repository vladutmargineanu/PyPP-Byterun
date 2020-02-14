(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None))
		#hash((0 . 0) (1 . 1) (2 . 2) (3 . 3) (4 . 0) (5 . 10) (6 . (1 2 3)))
		#hash((0 . "print"))
		'((SETUP_LOOP . 20) (LOAD_CONST . 6) (GET_ITER . 0) (FOR_ITER . 12) (STORE_FAST . 0) (LOAD_GLOBAL . 0) (LOAD_FAST . 0) (CALL_FUNCTION . 1) (POP_TOP . 0) (JUMP_ABSOLUTE . 6) (POP_BLOCK . 0) (LOAD_CONST . 4) (STORE_FAST . 1) (SETUP_LOOP . 28) (LOAD_FAST . 1) (LOAD_CONST . 5) (COMPARE_OP . 0) (POP_JUMP_IF_FALSE . 54) (LOAD_GLOBAL . 0) (LOAD_FAST . 1) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_FAST . 1) (LOAD_CONST . 1) (INPLACE_ADD . 0) (STORE_FAST . 1) (JUMP_ABSOLUTE . 28) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))