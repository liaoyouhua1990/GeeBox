   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _njm7181_sleep:
2536  0000 00            	dc.b	0
2537  0001               _njm7181_signal:
2538  0001 00            	dc.b	0
2539  0002               L3361_njm7181_exti:
2540  0002 01            	dc.b	1
2541  0003               L5361_njm7181_flag:
2542  0003 00            	dc.b	0
2575                     ; 9 void NJM7181_Init(void)
2575                     ; 10 {
2577                     	switch	.text
2578  0000               _NJM7181_Init:
2582                     ; 11 	_asm("sim");
2585  0000 9b            sim
2587                     ; 12 	PA_DDR&=~(1<<2);//Ðü¸¡ÖÐ¶Ï
2589  0001 72155002      	bres	_PA_DDR,#2
2590                     ; 13 	PA_CR1&=~(1<<2);
2592  0005 72155003      	bres	_PA_CR1,#2
2593                     ; 14 	PA_CR2|=(1<<2);
2595  0009 72145004      	bset	_PA_CR2,#2
2596                     ; 15 	EXTI_CR1|=(1<<0);//ÉÏÉýÑØ´¥·¢
2598  000d 721050a0      	bset	_EXTI_CR1,#0
2599                     ; 16 	EXTI_CR1|=(1<<1);//ÏÂ½µÑØ´¥·¢
2601  0011 721250a0      	bset	_EXTI_CR1,#1
2602                     ; 17 	_asm("rim");
2605  0015 9a            rim
2607                     ; 18 }
2610  0016 81            	ret
2635                     ; 20 void NJM7181_Scan_ISR(void)
2635                     ; 21 {
2636                     	switch	.text
2637  0017               _NJM7181_Scan_ISR:
2641                     ; 22 	if(njm7181_flag==0)
2643  0017 3d03          	tnz	L5361_njm7181_flag
2644  0019 2604          	jrne	L5661
2645                     ; 24 		njm7181_exti=1;
2647  001b 35010002      	mov	L3361_njm7181_exti,#1
2648  001f               L5661:
2649                     ; 26 }
2652  001f 81            	ret
2655                     	bsct
2656  0004               L7661_count:
2657  0004 0000          	dc.w	0
2693                     ; 28 void NJM7181_Scan_Ser(void)
2693                     ; 29 {
2694                     	switch	.text
2695  0020               _NJM7181_Scan_Ser:
2699                     ; 32 	if(njm7181_flag)
2701  0020 3d03          	tnz	L5361_njm7181_flag
2702  0022 2724          	jreq	L7071
2703                     ; 34 		count++;
2705  0024 be04          	ldw	x,L7661_count
2706  0026 1c0001        	addw	x,#1
2707  0029 bf04          	ldw	L7661_count,x
2708                     ; 35 		if(count>5000)
2710  002b be04          	ldw	x,L7661_count
2711  002d a31389        	cpw	x,#5001
2712  0030 2520          	jrult	L7171
2713                     ; 37 			count=0;
2715  0032 5f            	clrw	x
2716  0033 bf04          	ldw	L7661_count,x
2717                     ; 38 			njm7181_flag=0;
2719  0035 3f03          	clr	L5361_njm7181_flag
2720                     ; 39 			if(NJM7181_DET)
2722  0037 c65001        	ld	a,_PA_IDR
2723  003a a504          	bcp	a,#4
2724  003c 2706          	jreq	L3171
2725                     ; 41 				njm7181_signal=1;//ÓÐÉùÒôÊä³ö
2727  003e 35010001      	mov	_njm7181_signal,#1
2729  0042 200e          	jra	L7171
2730  0044               L3171:
2731                     ; 45 				njm7181_signal=0;//ÎÞÉùÒôÊä³ö
2733  0044 3f01          	clr	_njm7181_signal
2734  0046 200a          	jra	L7171
2735  0048               L7071:
2736                     ; 51 		if(njm7181_exti)
2738  0048 3d02          	tnz	L3361_njm7181_exti
2739  004a 2706          	jreq	L7171
2740                     ; 53 			njm7181_exti=0;
2742  004c 3f02          	clr	L3361_njm7181_exti
2743                     ; 54 			njm7181_flag=1;
2745  004e 35010003      	mov	L5361_njm7181_flag,#1
2746  0052               L7171:
2747                     ; 57 }
2750  0052 81            	ret
2753                     	bsct
2754  0006               L3271_flag:
2755  0006 00            	dc.b	0
2756  0007               L5271_count:
2757  0007 00000000      	dc.l	0
2802                     .const:	section	.text
2803  0000               L41:
2804  0000 003ab00a      	dc.l	3846154
2805                     ; 59 void NJM7181_Nsignal_Ser(void)
2805                     ; 60 {
2806                     	switch	.text
2807  0053               _NJM7181_Nsignal_Ser:
2811                     ; 64 	NJM7181_Scan_Ser();
2813  0053 adcb          	call	_NJM7181_Scan_Ser
2815                     ; 65 	if(njm7181_signal)
2817  0055 3d01          	tnz	_njm7181_signal
2818  0057 270e          	jreq	L1571
2819                     ; 67 		njm7181_sleep=0;
2821  0059 3f00          	clr	_njm7181_sleep
2822                     ; 68 		count=0;
2824  005b ae0000        	ldw	x,#0
2825  005e bf09          	ldw	L5271_count+2,x
2826  0060 ae0000        	ldw	x,#0
2827  0063 bf07          	ldw	L5271_count,x
2829  0065 2004          	jra	L3571
2830  0067               L1571:
2831                     ; 72 		flag=1;
2833  0067 35010006      	mov	L3271_flag,#1
2834  006b               L3571:
2835                     ; 74 	if(flag)
2837  006b 3d06          	tnz	L3271_flag
2838  006d 2726          	jreq	L5571
2839                     ; 76 		count++;
2841  006f ae0007        	ldw	x,#L5271_count
2842  0072 a601          	ld	a,#1
2843  0074 cd0000        	call	c_lgadc
2845                     ; 77 		if(count>3846153)//15min=3846153
2847  0077 ae0007        	ldw	x,#L5271_count
2848  007a cd0000        	call	c_ltor
2850  007d ae0000        	ldw	x,#L41
2851  0080 cd0000        	call	c_lcmp
2853  0083 2510          	jrult	L5571
2854                     ; 79 			count=0;
2856  0085 ae0000        	ldw	x,#0
2857  0088 bf09          	ldw	L5271_count+2,x
2858  008a ae0000        	ldw	x,#0
2859  008d bf07          	ldw	L5271_count,x
2860                     ; 80 			njm7181_sleep=1;
2862  008f 35010000      	mov	_njm7181_sleep,#1
2863                     ; 81 			flag=0;
2865  0093 3f06          	clr	L3271_flag
2866  0095               L5571:
2867                     ; 84 }
2870  0095 81            	ret
2921                     	xdef	_NJM7181_Nsignal_Ser
2922                     	xdef	_NJM7181_Scan_Ser
2923                     	xdef	_NJM7181_Scan_ISR
2924                     	xdef	_NJM7181_Init
2925                     	xdef	_njm7181_signal
2926                     	xdef	_njm7181_sleep
2945                     	xref	c_lcmp
2946                     	xref	c_ltor
2947                     	xref	c_lgadc
2948                     	end
