   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2534                     	bsct
2535  0000               _pt2314_aux:
2536  0000 00            	dc.b	0
2537  0001               L3361_pt2314_exti:
2538  0001 01            	dc.b	1
2539  0002               L5361_pt2314_flag:
2540  0002 00            	dc.b	0
2541  0003               L7361_pt2314_buffer:
2542  0003 88            	dc.b	136
2543  0004 00            	dc.b	0
2544                     .const:	section	.text
2545  0000               L1461_pt2314_volume_table:
2546  0000 38            	dc.b	56
2547  0001 30            	dc.b	48
2548  0002 2c            	dc.b	44
2549  0003 28            	dc.b	40
2550  0004 24            	dc.b	36
2551  0005 20            	dc.b	32
2552  0006 1c            	dc.b	28
2553  0007 18            	dc.b	24
2554  0008 14            	dc.b	20
2555  0009 10            	dc.b	16
2556  000a 0c            	dc.b	12
2557  000b 08            	dc.b	8
2558  000c 05            	dc.b	5
2559  000d 03            	dc.b	3
2560  000e 00            	dc.b	0
2594                     ; 31 void PT2314_WriteBuffer(void)
2594                     ; 32 {
2596                     	switch	.text
2597  0000               L3461_PT2314_WriteBuffer:
2601                     ; 33 	I2C_Start();
2603  0000 cd0000        	call	_I2C_Start
2605                     ; 34 	I2C_WriteByte(pt2314_buffer[0]);
2607  0003 b603          	ld	a,L7361_pt2314_buffer
2608  0005 cd0000        	call	_I2C_WriteByte
2610                     ; 35 	I2C_CheckAck();
2612  0008 cd0000        	call	_I2C_CheckAck
2614                     ; 36 	I2C_WriteByte(pt2314_buffer[1]);
2616  000b b604          	ld	a,L7361_pt2314_buffer+1
2617  000d cd0000        	call	_I2C_WriteByte
2619                     ; 37 	I2C_CheckAck();
2621  0010 cd0000        	call	_I2C_CheckAck
2623                     ; 38 	I2C_Stop();
2625  0013 cd0000        	call	_I2C_Stop
2627                     ; 39 }
2630  0016 81            	ret
2658                     ; 41 void PT2314_Init(void)
2658                     ; 42 {
2659                     	switch	.text
2660  0017               _PT2314_Init:
2664                     ; 43 	_asm("sim");
2667  0017 9b            sim
2669                     ; 44 	PC_DDR&=~(1<<3);//上拉中断
2671  0018 7217500c      	bres	_PC_DDR,#3
2672                     ; 45 	PC_CR1|=(1<<3);
2674  001c 7216500d      	bset	_PC_CR1,#3
2675                     ; 46 	PC_CR2|=(1<<3);
2677  0020 7216500e      	bset	_PC_CR2,#3
2678                     ; 47 	EXTI_CR1|=(1<<4);//上升沿触发
2680  0024 721850a0      	bset	_EXTI_CR1,#4
2681                     ; 48 	EXTI_CR1|=(1<<5);//下降沿触发
2683  0028 721a50a0      	bset	_EXTI_CR1,#5
2684                     ; 49 	_asm("rim");
2687  002c 9a            rim
2689                     ; 51 	I2C_Init();
2691  002d cd0000        	call	_I2C_Init
2693                     ; 52 }
2696  0030 81            	ret
2721                     ; 54 void PT2314_SelectBt(void)
2721                     ; 55 {
2722                     	switch	.text
2723  0031               _PT2314_SelectBt:
2727                     ; 56 	pt2314_buffer[1]=0x55;
2729  0031 35550004      	mov	L7361_pt2314_buffer+1,#85
2730                     ; 57 	PT2314_WriteBuffer();
2732  0035 adc9          	call	L3461_PT2314_WriteBuffer
2734                     ; 58 }
2737  0037 81            	ret
2762                     ; 60 void PT2314_SelectAux(void)
2762                     ; 61 {
2763                     	switch	.text
2764  0038               _PT2314_SelectAux:
2768                     ; 62 	pt2314_buffer[1]=0x54;
2770  0038 35540004      	mov	L7361_pt2314_buffer+1,#84
2771                     ; 63 	PT2314_WriteBuffer();
2773  003c adc2          	call	L3461_PT2314_WriteBuffer
2775                     ; 64 }
2778  003e 81            	ret
2816                     ; 66 void PT2314_MasterVolume(u8 volume)
2816                     ; 67 {
2817                     	switch	.text
2818  003f               _PT2314_MasterVolume:
2822                     ; 68 	pt2314_buffer[1]=pt2314_volume_table[volume];
2824  003f 5f            	clrw	x
2825  0040 97            	ld	xl,a
2826  0041 d60000        	ld	a,(L1461_pt2314_volume_table,x)
2827  0044 b704          	ld	L7361_pt2314_buffer+1,a
2828                     ; 69 	PT2314_WriteBuffer();
2830  0046 adb8          	call	L3461_PT2314_WriteBuffer
2832                     ; 70 }
2835  0048 81            	ret
2860                     ; 72 void PT2314_Config(void)
2860                     ; 73 {		
2861                     	switch	.text
2862  0049               _PT2314_Config:
2866                     ; 75 	pt2314_buffer[1]=0x00;
2868  0049 3f04          	clr	L7361_pt2314_buffer+1
2869                     ; 76 	PT2314_WriteBuffer();
2871  004b adb3          	call	L3461_PT2314_WriteBuffer
2873                     ; 79 	pt2314_buffer[1]=0xc5;//L -6.25
2875  004d 35c50004      	mov	L7361_pt2314_buffer+1,#197
2876                     ; 80 	PT2314_WriteBuffer();
2878  0051 adad          	call	L3461_PT2314_WriteBuffer
2880                     ; 81 	pt2314_buffer[1]=0xe5;//R -6.25
2882  0053 35e50004      	mov	L7361_pt2314_buffer+1,#229
2883                     ; 82 	PT2314_WriteBuffer();
2885  0057 ada7          	call	L3461_PT2314_WriteBuffer
2887                     ; 85 	pt2314_buffer[1]=0x55;//BT +3.75DB
2889  0059 35550004      	mov	L7361_pt2314_buffer+1,#85
2890                     ; 86 	PT2314_WriteBuffer();
2892  005d ada1          	call	L3461_PT2314_WriteBuffer
2894                     ; 89 	pt2314_buffer[1]=0x6f;//Bass 0DB
2896  005f 356f0004      	mov	L7361_pt2314_buffer+1,#111
2897                     ; 90 	PT2314_WriteBuffer();
2899  0063 ad9b          	call	L3461_PT2314_WriteBuffer
2901                     ; 91 	pt2314_buffer[1]=0x7f;//Treble 0DB
2903  0065 357f0004      	mov	L7361_pt2314_buffer+1,#127
2904                     ; 92 	PT2314_WriteBuffer();
2906  0069 ad95          	call	L3461_PT2314_WriteBuffer
2908                     ; 93 }
2911  006b 81            	ret
2914                     	bsct
2915  0005               L1471_count:
2916  0005 0000          	dc.w	0
2952                     ; 95 void PT2314_AuxScan_Ser(void)
2952                     ; 96 {
2953                     	switch	.text
2954  006c               _PT2314_AuxScan_Ser:
2958                     ; 99 	if(pt2314_flag)
2960  006c 3d02          	tnz	L5361_pt2314_flag
2961  006e 2724          	jreq	L1671
2962                     ; 101 		count++;
2964  0070 be05          	ldw	x,L1471_count
2965  0072 1c0001        	addw	x,#1
2966  0075 bf05          	ldw	L1471_count,x
2967                     ; 102 		if(count>5000)
2969  0077 be05          	ldw	x,L1471_count
2970  0079 a31389        	cpw	x,#5001
2971  007c 2520          	jrult	L1771
2972                     ; 104 			count=0;
2974  007e 5f            	clrw	x
2975  007f bf05          	ldw	L1471_count,x
2976                     ; 105 			pt2314_flag=0;
2978  0081 3f02          	clr	L5361_pt2314_flag
2979                     ; 106 			if(PT2314_AUX)
2981  0083 c6500b        	ld	a,_PC_IDR
2982  0086 a508          	bcp	a,#8
2983  0088 2704          	jreq	L5671
2984                     ; 108 				pt2314_aux=0;//外部DC拔出
2986  008a 3f00          	clr	_pt2314_aux
2988  008c 2010          	jra	L1771
2989  008e               L5671:
2990                     ; 112 				pt2314_aux=1;//外部DC接入
2992  008e 35010000      	mov	_pt2314_aux,#1
2993  0092 200a          	jra	L1771
2994  0094               L1671:
2995                     ; 118 		if(pt2314_exti)
2997  0094 3d01          	tnz	L3361_pt2314_exti
2998  0096 2706          	jreq	L1771
2999                     ; 120 			pt2314_exti=0;
3001  0098 3f01          	clr	L3361_pt2314_exti
3002                     ; 121 			pt2314_flag=1;
3004  009a 35010002      	mov	L5361_pt2314_flag,#1
3005  009e               L1771:
3006                     ; 124 }
3009  009e 81            	ret
3034                     ; 126 void PT2314_AuxScan_ISR(void)
3034                     ; 127 {
3035                     	switch	.text
3036  009f               _PT2314_AuxScan_ISR:
3040                     ; 128 	if(pt2314_flag==0)
3042  009f 3d02          	tnz	L5361_pt2314_flag
3043  00a1 2604          	jrne	L5002
3044                     ; 130 		pt2314_exti=1;
3046  00a3 35010001      	mov	L3361_pt2314_exti,#1
3047  00a7               L5002:
3048                     ; 132 }
3051  00a7 81            	ret
3114                     	xref	_I2C_WriteByte
3115                     	xref	_I2C_CheckAck
3116                     	xref	_I2C_Stop
3117                     	xref	_I2C_Start
3118                     	xref	_I2C_Init
3119                     	xdef	_PT2314_AuxScan_ISR
3120                     	xdef	_PT2314_AuxScan_Ser
3121                     	xdef	_PT2314_Config
3122                     	xdef	_PT2314_MasterVolume
3123                     	xdef	_PT2314_SelectAux
3124                     	xdef	_PT2314_SelectBt
3125                     	xdef	_PT2314_Init
3126                     	xdef	_pt2314_aux
3145                     	end
