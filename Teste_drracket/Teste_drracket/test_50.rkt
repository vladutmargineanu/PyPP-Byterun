(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None))
		#hash((0 . 0) (1 . 0) (2 . 3))
		#hash((0 . "range"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (SETUP_LOOP . 24) (LOAD_GLOBAL . 0) (LOAD_CONST . 2) (CALL_FUNCTION . 1) (GET_ITER . 0) (FOR_ITER . 12) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_CONST . 2) (INPLACE_ADD . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 14) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))