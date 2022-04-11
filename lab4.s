//Kristin Tong
//lab4.s
//copying data quickly

	.syntax		unified
	.cpu		cortex-m4
	.text

//void UseLDRB(void *dst, void *src)
	.global		UseLDRB
	.thumb_func
	.align
UseLDRB:
	.REPT	512		//512 loops at 1 byte
	LDRB	R2,[R1],1	//load R1 byte into R2 and shift 1 byte w post indexing
	STRB	R2,[R0],1	//store byte in R2 and post index again
	.ENDR
	BX	LR

//void UseLDRH(void *dst, void *src)
	.global		UseLDRH
	.thumb_func
	.align
UseLDRH:
	.REPT	256		//256 loops at 2 bytes
	LDRH	R2,[R1],2	//load half word R1->R2 and increment by two bytes
	STRH	R2,[R0],2	//store half word in R2
	.ENDR
	BX	LR

//void UseLDR(void *dst, void *src)
	.global		UseLDR
	.thumb_func
	.align
UseLDR:
	.REPT	128		//128 loops at 4 bytes
	LDR	R2,[R1],4	//load 4 bytes per cycle
	STR	R2,[R0],4	//store 4 bytes per cycle
	.ENDR
	BX	LR

//void UseLDRD(void *dst, void *src)
	.global		UseLDRD
	.thumb_func
	.align
UseLDRD:
	.REPT	64		//64 loops to copy 8 bytes each
	LDRD	R2,R3,[R1],8	//load 8 bytes into R2 and R3
	STRD	R2,R3,[R0],8	//store 8 bytes in R2 and R3
	.ENDR
	BX	LR

//void UseLDM(void *dst, void *src)
	.global		UseLDM
	.thumb_func
	.align
UseLDM:
	PUSH	{R4-R9}		//push R4-R9 onto stack to preserve original
	.REPT	16		//16 loops for 32 bytes total 512 bytes
	LDMIA	R1!,{R2-R9}	//load registers R2-R9 with 32 bytes
	STMIA	R0!,{R2-R9}	//store 32 bytes in R2-R9 to R0
	.ENDR	
	POP	{R4-R9}		//pop original R4-R9 off stack
	BX	LR
	
	.end
