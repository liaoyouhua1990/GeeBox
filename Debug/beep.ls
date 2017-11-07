   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2572                     ; 5 void Delay(u32 t)
2572                     ; 6 {
2574                     	switch	.text
2575  0000               L3361_Delay:
2577       00000000      OFST:	set	0
2580  0000               L3661:
2581                     ; 7 	while(t--);
2583  0000 96            	ldw	x,sp
2584  0001 1c0003        	addw	x,#OFST+3
2585  0004 cd0000        	call	c_ltor
2587  0007 96            	ldw	x,sp
2588  0008 1c0003        	addw	x,#OFST+3
2589  000b a601          	ld	a,#1
2590  000d cd0000        	call	c_lgsbc
2592  0010 cd0000        	call	c_lrzmp
2594  0013 26eb          	jrne	L3661
2595                     ; 8 }
2598  0015 81            	ret
2624                     ; 10 void BEEP_Init(void)
2624                     ; 11 {
2625                     	switch	.text
2626  0016               _BEEP_Init:
2630                     ; 12 	PB_DDR&=~(1<<6);
2632  0016 721d5007      	bres	_PB_DDR,#6
2633                     ; 13 	PB_CR1&=~(1<<6);
2635  001a 721d5008      	bres	_PB_CR1,#6
2636                     ; 14 	PB_CR2&=~(1<<6);
2638  001e 721d5009      	bres	_PB_CR2,#6
2639                     ; 15 }
2642  0022 81            	ret
2681                     ; 17 void BEEP_Moo(void)
2681                     ; 18 {
2682                     	switch	.text
2683  0023               _BEEP_Moo:
2685  0023 88            	push	a
2686       00000001      OFST:	set	1
2689                     ; 19 	u8 i=0;
2691  0024 0f01          	clr	(OFST+0,sp)
2692                     ; 21 	PB_DDR|=1<<6;
2694  0026 721c5007      	bset	_PB_DDR,#6
2695                     ; 22 	PB_CR1|=1<<6;
2697  002a 721c5008      	bset	_PB_CR1,#6
2698                     ; 23 	PB_CR2&=~(1<<6);
2700  002e 721d5009      	bres	_PB_CR2,#6
2701                     ; 24 	for(i=0;i<120;i++)
2703  0032 0f01          	clr	(OFST+0,sp)
2704  0034               L5171:
2705                     ; 26 		BEEP_1();
2707  0034 721c5005      	bset	_PB_ODR,#6
2708                     ; 27 		Delay(25);
2710  0038 ae0019        	ldw	x,#25
2711  003b 89            	pushw	x
2712  003c ae0000        	ldw	x,#0
2713  003f 89            	pushw	x
2714  0040 adbe          	call	L3361_Delay
2716  0042 5b04          	addw	sp,#4
2717                     ; 28 		BEEP_0();
2719  0044 721d5005      	bres	_PB_ODR,#6
2720                     ; 29 		Delay(20);
2722  0048 ae0014        	ldw	x,#20
2723  004b 89            	pushw	x
2724  004c ae0000        	ldw	x,#0
2725  004f 89            	pushw	x
2726  0050 adae          	call	L3361_Delay
2728  0052 5b04          	addw	sp,#4
2729                     ; 24 	for(i=0;i<120;i++)
2731  0054 0c01          	inc	(OFST+0,sp)
2734  0056 7b01          	ld	a,(OFST+0,sp)
2735  0058 a178          	cp	a,#120
2736  005a 25d8          	jrult	L5171
2737                     ; 31 	PB_DDR&=~(1<<6);
2739  005c 721d5007      	bres	_PB_DDR,#6
2740                     ; 32 	PB_CR1|=(1<<6);
2742  0060 721c5008      	bset	_PB_CR1,#6
2743                     ; 33 }
2746  0064 84            	pop	a
2747  0065 81            	ret
2760                     	xdef	_BEEP_Moo
2761                     	xdef	_BEEP_Init
2780                     	xref	c_lrzmp
2781                     	xref	c_lgsbc
2782                     	xref	c_ltor
2783                     	end
