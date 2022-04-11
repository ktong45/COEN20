	.syntax		unified
	.cpu		cortex-m4
	.text


/* uint32_t Add(uint32_t x); */
	.global		Add
	.thumb_func
	.align
Add:
	ADD			R0,R0,R1	// x+1 parameter 1,R0 and param 2,R1 to R0
	BX			LR

/* uint32_t Less1(uint32_t x); */
	.global		Less1
	.thumb_func
	.align
Less1:
	SUB			R0,R0,1		// x-1
	BX			LR

/* uint32_t Square2x(int32_t x); */
	.global		Square2x
	.thumb_func
	.align
Square2x:
	ADD			R0,R0,R0	// x+x	add value of R0 (x) to itself
	B			Square		// go to Square() func with R0 = 2x
/* uint32_t Last(int32_t x); */
	.global		Last
	.thumb_func
	.align
Last:
	PUSH			{R4,LR}		//save R4 data to stack
	MOV			R4,R0		//save value of R0(aka x) to R4
	BL			SquareRoot	//call SquareRoot on value of x
	ADD			R0,R0,R4	//add value of x(R4) to SquareRoot(x)
	POP			{R4,PC}		//return to R4 value
	/* End of file */
	.end
