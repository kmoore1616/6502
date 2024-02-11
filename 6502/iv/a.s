ACIA_DATA = $5000
ACIA_STATUS = $5001
ACIA_CMD = $5002
ACIA_CTRL = $5003


	.org $8000

reset:
	lda #$00
	sta ACIA_STATUS ; Reset
	
	lda #$1f  ; 8bts, 19200
	sta ACIA_CTRL
	
	lda #$0b  ; Setup more crap
	sta ACIA_CMD
	
rx_wait:
	lda ACIA_DATA  ; Echo stuff
	jsr send_char
	jmp rx_wait

send_char:
	sta ACIA_DATA
	pha
	rts
tx_wait:
	lda ACIA_STATUS
	and #$10  ; Is tx ready?
	beq tx_wait
	pla
	rts
loop:
	
	jmp loop
	

	.org $fffc
	.word reset
	.word $0000
