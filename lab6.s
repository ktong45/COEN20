//Kristin Tong
	.syntax		unified
	.cpu		cortex-m4
	.text

//void MatrixMultiply(int32_t a[3][3],int32_t b[3][3], int32_t c[3][3]);
	.global		MatrixMultiply
	.thumb_func
	.align
MatrixMultiply:
	PUSH	{R4-R11,LR}
	MOV	R7,R0	//R7<-&a
	MOV	R8,R1	//R8<-&b
	MOV	R9,R2	//R9<-&c
	LDR	R4,=0	//row=0
	LDR	R11,=3	//R11<-3
			//address = 4*(3*row+col)
loop1:	CMP	R4,2
	BGT	done	//if row>2 goto done
	LDR	R5,=0	//set R5 =0

loop2:	CMP	R5,2
	BGT	end2			//if col>2 goto end2
	MUL	R3,R4,R11		//R3 = 3*row
	ADD	R10,R3,R5		//R10 = 3*row + col
	LDR	R6,=0			//R3<-0
	STR	R6,[R7,R10,LSL 2]	//a[row][col]=0

loop3:	CMP	R6,2
	BGT	end3			//if k>2 goto end3
	LDR	R0,[R7,R10,LSL 2]	//R0<-a[row][col]
	MUL	R1,R4,R11		//R1=3*row
	ADD	R1,R1,R6		//R1=3*row+k
	LDR	R1,[R8,R1,LSL 2]	//R1<-b[row][k]
	MUL	R3,R6,R11		//R3=3*k
	ADD	R3,R3,R5		//R3=3*k+col
	LDR	R2,[R9,R3,LSL 2]	//R2<-c[k][col]
	BL	MultAndAdd		//call function
	STR	R0,[R7,R10,LSL 2]	//store MultAndAdd return in a[row][col]
	ADD	R6,R6,1			//k++
	B	loop3			//loop
	
end3:	ADD	R5,R5,1		//col++
	B	loop2
end2:	ADD	R4,R4,1		//row++
	B	loop1
done:	POP	{R4-R11,PC}
