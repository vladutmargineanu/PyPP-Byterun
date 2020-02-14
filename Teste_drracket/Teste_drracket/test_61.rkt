(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None) (1 . None) (2 . None) (3 . None) (4 . None) (5 . None) (6 . None))
		#hash((0 . 0) (1 . 9) (2 . 3) (3 . 4) (4 . 5) (5 . 2) (6 . 6))
		#hash((0 . "prod"))
		'((LOAD_CONST . 1) (STORE_FAST . 0) (LOAD_CONST . 2) (STORE_FAST . 1) (LOAD_CONST . 3) (STORE_FAST . 2) (LOAD_CONST . 4) (STORE_FAST . 3) (LOAD_GLOBAL . 0) (LOAD_FAST . 0) (LOAD_FAST . 1) (LOAD_FAST . 2) (LOAD_FAST . 3) (CALL_FUNCTION . 4) (STORE_FAST . 4) (LOAD_GLOBAL . 0) (LOAD_FAST . 4) (LOAD_CONST . 5) (LOAD_CONST . 2) (LOAD_CONST . 3) (LOAD_CONST . 4) (LOAD_CONST . 6) (CALL_FUNCTION . 6) (STORE_FAST . 5) (LOAD_FAST . 4) (LOAD_FAST . 5) (BINARY_ADD . 0) (STORE_FAST . 6) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))