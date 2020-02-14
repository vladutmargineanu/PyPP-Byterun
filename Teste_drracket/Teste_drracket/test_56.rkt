(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None))
		#hash((0 . 0) (1 . 9) (2 . 16) (3 . 6) (4 . 10) (5 . 15))
		#hash((0 . "sqrt"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_GLOBAL . 0) (LOAD_FAST . 0) (CALL_FUNCTION . 1) (STORE_FAST . 2) (LOAD_GLOBAL . 0) (LOAD_FAST . 1) (CALL_FUNCTION . 1) (STORE_FAST . 3) (LOAD_FAST . 2) (LOAD_FAST . 3) (BINARY_ADD . 0) (STORE_FAST . 4) (LOAD_CONST . 5) (STORE_FAST . 5) (LOAD_FAST . 5) (LOAD_CONST . 4) (BINARY_ADD . 0) (STORE_FAST . 5) (LOAD_GLOBAL . 0) (LOAD_FAST . 5) (CALL_FUNCTION . 1) (STORE_FAST . 6) (LOAD_FAST . 4) (LOAD_FAST . 6) (INPLACE_ADD . 0) (STORE_FAST . 4) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))