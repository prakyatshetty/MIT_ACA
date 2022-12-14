;Convert a given number from 0x4000 0000 hex value to ASCII
    
	AREA mycode, CODE, READONLY
	ENTRY
Main
	LDR R0, =0x40000000	; Get the memory loc of Hex Digit source
	LDR R5, [R0] 		; Copy the value from memory to R5, i.e 
	MOV R1, #0x08 		; N = 8 number of HEX digits
	LDR R6, =0x40000004	; Load R6 with Address of Destination location 
UP	AND R2, R5, #0x0F 	; Masking to get only LSB byte in case of multidigit number
	CMP R2, #09 			; Affects the carry flag if no>9 c = 1 else C = 0
	BLO DOWN 			; No < 9, add only 30
	ADD R2, #07 			; No > 9, add 7 + 30
DOWN
	ADD R2, #0x30
	STRB R2, [R6], #01 	; Store the result in Memory pointed by R1
	ROR R5, #4  		; Rotate the Number to process the next digit
	SUBS R1, #01 		; decrement the count by 1 and check for zero condition
	BNE UP 				; if Z = 0 repeat the process else exit
	
STOP B STOP
	END