(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None))
		#hash((0 . 0) (1 . 4) (2 . 5) (3 . 1))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (COMPARE_OP . 2) (POP_JUMP_IF_FALSE . 32) (LOAD_FAST . 0) (LOAD_CONST . 3) (INPLACE_ADD . 0) (STORE_FAST . 0) (LOAD_FAST . 1) (LOAD_CONST . 3) (INPLACE_SUBTRACT . 0) (STORE_FAST . 1) (LOAD_FAST . 1) (LOAD_CONST . 1) (COMPARE_OP . 2) (POP_JUMP_IF_FALSE . 48) (LOAD_FAST . 0) (STORE_FAST . 1) (LOAD_FAST . 1) (STORE_FAST . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))