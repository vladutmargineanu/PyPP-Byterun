(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 3) (2 . 0) (3 . 5) (4 . 2) (5 . 1) (6 . 10))
		#hash()
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (SETUP_LOOP . 28) (LOAD_FAST . 1) (LOAD_CONST . 3) (COMPARE_OP . 0) (POP_JUMP_IF_FALSE . 36) (LOAD_FAST . 0) (LOAD_CONST . 4) (BINARY_ADD . 0) (STORE_FAST . 0) (LOAD_FAST . 1) (LOAD_CONST . 5) (BINARY_ADD . 0) (STORE_FAST . 1) (JUMP_ABSOLUTE . 10) (POP_BLOCK . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_CONST . 5) (STORE_FAST . 2) (SETUP_LOOP . 28) (LOAD_FAST . 1) (LOAD_CONST . 6) (COMPARE_OP . 3) (POP_JUMP_IF_FALSE . 74) (LOAD_FAST . 1) (LOAD_CONST . 5) (BINARY_ADD . 0) (STORE_FAST . 1) (LOAD_FAST . 2) (LOAD_FAST . 1) (BINARY_ADD . 0) (STORE_FAST . 2) (JUMP_ABSOLUTE . 48) (POP_BLOCK . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))