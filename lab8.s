//Kristin Tong
//lab8.s
	.syntax		unified
	.cpu		cortex-m4
	.text
//Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
//using MUL and DIV
	.global		Zeller1
	.thumb_func
	.align
Zeller1:	//R0=k, R1=m, R2=D, R3=C
	ADD	R0,R0,R2	//R0=k+D
	ADD	R0,R0,R2,LSR 2	//R0=k+D+(D/4)
	ADD	R0,R0,R3,LSR 2	//R0=k+D+(D/4)+(C/4)
	SUB	R0,R0,R3,LSL 1	//R0=k+D+(D/4)+(C/4)-2C
	LDR	R2,=13		//R2=13
	MUL	R1,R1,R2	//R1=13*m
	SUB	R1,R1,1		//R1=(13*m)-1
	LDR	R2,=5		//R2=5
	UDIV	R1,R1,R2	//R1=((13*m)-1)/5
	ADD	R0,R0,R1	//f=k+D+(D/4)+(C/4)-2C+((13*m)-1)/5
	LDR	R2,=7		//R2=7
	SDIV	R3,R0,R2	//R3=f/7
	MUL	R3,R3,R2	//R3=7*(f/7)
	SUB	R0,R0,R3	//R0=f-7*(f/7)
	CMP	R0,0
	IT	LT		//if(remainder<0)
	ADDLT	R0,R0,R2	//then remainder +=7
	BX	LR
	
//Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
//not using MUL
	.global		Zeller2
	.thumb_func
	.align
Zeller2:	//R0 = k, R1 = m, R2 = D, R3 = C
	ADD	R0,R0,R2	//R0=k+D
	ADD	R0,R0,R2,LSR 2	//R0=R0+(D/4)
	ADD	R0,R0,R3,LSR 2	//R0=R0+(C/4)
	SUB	R0,R0,R3,LSL 1	//R0=R0+(2*C)
	LSL	R2,R1,3		//R2=8m
	ADD	R3,R1,R1,LSL 2	//R3=5m
	ADD	R2,R2,R3	//R2=13m
	SUB	R1,R2,1		//R1=13m-1
	LDR	R2,=5		//R2=5
	UDIV	R1,R1,R2	//R1=(13m-1)/5
	ADD	R0,R0,R1	//f=k+D+D/4+C/4-2C+(13m-1)/5
	LDR	R2,=7		//R2=7
	SDIV	R3,R0,R2	//R3=f/7
	RSB	R2,R3,R3,LSL 3	//R2=7*(f/7)
	SUB	R0,R0,R2	//R0=f-(f/7)*7
	CMP	R0,0
	IT	LT		//if R0<0
	ADDLT	R0,R0,7		//R0+=7
	BX	LR

//Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C)
//not using SDIV or DIV
	.global		Zeller3
	.thumb_func
	.align
Zeller3:
	ADD	R0,R0,R2	//R0=f+D
	ADD	R0,R0,R2,LSR 2	//R0=R0+(D/4)
	ADD	R0,R0,R3,LSR 2	//R0=R0+(C/4)
	SUB	R0,R0,R3,LSL 1	//R0=R0+(2*C)
	LSL	R2,R1,3		//R2=8m
	ADD	R3,R1,R1,LSL 2	//R3=5m
	ADD	R2,R2,R3	//R2=13m
	SUB	R1,R2,1		//R1=13m-1
	LDR	R2,=1717986919	//R2=magic5const
	SMMUL	R2,R2,R1	//R2=64-bit prod
	LSR	R1,R1,31
	ADD	R1,R1,R2,ASR 1	//R1=(13*m)/5
	ADD	R0,R0,R1	//f=k+D+D/4+C/4-2C+(13m-1)/5
	LDR	R2,=2454267027	//R2=magic7const
	SMMLA	R2,R2,R0,R0	
	LSR	R3,R0,31
	ADD	R3,R3,R2,ASR 2	//R3=f/7
	RSB	R2,R3,R3,LSL 3	//R2=7*(f/7)
	SUB	R0,R0,R2	//R0=R0-(f/7)*7
	CMP	R0,0
	IT	LT
	ADDLT	R0,R0,7		//if(remainder <0) then remainder+=7
	BX	LR
