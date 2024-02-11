PORTB = $6000
PORTA= $6001
DDRB = $6002
DDRA = $6003
T1CL = $6004
T1CH = $6005
ACR = $600B
IER = $600E

E = %01000000
RW = %00100000
RS = %00010000

ACIA_DATA = $5000
ACIA_STATUS = $5001
ACIA_CMD = $5002
ACIA_CTRL = $5003

    .org $8000

reset:
    ldx #$ff
    txs

    lda #$00
    sta ACIA_STATUS  ; Soft Reset

    lda #$1f    ; Serial Setup
    sta ACIA_CTRL

    lda #$0b    ; Mas Serial Setup
    sta ACIA_CMD

    ldx #0
send_msg:
    lda message,x
    beq done
    jsr send_char
    inx
    jmp send_msg

done:

rx_wait:
    lda ACIA_STATUS
    and #$08
    beq rx_wait ; loop if rx buffer is empty
    lda ACIA_DATA
    jsr send_char
    jmp rx_wait

message: .asciiz "Hello, World"

send_char:
    sta ACIA_DATA
    pha
tx_wait:
    lda ACIA_STATUS
    and #$10    ; Check tx buffer
    beq tx_wait
    pla
    rts
