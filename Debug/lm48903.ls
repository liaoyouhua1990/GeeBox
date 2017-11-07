   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _lm48903_det:
2536  0000 00            	dc.b	0
2537  0001               _lm48903_buffer:
2538  0001 60            	dc.b	96
2539  0002 00            	dc.b	0
2540  0003 00            	dc.b	0
2541  0004 00            	dc.b	0
2542  0005 00            	dc.b	0
2543  0006 00            	dc.b	0
2544  0007 00            	dc.b	0
2545                     .const:	section	.text
2546  0000               L3361_volume_table:
2547  0000 00            	dc.b	0
2548  0001 24            	dc.b	36
2549  0002 25            	dc.b	37
2550  0003 26            	dc.b	38
2551  0004 28            	dc.b	40
2552  0005 2c            	dc.b	44
2553  0006 2e            	dc.b	46
2554  0007 30            	dc.b	48
2555  0008 32            	dc.b	50
2556  0009 34            	dc.b	52
2557  000a 36            	dc.b	54
2558  000b 38            	dc.b	56
2559  000c 3a            	dc.b	58
2560  000d 3c            	dc.b	60
2561  000e 3f            	dc.b	63
2601                     ; 31 void LM48903_Delay(u32 t)
2601                     ; 32 {
2603                     	switch	.text
2604  0000               _LM48903_Delay:
2606       00000000      OFST:	set	0
2609  0000               L7661:
2610                     ; 33 	while(t--);	
2612  0000 96            	ldw	x,sp
2613  0001 1c0003        	addw	x,#OFST+3
2614  0004 cd0000        	call	c_ltor
2616  0007 96            	ldw	x,sp
2617  0008 1c0003        	addw	x,#OFST+3
2618  000b a601          	ld	a,#1
2619  000d cd0000        	call	c_lgsbc
2621  0010 cd0000        	call	c_lrzmp
2623  0013 26eb          	jrne	L7661
2624                     ; 34 }
2627  0015 81            	ret
2667                     ; 36 void LM48903_WriteBuffer(void)
2667                     ; 37 {
2668                     	switch	.text
2669  0016               L5361_LM48903_WriteBuffer:
2671  0016 88            	push	a
2672       00000001      OFST:	set	1
2675                     ; 38 	u8 i=0;
2677  0017 0f01          	clr	(OFST+0,sp)
2678                     ; 40 	I2C_Start();
2680  0019 cd0000        	call	_I2C_Start
2682                     ; 41 	for(i=0;i<7;i++)
2684  001c 0f01          	clr	(OFST+0,sp)
2685  001e               L1171:
2686                     ; 43 		I2C_WriteByte(lm48903_buffer[i]);
2688  001e 7b01          	ld	a,(OFST+0,sp)
2689  0020 5f            	clrw	x
2690  0021 97            	ld	xl,a
2691  0022 e601          	ld	a,(_lm48903_buffer,x)
2692  0024 cd0000        	call	_I2C_WriteByte
2694                     ; 44 		I2C_CheckAck();
2696  0027 cd0000        	call	_I2C_CheckAck
2698                     ; 41 	for(i=0;i<7;i++)
2700  002a 0c01          	inc	(OFST+0,sp)
2703  002c 7b01          	ld	a,(OFST+0,sp)
2704  002e a107          	cp	a,#7
2705  0030 25ec          	jrult	L1171
2706                     ; 46 	I2C_Stop();
2708  0032 cd0000        	call	_I2C_Stop
2710                     ; 47 }
2713  0035 84            	pop	a
2714  0036 81            	ret
2743                     ; 49 void LM48903_ReadBuffer(void)
2743                     ; 50 {
2744                     	switch	.text
2745  0037               L7361_LM48903_ReadBuffer:
2749                     ; 51 	I2C_Start();
2751  0037 cd0000        	call	_I2C_Start
2753                     ; 52 	I2C_WriteByte(LM48903_ADDRESS);
2755  003a a660          	ld	a,#96
2756  003c cd0000        	call	_I2C_WriteByte
2758                     ; 53 	I2C_CheckAck();
2760  003f cd0000        	call	_I2C_CheckAck
2762                     ; 54 	I2C_WriteByte(lm48903_buffer[1]);
2764  0042 b602          	ld	a,_lm48903_buffer+1
2765  0044 cd0000        	call	_I2C_WriteByte
2767                     ; 55 	I2C_CheckAck();
2769  0047 cd0000        	call	_I2C_CheckAck
2771                     ; 56 	I2C_WriteByte(lm48903_buffer[2]);
2773  004a b603          	ld	a,_lm48903_buffer+2
2774  004c cd0000        	call	_I2C_WriteByte
2776                     ; 57 	I2C_CheckAck();
2778  004f cd0000        	call	_I2C_CheckAck
2780                     ; 58 	I2C_Start();
2782  0052 cd0000        	call	_I2C_Start
2784                     ; 59 	I2C_WriteByte(LM48903_ADDRESS|0x01);
2786  0055 a661          	ld	a,#97
2787  0057 cd0000        	call	_I2C_WriteByte
2789                     ; 60 	I2C_CheckAck();
2791  005a cd0000        	call	_I2C_CheckAck
2793                     ; 61 	lm48903_buffer[3]=I2C_ReadByte();
2795  005d cd0000        	call	_I2C_ReadByte
2797  0060 b704          	ld	_lm48903_buffer+3,a
2798                     ; 62 	I2C_CheckAck();
2800  0062 cd0000        	call	_I2C_CheckAck
2802                     ; 63 	lm48903_buffer[4]=I2C_ReadByte();
2804  0065 cd0000        	call	_I2C_ReadByte
2806  0068 b705          	ld	_lm48903_buffer+4,a
2807                     ; 64 	I2C_CheckAck();
2809  006a cd0000        	call	_I2C_CheckAck
2811                     ; 65 	lm48903_buffer[5]=I2C_ReadByte();
2813  006d cd0000        	call	_I2C_ReadByte
2815  0070 b706          	ld	_lm48903_buffer+5,a
2816                     ; 66 	I2C_CheckAck();
2818  0072 cd0000        	call	_I2C_CheckAck
2820                     ; 67 	lm48903_buffer[6]=I2C_ReadByte();
2822  0075 cd0000        	call	_I2C_ReadByte
2824  0078 b707          	ld	_lm48903_buffer+6,a
2825                     ; 68 	I2C_CheckAck();
2827  007a cd0000        	call	_I2C_CheckAck
2829                     ; 69 	I2C_Stop();
2831  007d cd0000        	call	_I2C_Stop
2833                     ; 70 }
2836  0080 81            	ret
2870                     ; 72 void LM48903_Init(void)
2870                     ; 73 {
2871                     	switch	.text
2872  0081               _LM48903_Init:
2876                     ; 74 	PF_DDR|=1<<4;
2878  0081 7218501b      	bset	_PF_DDR,#4
2879                     ; 75 	PF_CR1|=1<<4;
2881  0085 7218501c      	bset	_PF_CR1,#4
2882                     ; 76 	PF_CR2&=~(1<<4);
2884  0089 7219501d      	bres	_PF_CR2,#4
2885                     ; 77 	LM48903_SD_0();
2887  008d 72195019      	bres	_PF_ODR,#4
2888                     ; 82 	PA_DDR|=1<<1;
2890  0091 72125002      	bset	_PA_DDR,#1
2891                     ; 83 	PA_CR1|=1<<1;
2893  0095 72125003      	bset	_PA_CR1,#1
2894                     ; 84 	PA_CR2&=~(1<<1);
2896  0099 72135004      	bres	_PA_CR2,#1
2897                     ; 85 	LM48903_SW_0();
2899  009d 72135000      	bres	_PA_ODR,#1
2900                     ; 87 	PD_DDR&=~(1<<3);
2902  00a1 72175011      	bres	_PD_DDR,#3
2903                     ; 88 	PD_CR1|=(1<<3);
2905  00a5 72165012      	bset	_PD_CR1,#3
2906                     ; 90 	I2C_Init();
2908  00a9 cd0000        	call	_I2C_Init
2910                     ; 91 }
2913  00ac 81            	ret
2951                     ; 93 void LM48903_WriteVolume(u8 volume)
2951                     ; 94 {
2952                     	switch	.text
2953  00ad               _LM48903_WriteVolume:
2957                     ; 95 	lm48903_buffer[1]=0x05;
2959  00ad 35050002      	mov	_lm48903_buffer+1,#5
2960                     ; 96 	lm48903_buffer[2]=0x22;
2962  00b1 35220003      	mov	_lm48903_buffer+2,#34
2963                     ; 97 	lm48903_buffer[3]=volume_table[volume];
2965  00b5 5f            	clrw	x
2966  00b6 97            	ld	xl,a
2967  00b7 d60000        	ld	a,(L3361_volume_table,x)
2968  00ba b704          	ld	_lm48903_buffer+3,a
2969                     ; 98 	lm48903_buffer[4]=0x33;
2971  00bc 35330005      	mov	_lm48903_buffer+4,#51
2972                     ; 99 	lm48903_buffer[5]=0x02;
2974  00c0 35020006      	mov	_lm48903_buffer+5,#2
2975                     ; 100 	lm48903_buffer[6]=0x05;
2977  00c4 35050007      	mov	_lm48903_buffer+6,#5
2978                     ; 101 	LM48903_WriteBuffer();
2980  00c8 cd0016        	call	L5361_LM48903_WriteBuffer
2982                     ; 102 }
2985  00cb 81            	ret
3011                     ; 104 void LM48903_WriteStereo(void)
3011                     ; 105 {
3012                     	switch	.text
3013  00cc               _LM48903_WriteStereo:
3017                     ; 106 	lm48903_buffer[1]=0x05;
3019  00cc 35050002      	mov	_lm48903_buffer+1,#5
3020                     ; 107 	lm48903_buffer[2]=0x00;
3022  00d0 3f03          	clr	_lm48903_buffer+2
3023                     ; 108 	lm48903_buffer[3]=0xff;
3025  00d2 35ff0004      	mov	_lm48903_buffer+3,#255
3026                     ; 109 	lm48903_buffer[4]=0xff;
3028  00d6 35ff0005      	mov	_lm48903_buffer+4,#255
3029                     ; 110 	lm48903_buffer[5]=0xe4;
3031  00da 35e40006      	mov	_lm48903_buffer+5,#228
3032                     ; 111 	lm48903_buffer[6]=0x41;
3034  00de 35410007      	mov	_lm48903_buffer+6,#65
3035                     ; 112 	LM48903_WriteBuffer();
3037  00e2 cd0016        	call	L5361_LM48903_WriteBuffer
3039                     ; 113 	lm48903_buffer[1]=0x05;
3041  00e5 35050002      	mov	_lm48903_buffer+1,#5
3042                     ; 114 	lm48903_buffer[2]=0x00;
3044  00e9 3f03          	clr	_lm48903_buffer+2
3045                     ; 115 	lm48903_buffer[3]=0xff;
3047  00eb 35ff0004      	mov	_lm48903_buffer+3,#255
3048                     ; 116 	lm48903_buffer[4]=0xff;
3050  00ef 35ff0005      	mov	_lm48903_buffer+4,#255
3051                     ; 117 	lm48903_buffer[5]=0xe4;
3053  00f3 35e40006      	mov	_lm48903_buffer+5,#228
3054                     ; 118 	lm48903_buffer[6]=0x01;
3056  00f7 35010007      	mov	_lm48903_buffer+6,#1
3057                     ; 119 	LM48903_WriteBuffer();
3059  00fb cd0016        	call	L5361_LM48903_WriteBuffer
3061                     ; 120 	lm48903_buffer[1]=0x05;
3063  00fe 35050002      	mov	_lm48903_buffer+1,#5
3064                     ; 121 	lm48903_buffer[2]=0x30;
3066  0102 35300003      	mov	_lm48903_buffer+2,#48
3067                     ; 122 	lm48903_buffer[3]=0x30;
3069  0106 35300004      	mov	_lm48903_buffer+3,#48
3070                     ; 123 	lm48903_buffer[4]=0x02;
3072  010a 35020005      	mov	_lm48903_buffer+4,#2
3073                     ; 124 	lm48903_buffer[5]=0x8c;
3075  010e 358c0006      	mov	_lm48903_buffer+5,#140
3076                     ; 125 	lm48903_buffer[6]=0x00;
3078  0112 3f07          	clr	_lm48903_buffer+6
3079                     ; 126 	LM48903_WriteBuffer();
3081  0114 cd0016        	call	L5361_LM48903_WriteBuffer
3083                     ; 127 	lm48903_buffer[1]=0x05;
3085  0117 35050002      	mov	_lm48903_buffer+1,#5
3086                     ; 128 	lm48903_buffer[2]=0x30;
3088  011b 35300003      	mov	_lm48903_buffer+2,#48
3089                     ; 129 	lm48903_buffer[3]=0x30;
3091  011f 35300004      	mov	_lm48903_buffer+3,#48
3092                     ; 130 	lm48903_buffer[4]=0x0e;
3094  0123 350e0005      	mov	_lm48903_buffer+4,#14
3095                     ; 131 	lm48903_buffer[5]=0x8c;
3097  0127 358c0006      	mov	_lm48903_buffer+5,#140
3098                     ; 132 	lm48903_buffer[6]=0x00;
3100  012b 3f07          	clr	_lm48903_buffer+6
3101                     ; 133 	LM48903_WriteBuffer();
3103  012d cd0016        	call	L5361_LM48903_WriteBuffer
3105                     ; 134 }
3108  0130 81            	ret
3133                     ; 136 void LM48903_Write3D(void)
3133                     ; 137 {
3134                     	switch	.text
3135  0131               _LM48903_Write3D:
3139                     ; 138 	lm48903_buffer[1]=0x05;
3141  0131 35050002      	mov	_lm48903_buffer+1,#5
3142                     ; 139 	lm48903_buffer[2]=0x01;
3144  0135 35010003      	mov	_lm48903_buffer+2,#1
3145                     ; 140 	lm48903_buffer[3]=0xd8;
3147  0139 35d80004      	mov	_lm48903_buffer+3,#216
3148                     ; 141 	lm48903_buffer[4]=0x01;
3150  013d 35010005      	mov	_lm48903_buffer+4,#1
3151                     ; 142 	lm48903_buffer[5]=0x00;
3153  0141 3f06          	clr	_lm48903_buffer+5
3154                     ; 143 	lm48903_buffer[6]=0x00;
3156  0143 3f07          	clr	_lm48903_buffer+6
3157                     ; 144 	LM48903_WriteBuffer();
3159  0145 cd0016        	call	L5361_LM48903_WriteBuffer
3161                     ; 145 	lm48903_buffer[1]=0x05;
3163  0148 35050002      	mov	_lm48903_buffer+1,#5
3164                     ; 146 	lm48903_buffer[2]=0x02;
3166  014c 35020003      	mov	_lm48903_buffer+2,#2
3167                     ; 147 	lm48903_buffer[3]=0xd8;
3169  0150 35d80004      	mov	_lm48903_buffer+3,#216
3170                     ; 148 	lm48903_buffer[4]=0x01;
3172  0154 35010005      	mov	_lm48903_buffer+4,#1
3173                     ; 149 	lm48903_buffer[5]=0xd8;
3175  0158 35d80006      	mov	_lm48903_buffer+5,#216
3176                     ; 150 	lm48903_buffer[6]=0x01;
3178  015c 35010007      	mov	_lm48903_buffer+6,#1
3179                     ; 151 	LM48903_WriteBuffer();
3181  0160 cd0016        	call	L5361_LM48903_WriteBuffer
3183                     ; 152 	lm48903_buffer[1]=0x05;
3185  0163 35050002      	mov	_lm48903_buffer+1,#5
3186                     ; 153 	lm48903_buffer[2]=0x00;
3188  0167 3f03          	clr	_lm48903_buffer+2
3189                     ; 154 	lm48903_buffer[3]=0xff;
3191  0169 35ff0004      	mov	_lm48903_buffer+3,#255
3192                     ; 155 	lm48903_buffer[4]=0xff;
3194  016d 35ff0005      	mov	_lm48903_buffer+4,#255
3195                     ; 156 	lm48903_buffer[5]=0xe4;
3197  0171 35e40006      	mov	_lm48903_buffer+5,#228
3198                     ; 157 	lm48903_buffer[6]=0x81;
3200  0175 35810007      	mov	_lm48903_buffer+6,#129
3201                     ; 158 	LM48903_WriteBuffer();
3203  0179 cd0016        	call	L5361_LM48903_WriteBuffer
3205                     ; 159 	lm48903_buffer[1]=0x05;
3207  017c 35050002      	mov	_lm48903_buffer+1,#5
3208                     ; 160 	lm48903_buffer[2]=0x00;
3210  0180 3f03          	clr	_lm48903_buffer+2
3211                     ; 161 	lm48903_buffer[3]=0xff;
3213  0182 35ff0004      	mov	_lm48903_buffer+3,#255
3214                     ; 162 	lm48903_buffer[4]=0xff;
3216  0186 35ff0005      	mov	_lm48903_buffer+4,#255
3217                     ; 163 	lm48903_buffer[5]=0xe4;
3219  018a 35e40006      	mov	_lm48903_buffer+5,#228
3220                     ; 164 	lm48903_buffer[6]=0xc1;
3222  018e 35c10007      	mov	_lm48903_buffer+6,#193
3223                     ; 165 	LM48903_WriteBuffer();
3225  0192 cd0016        	call	L5361_LM48903_WriteBuffer
3227                     ; 166 	lm48903_buffer[1]=0x05;
3229  0195 35050002      	mov	_lm48903_buffer+1,#5
3230                     ; 167 	lm48903_buffer[2]=0x30;
3232  0199 35300003      	mov	_lm48903_buffer+2,#48
3233                     ; 168 	lm48903_buffer[3]=0x30;
3235  019d 35300004      	mov	_lm48903_buffer+3,#48
3236                     ; 169 	lm48903_buffer[4]=0x0e;
3238  01a1 350e0005      	mov	_lm48903_buffer+4,#14
3239                     ; 170 	lm48903_buffer[5]=0x8c;
3241  01a5 358c0006      	mov	_lm48903_buffer+5,#140
3242                     ; 171 	lm48903_buffer[6]=0x00;
3244  01a9 3f07          	clr	_lm48903_buffer+6
3245                     ; 172 	LM48903_WriteBuffer();
3247  01ab cd0016        	call	L5361_LM48903_WriteBuffer
3249                     ; 173 	lm48903_buffer[1]=0x05;
3251  01ae 35050002      	mov	_lm48903_buffer+1,#5
3252                     ; 174 	lm48903_buffer[2]=0x30;
3254  01b2 35300003      	mov	_lm48903_buffer+2,#48
3255                     ; 175 	lm48903_buffer[3]=0x30;
3257  01b6 35300004      	mov	_lm48903_buffer+3,#48
3258                     ; 176 	lm48903_buffer[4]=0x02;
3260  01ba 35020005      	mov	_lm48903_buffer+4,#2
3261                     ; 177 	lm48903_buffer[5]=0x8c;
3263  01be 358c0006      	mov	_lm48903_buffer+5,#140
3264                     ; 178 	lm48903_buffer[6]=0x00;
3266  01c2 3f07          	clr	_lm48903_buffer+6
3267                     ; 179 	LM48903_WriteBuffer();
3269  01c4 cd0016        	call	L5361_LM48903_WriteBuffer
3271                     ; 180 }
3274  01c7 81            	ret
3299                     ; 182 void LM48903_WriteSleep(void)
3299                     ; 183 {
3300                     	switch	.text
3301  01c8               _LM48903_WriteSleep:
3305                     ; 184 	lm48903_buffer[1]=0x05;
3307  01c8 35050002      	mov	_lm48903_buffer+1,#5
3308                     ; 185 	lm48903_buffer[2]=0x33;
3310  01cc 35330003      	mov	_lm48903_buffer+2,#51
3311                     ; 188 	lm48903_buffer[3]=0x25;//75mV
3313  01d0 35250004      	mov	_lm48903_buffer+3,#37
3314                     ; 193 	lm48903_buffer[4]=0xd9;//10S
3316  01d4 35d90005      	mov	_lm48903_buffer+4,#217
3317                     ; 195 	lm48903_buffer[5]=0x02;
3319  01d8 35020006      	mov	_lm48903_buffer+5,#2
3320                     ; 196 	lm48903_buffer[6]=0x00;
3322  01dc 3f07          	clr	_lm48903_buffer+6
3323                     ; 197 	LM48903_WriteBuffer();
3325  01de cd0016        	call	L5361_LM48903_WriteBuffer
3327                     ; 198 }
3330  01e1 81            	ret
3355                     ; 200 void LM48903_WriteSodp(void)
3355                     ; 201 {
3356                     	switch	.text
3357  01e2               _LM48903_WriteSodp:
3361                     ; 202 	lm48903_buffer[1]=0x05;
3363  01e2 35050002      	mov	_lm48903_buffer+1,#5
3364                     ; 203 	lm48903_buffer[2]=0x31;
3366  01e6 35310003      	mov	_lm48903_buffer+2,#49
3367                     ; 204 	lm48903_buffer[3]=0x65;
3369  01ea 35650004      	mov	_lm48903_buffer+3,#101
3370                     ; 205 	lm48903_buffer[4]=0x43;
3372  01ee 35430005      	mov	_lm48903_buffer+4,#67
3373                     ; 206 	lm48903_buffer[5]=0x83;
3375  01f2 35830006      	mov	_lm48903_buffer+5,#131
3376                     ; 207 	lm48903_buffer[6]=0x27;
3378  01f6 35270007      	mov	_lm48903_buffer+6,#39
3379                     ; 208 	LM48903_WriteBuffer();
3381  01fa cd0016        	call	L5361_LM48903_WriteBuffer
3383                     ; 209 }
3386  01fd 81            	ret
3389                     	bsct
3390  0008               L5102_count:
3391  0008 0000          	dc.w	0
3426                     ; 211 void LM48903_CheckSleep_Ser(void)
3426                     ; 212 {
3427                     	switch	.text
3428  01fe               _LM48903_CheckSleep_Ser:
3432                     ; 215 	if(LM48903_DET==0)
3434  01fe c65010        	ld	a,_PD_IDR
3435  0201 a508          	bcp	a,#8
3436  0203 261e          	jrne	L5302
3437                     ; 217 		count++;
3439  0205 be08          	ldw	x,L5102_count
3440  0207 1c0001        	addw	x,#1
3441  020a bf08          	ldw	L5102_count,x
3442                     ; 218 		if(count>5000)
3444  020c be08          	ldw	x,L5102_count
3445  020e a31389        	cpw	x,#5001
3446  0211 2515          	jrult	L3402
3447                     ; 220 			count=0;
3449  0213 5f            	clrw	x
3450  0214 bf08          	ldw	L5102_count,x
3451                     ; 221 			if(LM48903_DET==0)
3453  0216 c65010        	ld	a,_PD_IDR
3454  0219 a508          	bcp	a,#8
3455  021b 260b          	jrne	L3402
3456                     ; 223 				lm48903_det=1;
3458  021d 35010000      	mov	_lm48903_det,#1
3459  0221 2005          	jra	L3402
3460  0223               L5302:
3461                     ; 229 		count=0;
3463  0223 5f            	clrw	x
3464  0224 bf08          	ldw	L5102_count,x
3465                     ; 230 		lm48903_det=0;
3467  0226 3f00          	clr	_lm48903_det
3468  0228               L3402:
3469                     ; 232 }
3472  0228 81            	ret
3516                     	xref	_I2C_ReadByte
3517                     	xref	_I2C_WriteByte
3518                     	xref	_I2C_CheckAck
3519                     	xref	_I2C_Stop
3520                     	xref	_I2C_Start
3521                     	xref	_I2C_Init
3522                     	xdef	_LM48903_CheckSleep_Ser
3523                     	xdef	_LM48903_WriteSodp
3524                     	xdef	_LM48903_WriteSleep
3525                     	xdef	_LM48903_Write3D
3526                     	xdef	_LM48903_WriteStereo
3527                     	xdef	_LM48903_WriteVolume
3528                     	xdef	_LM48903_Delay
3529                     	xdef	_LM48903_Init
3530                     	xdef	_lm48903_det
3531                     	xdef	_lm48903_buffer
3550                     	xref	c_lrzmp
3551                     	xref	c_lgsbc
3552                     	xref	c_ltor
3553                     	end
