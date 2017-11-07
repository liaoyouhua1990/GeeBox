   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _bat_style:
2536  0000 00            	dc.b	0
2566                     ; 6 void BAT_Init(void)
2566                     ; 7 {	
2568                     	switch	.text
2569  0000               _BAT_Init:
2573                     ; 8 	ADC_Init();
2575  0000 cd0000        	call	_ADC_Init
2577                     ; 9 }
2580  0003 81            	ret
2583                     	bsct
2584  0001               L1561_count:
2585  0001 00000000      	dc.l	0
2586  0005               L3561_buffer:
2587  0005 0000          	dc.w	0
2588  0007 0000          	dc.w	0
2589  0009 0000          	dc.w	0
2590  000b 0000          	dc.w	0
2591  000d 0000          	dc.w	0
2592  000f 0000          	dc.w	0
2593  0011               L5561_i:
2594  0011 00            	dc.b	0
2595  0012               L7561_volue:
2596  0012 0000          	dc.w	0
2597  0014               L1661_mode:
2598  0014 00            	dc.b	0
2670                     .const:	section	.text
2671  0000               L01:
2672  0000 000003a1      	dc.l	929
2673  0004               L21:
2674  0004 00000ae3      	dc.l	2787
2675                     ; 11 void BAT_VoltageScan_Ser(void)
2675                     ; 12 {
2676                     	switch	.text
2677  0004               _BAT_VoltageScan_Ser:
2681                     ; 19 	switch(mode)
2683  0004 b614          	ld	a,L1661_mode
2685                     ; 95 		break;
2686  0006 4d            	tnz	a
2687  0007 271c          	jreq	L3661
2688  0009 4a            	dec	a
2689  000a 2744          	jreq	L5661
2690  000c 4a            	dec	a
2691  000d 2777          	jreq	L7661
2692  000f 4a            	dec	a
2693  0010 2603          	jrne	L41
2694  0012 cc00ac        	jp	L1761
2695  0015               L41:
2696  0015 4a            	dec	a
2697  0016 2603          	jrne	L61
2698  0018 cc00d2        	jp	L3761
2699  001b               L61:
2700  001b 4a            	dec	a
2701  001c 2603          	jrne	L02
2702  001e cc0105        	jp	L5761
2703  0021               L02:
2704  0021 ac260126      	jpf	L7371
2705  0025               L3661:
2706                     ; 23 			count++;//359us
2708  0025 ae0001        	ldw	x,#L1561_count
2709  0028 a601          	ld	a,#1
2710  002a cd0000        	call	c_lgadc
2712                     ; 24 			if(count>928)//333ms=928
2714  002d ae0001        	ldw	x,#L1561_count
2715  0030 cd0000        	call	c_ltor
2717  0033 ae0000        	ldw	x,#L01
2718  0036 cd0000        	call	c_lcmp
2720  0039 2403          	jruge	L22
2721  003b cc0126        	jp	L7371
2722  003e               L22:
2723                     ; 26 				count=0;
2725  003e ae0000        	ldw	x,#0
2726  0041 bf03          	ldw	L1561_count+2,x
2727  0043 ae0000        	ldw	x,#0
2728  0046 bf01          	ldw	L1561_count,x
2729                     ; 27 				mode=1;
2731  0048 35010014      	mov	L1661_mode,#1
2732  004c ac260126      	jpf	L7371
2733  0050               L5661:
2734                     ; 34 			buffer[i]=ADC_Sampling(4);
2736  0050 a604          	ld	a,#4
2737  0052 cd0000        	call	_ADC_Sampling
2739  0055 b611          	ld	a,L5561_i
2740  0057 905f          	clrw	y
2741  0059 9097          	ld	yl,a
2742  005b 9058          	sllw	y
2743  005d 90ef05        	ldw	(L3561_buffer,y),x
2744                     ; 35 			mode=0;
2746  0060 3f14          	clr	L1661_mode
2747                     ; 36 			i++;
2749  0062 3c11          	inc	L5561_i
2750                     ; 37 			if(i==3)
2752  0064 b611          	ld	a,L5561_i
2753  0066 a103          	cp	a,#3
2754  0068 2703          	jreq	L42
2755  006a cc0126        	jp	L7371
2756  006d               L42:
2757                     ; 39 				i=0;
2759  006d 3f11          	clr	L5561_i
2760                     ; 40 				mode=2;
2762  006f 35020014      	mov	L1661_mode,#2
2763                     ; 41 				buffer[0]=(buffer[0]+buffer[1]+buffer[2])/3;
2765  0073 be05          	ldw	x,L3561_buffer
2766  0075 72bb0007      	addw	x,L3561_buffer+2
2767  0079 72bb0009      	addw	x,L3561_buffer+4
2768  007d a603          	ld	a,#3
2769  007f 62            	div	x,a
2770  0080 bf05          	ldw	L3561_buffer,x
2771  0082 ac260126      	jpf	L7371
2772  0086               L7661:
2773                     ; 48 			count++;//359us
2775  0086 ae0001        	ldw	x,#L1561_count
2776  0089 a601          	ld	a,#1
2777  008b cd0000        	call	c_lgadc
2779                     ; 49 			if(count>2786)//1s=2786
2781  008e ae0001        	ldw	x,#L1561_count
2782  0091 cd0000        	call	c_ltor
2784  0094 ae0004        	ldw	x,#L21
2785  0097 cd0000        	call	c_lcmp
2787  009a 25ce          	jrult	L7371
2788                     ; 51 				count=0;
2790  009c ae0000        	ldw	x,#0
2791  009f bf03          	ldw	L1561_count+2,x
2792  00a1 ae0000        	ldw	x,#0
2793  00a4 bf01          	ldw	L1561_count,x
2794                     ; 52 				mode=3;
2796  00a6 35030014      	mov	L1661_mode,#3
2797  00aa 207a          	jra	L7371
2798  00ac               L1761:
2799                     ; 59 			count++;//359us
2801  00ac ae0001        	ldw	x,#L1561_count
2802  00af a601          	ld	a,#1
2803  00b1 cd0000        	call	c_lgadc
2805                     ; 60 			if(count>928)//333ms=928
2807  00b4 ae0001        	ldw	x,#L1561_count
2808  00b7 cd0000        	call	c_ltor
2810  00ba ae0000        	ldw	x,#L01
2811  00bd cd0000        	call	c_lcmp
2813  00c0 2564          	jrult	L7371
2814                     ; 62 				count=0;
2816  00c2 ae0000        	ldw	x,#0
2817  00c5 bf03          	ldw	L1561_count+2,x
2818  00c7 ae0000        	ldw	x,#0
2819  00ca bf01          	ldw	L1561_count,x
2820                     ; 63 				mode=4;
2822  00cc 35040014      	mov	L1661_mode,#4
2823  00d0 2054          	jra	L7371
2824  00d2               L3761:
2825                     ; 70 			buffer[i+3]=ADC_Sampling(4);
2827  00d2 a604          	ld	a,#4
2828  00d4 cd0000        	call	_ADC_Sampling
2830  00d7 b611          	ld	a,L5561_i
2831  00d9 905f          	clrw	y
2832  00db 9097          	ld	yl,a
2833  00dd 9058          	sllw	y
2834  00df 90ef0b        	ldw	(L3561_buffer+6,y),x
2835                     ; 71 			mode=3;
2837  00e2 35030014      	mov	L1661_mode,#3
2838                     ; 72 			i++;
2840  00e6 3c11          	inc	L5561_i
2841                     ; 73 			if(i==3)
2843  00e8 b611          	ld	a,L5561_i
2844  00ea a103          	cp	a,#3
2845  00ec 2638          	jrne	L7371
2846                     ; 75 				i=0;
2848  00ee 3f11          	clr	L5561_i
2849                     ; 76 				buffer[3]=(buffer[3]+buffer[4]+buffer[5])/3;
2851  00f0 be0b          	ldw	x,L3561_buffer+6
2852  00f2 72bb000d      	addw	x,L3561_buffer+8
2853  00f6 72bb000f      	addw	x,L3561_buffer+10
2854  00fa a603          	ld	a,#3
2855  00fc 62            	div	x,a
2856  00fd bf0b          	ldw	L3561_buffer+6,x
2857                     ; 77 				mode=5;
2859  00ff 35050014      	mov	L1661_mode,#5
2860  0103 2021          	jra	L7371
2861  0105               L5761:
2862                     ; 84 			buffer[5]=(buffer[0]+buffer[3])/2;
2864  0105 be05          	ldw	x,L3561_buffer
2865  0107 72bb000b      	addw	x,L3561_buffer+6
2866  010b 54            	srlw	x
2867  010c bf0f          	ldw	L3561_buffer+10,x
2868                     ; 85 			if(buffer[5]<BAT_VLB)//小于6.8V
2870  010e be0f          	ldw	x,L3561_buffer+10
2871  0110 a302ef        	cpw	x,#751
2872  0113 2406          	jruge	L3571
2873                     ; 87 				bat_style=BAT_LOW;//低压
2875  0115 35010000      	mov	_bat_style,#1
2877  0119 2009          	jra	L5571
2878  011b               L3571:
2879                     ; 89 			else if(buffer[5]>BAT_VLT)//大于6.9V
2881  011b be0f          	ldw	x,L3561_buffer+10
2882  011d a30306        	cpw	x,#774
2883  0120 2502          	jrult	L5571
2884                     ; 91 				bat_style=0;//低压取消
2886  0122 3f00          	clr	_bat_style
2887  0124               L5571:
2888                     ; 93 			mode=0;
2890  0124 3f14          	clr	L1661_mode
2891                     ; 95 		break;
2893  0126               L7371:
2894                     ; 97 }
2897  0126 81            	ret
2921                     	xref	_ADC_Sampling
2922                     	xref	_ADC_Init
2923                     	xdef	_BAT_VoltageScan_Ser
2924                     	xdef	_BAT_Init
2925                     	xdef	_bat_style
2944                     	xref	c_lcmp
2945                     	xref	c_ltor
2946                     	xref	c_lgadc
2947                     	end
