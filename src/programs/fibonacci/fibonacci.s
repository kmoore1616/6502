.org	$3000

low = $0500
i = $0501
echo = $80EF

Fibbonoci:
	lda	#$30
	jsr	echo		; Output first 0
	lda	#$31
	jsr	echo		; and first 1
	lda	#$0		; Starter values of fib
	sta	low
	lda	#$1
	ldx	i		; The value of I is how many digits of fibbonoci to calculate
Fib_loop:
	dex			; Dec x towards 0.
	beq	Finished	; Is X 0? Yes, end program
	pha			; Save value of A to store in low later
	adc	low		; Do the addition
	tay			; Save value of A to store in high later
	pla			; Get saved value of A before addition
	sta	low		; Store it in low
	tya			; Get saved value of A after addition
	jsr	HEX_TO_ASCII	; Hex to ascii conversion
	jmp	Fib_loop	; AGAIN!

Finished:
	jmp	$8000		; Go back to RESET($8000)


HEX_TO_ASCII:
	sta	$1205
	jsr	$817F
	rts
