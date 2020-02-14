(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 2) (2 . 3) (3 . "ana are mere") (4 . 0))
		#hash((0 . "print"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (BINARY_ADD . 0) (STORE_FAST . 2) (LOAD_GLOBAL . 0) (LOAD_FAST . 2) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_GLOBAL . 0) (LOAD_CONST . 3) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_FAST . 2) (LOAD_CONST . 1) (BINARY_MODULO . 0) (LOAD_CONST . 4) (COMPARE_OP . 2) (POP_JUMP_IF_FALSE . 52) (LOAD_GLOBAL . 0) (LOAD_FAST . 2) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))