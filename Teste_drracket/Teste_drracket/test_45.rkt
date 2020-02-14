(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash()
		#hash((0 . 0) (1 . "Tema 1 - PP"))
		#hash((0 . "print"))
		'((LOAD_GLOBAL . 0) (LOAD_CONST . 1) (CALL_FUNCTION . 1) (POP_TOP . 0) (LOAD_CONST . 0) (RETURN_VALUE . 0))
		0))