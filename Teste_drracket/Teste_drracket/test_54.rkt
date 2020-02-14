(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None))
		#hash((0 . 0) (1 . 0) (2 . 5) (3 . 10))
		#hash((0 . "range"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_GLOBAL . 0) (LOAD_CONST . 2) (CALL_FUNCTION . 1) (STORE_FAST . 1) (LOAD_GLOBAL . 0) (LOAD_CONST . 3) (CALL_FUNCTION . 1) (STORE_FAST . 2) (SETUP_LOOP . 42) (LOAD_FAST . 1) (GET_ITER . 0) (FOR_ITER . 34) (STORE_FAST . 3) (SETUP_LOOP . 28) (LOAD_FAST . 2) (GET_ITER . 0) (FOR_ITER . 20) (STORE_FAST . 4) (LOAD_FAST . 0) (LOAD_FAST . 3) (INPLACE_ADD . 0) (STORE_FAST . 0) (LOAD_FAST . 0) (LOAD_FAST . 4) (INPLACE_ADD . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 36) (POP_BLOCK . 0) (JUMP_ABSOLUTE . 26) (POP_BLOCK . 0) (LOAD_GLOBAL . 0) (LOAD_FAST . 0) (CALL_FUNCTION . 1) (STORE_FAST . 5) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))