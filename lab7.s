//Kristin Tong
	.syntax		unified
	.cpu		cortex-m4
	.text

//void uint32_t ReverseBits(uint32_t word) ;
	.global		ReverseBits
	.thumb_func
	.align
ReverseBits:	//R0<-word
	.REPT	31		//repeat 31 times
	LSRS	R0,R0,1		//R0 shifts right one bit and saves MSB to carry
	ADC	R1,R1,R1	//R1 shifts and adds carry
	.ENDR			//end repeat
	LSRS	R0,R0,1		//shift R0 right 1 more bit
	ADC	R0,R1,R1	//add R1 to R0
	BX	LR
//void uint32_t ReverseBytes(uint32_t word) ;
	.global		ReverseBytes
	.thumb_func
	.align
ReverseBytes:	//R0<-word	
	ROR	R0,R0,8		//rotate LS byte to MS byte
	LSR	R1,R0,16	//shift R0 2 bytes right and store in R1
	BFI	R0,R0,16,8	//insert R0 LS byte two bytes to the left
	BFI	R0,R1,0,8	//copy LS byte from R1 to R0
	BX	LR
