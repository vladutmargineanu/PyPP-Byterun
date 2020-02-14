(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 0) (2 . 10))
		#hash((0 . "range"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (SETUP_LOOP . 46) (LOAD_GLOBAL . 0) (LOAD_CONST . 2) (CALL_FUNCTION . 1) (GET_ITER . 0) (FOR_ITER . 34) (STORE_FAST . 1) (SETUP_LOOP . 28) (LOAD_GLOBAL . 0) (LOAD_CONST . 2) (CALL_FUNCTION . 1) (GET_ITER . 0) (FOR_ITER . 16) (STORE_FAST . 2) (LOAD_FAST . 0) (LOAD_FAST . 1) (LOAD_FAST . 2) (BINARY_ADD . 0) (INPLACE_ADD . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 28) (POP_BLOCK . 0) (JUMP_ABSOLUTE . 14) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))