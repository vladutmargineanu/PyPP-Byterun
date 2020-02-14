(run-stack-machine
	(make-stack-machine 
		empty-stack 
		#hash((0 . None))
		#hash((0 . 0))
		#hash()
		'((LOAD_FAST . 0) (RETURN_VALUE . 0))
		0))