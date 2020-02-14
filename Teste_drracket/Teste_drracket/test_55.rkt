(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None))
		#hash((0 . 0) (1 . 9) (2 . 16))
		#hash((0 . "sqrt"))
		'((LOAD_GLOBAL . 0) (LOAD_CONST . 1) (CALL_FUNCTION . 1) (STORE_FAST . 0) (LOAD_GLOBAL . 0) (LOAD_CONST . 2) (CALL_FUNCTION . 1) (STORE_FAST . 1) (LOAD_FAST . 0) (LOAD_FAST . 1) (BINARY_ADD . 0) (STORE_FAST . 2) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))