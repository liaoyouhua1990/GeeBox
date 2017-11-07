   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _aic3254_aux:
2536  0000 00            	dc.b	0
2537  0001               L3361_aic3254_exti:
2538  0001 01            	dc.b	1
2539  0002               L5361_aic3254_flag:
2540  0002 00            	dc.b	0
2541                     .const:	section	.text
2542  0000               L7361_config_table:
2543  0000 00            	dc.b	0
2544  0001 00            	dc.b	0
2545  0002 01            	dc.b	1
2546  0003 01            	dc.b	1
2547  0004 00            	dc.b	0
2548  0005 01            	dc.b	1
2549  0006 01            	dc.b	1
2550  0007 08            	dc.b	8
2551  0008 02            	dc.b	2
2552  0009 01            	dc.b	1
2553  000a 7b            	dc.b	123
2554  000b 01            	dc.b	1
2555  000c 00            	dc.b	0
2556  000d 01            	dc.b	1
2557  000e 14            	dc.b	20
2558  000f 25            	dc.b	37
2559  0010 34            	dc.b	52
2560  0011 40            	dc.b	64
2561  0012 36            	dc.b	54
2562  0013 40            	dc.b	64
2563  0014 37            	dc.b	55
2564  0015 40            	dc.b	64
2565  0016 39            	dc.b	57
2566  0017 40            	dc.b	64
2567  0018 0c            	dc.b	12
2568  0019 02            	dc.b	2
2569  001a 0d            	dc.b	13
2570  001b 02            	dc.b	2
2571  001c 0e            	dc.b	14
2572  001d 02            	dc.b	2
2573  001e 0f            	dc.b	15
2574  001f 02            	dc.b	2
2575  0020 18            	dc.b	24
2576  0021 00            	dc.b	0
2577  0022 19            	dc.b	25
2578  0023 00            	dc.b	0
2579  0024 09            	dc.b	9
2580  0025 3f            	dc.b	63
2581  0026 10            	dc.b	16
2582  0027 00            	dc.b	0
2583  0028 11            	dc.b	17
2584  0029 00            	dc.b	0
2585  002a 12            	dc.b	18
2586  002b 00            	dc.b	0
2587  002c 13            	dc.b	19
2588  002d 00            	dc.b	0
2589  002e 00            	dc.b	0
2590  002f 00            	dc.b	0
2591  0030 00            	dc.b	0
2592  0031 01            	dc.b	1
2593  0032 00            	dc.b	0
2594  0033 02            	dc.b	2
2595  0034               L1461_volume_table:
2596  0034 28            	dc.b	40
2597  0035 23            	dc.b	35
2598  0036 1f            	dc.b	31
2599  0037 1b            	dc.b	27
2600  0038 17            	dc.b	23
2601  0039 14            	dc.b	20
2602  003a 12            	dc.b	18
2603  003b 10            	dc.b	16
2604  003c 0e            	dc.b	14
2605  003d 0c            	dc.b	12
2606  003e 0a            	dc.b	10
2607  003f 08            	dc.b	8
2608  0040 06            	dc.b	6
2609  0041 04            	dc.b	4
2610  0042 02            	dc.b	2
2611  0043 00            	dc.b	0
2651                     ; 60 void AIC3254_Delay(u32 t)
2651                     ; 61 {
2653                     	switch	.text
2654  0000               L3461_AIC3254_Delay:
2656       00000000      OFST:	set	0
2659  0000               L5761:
2660                     ; 62 	while(t--);
2662  0000 96            	ldw	x,sp
2663  0001 1c0003        	addw	x,#OFST+3
2664  0004 cd0000        	call	c_ltor
2666  0007 96            	ldw	x,sp
2667  0008 1c0003        	addw	x,#OFST+3
2668  000b a601          	ld	a,#1
2669  000d cd0000        	call	c_lgsbc
2671  0010 cd0000        	call	c_lrzmp
2673  0013 26eb          	jrne	L5761
2674                     ; 63 }
2677  0015 81            	ret
2732                     ; 65 void AIC3254_WriteNByte(u8 *p,u8 n)
2732                     ; 66 {
2733                     	switch	.text
2734  0016               L5461_AIC3254_WriteNByte:
2736  0016 89            	pushw	x
2737  0017 88            	push	a
2738       00000001      OFST:	set	1
2741                     ; 67 	u8 i=0;
2743  0018 0f01          	clr	(OFST+0,sp)
2744                     ; 69 	for(i=0;i<n;i++)
2746  001a 0f01          	clr	(OFST+0,sp)
2748  001c 2014          	jra	L3371
2749  001e               L7271:
2750                     ; 71 		I2C_WriteByte(*(p+i));
2752  001e 7b02          	ld	a,(OFST+1,sp)
2753  0020 97            	ld	xl,a
2754  0021 7b03          	ld	a,(OFST+2,sp)
2755  0023 1b01          	add	a,(OFST+0,sp)
2756  0025 2401          	jrnc	L01
2757  0027 5c            	incw	x
2758  0028               L01:
2759  0028 02            	rlwa	x,a
2760  0029 f6            	ld	a,(x)
2761  002a cd0000        	call	_I2C_WriteByte
2763                     ; 72 		I2C_CheckAck();
2765  002d cd0000        	call	_I2C_CheckAck
2767                     ; 69 	for(i=0;i<n;i++)
2769  0030 0c01          	inc	(OFST+0,sp)
2770  0032               L3371:
2773  0032 7b01          	ld	a,(OFST+0,sp)
2774  0034 1106          	cp	a,(OFST+5,sp)
2775  0036 25e6          	jrult	L7271
2776                     ; 74 }
2779  0038 5b03          	addw	sp,#3
2780  003a 81            	ret
2813                     ; 76 void AIC3254_Init(void)
2813                     ; 77 {
2814                     	switch	.text
2815  003b               _AIC3254_Init:
2819                     ; 78 	PA_DDR|=1<<3;
2821  003b 72165002      	bset	_PA_DDR,#3
2822                     ; 79 	PA_CR1|=1<<3;
2824  003f 72165003      	bset	_PA_CR1,#3
2825                     ; 80 	PA_CR2&=~(1<<3);
2827  0043 72175004      	bres	_PA_CR2,#3
2828                     ; 81 	AIC3254_RST_0();
2830  0047 72175000      	bres	_PA_ODR,#3
2831                     ; 82 	AIC3254_Delay(100);
2833  004b ae0064        	ldw	x,#100
2834  004e 89            	pushw	x
2835  004f ae0000        	ldw	x,#0
2836  0052 89            	pushw	x
2837  0053 adab          	call	L3461_AIC3254_Delay
2839  0055 5b04          	addw	sp,#4
2840                     ; 83 	AIC3254_RST_1();
2842  0057 72165000      	bset	_PA_ODR,#3
2843                     ; 85 	_asm("sim");
2846  005b 9b            sim
2848                     ; 86 	PC_DDR&=~(1<<3);//上拉中断
2850  005c 7217500c      	bres	_PC_DDR,#3
2851                     ; 87 	PC_CR1|=(1<<3);
2853  0060 7216500d      	bset	_PC_CR1,#3
2854                     ; 88 	PC_CR2|=(1<<3);
2856  0064 7216500e      	bset	_PC_CR2,#3
2857                     ; 89 	EXTI_CR1|=(1<<4);//上升沿触发
2859  0068 721850a0      	bset	_EXTI_CR1,#4
2860                     ; 90 	EXTI_CR1|=(1<<5);//下降沿触发
2862  006c 721a50a0      	bset	_EXTI_CR1,#5
2863                     ; 91 	_asm("rim");
2866  0070 9a            rim
2868                     ; 93 	I2C_Init();
2870  0071 cd0000        	call	_I2C_Init
2872                     ; 94 }
2875  0074 81            	ret
2916                     ; 96 void AIC3254_WriteVolume(u8 volume)
2916                     ; 97 {
2917                     	switch	.text
2918  0075               _AIC3254_WriteVolume:
2920  0075 88            	push	a
2921       00000000      OFST:	set	0
2924                     ; 98 	I2C_Start();
2926  0076 cd0000        	call	_I2C_Start
2928                     ; 99 	I2C_WriteByte(0x30);
2930  0079 a630          	ld	a,#48
2931  007b cd0000        	call	_I2C_WriteByte
2933                     ; 100 	I2C_CheckAck();
2935  007e cd0000        	call	_I2C_CheckAck
2937                     ; 101 	I2C_WriteByte(0x00);
2939  0081 4f            	clr	a
2940  0082 cd0000        	call	_I2C_WriteByte
2942                     ; 102 	I2C_CheckAck();
2944  0085 cd0000        	call	_I2C_CheckAck
2946                     ; 103 	I2C_WriteByte(0x01);
2948  0088 a601          	ld	a,#1
2949  008a cd0000        	call	_I2C_WriteByte
2951                     ; 104 	I2C_CheckAck();
2953  008d cd0000        	call	_I2C_CheckAck
2955                     ; 105 	I2C_Stop();
2957  0090 cd0000        	call	_I2C_Stop
2959                     ; 107 	I2C_Start();
2961  0093 cd0000        	call	_I2C_Start
2963                     ; 108 	I2C_WriteByte(0x30);
2965  0096 a630          	ld	a,#48
2966  0098 cd0000        	call	_I2C_WriteByte
2968                     ; 109 	I2C_CheckAck();
2970  009b cd0000        	call	_I2C_CheckAck
2972                     ; 110 	I2C_WriteByte(0x18);
2974  009e a618          	ld	a,#24
2975  00a0 cd0000        	call	_I2C_WriteByte
2977                     ; 111 	I2C_CheckAck();
2979  00a3 cd0000        	call	_I2C_CheckAck
2981                     ; 112 	AIC3254_WriteNByte(&volume_table[volume],1);
2983  00a6 4b01          	push	#1
2984  00a8 7b02          	ld	a,(OFST+2,sp)
2985  00aa 5f            	clrw	x
2986  00ab 97            	ld	xl,a
2987  00ac 1c0034        	addw	x,#L1461_volume_table
2988  00af cd0016        	call	L5461_AIC3254_WriteNByte
2990  00b2 84            	pop	a
2991                     ; 113 	AIC3254_WriteNByte(&volume_table[volume],1);
2993  00b3 4b01          	push	#1
2994  00b5 7b02          	ld	a,(OFST+2,sp)
2995  00b7 5f            	clrw	x
2996  00b8 97            	ld	xl,a
2997  00b9 1c0034        	addw	x,#L1461_volume_table
2998  00bc cd0016        	call	L5461_AIC3254_WriteNByte
3000  00bf 84            	pop	a
3001                     ; 114 	I2C_Stop();
3003  00c0 cd0000        	call	_I2C_Stop
3005                     ; 115 }
3008  00c3 84            	pop	a
3009  00c4 81            	ret
3049                     ; 117 void AIC3254_WriteCofig(void)
3049                     ; 118 {
3050                     	switch	.text
3051  00c5               _AIC3254_WriteCofig:
3053  00c5 89            	pushw	x
3054       00000002      OFST:	set	2
3057                     ; 119 	u16 i=0;
3059  00c6 5f            	clrw	x
3060  00c7 1f01          	ldw	(OFST-1,sp),x
3061                     ; 121 	for(i=0;i<26;i++)
3063  00c9 5f            	clrw	x
3064  00ca 1f01          	ldw	(OFST-1,sp),x
3065  00cc               L3002:
3066                     ; 123 		I2C_Start();
3068  00cc cd0000        	call	_I2C_Start
3070                     ; 124 		I2C_WriteByte(0x30);
3072  00cf a630          	ld	a,#48
3073  00d1 cd0000        	call	_I2C_WriteByte
3075                     ; 125 		I2C_CheckAck();
3077  00d4 cd0000        	call	_I2C_CheckAck
3079                     ; 126 		AIC3254_WriteNByte(&config_table[i][0],2);
3081  00d7 4b02          	push	#2
3082  00d9 1e02          	ldw	x,(OFST+0,sp)
3083  00db 58            	sllw	x
3084  00dc 1c0000        	addw	x,#L7361_config_table
3085  00df cd0016        	call	L5461_AIC3254_WriteNByte
3087  00e2 84            	pop	a
3088                     ; 127 		I2C_Stop();
3090  00e3 cd0000        	call	_I2C_Stop
3092                     ; 121 	for(i=0;i<26;i++)
3094  00e6 1e01          	ldw	x,(OFST-1,sp)
3095  00e8 1c0001        	addw	x,#1
3096  00eb 1f01          	ldw	(OFST-1,sp),x
3099  00ed 1e01          	ldw	x,(OFST-1,sp)
3100  00ef a3001a        	cpw	x,#26
3101  00f2 25d8          	jrult	L3002
3102                     ; 129 }
3105  00f4 85            	popw	x
3106  00f5 81            	ret
3133                     ; 131 void AIC3254_SelectIn1(void)
3133                     ; 132 {
3134                     	switch	.text
3135  00f6               _AIC3254_SelectIn1:
3139                     ; 133 	I2C_Start();
3141  00f6 cd0000        	call	_I2C_Start
3143                     ; 134 	I2C_WriteByte(0x30);
3145  00f9 a630          	ld	a,#48
3146  00fb cd0000        	call	_I2C_WriteByte
3148                     ; 135 	I2C_CheckAck();
3150  00fe cd0000        	call	_I2C_CheckAck
3152                     ; 136 	I2C_WriteByte(0x00);
3154  0101 4f            	clr	a
3155  0102 cd0000        	call	_I2C_WriteByte
3157                     ; 137 	I2C_CheckAck();
3159  0105 cd0000        	call	_I2C_CheckAck
3161                     ; 138 	I2C_WriteByte(0x01);
3163  0108 a601          	ld	a,#1
3164  010a cd0000        	call	_I2C_WriteByte
3166                     ; 139 	I2C_CheckAck();
3168  010d cd0000        	call	_I2C_CheckAck
3170                     ; 140 	I2C_Stop();
3172  0110 cd0000        	call	_I2C_Stop
3174                     ; 142 	I2C_Start();
3176  0113 cd0000        	call	_I2C_Start
3178                     ; 143 	I2C_WriteByte(0x30);
3180  0116 a630          	ld	a,#48
3181  0118 cd0000        	call	_I2C_WriteByte
3183                     ; 144 	I2C_CheckAck();
3185  011b cd0000        	call	_I2C_CheckAck
3187                     ; 145 	I2C_WriteByte(0x34);
3189  011e a634          	ld	a,#52
3190  0120 cd0000        	call	_I2C_WriteByte
3192                     ; 146 	I2C_CheckAck();
3194  0123 cd0000        	call	_I2C_CheckAck
3196                     ; 147 	I2C_WriteByte(0x40);
3198  0126 a640          	ld	a,#64
3199  0128 cd0000        	call	_I2C_WriteByte
3201                     ; 148 	I2C_CheckAck();
3203  012b cd0000        	call	_I2C_CheckAck
3205                     ; 149 	I2C_Stop();
3207  012e cd0000        	call	_I2C_Stop
3209                     ; 151 	I2C_Start();
3211  0131 cd0000        	call	_I2C_Start
3213                     ; 152 	I2C_WriteByte(0x30);
3215  0134 a630          	ld	a,#48
3216  0136 cd0000        	call	_I2C_WriteByte
3218                     ; 153 	I2C_CheckAck();
3220  0139 cd0000        	call	_I2C_CheckAck
3222                     ; 154 	I2C_WriteByte(0x37);
3224  013c a637          	ld	a,#55
3225  013e cd0000        	call	_I2C_WriteByte
3227                     ; 155 	I2C_CheckAck();
3229  0141 cd0000        	call	_I2C_CheckAck
3231                     ; 156 	I2C_WriteByte(0x40);
3233  0144 a640          	ld	a,#64
3234  0146 cd0000        	call	_I2C_WriteByte
3236                     ; 157 	I2C_CheckAck();
3238  0149 cd0000        	call	_I2C_CheckAck
3240                     ; 158 	I2C_Stop();
3242  014c cd0000        	call	_I2C_Stop
3244                     ; 159 }
3247  014f 81            	ret
3274                     ; 161 void AIC3254_SelectIn2(void)
3274                     ; 162 {
3275                     	switch	.text
3276  0150               _AIC3254_SelectIn2:
3280                     ; 163 	I2C_Start();
3282  0150 cd0000        	call	_I2C_Start
3284                     ; 164 	I2C_WriteByte(0x30);
3286  0153 a630          	ld	a,#48
3287  0155 cd0000        	call	_I2C_WriteByte
3289                     ; 165 	I2C_CheckAck();
3291  0158 cd0000        	call	_I2C_CheckAck
3293                     ; 166 	I2C_WriteByte(0x00);
3295  015b 4f            	clr	a
3296  015c cd0000        	call	_I2C_WriteByte
3298                     ; 167 	I2C_CheckAck();
3300  015f cd0000        	call	_I2C_CheckAck
3302                     ; 168 	I2C_WriteByte(0x01);
3304  0162 a601          	ld	a,#1
3305  0164 cd0000        	call	_I2C_WriteByte
3307                     ; 169 	I2C_CheckAck();
3309  0167 cd0000        	call	_I2C_CheckAck
3311                     ; 170 	I2C_Stop();
3313  016a cd0000        	call	_I2C_Stop
3315                     ; 172 	I2C_Start();
3317  016d cd0000        	call	_I2C_Start
3319                     ; 173 	I2C_WriteByte(0x30);
3321  0170 a630          	ld	a,#48
3322  0172 cd0000        	call	_I2C_WriteByte
3324                     ; 174 	I2C_CheckAck();
3326  0175 cd0000        	call	_I2C_CheckAck
3328                     ; 175 	I2C_WriteByte(0x34);
3330  0178 a634          	ld	a,#52
3331  017a cd0000        	call	_I2C_WriteByte
3333                     ; 176 	I2C_CheckAck();
3335  017d cd0000        	call	_I2C_CheckAck
3337                     ; 177 	I2C_WriteByte(0x10);
3339  0180 a610          	ld	a,#16
3340  0182 cd0000        	call	_I2C_WriteByte
3342                     ; 178 	I2C_CheckAck();
3344  0185 cd0000        	call	_I2C_CheckAck
3346                     ; 179 	I2C_Stop();
3348  0188 cd0000        	call	_I2C_Stop
3350                     ; 181 	I2C_Start();
3352  018b cd0000        	call	_I2C_Start
3354                     ; 182 	I2C_WriteByte(0x30);
3356  018e a630          	ld	a,#48
3357  0190 cd0000        	call	_I2C_WriteByte
3359                     ; 183 	I2C_CheckAck();
3361  0193 cd0000        	call	_I2C_CheckAck
3363                     ; 184 	I2C_WriteByte(0x37);
3365  0196 a637          	ld	a,#55
3366  0198 cd0000        	call	_I2C_WriteByte
3368                     ; 185 	I2C_CheckAck();
3370  019b cd0000        	call	_I2C_CheckAck
3372                     ; 186 	I2C_WriteByte(0x10);
3374  019e a610          	ld	a,#16
3375  01a0 cd0000        	call	_I2C_WriteByte
3377                     ; 187 	I2C_CheckAck();
3379  01a3 cd0000        	call	_I2C_CheckAck
3381                     ; 188 	I2C_Stop();
3383  01a6 cd0000        	call	_I2C_Stop
3385                     ; 189 }
3388  01a9 81            	ret
3391                     	bsct
3392  0003               L1302_count:
3393  0003 0000          	dc.w	0
3430                     ; 191 void AIC3254_AuxScan_Ser(void)
3430                     ; 192 {
3431                     	switch	.text
3432  01aa               _AIC3254_AuxScan_Ser:
3436                     ; 195 	if(aic3254_flag)
3438  01aa 3d02          	tnz	L5361_aic3254_flag
3439  01ac 2724          	jreq	L1502
3440                     ; 197 		count++;
3442  01ae be03          	ldw	x,L1302_count
3443  01b0 1c0001        	addw	x,#1
3444  01b3 bf03          	ldw	L1302_count,x
3445                     ; 198 		if(count>5000)
3447  01b5 be03          	ldw	x,L1302_count
3448  01b7 a31389        	cpw	x,#5001
3449  01ba 2520          	jrult	L1602
3450                     ; 200 			count=0;
3452  01bc 5f            	clrw	x
3453  01bd bf03          	ldw	L1302_count,x
3454                     ; 201 			aic3254_flag=0;
3456  01bf 3f02          	clr	L5361_aic3254_flag
3457                     ; 202 			if(AIC3254_AUX)
3459  01c1 c6500b        	ld	a,_PC_IDR
3460  01c4 a508          	bcp	a,#8
3461  01c6 2704          	jreq	L5502
3462                     ; 204 				aic3254_aux=0;//外部DC拔出
3464  01c8 3f00          	clr	_aic3254_aux
3466  01ca 2010          	jra	L1602
3467  01cc               L5502:
3468                     ; 208 				aic3254_aux=1;//外部DC接入
3470  01cc 35010000      	mov	_aic3254_aux,#1
3471  01d0 200a          	jra	L1602
3472  01d2               L1502:
3473                     ; 214 		if(aic3254_exti)
3475  01d2 3d01          	tnz	L3361_aic3254_exti
3476  01d4 2706          	jreq	L1602
3477                     ; 216 			aic3254_exti=0;
3479  01d6 3f01          	clr	L3361_aic3254_exti
3480                     ; 217 			aic3254_flag=1;
3482  01d8 35010002      	mov	L5361_aic3254_flag,#1
3483  01dc               L1602:
3484                     ; 220 }
3487  01dc 81            	ret
3513                     ; 222 void AIC3254_AuxScan_ISR(void)
3513                     ; 223 {
3514                     	switch	.text
3515  01dd               _AIC3254_AuxScan_ISR:
3519                     ; 224 	if(aic3254_flag==0)
3521  01dd 3d02          	tnz	L5361_aic3254_flag
3522  01df 2604          	jrne	L5702
3523                     ; 226 		aic3254_exti=1;
3525  01e1 35010001      	mov	L3361_aic3254_exti,#1
3526  01e5               L5702:
3527                     ; 228 }
3530  01e5 81            	ret
3593                     	xref	_I2C_WriteByte
3594                     	xref	_I2C_CheckAck
3595                     	xref	_I2C_Stop
3596                     	xref	_I2C_Start
3597                     	xref	_I2C_Init
3598                     	xdef	_AIC3254_AuxScan_ISR
3599                     	xdef	_AIC3254_AuxScan_Ser
3600                     	xdef	_AIC3254_SelectIn2
3601                     	xdef	_AIC3254_SelectIn1
3602                     	xdef	_AIC3254_WriteCofig
3603                     	xdef	_AIC3254_WriteVolume
3604                     	xdef	_AIC3254_Init
3605                     	xdef	_aic3254_aux
3624                     	xref	c_lrzmp
3625                     	xref	c_lgsbc
3626                     	xref	c_ltor
3627                     	end
