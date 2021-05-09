
	AREA heapSort, CODE,READONLY
	
ENTRY
	LDR R0,= number_list ; store the adress of number_list in r0 to build heap
	MOV R1,#0x00001000; heap adress
	MOV R12,R1;
	ADD R12,R12,#4
	MOV R3,#40;size of the number_list
	STR R3,[R1,#0];store the size of number_list in first element of heap	
	MOV R4,#0 ; i
BUILD
	ADD R5,R4,#4; i++
	LDR R6,[R0,R4] ; number_list[i]
	STR R6,[R1,R5] ; str r6 in r1[i+1]
	ADD R4,R4,#4 ; i++
	CMP R4,R3
	BLT BUILD
	LDR R0,[R1,#0] ; n
	MOV R4, #0 ; i = 0
HEAPIFY
	ADD R4,R4,#4 ; i 
	CMP R10,R0
	BGE SORT
	SUB R5,R4,#4 ; r5 = i-1
	LSR R5,R5,#3 ; R5 = (i-1) /2
	LDR R6 ,[R12,R4] ; heap[i]
	LDR R7 ,[R12,R5] ; heap[(i-1)/2]
	CMP R6,R7
	BGE HEAPIFY
	MOV R8,R4 ;j = i;
	
WHILE
	SUB R9,R8,#4 ; r9 = j-1
	LSR R9,R9,#3 ; R9 = (j-1) /2
	LDR R10, [R12,R8] ; heap[l]
	LDR R11, [R12,R9] ; heap[r]
	CMP R10,R11
	BGE HEAPIFY
	; a swap b operation
	MOV R2,R10     ;    temp = heap[l];
	STR	R11, [R12,R8]    ; heap[l] = heap[r];
	STR R2,[R12,R9]	;     heap[r]= temp
	MOV R8,R9  ;j = (j-1) /2
	B WHILE
	
SORT
	MOV R2,R0 ; let i = n;
	LSL R2,R2,#2 ; n = n*4
	SUB R2,R2,#4 ; let i = i-1 = (n) -1;
	CMP R2,#0
	BLE ENDL
	LDR R3,[R12,#4] ; heap[1]
	LDR R4, [R12, R2] ; heap[i];
	;SWAP OPERATION
	MOV R5, R3; temp = heap[1]
	STR R4 ,[R12,#4]; heap[1] = heap[i]
	STR R5,[R12,R2];heap[i] = temp
	MOV R6, #0 ; j
DO
	LSL R3,R6,#3 ; index variable = 2* j
	ADD R3,R3,#4 ; indx = 2*j+1
	SUB R4,R2,#4 ; i-1
	LDR R8,[R12,R3] ; heap[index]
	ADD R5,R3,#4 ; index +1
	LDR R7,[R12,R5] ; heap[index+1]
	
INDEXCONTROL1

	CMP R3,R4
	BGE INDEXCONTROL2
	CMP R8,R7
	BLE INDEXCONTROL2
	ADD R3,R3,#4 ; index++;
	
INDEXCONTROL2
	CMP R3,R2
	BGE INDEXCONTROL3
	LDR R5,[R12,R6] ; heap[j]
	CMP R5,R8
	BLE INDEXCONTROL3
	;SWAP
	MOV R10, R8   ; temp = heap[index]
	STR R5 ,[R12,R3]  ; heap[index] = heap[j]
	STR R10,[R12,R6]   ;heap[j] = temp
	
INDEXCONTROL3
	MOV R6, R3 ; j = index
	CMP R3,R2
	BGE FIND
	B DO
	
FIND
	MOV R0,#5 ; the value which gonna search in heap
	MOV R5,#0; i
	LDR R6, [R1,#0] ; n , size of array
SEARCH
	ADD R5,R5,#4 ; i starts with 1
	CMP R5 ,R6
	BGT ENDL
	LDR R7 ,[R12,R5] ; heap[i]
	CMP R0,R7
	BNE SEARCHELSE
	BEQ SEARCHIF
	B SEARCH

SEARCHIF
	MOV R0,#1
	B ENDL
SEARCHELSE
	MOV R0,#0 ; r0 = 0
	MOV R1,R0 ; R1 = found value
	B ENDL
	
number_list DCD 2,17,3,4,5,6,7,8,9,-2147483648

ENDL
	END
		
	