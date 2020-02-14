(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None))
		#hash((0 . 0) (1 . 0) (2 . 10) (3 . 1))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (SETUP_LOOP . 20) (LOAD_FAST . 0) (LOAD_CONST . 2) (COMPARE_OP . 0) (POP_JUMP_IF_FALSE . 24) (LOAD_FAST . 0) (LOAD_CONST . 3) (INPLACE_ADD . 0) (STORE_FAST . 0) (JUMP_ABSOLUTE . 6) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))
