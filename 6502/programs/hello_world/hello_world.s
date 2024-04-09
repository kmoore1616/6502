
START_LOOP:
	ldx	#$0
	lda	hello_world,x
	beq 	DONE
	jsr	#$80EF		; Echo
	inx
	jmp START_LOOP
DONE:
	jmp	#$8000		; Reset


hello_world:	.asciiz "Hello, There!"
