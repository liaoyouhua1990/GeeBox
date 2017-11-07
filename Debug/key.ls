   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _key_stby_t:
2536  0000 0000          	dc.w	0
2537  0002               _key_style:
2538  0002 00            	dc.b	0
2570                     ; 7 void KEY_Init(void)
2570                     ; 8 {	
2572                     	switch	.text
2573  0000               _KEY_Init:
2577                     ; 9 	PA_DDR&=~(1<<1);
2579  0000 72135002      	bres	_PA_DDR,#1
2580                     ; 10 	PA_CR1|=(1<<1);
2582  0004 72125003      	bset	_PA_CR1,#1
2583                     ; 12 	ADC_Init();
2585  0008 cd0000        	call	_ADC_Init
2587                     ; 13 }
2590  000b 81            	ret
2593                     	bsct
2594  0003               L1561_key_down_1:
2595  0003 00            	dc.b	0
2596  0004               L3561_count1:
2597  0004 0000          	dc.w	0
2598  0006               L5561_count2:
2599  0006 0000          	dc.w	0
2600  0008               L7561_flag1:
2601  0008 00            	dc.b	0
2602  0009               L1661_flag2:
2603  0009 01            	dc.b	1
2674                     ; 15 void KEY_STBY_Scan_Ser(void)
2674                     ; 16 {
2675                     	switch	.text
2676  000c               _KEY_STBY_Scan_Ser:
2680                     ; 23 	if(key_down_1)
2682  000c 3d03          	tnz	L1561_key_down_1
2683  000e 273c          	jreq	L1271
2684                     ; 25 		count2++;//20us
2686  0010 be06          	ldw	x,L5561_count2
2687  0012 1c0001        	addw	x,#1
2688  0015 bf06          	ldw	L5561_count2,x
2689                     ; 26 		if(count2>key_stby_t)
2691  0017 be06          	ldw	x,L5561_count2
2692  0019 b300          	cpw	x,_key_stby_t
2693  001b 2311          	jrule	L3271
2694                     ; 28 			count2=0;
2696  001d 5f            	clrw	x
2697  001e bf06          	ldw	L5561_count2,x
2698                     ; 29 			if(flag2)
2700  0020 3d09          	tnz	L1661_flag2
2701  0022 270a          	jreq	L3271
2702                     ; 31 				flag2=0;
2704  0024 3f09          	clr	L1661_flag2
2705                     ; 32 				key_style=KEY_STBY_L;
2707  0026 35060002      	mov	_key_style,#6
2708                     ; 33 				flag1=1;
2710  002a 35010008      	mov	L7561_flag1,#1
2711  002e               L3271:
2712                     ; 36 		if(KEY_STBY)
2714  002e c65001        	ld	a,_PA_IDR
2715  0031 a502          	bcp	a,#2
2716  0033 273f          	jreq	L5371
2717                     ; 38 			key_down_1=0;	
2719  0035 3f03          	clr	L1561_key_down_1
2720                     ; 39 			count2=0;
2722  0037 5f            	clrw	x
2723  0038 bf06          	ldw	L5561_count2,x
2724                     ; 40 			flag2=1;
2726  003a 35010009      	mov	L1661_flag2,#1
2727                     ; 41 			if(flag1)
2729  003e 3d08          	tnz	L7561_flag1
2730  0040 2704          	jreq	L1371
2731                     ; 43 				flag1=0;
2733  0042 3f08          	clr	L7561_flag1
2735  0044 202e          	jra	L5371
2736  0046               L1371:
2737                     ; 47 				key_style=KEY_STBY_S;
2739  0046 35050002      	mov	_key_style,#5
2740  004a 2028          	jra	L5371
2741  004c               L1271:
2742                     ; 53 		if(KEY_STBY==0)
2744  004c c65001        	ld	a,_PA_IDR
2745  004f a502          	bcp	a,#2
2746  0051 261e          	jrne	L7371
2747                     ; 55 			count1++;
2749  0053 be04          	ldw	x,L3561_count1
2750  0055 1c0001        	addw	x,#1
2751  0058 bf04          	ldw	L3561_count1,x
2752                     ; 56 			if(count1>500)
2754  005a be04          	ldw	x,L3561_count1
2755  005c a301f5        	cpw	x,#501
2756  005f 2513          	jrult	L5371
2757                     ; 58 				count1=0;
2759  0061 5f            	clrw	x
2760  0062 bf04          	ldw	L3561_count1,x
2761                     ; 59 				if(KEY_STBY==0)
2763  0064 c65001        	ld	a,_PA_IDR
2764  0067 a502          	bcp	a,#2
2765  0069 2609          	jrne	L5371
2766                     ; 61 					key_down_1=1;
2768  006b 35010003      	mov	L1561_key_down_1,#1
2769  006f 2003          	jra	L5371
2770  0071               L7371:
2771                     ; 67 			count1=0;
2773  0071 5f            	clrw	x
2774  0072 bf04          	ldw	L3561_count1,x
2775  0074               L5371:
2776                     ; 70 }
2779  0074 81            	ret
2782                     	bsct
2783  000a               L7471_key_down_1:
2784  000a 00            	dc.b	0
2785  000b               L1571_count1:
2786  000b 0000          	dc.w	0
2787  000d               L3571_count2:
2788  000d 0000          	dc.w	0
2789  000f               L5571_flag1:
2790  000f 00            	dc.b	0
2791  0010               L7571_flag2:
2792  0010 01            	dc.b	1
2862                     ; 72 void KEY_UP_Scan_Ser(void)
2862                     ; 73 {
2863                     	switch	.text
2864  0075               _KEY_UP_Scan_Ser:
2868                     ; 80 	if(key_down_1)
2870  0075 3d0a          	tnz	L7471_key_down_1
2871  0077 2740          	jreq	L7102
2872                     ; 82 		count2++;
2874  0079 be0d          	ldw	x,L3571_count2
2875  007b 1c0001        	addw	x,#1
2876  007e bf0d          	ldw	L3571_count2,x
2877                     ; 83 		if(count2>8000)
2879  0080 be0d          	ldw	x,L3571_count2
2880  0082 a31f41        	cpw	x,#8001
2881  0085 2511          	jrult	L1202
2882                     ; 85 			count2=0;
2884  0087 5f            	clrw	x
2885  0088 bf0d          	ldw	L3571_count2,x
2886                     ; 86 			if(flag2)
2888  008a 3d10          	tnz	L7571_flag2
2889  008c 270a          	jreq	L1202
2890                     ; 88 				flag2=0;
2892  008e 3f10          	clr	L7571_flag2
2893                     ; 89 				key_style=KEY_UP_L;
2895  0090 35040002      	mov	_key_style,#4
2896                     ; 90 				flag1=1;
2898  0094 3501000f      	mov	L5571_flag1,#1
2899  0098               L1202:
2900                     ; 93 		if(ADC_Sampling(3)>842)//高于2.7V按键释放
2902  0098 a603          	ld	a,#3
2903  009a cd0000        	call	_ADC_Sampling
2905  009d a3034b        	cpw	x,#843
2906  00a0 2559          	jrult	L3302
2907                     ; 95 			key_down_1=0;	
2909  00a2 3f0a          	clr	L7471_key_down_1
2910                     ; 96 			count2=0;
2912  00a4 5f            	clrw	x
2913  00a5 bf0d          	ldw	L3571_count2,x
2914                     ; 97 			flag2=1;
2916  00a7 35010010      	mov	L7571_flag2,#1
2917                     ; 98 			if(flag1)
2919  00ab 3d0f          	tnz	L5571_flag1
2920  00ad 2704          	jreq	L7202
2921                     ; 100 				flag1=0;
2923  00af 3f0f          	clr	L5571_flag1
2925  00b1 2048          	jra	L3302
2926  00b3               L7202:
2927                     ; 104 				key_style=KEY_UP_S;
2929  00b3 35030002      	mov	_key_style,#3
2930  00b7 2042          	jra	L3302
2931  00b9               L7102:
2932                     ; 110 		if((ADC_Sampling(3)<537)&&(ADC_Sampling(3)>477))//1.54V-1.74V之间有效
2934  00b9 a603          	ld	a,#3
2935  00bb cd0000        	call	_ADC_Sampling
2937  00be a30219        	cpw	x,#537
2938  00c1 2435          	jruge	L5302
2940  00c3 a603          	ld	a,#3
2941  00c5 cd0000        	call	_ADC_Sampling
2943  00c8 a301de        	cpw	x,#478
2944  00cb 252b          	jrult	L5302
2945                     ; 112 			count1++;
2947  00cd be0b          	ldw	x,L1571_count1
2948  00cf 1c0001        	addw	x,#1
2949  00d2 bf0b          	ldw	L1571_count1,x
2950                     ; 113 			if(count1>50)
2952  00d4 be0b          	ldw	x,L1571_count1
2953  00d6 a30033        	cpw	x,#51
2954  00d9 2520          	jrult	L3302
2955                     ; 115 				count1=0;
2957  00db 5f            	clrw	x
2958  00dc bf0b          	ldw	L1571_count1,x
2959                     ; 116 				if((ADC_Sampling(3)<537)&&(ADC_Sampling(3)>477))
2961  00de a603          	ld	a,#3
2962  00e0 cd0000        	call	_ADC_Sampling
2964  00e3 a30219        	cpw	x,#537
2965  00e6 2413          	jruge	L3302
2967  00e8 a603          	ld	a,#3
2968  00ea cd0000        	call	_ADC_Sampling
2970  00ed a301de        	cpw	x,#478
2971  00f0 2509          	jrult	L3302
2972                     ; 118 					key_down_1=1;
2974  00f2 3501000a      	mov	L7471_key_down_1,#1
2975  00f6 2003          	jra	L3302
2976  00f8               L5302:
2977                     ; 124 			count1=0;
2979  00f8 5f            	clrw	x
2980  00f9 bf0b          	ldw	L1571_count1,x
2981  00fb               L3302:
2982                     ; 127 }
2985  00fb 81            	ret
2988                     	bsct
2989  0011               L5402_key_down_1:
2990  0011 00            	dc.b	0
2991  0012               L7402_count1:
2992  0012 0000          	dc.w	0
2993  0014               L1502_count2:
2994  0014 0000          	dc.w	0
2995  0016               L3502_flag1:
2996  0016 00            	dc.b	0
2997  0017               L5502_flag2:
2998  0017 01            	dc.b	1
3068                     ; 129 void KEY_DOWN_Scan_Ser(void)
3068                     ; 130 {
3069                     	switch	.text
3070  00fc               _KEY_DOWN_Scan_Ser:
3074                     ; 137 	if(key_down_1)
3076  00fc 3d11          	tnz	L5402_key_down_1
3077  00fe 2740          	jreq	L5112
3078                     ; 139 		count2++;
3080  0100 be14          	ldw	x,L1502_count2
3081  0102 1c0001        	addw	x,#1
3082  0105 bf14          	ldw	L1502_count2,x
3083                     ; 140 		if(count2>8000)
3085  0107 be14          	ldw	x,L1502_count2
3086  0109 a31f41        	cpw	x,#8001
3087  010c 2511          	jrult	L7112
3088                     ; 142 			count2=0;
3090  010e 5f            	clrw	x
3091  010f bf14          	ldw	L1502_count2,x
3092                     ; 143 			if(flag2)
3094  0111 3d17          	tnz	L5502_flag2
3095  0113 270a          	jreq	L7112
3096                     ; 145 				flag2=0;
3098  0115 3f17          	clr	L5502_flag2
3099                     ; 146 				key_style=KEY_DOWN_L;
3101  0117 35020002      	mov	_key_style,#2
3102                     ; 147 				flag1=1;
3104  011b 35010016      	mov	L3502_flag1,#1
3105  011f               L7112:
3106                     ; 150 		if(ADC_Sampling(3)>842)//高于2.7V按键释放
3108  011f a603          	ld	a,#3
3109  0121 cd0000        	call	_ADC_Sampling
3111  0124 a3034b        	cpw	x,#843
3112  0127 2559          	jrult	L1312
3113                     ; 152 			key_down_1=0;	
3115  0129 3f11          	clr	L5402_key_down_1
3116                     ; 153 			count2=0;
3118  012b 5f            	clrw	x
3119  012c bf14          	ldw	L1502_count2,x
3120                     ; 154 			flag2=1;
3122  012e 35010017      	mov	L5502_flag2,#1
3123                     ; 155 			if(flag1)
3125  0132 3d16          	tnz	L3502_flag1
3126  0134 2704          	jreq	L5212
3127                     ; 157 				flag1=0;
3129  0136 3f16          	clr	L3502_flag1
3131  0138 2048          	jra	L1312
3132  013a               L5212:
3133                     ; 161 				key_style=KEY_DOWN_S;
3135  013a 35010002      	mov	_key_style,#1
3136  013e 2042          	jra	L1312
3137  0140               L5112:
3138                     ; 167 		if((ADC_Sampling(3)<704)&&(ADC_Sampling(3)>644))//2.08V-2.28V之间有效
3140  0140 a603          	ld	a,#3
3141  0142 cd0000        	call	_ADC_Sampling
3143  0145 a302c0        	cpw	x,#704
3144  0148 2435          	jruge	L3312
3146  014a a603          	ld	a,#3
3147  014c cd0000        	call	_ADC_Sampling
3149  014f a30285        	cpw	x,#645
3150  0152 252b          	jrult	L3312
3151                     ; 169 			count1++;
3153  0154 be12          	ldw	x,L7402_count1
3154  0156 1c0001        	addw	x,#1
3155  0159 bf12          	ldw	L7402_count1,x
3156                     ; 170 			if(count1>50)
3158  015b be12          	ldw	x,L7402_count1
3159  015d a30033        	cpw	x,#51
3160  0160 2520          	jrult	L1312
3161                     ; 172 				count1=0;
3163  0162 5f            	clrw	x
3164  0163 bf12          	ldw	L7402_count1,x
3165                     ; 173 				if((ADC_Sampling(3)<704)&&(ADC_Sampling(3)>644))
3167  0165 a603          	ld	a,#3
3168  0167 cd0000        	call	_ADC_Sampling
3170  016a a302c0        	cpw	x,#704
3171  016d 2413          	jruge	L1312
3173  016f a603          	ld	a,#3
3174  0171 cd0000        	call	_ADC_Sampling
3176  0174 a30285        	cpw	x,#645
3177  0177 2509          	jrult	L1312
3178                     ; 175 					key_down_1=1;
3180  0179 35010011      	mov	L5402_key_down_1,#1
3181  017d 2003          	jra	L1312
3182  017f               L3312:
3183                     ; 181 			count1=0;
3185  017f 5f            	clrw	x
3186  0180 bf12          	ldw	L7402_count1,x
3187  0182               L1312:
3188                     ; 184 }
3191  0182 81            	ret
3194                     	bsct
3195  0018               L3412_key_down_1:
3196  0018 00            	dc.b	0
3197  0019               L5412_count1:
3198  0019 0000          	dc.w	0
3199  001b               L7412_count2:
3200  001b 0000          	dc.w	0
3201  001d               L1512_flag1:
3202  001d 00            	dc.b	0
3203  001e               L3512_flag2:
3204  001e 01            	dc.b	1
3274                     ; 186 void KEY_CALL_Scan_Ser(void)
3274                     ; 187 {
3275                     	switch	.text
3276  0183               _KEY_CALL_Scan_Ser:
3280                     ; 194 	if(key_down_1)
3282  0183 3d18          	tnz	L3412_key_down_1
3283  0185 2740          	jreq	L3122
3284                     ; 196 		count2++;
3286  0187 be1b          	ldw	x,L7412_count2
3287  0189 1c0001        	addw	x,#1
3288  018c bf1b          	ldw	L7412_count2,x
3289                     ; 197 		if(count2>8000)
3291  018e be1b          	ldw	x,L7412_count2
3292  0190 a31f41        	cpw	x,#8001
3293  0193 2511          	jrult	L5122
3294                     ; 199 			count2=0;
3296  0195 5f            	clrw	x
3297  0196 bf1b          	ldw	L7412_count2,x
3298                     ; 200 			if(flag2)
3300  0198 3d1e          	tnz	L3512_flag2
3301  019a 270a          	jreq	L5122
3302                     ; 202 				flag2=0;
3304  019c 3f1e          	clr	L3512_flag2
3305                     ; 203 				key_style=KEY_CALL_L;
3307  019e 35080002      	mov	_key_style,#8
3308                     ; 204 				flag1=1;
3310  01a2 3501001d      	mov	L1512_flag1,#1
3311  01a6               L5122:
3312                     ; 207 		if(ADC_Sampling(3)>842)//高于2.7V按键释放
3314  01a6 a603          	ld	a,#3
3315  01a8 cd0000        	call	_ADC_Sampling
3317  01ab a3034b        	cpw	x,#843
3318  01ae 2559          	jrult	L7222
3319                     ; 209 			key_down_1=0;	
3321  01b0 3f18          	clr	L3412_key_down_1
3322                     ; 210 			count2=0;
3324  01b2 5f            	clrw	x
3325  01b3 bf1b          	ldw	L7412_count2,x
3326                     ; 211 			flag2=1;
3328  01b5 3501001e      	mov	L3512_flag2,#1
3329                     ; 212 			if(flag1)
3331  01b9 3d1d          	tnz	L1512_flag1
3332  01bb 2704          	jreq	L3222
3333                     ; 214 				flag1=0;
3335  01bd 3f1d          	clr	L1512_flag1
3337  01bf 2048          	jra	L7222
3338  01c1               L3222:
3339                     ; 218 				key_style=KEY_CALL_S;
3341  01c1 35070002      	mov	_key_style,#7
3342  01c5 2042          	jra	L7222
3343  01c7               L3122:
3344                     ; 224 		if((ADC_Sampling(3)<373)&&(ADC_Sampling(3)>313))//1.01V-1.21V之间有效
3346  01c7 a603          	ld	a,#3
3347  01c9 cd0000        	call	_ADC_Sampling
3349  01cc a30175        	cpw	x,#373
3350  01cf 2435          	jruge	L1322
3352  01d1 a603          	ld	a,#3
3353  01d3 cd0000        	call	_ADC_Sampling
3355  01d6 a3013a        	cpw	x,#314
3356  01d9 252b          	jrult	L1322
3357                     ; 226 			count1++;
3359  01db be19          	ldw	x,L5412_count1
3360  01dd 1c0001        	addw	x,#1
3361  01e0 bf19          	ldw	L5412_count1,x
3362                     ; 227 			if(count1>50)
3364  01e2 be19          	ldw	x,L5412_count1
3365  01e4 a30033        	cpw	x,#51
3366  01e7 2520          	jrult	L7222
3367                     ; 229 				count1=0;
3369  01e9 5f            	clrw	x
3370  01ea bf19          	ldw	L5412_count1,x
3371                     ; 230 				if((ADC_Sampling(3)<373)&&(ADC_Sampling(3)>313))
3373  01ec a603          	ld	a,#3
3374  01ee cd0000        	call	_ADC_Sampling
3376  01f1 a30175        	cpw	x,#373
3377  01f4 2413          	jruge	L7222
3379  01f6 a603          	ld	a,#3
3380  01f8 cd0000        	call	_ADC_Sampling
3382  01fb a3013a        	cpw	x,#314
3383  01fe 2509          	jrult	L7222
3384                     ; 232 					key_down_1=1;
3386  0200 35010018      	mov	L3412_key_down_1,#1
3387  0204 2003          	jra	L7222
3388  0206               L1322:
3389                     ; 238 			count1=0;
3391  0206 5f            	clrw	x
3392  0207 bf19          	ldw	L5412_count1,x
3393  0209               L7222:
3394                     ; 241 }
3397  0209 81            	ret
3400                     	bsct
3401  001f               L1422_key_down_1:
3402  001f 00            	dc.b	0
3403  0020               L3422_count1:
3404  0020 0000          	dc.w	0
3405  0022               L5422_count2:
3406  0022 0000          	dc.w	0
3407  0024               L7422_flag1:
3408  0024 00            	dc.b	0
3409  0025               L1522_flag2:
3410  0025 01            	dc.b	1
3480                     ; 243 void KEY_PAIR_Scan_Ser(void)
3480                     ; 244 {
3481                     	switch	.text
3482  020a               _KEY_PAIR_Scan_Ser:
3486                     ; 251 	if(key_down_1)
3488  020a 3d1f          	tnz	L1422_key_down_1
3489  020c 2740          	jreq	L1132
3490                     ; 253 		count2++;
3492  020e be22          	ldw	x,L5422_count2
3493  0210 1c0001        	addw	x,#1
3494  0213 bf22          	ldw	L5422_count2,x
3495                     ; 254 		if(count2>8000)
3497  0215 be22          	ldw	x,L5422_count2
3498  0217 a31f41        	cpw	x,#8001
3499  021a 2511          	jrult	L3132
3500                     ; 256 			count2=0;
3502  021c 5f            	clrw	x
3503  021d bf22          	ldw	L5422_count2,x
3504                     ; 257 			if(flag2)
3506  021f 3d25          	tnz	L1522_flag2
3507  0221 270a          	jreq	L3132
3508                     ; 259 				flag2=0;
3510  0223 3f25          	clr	L1522_flag2
3511                     ; 260 				key_style=KEY_PAIR_L;
3513  0225 350a0002      	mov	_key_style,#10
3514                     ; 261 				flag1=1;
3516  0229 35010024      	mov	L7422_flag1,#1
3517  022d               L3132:
3518                     ; 264 		if(ADC_Sampling(3)>842)//高于2.7V按键释放
3520  022d a603          	ld	a,#3
3521  022f cd0000        	call	_ADC_Sampling
3523  0232 a3034b        	cpw	x,#843
3524  0235 2545          	jrult	L5232
3525                     ; 266 			key_down_1=0;	
3527  0237 3f1f          	clr	L1422_key_down_1
3528                     ; 267 			count2=0;
3530  0239 5f            	clrw	x
3531  023a bf22          	ldw	L5422_count2,x
3532                     ; 268 			flag2=1;
3534  023c 35010025      	mov	L1522_flag2,#1
3535                     ; 269 			if(flag1)
3537  0240 3d24          	tnz	L7422_flag1
3538  0242 2704          	jreq	L1232
3539                     ; 271 				flag1=0;
3541  0244 3f24          	clr	L7422_flag1
3543  0246 2034          	jra	L5232
3544  0248               L1232:
3545                     ; 275 				key_style=KEY_PAIR_S;
3547  0248 35090002      	mov	_key_style,#9
3548  024c 202e          	jra	L5232
3549  024e               L1132:
3550                     ; 281 		if(ADC_Sampling(3)<30)//0.1V之内有效
3552  024e a603          	ld	a,#3
3553  0250 cd0000        	call	_ADC_Sampling
3555  0253 a3001e        	cpw	x,#30
3556  0256 2421          	jruge	L7232
3557                     ; 283 			count1++;
3559  0258 be20          	ldw	x,L3422_count1
3560  025a 1c0001        	addw	x,#1
3561  025d bf20          	ldw	L3422_count1,x
3562                     ; 284 			if(count1>50)
3564  025f be20          	ldw	x,L3422_count1
3565  0261 a30033        	cpw	x,#51
3566  0264 2516          	jrult	L5232
3567                     ; 286 				count1=0;
3569  0266 5f            	clrw	x
3570  0267 bf20          	ldw	L3422_count1,x
3571                     ; 287 				if(ADC_Sampling(3)<30)
3573  0269 a603          	ld	a,#3
3574  026b cd0000        	call	_ADC_Sampling
3576  026e a3001e        	cpw	x,#30
3577  0271 2409          	jruge	L5232
3578                     ; 289 					key_down_1=1;
3580  0273 3501001f      	mov	L1422_key_down_1,#1
3581  0277 2003          	jra	L5232
3582  0279               L7232:
3583                     ; 295 			count1=0;
3585  0279 5f            	clrw	x
3586  027a bf20          	ldw	L3422_count1,x
3587  027c               L5232:
3588                     ; 298 }
3591  027c 81            	ret
3624                     	xref	_ADC_Sampling
3625                     	xref	_ADC_Init
3626                     	xdef	_KEY_PAIR_Scan_Ser
3627                     	xdef	_KEY_CALL_Scan_Ser
3628                     	xdef	_KEY_DOWN_Scan_Ser
3629                     	xdef	_KEY_UP_Scan_Ser
3630                     	xdef	_KEY_STBY_Scan_Ser
3631                     	xdef	_KEY_Init
3632                     	xdef	_key_style
3633                     	xdef	_key_stby_t
3652                     	end
