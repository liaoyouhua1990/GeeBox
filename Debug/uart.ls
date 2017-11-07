   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _uart_buffer:
2536  0000 00            	dc.b	0
2537  0001 00            	dc.b	0
2538  0002 00            	dc.b	0
2539  0003 00            	dc.b	0
2540  0004               L3361_i:
2541  0004 00            	dc.b	0
2573                     ; 7 void UART_Init(void)
2573                     ; 8 {	
2575                     	switch	.text
2576  0000               _UART_Init:
2580                     ; 9 	_asm("sim");//关全局中断
2583  0000 9b            sim
2585                     ; 10 	UART1_BRR2=0x01;
2587  0001 35015233      	mov	_UART1_BRR2,#1
2588                     ; 11 	UART1_BRR1=0x34;
2590  0005 35345232      	mov	_UART1_BRR1,#52
2591                     ; 12 	UART1_CR2=0x2c;
2593  0009 352c5235      	mov	_UART1_CR2,#44
2594                     ; 13 	_asm("rim");//开全局中断
2597  000d 9a            rim
2599                     ; 14 }
2602  000e 81            	ret
2638                     ; 16 void UART_SendByte(u8 byte)
2638                     ; 17 {
2639                     	switch	.text
2640  000f               _UART_SendByte:
2642  000f 88            	push	a
2643       00000000      OFST:	set	0
2646  0010               L3761:
2647                     ; 18 	while(!(UART1_SR&(1<<7)));
2649  0010 c65230        	ld	a,_UART1_SR
2650  0013 a580          	bcp	a,#128
2651  0015 27f9          	jreq	L3761
2652                     ; 19 	UART1_DR=byte;
2654  0017 7b01          	ld	a,(OFST+1,sp)
2655  0019 c75231        	ld	_UART1_DR,a
2656                     ; 20 }
2659  001c 84            	pop	a
2660  001d 81            	ret
2696                     ; 22 void UART_SendString(u8 *string)
2696                     ; 23 {	
2697                     	switch	.text
2698  001e               _UART_SendString:
2700  001e 89            	pushw	x
2701       00000000      OFST:	set	0
2704  001f 200c          	jra	L7171
2705  0021               L5171:
2706                     ; 26 		UART_SendByte(*string);
2708  0021 1e01          	ldw	x,(OFST+1,sp)
2709  0023 f6            	ld	a,(x)
2710  0024 ade9          	call	_UART_SendByte
2712                     ; 27 		string++;
2714  0026 1e01          	ldw	x,(OFST+1,sp)
2715  0028 1c0001        	addw	x,#1
2716  002b 1f01          	ldw	(OFST+1,sp),x
2717  002d               L7171:
2718                     ; 24 	while(*string)
2720  002d 1e01          	ldw	x,(OFST+1,sp)
2721  002f 7d            	tnz	(x)
2722  0030 26ef          	jrne	L5171
2723                     ; 29 }
2726  0032 85            	popw	x
2727  0033 81            	ret
2754                     ; 31 void UART_RecvString_ISR(void)
2754                     ; 32 {
2755                     	switch	.text
2756  0034               _UART_RecvString_ISR:
2760                     ; 33 	uart_buffer[i]=UART1_DR;
2762  0034 b604          	ld	a,L3361_i
2763  0036 5f            	clrw	x
2764  0037 97            	ld	xl,a
2765  0038 c65231        	ld	a,_UART1_DR
2766  003b e700          	ld	(_uart_buffer,x),a
2767                     ; 34 	i++;
2769  003d 3c04          	inc	L3361_i
2770                     ; 35 }
2773  003f 81            	ret
2799                     ; 37 void UART_RecvBtm513_Ser(void)
2799                     ; 38 {
2800                     	switch	.text
2801  0040               _UART_RecvBtm513_Ser:
2805                     ; 39 	if(uart_buffer[0]=='M')
2807  0040 b600          	ld	a,_uart_buffer
2808  0042 a14d          	cp	a,#77
2809  0044 260e          	jrne	L3471
2810                     ; 41 		if(i==3)
2812  0046 b604          	ld	a,L3361_i
2813  0048 a103          	cp	a,#3
2814  004a 260a          	jrne	L7471
2815                     ; 43 			i=0;
2817  004c 3f04          	clr	L3361_i
2818                     ; 44 			uart_buffer[3]=1;
2820  004e 35010003      	mov	_uart_buffer+3,#1
2821  0052 2002          	jra	L7471
2822  0054               L3471:
2823                     ; 49 		i=0;
2825  0054 3f04          	clr	L3361_i
2826  0056               L7471:
2827                     ; 51 }
2830  0056 81            	ret
2864                     	xdef	_UART_RecvBtm513_Ser
2865                     	xdef	_UART_RecvString_ISR
2866                     	xdef	_UART_SendString
2867                     	xdef	_UART_SendByte
2868                     	xdef	_UART_Init
2869                     	xdef	_uart_buffer
2888                     	end
