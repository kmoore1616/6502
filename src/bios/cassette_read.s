.setcpu "65C02"
.segment "CASSETTE"
STORE_ADDRESS_LOW = $2A00
STORE_ADDRESS_HIGH = $2A01

CASSETTE_READ:				; Recognizable label to locate program in memory
CAS_SETUP:
	pha
	phx
	phy
	lda	#$00
	sta	ACIA_CTRL		; Reset Ctrl register
	lda	#$16			; 8-N-1, 300bps (need to lower to accomodate KCS)
	sta	ACIA_CTRL

GET_DATA:
	lda	ACIA_STATUS
	and	#$08			; Is there data to be read
	beq	GET_DATA		; No? Keep Looking
RECIEVE_DATA:
	cmp	#$FF			; FF signals the end of data transmission
	beq	FINISHED_RECEPTION
	lda	STORE_ADDRESS_LOW
	sta	$00
	lda	STORE_ADDRESS_HIGH
	sta	$01
	ldy	#$00
	lda	ACIA_DATA
	sta	($00),y
	
	inc	STORE_ADDRESS_LOW	;
	bne	SKIP_UPPER
	inc	STORE_ADDRESS_HIGH
SKIP_UPPER:
	jmp	GET_DATA

FINISHED_RECEPTION:
	lda	#$00
	sta	ACIA_CTRL		; Reset Ctrl register
	lda	#$1f				; 8-N-1, 19200bps (return baud rate to terminal's rate)
	sta	ACIA_CTRL
	ldx	#$0
	jsr	CAS_FINISH_MESSAGE
	ply
	plx
	pla
	jmp	RESET
CAS_FINISH_MESSAGE:
	lda	end_message,x
	beq	FINISHED_PRINTING
	jsr	ECHO
	inx 
	jmp	CAS_FINISH_MESSAGE
FINISHED_PRINTING:
	rts

end_message:
	.asciiz "RECEPTION ENDED"



	
	
