   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _status_mode:
2536  0000 00            	dc.b	0
2537  0001               _status_sync:
2538  0001 00            	dc.b	0
2539  0002               _status_volume:
2540  0002 08            	dc.b	8
2541  0003               _status_input:
2542  0003 00            	dc.b	0
2543  0004               _status_pair:
2544  0004 00            	dc.b	0
2545  0005               _status_list:
2546  0005 00            	dc.b	0
2547  0006               _status_call:
2548  0006 00            	dc.b	0
2549  0007               _status_low:
2550  0007 00            	dc.b	0
2551  0008               _status_hang:
2552  0008 00            	dc.b	0
2589                     ; 74 void KEY_Mode_Ser(void)
2589                     ; 75 {
2591                     	switch	.text
2592  0000               _KEY_Mode_Ser:
2596                     ; 76 	switch(status_mode)
2598  0000 b600          	ld	a,_status_mode
2600                     ; 112 		break;
2601  0002 4d            	tnz	a
2602  0003 2706          	jreq	L3361
2603  0005 a003          	sub	a,#3
2604  0007 2718          	jreq	L7361
2605  0009 2032          	jra	L3661
2606  000b               L3361:
2607                     ; 80 			key_stby_t=40000;
2609  000b ae9c40        	ldw	x,#40000
2610  000e bf00          	ldw	_key_stby_t,x
2611                     ; 81 			KEY_STBY_Scan_Ser();
2613  0010 cd0000        	call	_KEY_STBY_Scan_Ser
2615                     ; 82 			switch(key_style)
2617  0013 b600          	ld	a,_key_style
2618  0015 a106          	cp	a,#6
2619  0017 2624          	jrne	L3661
2622  0019               L5361:
2623                     ; 86 					key_style=0;
2625  0019 3f00          	clr	_key_style
2626                     ; 87 					status_mode=MODE_ON;
2628  001b 35020000      	mov	_status_mode,#2
2629                     ; 89 				break;
2631  001f 201c          	jra	L3661
2632  0021               L7361:
2633                     ; 96 			key_stby_t=5000;
2635  0021 ae1388        	ldw	x,#5000
2636  0024 bf00          	ldw	_key_stby_t,x
2637                     ; 97 			KEY_STBY_Scan_Ser();
2639  0026 cd0000        	call	_KEY_STBY_Scan_Ser
2641                     ; 98 			switch(key_style)
2643  0029 b600          	ld	a,_key_style
2644  002b a106          	cp	a,#6
2645  002d 2606          	jrne	L3761
2648  002f               L1461:
2649                     ; 102 					key_style=0;
2651  002f 3f00          	clr	_key_style
2652                     ; 103 					status_mode=MODE_OFF;
2654  0031 35010000      	mov	_status_mode,#1
2655                     ; 105 				break;
2657  0035               L3761:
2658                     ; 107 			KEY_Volume_Ser();
2660  0035 ad07          	call	_KEY_Volume_Ser
2662                     ; 108 			KEY_Pair_Ser();
2664  0037 ad35          	call	_KEY_Pair_Ser
2666                     ; 109 			KEY_List_Ser();
2668  0039 ad46          	call	_KEY_List_Ser
2670                     ; 110 			KEY_Call_Ser();
2672  003b ad65          	call	_KEY_Call_Ser
2674                     ; 112 		break;
2676  003d               L3661:
2677                     ; 114 }
2680  003d 81            	ret
2707                     ; 116 void KEY_Volume_Ser(void)
2707                     ; 117 {
2708                     	switch	.text
2709  003e               _KEY_Volume_Ser:
2713                     ; 118 	KEY_UP_Scan_Ser();
2715  003e cd0000        	call	_KEY_UP_Scan_Ser
2717                     ; 119 	KEY_DOWN_Scan_Ser();
2719  0041 cd0000        	call	_KEY_DOWN_Scan_Ser
2721                     ; 120 	switch(key_style)                                      
2723  0044 b600          	ld	a,_key_style
2725                     ; 148 		break;
2726  0046 4a            	dec	a
2727  0047 2706          	jreq	L5761
2728  0049 a002          	sub	a,#2
2729  004b 2710          	jreq	L7761
2730  004d 201e          	jra	L3171
2731  004f               L5761:
2732                     ; 124 			key_style=KEY_NO;
2734  004f 3f00          	clr	_key_style
2735                     ; 125 			if(status_volume==VOLUME_MIN)
2737  0051 3d02          	tnz	_status_volume
2738  0053 2604          	jrne	L5171
2739                     ; 127 				status_volume=VOLUME_MIN;
2741  0055 3f02          	clr	_status_volume
2743  0057 2014          	jra	L3171
2744  0059               L5171:
2745                     ; 131 				status_volume--;
2747  0059 3a02          	dec	_status_volume
2748  005b 2010          	jra	L3171
2749  005d               L7761:
2750                     ; 138 			key_style=KEY_NO;
2752  005d 3f00          	clr	_key_style
2753                     ; 139 			if(status_volume==VOLUME_MAX)
2755  005f b602          	ld	a,_status_volume
2756  0061 a10c          	cp	a,#12
2757  0063 2606          	jrne	L1271
2758                     ; 141 				status_volume=VOLUME_MAX;
2760  0065 350c0002      	mov	_status_volume,#12
2762  0069 2002          	jra	L3171
2763  006b               L1271:
2764                     ; 145 				status_volume++;
2766  006b 3c02          	inc	_status_volume
2767  006d               L3171:
2768                     ; 150 }
2771  006d 81            	ret
2797                     ; 152 void KEY_Pair_Ser(void)
2797                     ; 153 {
2798                     	switch	.text
2799  006e               _KEY_Pair_Ser:
2803                     ; 154 	KEY_PAIR_Scan_Ser();
2805  006e cd0000        	call	_KEY_PAIR_Scan_Ser
2807                     ; 155 	switch(key_style)                                      
2809  0071 b600          	ld	a,_key_style
2811                     ; 163 		break;
2812  0073 a009          	sub	a,#9
2813  0075 2703          	jreq	L5271
2814  0077 4a            	dec	a
2815  0078 2606          	jrne	L1471
2816  007a               L5271:
2817                     ; 160 			key_style=KEY_NO;
2819  007a 3f00          	clr	_key_style
2820                     ; 161 			status_pair=1;
2822  007c 35010004      	mov	_status_pair,#1
2823                     ; 163 		break;
2825  0080               L1471:
2826                     ; 165 }
2829  0080 81            	ret
2856                     ; 167 void KEY_List_Ser(void)
2856                     ; 168 {
2857                     	switch	.text
2858  0081               _KEY_List_Ser:
2862                     ; 169 	KEY_UP_Scan_Ser();
2864  0081 cd0000        	call	_KEY_UP_Scan_Ser
2866                     ; 170 	KEY_DOWN_Scan_Ser();
2868  0084 cd0000        	call	_KEY_DOWN_Scan_Ser
2870                     ; 171 	switch(key_style)                                      
2872  0087 b600          	ld	a,_key_style
2874                     ; 186 		break;
2875  0089 a002          	sub	a,#2
2876  008b 2706          	jreq	L3471
2877  008d a002          	sub	a,#2
2878  008f 270a          	jreq	L5471
2879  0091 200e          	jra	L1671
2880  0093               L3471:
2881                     ; 175 			key_style=KEY_NO;
2883  0093 3f00          	clr	_key_style
2884                     ; 176 			status_list=LIST_PREV;
2886  0095 35010005      	mov	_status_list,#1
2887                     ; 178 		break;
2889  0099 2006          	jra	L1671
2890  009b               L5471:
2891                     ; 182 			key_style=KEY_NO;
2893  009b 3f00          	clr	_key_style
2894                     ; 183 			status_list=LIST_NEXT;
2896  009d 35020005      	mov	_status_list,#2
2897                     ; 186 		break;
2899  00a1               L1671:
2900                     ; 188 }
2903  00a1 81            	ret
2930                     ; 190 void KEY_Call_Ser(void)
2930                     ; 191 {
2931                     	switch	.text
2932  00a2               _KEY_Call_Ser:
2936                     ; 192 	KEY_CALL_Scan_Ser();
2938  00a2 cd0000        	call	_KEY_CALL_Scan_Ser
2940                     ; 193 	switch(key_style)                                      
2942  00a5 b600          	ld	a,_key_style
2944                     ; 207 		break;
2945  00a7 a007          	sub	a,#7
2946  00a9 2705          	jreq	L3671
2947  00ab 4a            	dec	a
2948  00ac 270a          	jreq	L5671
2949  00ae 200e          	jra	L1002
2950  00b0               L3671:
2951                     ; 197 			key_style=KEY_NO;
2953  00b0 3f00          	clr	_key_style
2954                     ; 198 			status_call=1;
2956  00b2 35010006      	mov	_status_call,#1
2957                     ; 200 		break;
2959  00b6 2006          	jra	L1002
2960  00b8               L5671:
2961                     ; 204 			key_style=KEY_NO;
2963  00b8 3f00          	clr	_key_style
2964                     ; 205 			status_hang=1;
2966  00ba 35010008      	mov	_status_hang,#1
2967                     ; 207 		break;
2969  00be               L1002:
2970                     ; 209 }
2973  00be 81            	ret
2976                     	bsct
2977  0009               L3002_count:
2978  0009 00000000      	dc.l	0
3013                     ; 211 void POWER_Mode_Ser(void)
3013                     ; 212 {
3014                     	switch	.text
3015  00bf               _POWER_Mode_Ser:
3019                     ; 215 	switch(status_mode)
3021  00bf b600          	ld	a,_status_mode
3023                     ; 244 		break;
3024  00c1 4a            	dec	a
3025  00c2 2711          	jreq	L1102
3026  00c4 4a            	dec	a
3027  00c5 261c          	jrne	L5302
3028                     ; 219 			switch(status_sync)
3030  00c7 3d01          	tnz	_status_sync
3031  00c9 2618          	jrne	L5302
3034  00cb               L7002:
3035                     ; 223 					POWER_STBY_1();//打开电源
3037  00cb 721a500f      	bset	_PD_ODR,#5
3038                     ; 224 					status_sync=1;
3040  00cf 35010001      	mov	_status_sync,#1
3041                     ; 226 				break;
3043  00d3 200e          	jra	L5302
3044  00d5               L1102:
3045                     ; 233 			switch(status_sync)
3047  00d5 b601          	ld	a,_status_sync
3048  00d7 a108          	cp	a,#8
3049  00d9 2608          	jrne	L5302
3052  00db               L3102:
3053                     ; 237 					POWER_STBY_0();//关闭电源
3055  00db 721b500f      	bres	_PD_ODR,#5
3056                     ; 238 					status_sync=0;
3058  00df 3f01          	clr	_status_sync
3059                     ; 239 					status_mode=MODE_SLEEP;
3061  00e1 3f00          	clr	_status_mode
3062                     ; 241 				break;
3064  00e3               L5302:
3065                     ; 246 }
3068  00e3 81            	ret
3071                     	bsct
3072  000d               L7402_count:
3073  000d 00000000      	dc.l	0
3113                     .const:	section	.text
3114  0000               L22:
3115  0000 0001d4c1      	dc.l	120001
3116  0004               L42:
3117  0004 00019a29      	dc.l	105001
3118                     ; 248 void BT_Mode_Ser(void)
3118                     ; 249 {
3119                     	switch	.text
3120  00e4               _BT_Mode_Ser:
3124                     ; 252 	switch(status_mode)
3126  00e4 b600          	ld	a,_status_mode
3128                     ; 313 		break;
3129  00e6 4a            	dec	a
3130  00e7 2758          	jreq	L1602
3131  00e9 4a            	dec	a
3132  00ea 2706          	jreq	L1502
3133  00ec 4a            	dec	a
3134  00ed 2742          	jreq	L7502
3135  00ef cc017a        	jra	L7012
3136  00f2               L1502:
3137                     ; 256 			switch(status_sync)
3139  00f2 b601          	ld	a,_status_sync
3141                     ; 275 				break;
3142  00f4 a007          	sub	a,#7
3143  00f6 2705          	jreq	L3502
3144  00f8 4a            	dec	a
3145  00f9 270c          	jreq	L5502
3146  00fb 207d          	jra	L7012
3147  00fd               L3502:
3148                     ; 260 					BT_EN_1();
3150  00fd 721c500f      	bset	_PD_ODR,#6
3151                     ; 261 					status_sync=8;
3153  0101 35080001      	mov	_status_sync,#8
3154                     ; 263 				break;
3156  0105 2073          	jra	L7012
3157  0107               L5502:
3158                     ; 267 					count++;//26us
3160  0107 ae000d        	ldw	x,#L7402_count
3161  010a a601          	ld	a,#1
3162  010c cd0000        	call	c_lgadc
3164                     ; 268 					if(count>120000)//等待关机声完全发出
3166  010f ae000d        	ldw	x,#L7402_count
3167  0112 cd0000        	call	c_ltor
3169  0115 ae0000        	ldw	x,#L22
3170  0118 cd0000        	call	c_lcmp
3172  011b 255d          	jrult	L7012
3173                     ; 270 						count=0;
3175  011d ae0000        	ldw	x,#0
3176  0120 bf0f          	ldw	L7402_count+2,x
3177  0122 ae0000        	ldw	x,#0
3178  0125 bf0d          	ldw	L7402_count,x
3179                     ; 271 						status_sync=0;
3181  0127 3f01          	clr	_status_sync
3182                     ; 272 						status_mode=MODE_PLAY;
3184  0129 35030000      	mov	_status_mode,#3
3185  012d 204b          	jra	L7012
3186  012f               L3112:
3187                     ; 278 		break;
3189  012f 2049          	jra	L7012
3190  0131               L7502:
3191                     ; 282 			BT_Bt_Ser();
3193  0131 ad48          	call	_BT_Bt_Ser
3195                     ; 283 			BT_Pair_Ser();
3197  0133 cd01c7        	call	_BT_Pair_Ser
3199                     ; 284 			BT_List_Ser();
3201  0136 cd0200        	call	_BT_List_Ser
3203                     ; 285 			BT_Call_Ser();
3205  0139 cd0279        	call	_BT_Call_Ser
3207                     ; 286 			BT_Hang_Ser();
3209  013c cd02b2        	call	_BT_Hang_Ser
3211                     ; 288 		break;
3213  013f 2039          	jra	L7012
3214  0141               L1602:
3215                     ; 292 			switch(status_sync)
3217  0141 b601          	ld	a,_status_sync
3219                     ; 310 				break;
3220  0143 a002          	sub	a,#2
3221  0145 2705          	jreq	L3602
3222  0147 4a            	dec	a
3223  0148 270c          	jreq	L5602
3224  014a 202e          	jra	L7012
3225  014c               L3602:
3226                     ; 296 					BT_EN_0();//关蓝牙
3228  014c 721d500f      	bres	_PD_ODR,#6
3229                     ; 297 					status_sync=3;
3231  0150 35030001      	mov	_status_sync,#3
3232                     ; 299 				break;
3234  0154 2024          	jra	L7012
3235  0156               L5602:
3236                     ; 303 					count++;
3238  0156 ae000d        	ldw	x,#L7402_count
3239  0159 a601          	ld	a,#1
3240  015b cd0000        	call	c_lgadc
3242                     ; 304 					if(count>105000)//等待关机声完全发出
3244  015e ae000d        	ldw	x,#L7402_count
3245  0161 cd0000        	call	c_ltor
3247  0164 ae0004        	ldw	x,#L42
3248  0167 cd0000        	call	c_lcmp
3250  016a 250e          	jrult	L7012
3251                     ; 306 						count=0;
3253  016c ae0000        	ldw	x,#0
3254  016f bf0f          	ldw	L7402_count+2,x
3255  0171 ae0000        	ldw	x,#0
3256  0174 bf0d          	ldw	L7402_count,x
3257                     ; 307 						status_sync=4;
3259  0176 35040001      	mov	_status_sync,#4
3260  017a               L1212:
3261                     ; 313 		break;
3263  017a               L7012:
3264                     ; 315 }
3267  017a 81            	ret
3270                     	bsct
3271  0011               L5212_status_input_old:
3272  0011 ff            	dc.b	255
3273  0012               L7212_count:
3274  0012 00000000      	dc.l	0
3275  0016               L1312_flag:
3276  0016 00            	dc.b	0
3328                     	switch	.const
3329  0008               L03:
3330  0008 0000080a      	dc.l	2058
3331                     ; 317 void BT_Bt_Ser(void)
3331                     ; 318 {
3332                     	switch	.text
3333  017b               _BT_Bt_Ser:
3337                     ; 323 	if(flag)
3339  017b 3d16          	tnz	L1312_flag
3340  017d 273a          	jreq	L5612
3341                     ; 325 		count++;//243us
3343  017f ae0012        	ldw	x,#L7212_count
3344  0182 a601          	ld	a,#1
3345  0184 cd0000        	call	c_lgadc
3347                     ; 326 		if(count>2057)//500ms=0.243*2057
3349  0187 ae0012        	ldw	x,#L7212_count
3350  018a cd0000        	call	c_ltor
3352  018d ae0008        	ldw	x,#L03
3353  0190 cd0000        	call	c_lcmp
3355  0193 2531          	jrult	L5712
3356                     ; 328 			count=0;
3358  0195 ae0000        	ldw	x,#0
3359  0198 bf14          	ldw	L7212_count+2,x
3360  019a ae0000        	ldw	x,#0
3361  019d bf12          	ldw	L7212_count,x
3362                     ; 329 			flag=0;
3364  019f 3f16          	clr	L1312_flag
3365                     ; 330 			switch(status_input_old)
3367  01a1 b611          	ld	a,L5212_status_input_old
3369                     ; 342 				break;	
3370  01a3 4d            	tnz	a
3371  01a4 2705          	jreq	L3312
3372  01a6 4a            	dec	a
3373  01a7 2708          	jreq	L5312
3374  01a9 201b          	jra	L5712
3375  01ab               L3312:
3376                     ; 334 					BT_EN_1();
3378  01ab 721c500f      	bset	_PD_ODR,#6
3379                     ; 336 				break;	
3381  01af 2015          	jra	L5712
3382  01b1               L5312:
3383                     ; 340 					BT_EN_0();
3385  01b1 721d500f      	bres	_PD_ODR,#6
3386                     ; 342 				break;	
3388  01b5 200f          	jra	L5712
3389  01b7               L3712:
3390  01b7 200d          	jra	L5712
3391  01b9               L5612:
3392                     ; 348 		if(status_input!=status_input_old)
3394  01b9 b603          	ld	a,_status_input
3395  01bb b111          	cp	a,L5212_status_input_old
3396  01bd 2707          	jreq	L5712
3397                     ; 350 			status_input_old=status_input;
3399  01bf 450311        	mov	L5212_status_input_old,_status_input
3400                     ; 351 			flag=1;
3402  01c2 35010016      	mov	L1312_flag,#1
3403  01c6               L5712:
3404                     ; 354 }
3407  01c6 81            	ret
3410                     	bsct
3411  0017               L1022_flag:
3412  0017 00            	dc.b	0
3413  0018               L3022_count:
3414  0018 00000000      	dc.l	0
3457                     	switch	.const
3458  000c               L43:
3459  000c 000003e9      	dc.l	1001
3460                     ; 356 void BT_Pair_Ser(void)
3460                     ; 357 {
3461                     	switch	.text
3462  01c7               _BT_Pair_Ser:
3466                     ; 361 	if(status_pair)
3468  01c7 3d04          	tnz	_status_pair
3469  01c9 2706          	jreq	L7222
3470                     ; 363 		status_pair=0;
3472  01cb 3f04          	clr	_status_pair
3473                     ; 364 		flag=1;
3475  01cd 35010017      	mov	L1022_flag,#1
3476  01d1               L7222:
3477                     ; 366 	if(flag)
3479  01d1 3d17          	tnz	L1022_flag
3480  01d3 272a          	jreq	L1322
3481                     ; 368 		BT_PAIR_1();
3483  01d5 7218500a      	bset	_PC_ODR,#4
3484                     ; 369 		count++;
3486  01d9 ae0018        	ldw	x,#L3022_count
3487  01dc a601          	ld	a,#1
3488  01de cd0000        	call	c_lgadc
3490                     ; 370 		if(count>1000)
3492  01e1 ae0018        	ldw	x,#L3022_count
3493  01e4 cd0000        	call	c_ltor
3495  01e7 ae000c        	ldw	x,#L43
3496  01ea cd0000        	call	c_lcmp
3498  01ed 2510          	jrult	L1322
3499                     ; 372 			count=0;
3501  01ef ae0000        	ldw	x,#0
3502  01f2 bf1a          	ldw	L3022_count+2,x
3503  01f4 ae0000        	ldw	x,#0
3504  01f7 bf18          	ldw	L3022_count,x
3505                     ; 373 			BT_PAIR_0();
3507  01f9 7219500a      	bres	_PC_ODR,#4
3508                     ; 374 			flag=0;
3510  01fd 3f17          	clr	L1022_flag
3511  01ff               L1322:
3512                     ; 377 }
3515  01ff 81            	ret
3518                     	bsct
3519  001c               L5322_flag1:
3520  001c 00            	dc.b	0
3521  001d               L7322_flag2:
3522  001d 00            	dc.b	0
3523  001e               L1422_count:
3524  001e 00000000      	dc.l	0
3576                     ; 379 void BT_List_Ser(void)
3576                     ; 380 {
3577                     	switch	.text
3578  0200               _BT_List_Ser:
3582                     ; 385 	switch(status_list)
3584  0200 b605          	ld	a,_status_list
3586                     ; 401 		break;
3587  0202 4a            	dec	a
3588  0203 2705          	jreq	L3422
3589  0205 4a            	dec	a
3590  0206 270c          	jreq	L5422
3591  0208 2012          	jra	L7722
3592  020a               L3422:
3593                     ; 389 			status_list=0;
3595  020a 3f05          	clr	_status_list
3596                     ; 390 			flag1=1;
3598  020c 3501001c      	mov	L5322_flag1,#1
3599                     ; 391 			flag2=0;
3601  0210 3f1d          	clr	L7322_flag2
3602                     ; 393 		break;
3604  0212 2008          	jra	L7722
3605  0214               L5422:
3606                     ; 397 			status_list=0;
3608  0214 3f05          	clr	_status_list
3609                     ; 398 			flag1=0;
3611  0216 3f1c          	clr	L5322_flag1
3612                     ; 399 			flag2=1;
3614  0218 3501001d      	mov	L7322_flag2,#1
3615                     ; 401 		break;
3617  021c               L7722:
3618                     ; 403 	if(flag1)
3620  021c 3d1c          	tnz	L5322_flag1
3621  021e 272a          	jreq	L1032
3622                     ; 405 		BT_PREV_1();
3624  0220 721e500a      	bset	_PC_ODR,#7
3625                     ; 406 		count++;
3627  0224 ae001e        	ldw	x,#L1422_count
3628  0227 a601          	ld	a,#1
3629  0229 cd0000        	call	c_lgadc
3631                     ; 407 		if(count>1000)
3633  022c ae001e        	ldw	x,#L1422_count
3634  022f cd0000        	call	c_ltor
3636  0232 ae000c        	ldw	x,#L43
3637  0235 cd0000        	call	c_lcmp
3639  0238 2510          	jrult	L1032
3640                     ; 409 			count=0;
3642  023a ae0000        	ldw	x,#0
3643  023d bf20          	ldw	L1422_count+2,x
3644  023f ae0000        	ldw	x,#0
3645  0242 bf1e          	ldw	L1422_count,x
3646                     ; 410 			flag1=0;
3648  0244 3f1c          	clr	L5322_flag1
3649                     ; 411 			BT_PREV_0();			
3651  0246 721f500a      	bres	_PC_ODR,#7
3652  024a               L1032:
3653                     ; 414 	if(flag2)
3655  024a 3d1d          	tnz	L7322_flag2
3656  024c 272a          	jreq	L5032
3657                     ; 416 		BT_NEXT_1();
3659  024e 721a500a      	bset	_PC_ODR,#5
3660                     ; 417 		count++;
3662  0252 ae001e        	ldw	x,#L1422_count
3663  0255 a601          	ld	a,#1
3664  0257 cd0000        	call	c_lgadc
3666                     ; 418 		if(count>1000)
3668  025a ae001e        	ldw	x,#L1422_count
3669  025d cd0000        	call	c_ltor
3671  0260 ae000c        	ldw	x,#L43
3672  0263 cd0000        	call	c_lcmp
3674  0266 2510          	jrult	L5032
3675                     ; 420 			count=0;
3677  0268 ae0000        	ldw	x,#0
3678  026b bf20          	ldw	L1422_count+2,x
3679  026d ae0000        	ldw	x,#0
3680  0270 bf1e          	ldw	L1422_count,x
3681                     ; 421 			flag2=0;
3683  0272 3f1d          	clr	L7322_flag2
3684                     ; 422 			BT_NEXT_0();
3686  0274 721b500a      	bres	_PC_ODR,#5
3687  0278               L5032:
3688                     ; 425 }
3691  0278 81            	ret
3694                     	bsct
3695  0022               L1132_flag:
3696  0022 00            	dc.b	0
3697  0023               L3132_count:
3698  0023 00000000      	dc.l	0
3741                     ; 427 void BT_Call_Ser(void)
3741                     ; 428 {
3742                     	switch	.text
3743  0279               _BT_Call_Ser:
3747                     ; 432 	if(status_call)
3749  0279 3d06          	tnz	_status_call
3750  027b 2706          	jreq	L7332
3751                     ; 434 		status_call=0;
3753  027d 3f06          	clr	_status_call
3754                     ; 435 		flag=1;
3756  027f 35010022      	mov	L1132_flag,#1
3757  0283               L7332:
3758                     ; 437 	if(flag)
3760  0283 3d22          	tnz	L1132_flag
3761  0285 272a          	jreq	L1432
3762                     ; 439 		BT_CALL_1();
3764  0287 721c500a      	bset	_PC_ODR,#6
3765                     ; 440 		count++;
3767  028b ae0023        	ldw	x,#L3132_count
3768  028e a601          	ld	a,#1
3769  0290 cd0000        	call	c_lgadc
3771                     ; 441 		if(count>1000)
3773  0293 ae0023        	ldw	x,#L3132_count
3774  0296 cd0000        	call	c_ltor
3776  0299 ae000c        	ldw	x,#L43
3777  029c cd0000        	call	c_lcmp
3779  029f 2510          	jrult	L1432
3780                     ; 443 			count=0;
3782  02a1 ae0000        	ldw	x,#0
3783  02a4 bf25          	ldw	L3132_count+2,x
3784  02a6 ae0000        	ldw	x,#0
3785  02a9 bf23          	ldw	L3132_count,x
3786                     ; 444 			BT_CALL_0();
3788  02ab 721d500a      	bres	_PC_ODR,#6
3789                     ; 445 			flag=0;
3791  02af 3f22          	clr	L1132_flag
3792  02b1               L1432:
3793                     ; 448 }
3796  02b1 81            	ret
3799                     	bsct
3800  0027               L5432_flag:
3801  0027 00            	dc.b	0
3802  0028               L7432_count:
3803  0028 00000000      	dc.l	0
3846                     	switch	.const
3847  0010               L44:
3848  0010 00002711      	dc.l	10001
3849                     ; 450 void BT_Hang_Ser(void)
3849                     ; 451 {
3850                     	switch	.text
3851  02b2               _BT_Hang_Ser:
3855                     ; 455 	if(status_hang)
3857  02b2 3d08          	tnz	_status_hang
3858  02b4 2706          	jreq	L3732
3859                     ; 457 		status_hang=0;
3861  02b6 3f08          	clr	_status_hang
3862                     ; 458 		flag=1;
3864  02b8 35010027      	mov	L5432_flag,#1
3865  02bc               L3732:
3866                     ; 460 	if(flag)
3868  02bc 3d27          	tnz	L5432_flag
3869  02be 272a          	jreq	L5732
3870                     ; 462 		BT_CALL_1();
3872  02c0 721c500a      	bset	_PC_ODR,#6
3873                     ; 463 		count++;
3875  02c4 ae0028        	ldw	x,#L7432_count
3876  02c7 a601          	ld	a,#1
3877  02c9 cd0000        	call	c_lgadc
3879                     ; 464 		if(count>10000)
3881  02cc ae0028        	ldw	x,#L7432_count
3882  02cf cd0000        	call	c_ltor
3884  02d2 ae0010        	ldw	x,#L44
3885  02d5 cd0000        	call	c_lcmp
3887  02d8 2510          	jrult	L5732
3888                     ; 466 			count=0;
3890  02da ae0000        	ldw	x,#0
3891  02dd bf2a          	ldw	L7432_count+2,x
3892  02df ae0000        	ldw	x,#0
3893  02e2 bf28          	ldw	L7432_count,x
3894                     ; 467 			BT_CALL_0();
3896  02e4 721d500a      	bres	_PC_ODR,#6
3897                     ; 468 			flag=0;
3899  02e8 3f27          	clr	L5432_flag
3900  02ea               L5732:
3901                     ; 471 }
3904  02ea 81            	ret
3907                     	bsct
3908  002c               L1042_count:
3909  002c 00000000      	dc.l	0
3953                     ; 473 void NPCA110_Mode_Ser(void)
3953                     ; 474 {
3954                     	switch	.text
3955  02eb               _NPCA110_Mode_Ser:
3959                     ; 477 	switch(status_mode)
3961  02eb b600          	ld	a,_status_mode
3963                     ; 587 		break;
3964  02ed 4a            	dec	a
3965  02ee 2603          	jrne	L05
3966  02f0 cc03a0        	jp	L3242
3967  02f3               L05:
3968  02f3 4a            	dec	a
3969  02f4 270a          	jreq	L3042
3970  02f6 4a            	dec	a
3971  02f7 2603          	jrne	L25
3972  02f9 cc0399        	jp	L1242
3973  02fc               L25:
3974  02fc ac120412      	jpf	L5542
3975  0300               L3042:
3976                     ; 481 			switch(status_sync)
3978  0300 b601          	ld	a,_status_sync
3980                     ; 533 				break;
3981  0302 4a            	dec	a
3982  0303 270e          	jreq	L5042
3983  0305 4a            	dec	a
3984  0306 2730          	jreq	L3142
3985  0308 a003          	sub	a,#3
3986  030a 2757          	jreq	L5142
3987  030c 4a            	dec	a
3988  030d 275f          	jreq	L7142
3989  030f ac120412      	jpf	L5542
3990  0313               L5042:
3991                     ; 485 					NPCA110_WriteCofig();
3993  0313 cd0000        	call	_NPCA110_WriteCofig
3995                     ; 486 					NPCA110_WriteVolume(status_volume);
3997  0316 b602          	ld	a,_status_volume
3998  0318 cd0000        	call	_NPCA110_WriteVolume
4000                     ; 487 					switch(status_input)
4002  031b b603          	ld	a,_status_input
4004                     ; 499 						break;
4005  031d 4d            	tnz	a
4006  031e 2705          	jreq	L7042
4007  0320 4a            	dec	a
4008  0321 2707          	jreq	L1142
4009  0323 2008          	jra	L5642
4010  0325               L7042:
4011                     ; 491 							NPCA110_WriteDig();
4013  0325 cd0000        	call	_NPCA110_WriteDig
4015                     ; 493 						break;
4017  0328 2003          	jra	L5642
4018  032a               L1142:
4019                     ; 497 							NPCA110_WriteAn1();
4021  032a cd0000        	call	_NPCA110_WriteAn1
4023                     ; 499 						break;
4025  032d               L5642:
4026                     ; 501 					NPCA110_WriteMute();
4028  032d cd0000        	call	_NPCA110_WriteMute
4030                     ; 502 					status_sync=2;
4032  0330 35020001      	mov	_status_sync,#2
4033                     ; 504 				break;
4035  0334 ac120412      	jpf	L5542
4036  0338               L3142:
4037                     ; 508 					count++;
4039  0338 ae002c        	ldw	x,#L1042_count
4040  033b a601          	ld	a,#1
4041  033d cd0000        	call	c_lgadc
4043                     ; 509 					if(count>1000)
4045  0340 ae002c        	ldw	x,#L1042_count
4046  0343 cd0000        	call	c_ltor
4048  0346 ae000c        	ldw	x,#L43
4049  0349 cd0000        	call	c_lcmp
4051  034c 2403          	jruge	L45
4052  034e cc0412        	jp	L5542
4053  0351               L45:
4054                     ; 511 						count=0;
4056  0351 ae0000        	ldw	x,#0
4057  0354 bf2e          	ldw	L1042_count+2,x
4058  0356 ae0000        	ldw	x,#0
4059  0359 bf2c          	ldw	L1042_count,x
4060                     ; 512 						status_sync=3;
4062  035b 35030001      	mov	_status_sync,#3
4063  035f ac120412      	jpf	L5542
4064  0363               L5142:
4065                     ; 519 					NPCA110_WriteNMute();
4067  0363 cd0000        	call	_NPCA110_WriteNMute
4069                     ; 520 					status_sync=6;
4071  0366 35060001      	mov	_status_sync,#6
4072                     ; 522 				break;
4074  036a ac120412      	jpf	L5542
4075  036e               L7142:
4076                     ; 526 					count++;
4078  036e ae002c        	ldw	x,#L1042_count
4079  0371 a601          	ld	a,#1
4080  0373 cd0000        	call	c_lgadc
4082                     ; 527 					if(count>1000)
4084  0376 ae002c        	ldw	x,#L1042_count
4085  0379 cd0000        	call	c_ltor
4087  037c ae000c        	ldw	x,#L43
4088  037f cd0000        	call	c_lcmp
4090  0382 2403          	jruge	L65
4091  0384 cc0412        	jp	L5542
4092  0387               L65:
4093                     ; 529 						count=0;
4095  0387 ae0000        	ldw	x,#0
4096  038a bf2e          	ldw	L1042_count+2,x
4097  038c ae0000        	ldw	x,#0
4098  038f bf2c          	ldw	L1042_count,x
4099                     ; 530 						status_sync=7;
4101  0391 35070001      	mov	_status_sync,#7
4102  0395 207b          	jra	L5542
4103  0397               L1642:
4104                     ; 536 		break;
4106  0397 2079          	jra	L5542
4107  0399               L1242:
4108                     ; 540 			NPCA110_Volume_Ser();
4110  0399 ad78          	call	_NPCA110_Volume_Ser
4112                     ; 541 			NPCA110_Input_Ser();
4114  039b cd042e        	call	_NPCA110_Input_Ser
4116                     ; 543 		break;
4118  039e 2072          	jra	L5542
4119  03a0               L3242:
4120                     ; 547 			switch(status_sync)
4122  03a0 b601          	ld	a,_status_sync
4124                     ; 584 				break;
4125  03a2 4d            	tnz	a
4126  03a3 270c          	jreq	L5242
4127  03a5 4a            	dec	a
4128  03a6 2717          	jreq	L7242
4129  03a8 a005          	sub	a,#5
4130  03aa 2739          	jreq	L1342
4131  03ac 4a            	dec	a
4132  03ad 273f          	jreq	L3342
4133  03af 2061          	jra	L5542
4134  03b1               L5242:
4135                     ; 551 					NPCA110_WriteNMute();
4137  03b1 cd0000        	call	_NPCA110_WriteNMute
4139                     ; 552 					NPCA110_WriteVolume(6);//0db关机声
4141  03b4 a606          	ld	a,#6
4142  03b6 cd0000        	call	_NPCA110_WriteVolume
4144                     ; 553 					status_sync=1;
4146  03b9 35010001      	mov	_status_sync,#1
4147                     ; 555 				break;
4149  03bd 2053          	jra	L5542
4150  03bf               L7242:
4151                     ; 559 					count++;
4153  03bf ae002c        	ldw	x,#L1042_count
4154  03c2 a601          	ld	a,#1
4155  03c4 cd0000        	call	c_lgadc
4157                     ; 560 					if(count>1000)
4159  03c7 ae002c        	ldw	x,#L1042_count
4160  03ca cd0000        	call	c_ltor
4162  03cd ae000c        	ldw	x,#L43
4163  03d0 cd0000        	call	c_lcmp
4165  03d3 253d          	jrult	L5542
4166                     ; 562 						count=0;
4168  03d5 ae0000        	ldw	x,#0
4169  03d8 bf2e          	ldw	L1042_count+2,x
4170  03da ae0000        	ldw	x,#0
4171  03dd bf2c          	ldw	L1042_count,x
4172                     ; 563 						status_sync=2;
4174  03df 35020001      	mov	_status_sync,#2
4175  03e3 202d          	jra	L5542
4176  03e5               L1342:
4177                     ; 570 					NPCA110_WriteMute();
4179  03e5 cd0000        	call	_NPCA110_WriteMute
4181                     ; 571 					status_sync=7;
4183  03e8 35070001      	mov	_status_sync,#7
4184                     ; 573 				break;
4186  03ec 2024          	jra	L5542
4187  03ee               L3342:
4188                     ; 577 					count++;
4190  03ee ae002c        	ldw	x,#L1042_count
4191  03f1 a601          	ld	a,#1
4192  03f3 cd0000        	call	c_lgadc
4194                     ; 578 					if(count>1000)
4196  03f6 ae002c        	ldw	x,#L1042_count
4197  03f9 cd0000        	call	c_ltor
4199  03fc ae000c        	ldw	x,#L43
4200  03ff cd0000        	call	c_lcmp
4202  0402 250e          	jrult	L5542
4203                     ; 580 						count=0;
4205  0404 ae0000        	ldw	x,#0
4206  0407 bf2e          	ldw	L1042_count+2,x
4207  0409 ae0000        	ldw	x,#0
4208  040c bf2c          	ldw	L1042_count,x
4209                     ; 581 						status_sync=8;
4211  040e 35080001      	mov	_status_sync,#8
4212  0412               L5742:
4213                     ; 587 		break;
4215  0412               L5542:
4216                     ; 589 }
4219  0412 81            	ret
4222                     	bsct
4223  0030               L3052_status_volume_old:
4224  0030 ff            	dc.b	255
4260                     ; 591 void NPCA110_Volume_Ser(void)
4260                     ; 592 {
4261                     	switch	.text
4262  0413               _NPCA110_Volume_Ser:
4266                     ; 595 	if(status_volume!=status_volume_old)
4268  0413 b602          	ld	a,_status_volume
4269  0415 b130          	cp	a,L3052_status_volume_old
4270  0417 2714          	jreq	L3252
4271                     ; 597 		status_volume_old=status_volume;
4273  0419 450230        	mov	L3052_status_volume_old,_status_volume
4274                     ; 598 		if(status_volume_old)
4276  041c 3d30          	tnz	L3052_status_volume_old
4277  041e 270a          	jreq	L5252
4278                     ; 600 			NPCA110_WriteVolume(status_volume_old);
4280  0420 b630          	ld	a,L3052_status_volume_old
4281  0422 cd0000        	call	_NPCA110_WriteVolume
4283                     ; 601 			NPCA110_WriteNMute();
4285  0425 cd0000        	call	_NPCA110_WriteNMute
4288  0428 2003          	jra	L3252
4289  042a               L5252:
4290                     ; 605 			NPCA110_WriteMute();
4292  042a cd0000        	call	_NPCA110_WriteMute
4294  042d               L3252:
4295                     ; 608 }
4298  042d 81            	ret
4301                     	bsct
4302  0031               L1352_npca110_aux_old:
4303  0031 ff            	dc.b	255
4340                     ; 610 void NPCA110_Input_Ser(void)
4340                     ; 611 {
4341                     	switch	.text
4342  042e               _NPCA110_Input_Ser:
4346                     ; 614 	NPCA110_AuxScan_Ser();
4348  042e cd0000        	call	_NPCA110_AuxScan_Ser
4350                     ; 615 	if(npca110_aux!=npca110_aux_old)
4352  0431 b600          	ld	a,_npca110_aux
4353  0433 b131          	cp	a,L1352_npca110_aux_old
4354  0435 2718          	jreq	L5552
4355                     ; 617 		npca110_aux_old=npca110_aux;
4357  0437 450031        	mov	L1352_npca110_aux_old,_npca110_aux
4358                     ; 618 		status_input=npca110_aux_old;
4360  043a 453103        	mov	_status_input,L1352_npca110_aux_old
4361                     ; 619 		switch(npca110_aux_old)
4363  043d b631          	ld	a,L1352_npca110_aux_old
4365                     ; 631 			break;
4366  043f 4d            	tnz	a
4367  0440 2705          	jreq	L3352
4368  0442 4a            	dec	a
4369  0443 2707          	jreq	L5352
4370  0445 2008          	jra	L5552
4371  0447               L3352:
4372                     ; 623 				NPCA110_WriteDig();
4374  0447 cd0000        	call	_NPCA110_WriteDig
4376                     ; 625 			break;
4378  044a 2003          	jra	L5552
4379  044c               L5352:
4380                     ; 629 				NPCA110_WriteAn1();
4382  044c cd0000        	call	_NPCA110_WriteAn1
4384                     ; 631 			break;
4386  044f               L1652:
4387  044f               L5552:
4388                     ; 634 }
4391  044f 81            	ret
4394                     	bsct
4395  0032               L3652_count:
4396  0032 00000000      	dc.l	0
4431                     ; 636 void TPA3130_Mode_Ser(void)
4431                     ; 637 {	
4432                     	switch	.text
4433  0450               _TPA3130_Mode_Ser:
4437                     ; 640 	switch(status_mode)
4439  0450 b600          	ld	a,_status_mode
4441                     ; 690 		break;
4442  0452 4a            	dec	a
4443  0453 2740          	jreq	L3752
4444  0455 4a            	dec	a
4445  0456 2676          	jrne	L1262
4446                     ; 644 			switch(status_sync)
4448  0458 b601          	ld	a,_status_sync
4450                     ; 662 				break;
4451  045a a003          	sub	a,#3
4452  045c 2705          	jreq	L7652
4453  045e 4a            	dec	a
4454  045f 270c          	jreq	L1752
4455  0461 206b          	jra	L1262
4456  0463               L7652:
4457                     ; 648 					TPA3130_UMUTE_1();//取消静音
4459  0463 7218500f      	bset	_PD_ODR,#4
4460                     ; 649 					status_sync=4;
4462  0467 35040001      	mov	_status_sync,#4
4463                     ; 651 				break;
4465  046b 2061          	jra	L1262
4466  046d               L1752:
4467                     ; 655 					count++;
4469  046d ae0032        	ldw	x,#L3652_count
4470  0470 a601          	ld	a,#1
4471  0472 cd0000        	call	c_lgadc
4473                     ; 656 					if(count>1000)
4475  0475 ae0032        	ldw	x,#L3652_count
4476  0478 cd0000        	call	c_ltor
4478  047b ae000c        	ldw	x,#L43
4479  047e cd0000        	call	c_lcmp
4481  0481 254b          	jrult	L1262
4482                     ; 658 						count=0;
4484  0483 ae0000        	ldw	x,#0
4485  0486 bf34          	ldw	L3652_count+2,x
4486  0488 ae0000        	ldw	x,#0
4487  048b bf32          	ldw	L3652_count,x
4488                     ; 659 						status_sync=5;
4490  048d 35050001      	mov	_status_sync,#5
4491  0491 203b          	jra	L1262
4492  0493               L5262:
4493                     ; 665 		break;
4495  0493 2039          	jra	L1262
4496  0495               L3752:
4497                     ; 669 			switch(status_sync)
4499  0495 b601          	ld	a,_status_sync
4501                     ; 687 				break;
4502  0497 a004          	sub	a,#4
4503  0499 2705          	jreq	L5752
4504  049b 4a            	dec	a
4505  049c 270c          	jreq	L7752
4506  049e 202e          	jra	L1262
4507  04a0               L5752:
4508                     ; 673 					TPA3130_UMUTE_0();//静音
4510  04a0 7219500f      	bres	_PD_ODR,#4
4511                     ; 674 					status_sync=5;
4513  04a4 35050001      	mov	_status_sync,#5
4514                     ; 676 				break;
4516  04a8 2024          	jra	L1262
4517  04aa               L7752:
4518                     ; 680 					count++;
4520  04aa ae0032        	ldw	x,#L3652_count
4521  04ad a601          	ld	a,#1
4522  04af cd0000        	call	c_lgadc
4524                     ; 681 					if(count>1000)//等待静音
4526  04b2 ae0032        	ldw	x,#L3652_count
4527  04b5 cd0000        	call	c_ltor
4529  04b8 ae000c        	ldw	x,#L43
4530  04bb cd0000        	call	c_lcmp
4532  04be 250e          	jrult	L1262
4533                     ; 683 						count=0;
4535  04c0 ae0000        	ldw	x,#0
4536  04c3 bf34          	ldw	L3652_count+2,x
4537  04c5 ae0000        	ldw	x,#0
4538  04c8 bf32          	ldw	L3652_count,x
4539                     ; 684 						status_sync=6;
4541  04ca 35060001      	mov	_status_sync,#6
4542  04ce               L3362:
4543                     ; 690 		break;
4545  04ce               L1262:
4546                     ; 692 }
4549  04ce 81            	ret
4575                     ; 694 void NJM7181_Mode_Ser(void)
4575                     ; 695 {
4576                     	switch	.text
4577  04cf               _NJM7181_Mode_Ser:
4581                     ; 696 	switch(status_mode)
4583  04cf b600          	ld	a,_status_mode
4584  04d1 a103          	cp	a,#3
4585  04d3 260d          	jrne	L3562
4588  04d5               L7362:
4589                     ; 700 			NJM7181_Nsignal_Ser();
4591  04d5 cd0000        	call	_NJM7181_Nsignal_Ser
4593                     ; 701 			if(njm7181_sleep)
4595  04d8 3d00          	tnz	_njm7181_sleep
4596  04da 2706          	jreq	L3562
4597                     ; 703 				njm7181_sleep=0;
4599  04dc 3f00          	clr	_njm7181_sleep
4600                     ; 704 				status_mode=MODE_OFF;
4602  04de 35010000      	mov	_status_mode,#1
4603  04e2               L3562:
4604                     ; 709 }
4607  04e2 81            	ret
4632                     ; 711 void BAT_Mode_Ser(void)
4632                     ; 712 {
4633                     	switch	.text
4634  04e3               _BAT_Mode_Ser:
4638                     ; 713 	switch(status_mode)
4640  04e3 b600          	ld	a,_status_mode
4641  04e5 a103          	cp	a,#3
4642  04e7 2602          	jrne	L3762
4645  04e9               L7562:
4646                     ; 717 			BAT_Low_Ser();
4648  04e9 ad01          	call	_BAT_Low_Ser
4650                     ; 719 		break;
4652  04eb               L3762:
4653                     ; 721 }
4656  04eb 81            	ret
4659                     	bsct
4660  0036               L5762_bat_low_old:
4661  0036 ff            	dc.b	255
4696                     ; 723 void BAT_Low_Ser(void)
4696                     ; 724 {
4697                     	switch	.text
4698  04ec               _BAT_Low_Ser:
4702                     ; 727 	BAT_VoltageScan_Ser();
4704  04ec cd0000        	call	_BAT_VoltageScan_Ser
4706                     ; 728 	if(bat_style!=bat_low_old)
4708  04ef b600          	ld	a,_bat_style
4709  04f1 b136          	cp	a,L5762_bat_low_old
4710  04f3 2706          	jreq	L5172
4711                     ; 730 		bat_low_old=bat_style;
4713  04f5 450036        	mov	L5762_bat_low_old,_bat_style
4714                     ; 731 		status_low=bat_low_old;
4716  04f8 453607        	mov	_status_low,L5762_bat_low_old
4717  04fb               L5172:
4718                     ; 733 }
4721  04fb 81            	ret
4747                     ; 735 void LED_Low_Ser(void)
4747                     ; 736 {	
4748                     	switch	.text
4749  04fc               _LED_Low_Ser:
4753                     ; 737 	if(status_low)
4755  04fc 3d07          	tnz	_status_low
4756  04fe 2705          	jreq	L7272
4757                     ; 739 		LED_Flash_Ser();
4759  0500 cd0000        	call	_LED_Flash_Ser
4762  0503 2004          	jra	L1372
4763  0505               L7272:
4764                     ; 743 		LED_BAT_1();
4766  0505 7212500f      	bset	_PD_ODR,#1
4767  0509               L1372:
4768                     ; 745 }
4771  0509 81            	ret
4796                     ; 747 void LED_Mode_Ser(void)
4796                     ; 748 {
4797                     	switch	.text
4798  050a               _LED_Mode_Ser:
4802                     ; 749 	switch(status_mode)
4804  050a b600          	ld	a,_status_mode
4805  050c a103          	cp	a,#3
4806  050e 2602          	jrne	L7472
4809  0510               L3372:
4810                     ; 753 			LED_Low_Ser();
4812  0510 adea          	call	_LED_Low_Ser
4814                     ; 755 		break;
4816  0512               L7472:
4817                     ; 757 }
4820  0512 81            	ret
4860                     ; 759 void main(void)
4860                     ; 760 {	
4861                     	switch	.text
4862  0513               _main:
4866                     ; 761 	CLK_CKDIVR=0x08;//8M	
4868  0513 350850c6      	mov	_CLK_CKDIVR,#8
4869                     ; 763 	KEY_Init();
4871  0517 cd0000        	call	_KEY_Init
4873                     ; 764 	POWER_Init();
4875  051a cd0000        	call	_POWER_Init
4877                     ; 765 	BT_Init();
4879  051d cd0000        	call	_BT_Init
4881                     ; 766 	NPCA110_Init();
4883  0520 cd0000        	call	_NPCA110_Init
4885                     ; 767 	TPA3130_Init();
4887  0523 cd0000        	call	_TPA3130_Init
4889                     ; 768 	NJM7181_Init();
4891  0526 cd0000        	call	_NJM7181_Init
4893                     ; 769 	BAT_Init();
4895  0529 cd0000        	call	_BAT_Init
4897                     ; 770 	LED_Init();
4899  052c cd0000        	call	_LED_Init
4901  052f               L1672:
4902                     ; 775 		KEY_Mode_Ser();
4904  052f cd0000        	call	_KEY_Mode_Ser
4906                     ; 777 		POWER_Mode_Ser();
4908  0532 cd00bf        	call	_POWER_Mode_Ser
4910                     ; 779 		BT_Mode_Ser();
4912  0535 cd00e4        	call	_BT_Mode_Ser
4914                     ; 781 		NPCA110_Mode_Ser();
4916  0538 cd02eb        	call	_NPCA110_Mode_Ser
4918                     ; 783 		TPA3130_Mode_Ser();
4920  053b cd0450        	call	_TPA3130_Mode_Ser
4922                     ; 785 		NJM7181_Mode_Ser();
4924  053e ad8f          	call	_NJM7181_Mode_Ser
4926                     ; 787 		BAT_Mode_Ser();
4928  0540 ada1          	call	_BAT_Mode_Ser
4930                     ; 789 		LED_Mode_Ser();
4932  0542 adc6          	call	_LED_Mode_Ser
4935  0544 20e9          	jra	L1672
5031                     	xdef	_main
5032                     	xdef	_LED_Low_Ser
5033                     	xdef	_LED_Mode_Ser
5034                     	xdef	_BAT_Low_Ser
5035                     	xdef	_BAT_Mode_Ser
5036                     	xdef	_NJM7181_Mode_Ser
5037                     	xdef	_TPA3130_Mode_Ser
5038                     	xdef	_NPCA110_Input_Ser
5039                     	xdef	_NPCA110_Volume_Ser
5040                     	xdef	_NPCA110_Mode_Ser
5041                     	xdef	_BT_Hang_Ser
5042                     	xdef	_BT_Call_Ser
5043                     	xdef	_BT_List_Ser
5044                     	xdef	_BT_Pair_Ser
5045                     	xdef	_BT_Bt_Ser
5046                     	xdef	_BT_Mode_Ser
5047                     	xdef	_POWER_Mode_Ser
5048                     	xdef	_KEY_Call_Ser
5049                     	xdef	_KEY_List_Ser
5050                     	xdef	_KEY_Pair_Ser
5051                     	xdef	_KEY_Volume_Ser
5052                     	xdef	_KEY_Mode_Ser
5053                     	xdef	_status_hang
5054                     	xdef	_status_low
5055                     	xdef	_status_call
5056                     	xdef	_status_list
5057                     	xdef	_status_pair
5058                     	xdef	_status_input
5059                     	xdef	_status_volume
5060                     	xdef	_status_sync
5061                     	xdef	_status_mode
5062                     	xref	_LED_Flash_Ser
5063                     	xref	_LED_Init
5064                     	xref	_BAT_VoltageScan_Ser
5065                     	xref	_BAT_Init
5066                     	xref.b	_bat_style
5067                     	xref	_NJM7181_Nsignal_Ser
5068                     	xref	_NJM7181_Init
5069                     	xref.b	_njm7181_sleep
5070                     	xref	_POWER_Init
5071                     	xref	_KEY_PAIR_Scan_Ser
5072                     	xref	_KEY_CALL_Scan_Ser
5073                     	xref	_KEY_DOWN_Scan_Ser
5074                     	xref	_KEY_UP_Scan_Ser
5075                     	xref	_KEY_STBY_Scan_Ser
5076                     	xref	_KEY_Init
5077                     	xref.b	_key_style
5078                     	xref.b	_key_stby_t
5079                     	xref	_TPA3130_Init
5080                     	xref	_NPCA110_WriteNMute
5081                     	xref	_NPCA110_WriteMute
5082                     	xref	_NPCA110_WriteVolume
5083                     	xref	_NPCA110_WriteDig
5084                     	xref	_NPCA110_WriteAn1
5085                     	xref	_NPCA110_AuxScan_Ser
5086                     	xref	_NPCA110_WriteCofig
5087                     	xref	_NPCA110_Init
5088                     	xref.b	_npca110_aux
5089                     	xref	_BT_Init
5108                     	xref	c_lcmp
5109                     	xref	c_ltor
5110                     	xref	c_lgadc
5111                     	end
