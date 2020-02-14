(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash()
		#hash((0 . 0) (1 . 2))
		#hash()
		'((LOAD_CONST . 1) (RETURN_VALUE . 0))
		0))