.setcpu "65816"
.segment "MATH"

dividend = $1200
divisor = $1202
quotient = $1204
remainder = $1206

multiplicand = $1210
multiplier = $1212
product = $1214

convert = $1208

DIVIDE:				; Load A with dividned and X with divisor
    
    REP  #%00110000		;16 bit XY+Accumulator
    .A16                ; Goto 16 bit mode!
    .I16


	lda	#0		; Clear Quotient
	sta	quotient
	ldx	#16		; Loop variable
DLOOP:				
	asl	dividend	; Slowly load ACC with dividend
	rol			; ^
	cmp	divisor		; Can you subtract ACC by divisor?
	php			; Save result of prev operation (Carry flg)
	rol	quotient	; Put result of cmp into quotient
	plp			; Restore carry flag
	bcc	NOSBC		; If no carry skip next step
	sbc	divisor		; If carry subtract divisor from ACC
NOSBC:
	dex			; Decrement loop
	bne	DLOOP		; Is loop done? No? goto DLOOP
	sta	remainder	; Yes? Store whats left in A into remainder
	rts			; GOBACK


DEC_TO_ASCII:			; Converts the value at $1205 to an ascii #
    REP  #%00110000		;16 bit XY+Accumulator
    .A16                ; Goto 16 bit mode!
    .I16
	clc			; Just in case
	lda	convert		; Grab that value
	sta	dividend	; Store it to be divided
	lda	#100		; By hundred
	sta	divisor
	lda	#0		; Clear remainder just in case
	sta	remainder	
	jsr	DIVIDE
	clc
	lda	#$0A		; Output linefeed
	jsr	16ECHO
	lda	#$0D		; CR
	jsr	16ECHO
	lda	quotient	; Output hundreds place
	adc	#$30
	jsr	16ECHO
	lda	remainder	; Remainder has tens and ones place
	sta	dividend
	lda	#10		; By ten
	sta	divisor		
	jsr	DIVIDE		; Do the division
	clc
	lda	quotient	; Tens place
	adc	#$30		; Convert to ascii
	jsr	16ECHO
	lda	remainder	; Ones place
	adc	#$30		; Convert to ascii
	jsr	16ECHO
	rts

MULTIPLY:
    REP  #%00110000		;16 bit XY+Accumulator
    .A16                ; Goto 16 bit mode!
    .I16
    pha
    phx
    lda #00
    sta product
    ldx multiplier
MUL_LOOP:
    adc multiplicand
    dex
    beq MUL_DONE
    jmp MUL_LOOP
MUL_DONE:
    sta product
    plx
    pla
    rts
