	.file	"midiVolume.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_11
	.type	__vector_11, @function
__vector_11:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
.L2:
	sbis 43-32,7
	rjmp .L2
	in r25,44-32
	lds r24,state
	cpi r24,lo8(1)
	brne .L3
	sts state,__zero_reg__
	cpi r25,lo8(120)
	brsh .L5
	mov r24,r25
	call enterProgram
	rjmp .L5
.L3:
	andi r25,lo8(-16)
	cpi r25,lo8(-64)
	brne .L5
	ldi r24,lo8(1)
	sts state,r24
.L5:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_11, .-__vector_11
.global	main
	.type	main, @function
main:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
	call init
	ldi r16,lo8(2)
	ldi r17,hi8(2)
	ldi r28,lo8(1)
	ldi r29,hi8(1)
.L24:
	call detectInteraction
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L10
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L13
	sbiw r24,1
	brne .L24
	rjmp .L25
.L13:
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L11
	sbiw r24,4
	brne .L24
	rjmp .L26
.L25:
	lds r24,state+1
	lds r25,(state+1)+1
	or r24,r25
	brne .L22
	call togglePedal
	rjmp .L24
.L10:
	lds r24,state+1
	lds r25,(state+1)+1
	sbiw r24,0
	breq .L16
	sbiw r24,1
	brne .L22
	rjmp .L21
.L16:
	sts (state+1)+1,r29
	sts state+1,r28
	rjmp .L24
.L11:
	lds r18,state+1
	lds r19,(state+1)+1
	cpi r18,2
	cpc r19,__zero_reg__
	breq .L20
	cpi r18,3
	cpc r19,__zero_reg__
	breq .L21
	or r18,r19
	brne .L22
	sts (state+1)+1,r17
	sts state+1,r16
	rjmp .L24
.L20:
	sts (state+1)+1,r25
	sts state+1,r24
	rjmp .L24
.L21:
	call storeProgram
	rjmp .L22
.L26:
	lds r24,state+1
	lds r25,(state+1)+1
	or r24,r25
	brne .L22
	call switchWaveForm
	rjmp .L24
.L22:
	sts (state+1)+1,__zero_reg__
	sts state+1,__zero_reg__
	rjmp .L24
	.size	main, .-main
	.comm program,3,1
	.comm state,3,1
.global __do_clear_bss
