//Kristin Tong
	.syntax		unified
	.cpu		cortex-m4
	.text


/* uint64_t TireDiam(uint32_t W, uint32_t A, uint32_t R); */
	.global		TireDiam
	.thumb_func
	.align
TireDiam:
	MUL	R0,R1,R0	// R0 = A*W
	LDR	R3,=1270	// R3 = 1270
	UDIV	R1,R0,R3	// R1 = A*W/1270
	MLS	R0,R3,R1,R0	// R0 = R0-(1270*R1)
	ADD	R1,R2,R1	// R1 = R+(A*W)/1270
	BX	LR

/* uint64_t TireCirc(uint32_t W, uint32_t A, uint32_t R); */
	.global		TireCirc
	.thumb_func
	.align
TireCirc:
	PUSH	{LR}		//preserve LR
	BL	TireDiam	//R1<- D(63-32),R0<-D(31-0)
	LDR	R2,=4987290	//R2 = 4987290
	LDR	R3,=3927	//R3 = 3927
	MUL	R1,R1,R2	//R1<- 4987290*D(63-32)
	MUL	R2,R0,R3	//R2<- 3927*D(31-0)
	ADD	R2,R1,R2	//R2 = R1+R2
	LDR	R3,=1587500	//R3 = 1587500
	UDIV	R1,R2,R3	//R1 = R2/R3
	MLS	R0,R1,R3,R2	//R0 = R2-(R3*R1)
	POP	{PC}

	/* End of file */
	.end
