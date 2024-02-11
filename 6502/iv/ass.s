	.org $8000

loop:
	jmp loop
	

	.org $fffc
	.word loop
	.word $0000
