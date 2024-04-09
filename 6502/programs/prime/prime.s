.org $3300

is_prime = $500
dividend = $1200
divisor  = $1201
quotient = $1202
remainder= $1203
convert	 = $1205


DIVIDE   = $8160
ECHO	 = $80EF
DEC_OUT  = $817F


PRIME_SIEVE:
	ldx	$500		; Load the value to be tested
	stx	dividend	; The value in the dividned will never change
PRIME_LOOP:
	dex			; Dec X to test next number
	stx	divisor	
	jsr	DIVIDE		; Divide number
	lda	remainder	; Get the remainder
	beq	ISNT_PRIME	; Is remainder 0?
	jmp	PRIME_LOOP	; Yes? Print


ISNT_PRIME:
	lda	#$0A
	jsr	ECHO
	lda	#$0D
	jsr	ECHO
	stx	convert
	jsr	DEC_OUT
	lda	#$2A
	jsr	ECHO
	lda	quotient
	jsr	ECHO
	jsr	$8000
	

	

