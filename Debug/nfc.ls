   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _nfc_en:
2536  0000 00            	dc.b	0
2537  0001               L3361_nfc_exti0:
2538  0001 00            	dc.b	0
2571                     ; 7 void NFC_Init(void)
2571                     ; 8 {	
2573                     	switch	.text
2574  0000               _NFC_Init:
2578                     ; 9 	_asm("sim");//关全局中断
2581  0000 9b            sim
2583                     ; 10 	PE_DDR&=~(1<<5);
2585  0001 721b5016      	bres	_PE_DDR,#5
2586                     ; 11 	PE_CR1|=(1<<5);
2588  0005 721a5017      	bset	_PE_CR1,#5
2589                     ; 12 	PE_CR2|=(1<<5);
2591  0009 721a5018      	bset	_PE_CR2,#5
2592                     ; 13 	EXTI_CR2|=(1<<1);//下降沿触发
2594  000d 721250a1      	bset	_EXTI_CR2,#1
2595                     ; 14 	_asm("rim");//开全局中断
2598  0011 9a            rim
2600                     ; 15 }
2603  0012 81            	ret
2627                     ; 17 void NFC_EnScan_ISR(void)
2627                     ; 18 {
2628                     	switch	.text
2629  0013               _NFC_EnScan_ISR:
2633                     ; 19 	nfc_exti0=1;
2635  0013 35010001      	mov	L3361_nfc_exti0,#1
2636                     ; 20 }
2639  0017 81            	ret
2642                     	bsct
2643  0002               L3661_count:
2644  0002 0000          	dc.w	0
2645  0004               L5661_flag:
2646  0004 00            	dc.b	0
2690                     ; 22 void NFC_EnScan_Ser(void)
2690                     ; 23 {
2691                     	switch	.text
2692  0018               _NFC_EnScan_Ser:
2696                     ; 27 	if(flag)
2698  0018 3d04          	tnz	L5661_flag
2699  001a 2724          	jreq	L1171
2700                     ; 29 		count++;
2702  001c be02          	ldw	x,L3661_count
2703  001e 1c0001        	addw	x,#1
2704  0021 bf02          	ldw	L3661_count,x
2705                     ; 30 		if(count>2000)
2707  0023 be02          	ldw	x,L3661_count
2708  0025 a307d1        	cpw	x,#2001
2709  0028 2520          	jrult	L1271
2710                     ; 32 			count=0;
2712  002a 5f            	clrw	x
2713  002b bf02          	ldw	L3661_count,x
2714                     ; 33 			flag=0;
2716  002d 3f04          	clr	L5661_flag
2717                     ; 34 			if(NFC_IN)
2719  002f c65015        	ld	a,_PE_IDR
2720  0032 a520          	bcp	a,#32
2721  0034 2704          	jreq	L5171
2722                     ; 36 				nfc_en=0;//离开
2724  0036 3f00          	clr	_nfc_en
2726  0038 2010          	jra	L1271
2727  003a               L5171:
2728                     ; 40 				nfc_en=1;//靠近
2730  003a 35010000      	mov	_nfc_en,#1
2731  003e 200a          	jra	L1271
2732  0040               L1171:
2733                     ; 46 		if(nfc_exti0)
2735  0040 3d01          	tnz	L3361_nfc_exti0
2736  0042 2706          	jreq	L1271
2737                     ; 48 			nfc_exti0=0;
2739  0044 3f01          	clr	L3361_nfc_exti0
2740                     ; 49 			flag=1;
2742  0046 35010004      	mov	L5661_flag,#1
2743  004a               L1271:
2744                     ; 52 }
2747  004a 81            	ret
2780                     	xdef	_NFC_EnScan_Ser
2781                     	xdef	_NFC_EnScan_ISR
2782                     	xdef	_NFC_Init
2783                     	xdef	_nfc_en
2802                     	end
