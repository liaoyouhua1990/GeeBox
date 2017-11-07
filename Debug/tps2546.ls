   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _tps2546_charge:
2536  0000 00            	dc.b	0
2537  0001               L3361_tps2546_exti:
2538  0001 01            	dc.b	1
2539  0002               L5361_tps2546_flag:
2540  0002 00            	dc.b	0
2573                     ; 8 void TPS2546_Init(void)
2573                     ; 9 {
2575                     	switch	.text
2576  0000               _TPS2546_Init:
2580                     ; 10 	_asm("sim");
2583  0000 9b            sim
2585                     ; 11 	PC_DDR&=~(1<<4);//悬浮中断
2587  0001 7219500c      	bres	_PC_DDR,#4
2588                     ; 12 	PC_CR1&=~(1<<4);
2590  0005 7219500d      	bres	_PC_CR1,#4
2591                     ; 13 	PC_CR2|=(1<<4);
2593  0009 7218500e      	bset	_PC_CR2,#4
2594                     ; 14 	EXTI_CR1|=(1<<4);//上升沿触发
2596  000d 721850a0      	bset	_EXTI_CR1,#4
2597                     ; 15 	EXTI_CR1|=(1<<5);//下降沿触发
2599  0011 721a50a0      	bset	_EXTI_CR1,#5
2600                     ; 16 	_asm("rim");
2603  0015 9a            rim
2605                     ; 17 }
2608  0016 81            	ret
2633                     ; 19 void TPS2546_Scan_ISR(void)
2633                     ; 20 {
2634                     	switch	.text
2635  0017               _TPS2546_Scan_ISR:
2639                     ; 21 	if(tps2546_flag==0)
2641  0017 3d02          	tnz	L5361_tps2546_flag
2642  0019 2604          	jrne	L5661
2643                     ; 23 		tps2546_exti=1;
2645  001b 35010001      	mov	L3361_tps2546_exti,#1
2646  001f               L5661:
2647                     ; 25 }
2650  001f 81            	ret
2653                     	bsct
2654  0003               L7661_count:
2655  0003 0000          	dc.w	0
2691                     ; 27 void TPS2546_Scan_Ser(void)
2691                     ; 28 {
2692                     	switch	.text
2693  0020               _TPS2546_Scan_Ser:
2697                     ; 31 	if(tps2546_flag)
2699  0020 3d02          	tnz	L5361_tps2546_flag
2700  0022 2724          	jreq	L7071
2701                     ; 33 		count++;
2703  0024 be03          	ldw	x,L7661_count
2704  0026 1c0001        	addw	x,#1
2705  0029 bf03          	ldw	L7661_count,x
2706                     ; 34 		if(count>200)
2708  002b be03          	ldw	x,L7661_count
2709  002d a300c9        	cpw	x,#201
2710  0030 2520          	jrult	L7171
2711                     ; 36 			count=0;
2713  0032 5f            	clrw	x
2714  0033 bf03          	ldw	L7661_count,x
2715                     ; 37 			tps2546_flag=0;
2717  0035 3f02          	clr	L5361_tps2546_flag
2718                     ; 38 			if(TPS2546_DET)
2720  0037 c6500b        	ld	a,_PC_IDR
2721  003a a510          	bcp	a,#16
2722  003c 2704          	jreq	L3171
2723                     ; 40 				tps2546_charge=0;//不充电
2725  003e 3f00          	clr	_tps2546_charge
2727  0040 2010          	jra	L7171
2728  0042               L3171:
2729                     ; 44 				tps2546_charge=1;//充电
2731  0042 35010000      	mov	_tps2546_charge,#1
2732  0046 200a          	jra	L7171
2733  0048               L7071:
2734                     ; 50 		if(tps2546_exti)
2736  0048 3d01          	tnz	L3361_tps2546_exti
2737  004a 2706          	jreq	L7171
2738                     ; 52 			tps2546_exti=0;
2740  004c 3f01          	clr	L3361_tps2546_exti
2741                     ; 53 			tps2546_flag=1;
2743  004e 35010002      	mov	L5361_tps2546_flag,#1
2744  0052               L7171:
2745                     ; 56 }
2748  0052 81            	ret
2790                     	xdef	_TPS2546_Scan_Ser
2791                     	xdef	_TPS2546_Scan_ISR
2792                     	xdef	_TPS2546_Init
2793                     	xdef	_tps2546_charge
2812                     	end
