   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2565                     ; 3 void LED_Init(void)
2565                     ; 4 {	
2567                     	switch	.text
2568  0000               _LED_Init:
2572                     ; 5 	PD_DDR|=1<<1;
2574  0000 72125011      	bset	_PD_DDR,#1
2575                     ; 6 	PD_CR1|=1<<1;
2577  0004 72125012      	bset	_PD_CR1,#1
2578                     ; 7 	PD_CR2&=~(1<<1);
2580  0008 72135013      	bres	_PD_CR2,#1
2581                     ; 8 	LED_BAT_1();
2583  000c 7212500f      	bset	_PD_ODR,#1
2584                     ; 9 }
2587  0010 81            	ret
2590                     	bsct
2591  0000               L1561_count:
2592  0000 00000000      	dc.l	0
2625                     .const:	section	.text
2626  0000               L01:
2627  0000 00001389      	dc.l	5001
2628                     ; 11 void LED_Flash_Ser(void)
2628                     ; 12 {
2629                     	switch	.text
2630  0011               _LED_Flash_Ser:
2634                     ; 15 	count++;
2636  0011 ae0000        	ldw	x,#L1561_count
2637  0014 a601          	ld	a,#1
2638  0016 cd0000        	call	c_lgadc
2640                     ; 16 	if(count>5000)
2642  0019 ae0000        	ldw	x,#L1561_count
2643  001c cd0000        	call	c_ltor
2645  001f ae0000        	ldw	x,#L01
2646  0022 cd0000        	call	c_lcmp
2648  0025 2512          	jrult	L1761
2649                     ; 18 		count=0;
2651  0027 ae0000        	ldw	x,#0
2652  002a bf02          	ldw	L1561_count+2,x
2653  002c ae0000        	ldw	x,#0
2654  002f bf00          	ldw	L1561_count,x
2655                     ; 19 		LED_BAT_x();
2657  0031 c6500f        	ld	a,_PD_ODR
2658  0034 a802          	xor	a,	#2
2659  0036 c7500f        	ld	_PD_ODR,a
2660  0039               L1761:
2661                     ; 21 }
2664  0039 81            	ret
2677                     	xdef	_LED_Flash_Ser
2678                     	xdef	_LED_Init
2697                     	xref	c_lcmp
2698                     	xref	c_ltor
2699                     	xref	c_lgadc
2700                     	end
