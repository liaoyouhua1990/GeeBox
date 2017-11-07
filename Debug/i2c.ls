   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2576                     ; 8 void SCL_SET(u8 flag)
2576                     ; 9 {
2578                     	switch	.text
2579  0000               L3361_SCL_SET:
2583                     ; 10 	PB_DDR|=1<<4;
2585  0000 72185007      	bset	_PB_DDR,#4
2586                     ; 11 	PB_CR1|=1<<4;
2588  0004 72185008      	bset	_PB_CR1,#4
2589                     ; 12 	PB_CR2&=~(1<<4);
2591  0008 72195009      	bres	_PB_CR2,#4
2592                     ; 13 	if(flag)
2594  000c 4d            	tnz	a
2595  000d 2706          	jreq	L7661
2596                     ; 15 		PB_ODR|=(1<<4);	
2598  000f 72185005      	bset	_PB_ODR,#4
2600  0013 2004          	jra	L1761
2601  0015               L7661:
2602                     ; 19 		PB_ODR&=~(1<<4);	
2604  0015 72195005      	bres	_PB_ODR,#4
2605  0019               L1761:
2606                     ; 21 }
2609  0019 81            	ret
2647                     ; 23 void SDA_SET(u8 flag)
2647                     ; 24 {
2648                     	switch	.text
2649  001a               L5361_SDA_SET:
2653                     ; 25 	PB_DDR|=1<<5;
2655  001a 721a5007      	bset	_PB_DDR,#5
2656                     ; 26 	PB_CR1|=1<<5;
2658  001e 721a5008      	bset	_PB_CR1,#5
2659                     ; 27 	PB_CR2&=~(1<<5);
2661  0022 721b5009      	bres	_PB_CR2,#5
2662                     ; 28 	if(flag)
2664  0026 4d            	tnz	a
2665  0027 2706          	jreq	L1171
2666                     ; 30 		PB_ODR|=(1<<5);	
2668  0029 721a5005      	bset	_PB_ODR,#5
2670  002d 2004          	jra	L3171
2671  002f               L1171:
2672                     ; 34 		PB_ODR&=~(1<<5);	
2674  002f 721b5005      	bres	_PB_ODR,#5
2675  0033               L3171:
2676                     ; 36 }
2679  0033 81            	ret
2717                     ; 38 u8 SDA_GET(void)
2717                     ; 39 {
2718                     	switch	.text
2719  0034               L7361_SDA_GET:
2721  0034 88            	push	a
2722       00000001      OFST:	set	1
2725                     ; 40 	u8 flag=0;
2727  0035 0f01          	clr	(OFST+0,sp)
2728                     ; 42 	PB_DDR&=~(1<<5);
2730  0037 721b5007      	bres	_PB_DDR,#5
2731                     ; 43 	PB_CR1|=(1<<5);
2733  003b 721a5008      	bset	_PB_CR1,#5
2734                     ; 44 	PB_CR2&=~(1<<5);
2736  003f 721b5009      	bres	_PB_CR2,#5
2737                     ; 45 	if(PB_IDR&(1<<5))
2739  0043 c65006        	ld	a,_PB_IDR
2740  0046 a520          	bcp	a,#32
2741  0048 2706          	jreq	L3371
2742                     ; 47 		flag=1;
2744  004a a601          	ld	a,#1
2745  004c 6b01          	ld	(OFST+0,sp),a
2747  004e 2002          	jra	L5371
2748  0050               L3371:
2749                     ; 51 		flag=0;
2751  0050 0f01          	clr	(OFST+0,sp)
2752  0052               L5371:
2753                     ; 54 	return flag;
2755  0052 7b01          	ld	a,(OFST+0,sp)
2758  0054 5b01          	addw	sp,#1
2759  0056 81            	ret
2793                     ; 57 void I2C_Wait(u8 t)
2793                     ; 58 {
2794                     	switch	.text
2795  0057               L1461_I2C_Wait:
2797  0057 88            	push	a
2798       00000000      OFST:	set	0
2801  0058               L7571:
2802                     ; 59 	while(t--);
2804  0058 7b01          	ld	a,(OFST+1,sp)
2805  005a 0a01          	dec	(OFST+1,sp)
2806  005c 4d            	tnz	a
2807  005d 26f9          	jrne	L7571
2808                     ; 60 }
2811  005f 84            	pop	a
2812  0060 81            	ret
2837                     ; 62 void I2C_Init(void)
2837                     ; 63 {
2838                     	switch	.text
2839  0061               _I2C_Init:
2843                     ; 64 	SCL_SET(1);
2845  0061 a601          	ld	a,#1
2846  0063 ad9b          	call	L3361_SCL_SET
2848                     ; 65 	SDA_GET();
2850  0065 adcd          	call	L7361_SDA_GET
2852                     ; 66 }
2855  0067 81            	ret
2901                     ; 68 void I2C_WriteByte(u8 byte)
2901                     ; 69 {
2902                     	switch	.text
2903  0068               _I2C_WriteByte:
2905  0068 88            	push	a
2906  0069 88            	push	a
2907       00000001      OFST:	set	1
2910                     ; 70 	u8 i=0;
2912  006a 0f01          	clr	(OFST+0,sp)
2913                     ; 72 	for(i=0;i<8;i++)
2915  006c 0f01          	clr	(OFST+0,sp)
2916  006e               L5102:
2917                     ; 74 		SCL_SET(0);
2919  006e 4f            	clr	a
2920  006f ad8f          	call	L3361_SCL_SET
2922                     ; 75 		I2C_Wait(2);
2924  0071 a602          	ld	a,#2
2925  0073 ade2          	call	L1461_I2C_Wait
2927                     ; 76 		if((byte<<i)&0x80)
2929  0075 7b02          	ld	a,(OFST+1,sp)
2930  0077 5f            	clrw	x
2931  0078 97            	ld	xl,a
2932  0079 7b01          	ld	a,(OFST+0,sp)
2933  007b 4d            	tnz	a
2934  007c 2704          	jreq	L02
2935  007e               L22:
2936  007e 58            	sllw	x
2937  007f 4a            	dec	a
2938  0080 26fc          	jrne	L22
2939  0082               L02:
2940  0082 01            	rrwa	x,a
2941  0083 a580          	bcp	a,#128
2942  0085 2706          	jreq	L3202
2943                     ; 78 			SDA_SET(1);
2945  0087 a601          	ld	a,#1
2946  0089 ad8f          	call	L5361_SDA_SET
2949  008b 2003          	jra	L5202
2950  008d               L3202:
2951                     ; 82 			SDA_SET(0);
2953  008d 4f            	clr	a
2954  008e ad8a          	call	L5361_SDA_SET
2956  0090               L5202:
2957                     ; 84 		I2C_Wait(2);
2959  0090 a602          	ld	a,#2
2960  0092 adc3          	call	L1461_I2C_Wait
2962                     ; 85 		SCL_SET(1);
2964  0094 a601          	ld	a,#1
2965  0096 cd0000        	call	L3361_SCL_SET
2967                     ; 86 		I2C_Wait(12);
2969  0099 a60c          	ld	a,#12
2970  009b adba          	call	L1461_I2C_Wait
2972                     ; 72 	for(i=0;i<8;i++)
2974  009d 0c01          	inc	(OFST+0,sp)
2977  009f 7b01          	ld	a,(OFST+0,sp)
2978  00a1 a108          	cp	a,#8
2979  00a3 25c9          	jrult	L5102
2980                     ; 88 	SCL_SET(0);
2982  00a5 4f            	clr	a
2983  00a6 cd0000        	call	L3361_SCL_SET
2985                     ; 89 	I2C_Wait(4);
2987  00a9 a604          	ld	a,#4
2988  00ab adaa          	call	L1461_I2C_Wait
2990                     ; 90 }
2993  00ad 85            	popw	x
2994  00ae 81            	ret
3040                     ; 92 u8 I2C_ReadByte(void)
3040                     ; 93 {
3041                     	switch	.text
3042  00af               _I2C_ReadByte:
3044  00af 89            	pushw	x
3045       00000002      OFST:	set	2
3048                     ; 94 	u8 i=0;
3050  00b0 7b01          	ld	a,(OFST-1,sp)
3051  00b2 97            	ld	xl,a
3052                     ; 95 	u8 dat=0;
3054  00b3 0f02          	clr	(OFST+0,sp)
3055                     ; 97 	for(i=0;i<8;i++)
3057  00b5 0f01          	clr	(OFST-1,sp)
3058  00b7               L1502:
3059                     ; 99 		SCL_SET(1);
3061  00b7 a601          	ld	a,#1
3062  00b9 cd0000        	call	L3361_SCL_SET
3064                     ; 100 		I2C_Wait(8);
3066  00bc a608          	ld	a,#8
3067  00be ad97          	call	L1461_I2C_Wait
3069                     ; 101 		dat=dat<<1;
3071  00c0 0802          	sll	(OFST+0,sp)
3072                     ; 102 		if(SDA_GET())
3074  00c2 cd0034        	call	L7361_SDA_GET
3076  00c5 4d            	tnz	a
3077  00c6 2702          	jreq	L7502
3078                     ; 104 			dat++;
3080  00c8 0c02          	inc	(OFST+0,sp)
3081  00ca               L7502:
3082                     ; 106 		SCL_SET(0);
3084  00ca 4f            	clr	a
3085  00cb cd0000        	call	L3361_SCL_SET
3087                     ; 107 		I2C_Wait(10);
3089  00ce a60a          	ld	a,#10
3090  00d0 ad85          	call	L1461_I2C_Wait
3092                     ; 97 	for(i=0;i<8;i++)
3094  00d2 0c01          	inc	(OFST-1,sp)
3097  00d4 7b01          	ld	a,(OFST-1,sp)
3098  00d6 a108          	cp	a,#8
3099  00d8 25dd          	jrult	L1502
3100                     ; 110 	return dat;
3102  00da 7b02          	ld	a,(OFST+0,sp)
3105  00dc 85            	popw	x
3106  00dd 81            	ret
3132                     ; 113 void I2C_Start(void)
3132                     ; 114 {
3133                     	switch	.text
3134  00de               _I2C_Start:
3138                     ; 115 	SDA_SET(1);
3140  00de a601          	ld	a,#1
3141  00e0 cd001a        	call	L5361_SDA_SET
3143                     ; 116 	SCL_SET(1);
3145  00e3 a601          	ld	a,#1
3146  00e5 cd0000        	call	L3361_SCL_SET
3148                     ; 117 	I2C_Wait(4);
3150  00e8 a604          	ld	a,#4
3151  00ea cd0057        	call	L1461_I2C_Wait
3153                     ; 118 	SDA_SET(0);
3155  00ed 4f            	clr	a
3156  00ee cd001a        	call	L5361_SDA_SET
3158                     ; 119 	I2C_Wait(4);
3160  00f1 a604          	ld	a,#4
3161  00f3 cd0057        	call	L1461_I2C_Wait
3163                     ; 120 }
3166  00f6 81            	ret
3192                     ; 122 void I2C_Stop(void)
3192                     ; 123 {
3193                     	switch	.text
3194  00f7               _I2C_Stop:
3198                     ; 124 	SDA_SET(0);
3200  00f7 4f            	clr	a
3201  00f8 cd001a        	call	L5361_SDA_SET
3203                     ; 125 	SCL_SET(1);
3205  00fb a601          	ld	a,#1
3206  00fd cd0000        	call	L3361_SCL_SET
3208                     ; 126 	I2C_Wait(4);
3210  0100 a604          	ld	a,#4
3211  0102 cd0057        	call	L1461_I2C_Wait
3213                     ; 127 	SDA_SET(1);
3215  0105 a601          	ld	a,#1
3216  0107 cd001a        	call	L5361_SDA_SET
3218                     ; 128 	I2C_Wait(4);
3220  010a a604          	ld	a,#4
3221  010c cd0057        	call	L1461_I2C_Wait
3223                     ; 129 }
3226  010f 81            	ret
3272                     ; 131 u8 I2C_ReadAck(void)
3272                     ; 132 {
3273                     	switch	.text
3274  0110               _I2C_ReadAck:
3276  0110 89            	pushw	x
3277       00000002      OFST:	set	2
3280                     ; 133 	u8 ack=0; 
3282  0111 0f02          	clr	(OFST+0,sp)
3283                     ; 134 	u8 i=0;
3285  0113 0f01          	clr	(OFST-1,sp)
3286                     ; 136 	SCL_SET(1);
3288  0115 a601          	ld	a,#1
3289  0117 cd0000        	call	L3361_SCL_SET
3291                     ; 137 	I2C_Wait(8);
3293  011a a608          	ld	a,#8
3294  011c cd0057        	call	L1461_I2C_Wait
3297  011f 2010          	jra	L5212
3298  0121               L3212:
3299                     ; 140 		if(SDA_GET())
3301  0121 cd0034        	call	L7361_SDA_GET
3303  0124 4d            	tnz	a
3304  0125 2704          	jreq	L1312
3305                     ; 142 			ack=0;
3307  0127 0f02          	clr	(OFST+0,sp)
3309  0129 2004          	jra	L3312
3310  012b               L1312:
3311                     ; 146 			ack=1;		
3313  012b a601          	ld	a,#1
3314  012d 6b02          	ld	(OFST+0,sp),a
3315  012f               L3312:
3316                     ; 148 		i++;
3318  012f 0c01          	inc	(OFST-1,sp)
3319  0131               L5212:
3320                     ; 138 	while((!ack)&&(i<50))
3322  0131 0d02          	tnz	(OFST+0,sp)
3323  0133 2606          	jrne	L5312
3325  0135 7b01          	ld	a,(OFST-1,sp)
3326  0137 a132          	cp	a,#50
3327  0139 25e6          	jrult	L3212
3328  013b               L5312:
3329                     ; 150 	SCL_SET(0);
3331  013b 4f            	clr	a
3332  013c cd0000        	call	L3361_SCL_SET
3334                     ; 151 	I2C_Wait(8);
3336  013f a608          	ld	a,#8
3337  0141 cd0057        	call	L1461_I2C_Wait
3339                     ; 153 	return ack;
3341  0144 7b02          	ld	a,(OFST+0,sp)
3344  0146 85            	popw	x
3345  0147 81            	ret
3383                     ; 156 void I2C_WriteAck(u8 ack)
3383                     ; 157 {
3384                     	switch	.text
3385  0148               _I2C_WriteAck:
3389                     ; 158 	if(ack)
3391  0148 4d            	tnz	a
3392  0149 2706          	jreq	L5512
3393                     ; 160 		SDA_SET(0);
3395  014b 4f            	clr	a
3396  014c cd001a        	call	L5361_SDA_SET
3399  014f 2005          	jra	L7512
3400  0151               L5512:
3401                     ; 164 		SDA_SET(1);
3403  0151 a601          	ld	a,#1
3404  0153 cd001a        	call	L5361_SDA_SET
3406  0156               L7512:
3407                     ; 166 	I2C_Wait(2);
3409  0156 a602          	ld	a,#2
3410  0158 cd0057        	call	L1461_I2C_Wait
3412                     ; 167 	SCL_SET(1);
3414  015b a601          	ld	a,#1
3415  015d cd0000        	call	L3361_SCL_SET
3417                     ; 168 	I2C_Wait(10);
3419  0160 a60a          	ld	a,#10
3420  0162 cd0057        	call	L1461_I2C_Wait
3422                     ; 169 	SCL_SET(0);
3424  0165 4f            	clr	a
3425  0166 cd0000        	call	L3361_SCL_SET
3427                     ; 170 	SDA_GET();
3429  0169 cd0034        	call	L7361_SDA_GET
3431                     ; 171 	I2C_Wait(8);
3433  016c a608          	ld	a,#8
3434  016e cd0057        	call	L1461_I2C_Wait
3436                     ; 172 }
3439  0171 81            	ret
3452                     	xdef	_I2C_ReadByte
3453                     	xdef	_I2C_WriteByte
3454                     	xdef	_I2C_WriteAck
3455                     	xdef	_I2C_ReadAck
3456                     	xdef	_I2C_Stop
3457                     	xdef	_I2C_Start
3458                     	xdef	_I2C_Init
3477                     	end
