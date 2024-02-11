

	.org $8000

reset:
	lda #$55
	sta $8200
	ldx $8200
	dex
	stx $8205
	pha
	pla
	dec
	sta $3000
	lda $3000
	jmp reset

	.org $fffc
	.word reset
	.word $0000
