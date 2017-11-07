   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _adc_cap:
2536  0000 00            	dc.b	0
2567                     ; 5 void ADC_Init(void)
2567                     ; 6 {
2569                     	switch	.text
2570  0000               _ADC_Init:
2574                     ; 7 	ADC_CR2|=(1<<3);//A/D结果数据右对齐
2576  0000 72165402      	bset	_ADC_CR2,#3
2577                     ; 8 	ADC_CR1|=(1<<6);//8分频
2579  0004 721c5401      	bset	_ADC_CR1,#6
2580                     ; 9 	ADC_CR1|=(1<<0);//开始转换
2582  0008 72105401      	bset	_ADC_CR1,#0
2583                     ; 10 }
2586  000c 81            	ret
2660                     ; 12 u16 ADC_Sampling(u8 channel)
2660                     ; 13 {
2661                     	switch	.text
2662  000d               _ADC_Sampling:
2664  000d 88            	push	a
2665  000e 5204          	subw	sp,#4
2666       00000004      OFST:	set	4
2669                     ; 14 	u16 word=0;
2671  0010 1e03          	ldw	x,(OFST-1,sp)
2672                     ; 15 	u8 byte_high=0;
2674  0012 7b01          	ld	a,(OFST-3,sp)
2675  0014 97            	ld	xl,a
2676                     ; 16 	u8 byte_low=0;
2678  0015 7b02          	ld	a,(OFST-2,sp)
2679  0017 97            	ld	xl,a
2680                     ; 17 	u16 i=0;
2682  0018 5f            	clrw	x
2683  0019 1f03          	ldw	(OFST-1,sp),x
2684                     ; 19 	ADC_CSR=0x00;
2686  001b 725f5400      	clr	_ADC_CSR
2687                     ; 20 	ADC_CSR|=(channel&0x0f);//选择通道
2689  001f 7b05          	ld	a,(OFST+1,sp)
2690  0021 a40f          	and	a,#15
2691  0023 ca5400        	or	a,_ADC_CSR
2692  0026 c75400        	ld	_ADC_CSR,a
2693                     ; 21 	ADC_CR1|=(1<<0);//启动转换
2695  0029 72105401      	bset	_ADC_CR1,#0
2697  002d 202f          	jra	L1171
2698  002f               L7071:
2699                     ; 24 		i++;
2701  002f 1e03          	ldw	x,(OFST-1,sp)
2702  0031 1c0001        	addw	x,#1
2703  0034 1f03          	ldw	(OFST-1,sp),x
2704                     ; 25 		if(i>1000)
2706  0036 1e03          	ldw	x,(OFST-1,sp)
2707  0038 a303e9        	cpw	x,#1001
2708  003b 2521          	jrult	L1171
2709                     ; 27 			i=0;
2711  003d 1e03          	ldw	x,(OFST-1,sp)
2712                     ; 28 			break;
2713  003f               L3171:
2714                     ; 31 	byte_low=ADC_DRL;
2716  003f c65405        	ld	a,_ADC_DRL
2717  0042 6b02          	ld	(OFST-2,sp),a
2718                     ; 32 	byte_high=ADC_DRH;
2720  0044 c65404        	ld	a,_ADC_DRH
2721  0047 6b01          	ld	(OFST-3,sp),a
2722                     ; 33 	word=byte_high*256+byte_low;
2724  0049 7b01          	ld	a,(OFST-3,sp)
2725  004b 5f            	clrw	x
2726  004c 97            	ld	xl,a
2727  004d 4f            	clr	a
2728  004e 02            	rlwa	x,a
2729  004f 01            	rrwa	x,a
2730  0050 1b02          	add	a,(OFST-2,sp)
2731  0052 2401          	jrnc	L01
2732  0054 5c            	incw	x
2733  0055               L01:
2734  0055 02            	rlwa	x,a
2735  0056 1f03          	ldw	(OFST-1,sp),x
2736  0058 01            	rrwa	x,a
2737                     ; 34 	return word;
2739  0059 1e03          	ldw	x,(OFST-1,sp)
2742  005b 5b05          	addw	sp,#5
2743  005d 81            	ret
2744  005e               L1171:
2745                     ; 22 	while((ADC_CSR&0x80)==0)//等待ADC结束
2747  005e c65400        	ld	a,_ADC_CSR
2748  0061 a580          	bcp	a,#128
2749  0063 27ca          	jreq	L7071
2750  0065 20d8          	jra	L3171
2774                     	xdef	_ADC_Sampling
2775                     	xdef	_ADC_Init
2776                     	xdef	_adc_cap
2795                     	end
