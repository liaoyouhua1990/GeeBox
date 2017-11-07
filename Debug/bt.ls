   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2569                     ; 3 void BT_Init(void)
2569                     ; 4 {
2571                     	switch	.text
2572  0000               _BT_Init:
2576                     ; 5 	PD_DDR|=1<<6;
2578  0000 721c5011      	bset	_PD_DDR,#6
2579                     ; 6 	PD_CR1|=1<<6;
2581  0004 721c5012      	bset	_PD_CR1,#6
2582                     ; 7 	PD_CR2&=~(1<<6);
2584  0008 721d5013      	bres	_PD_CR2,#6
2585                     ; 8 	BT_EN_0();//¹Ø±ÕÀ¶ÑÀ
2587  000c 721d500f      	bres	_PD_ODR,#6
2588                     ; 10 	PC_DDR|=1<<4;
2590  0010 7218500c      	bset	_PC_DDR,#4
2591                     ; 11 	PC_CR1|=1<<4;
2593  0014 7218500d      	bset	_PC_CR1,#4
2594                     ; 12 	PC_CR2&=~(1<<4);
2596  0018 7219500e      	bres	_PC_CR2,#4
2597                     ; 13 	BT_PAIR_0();
2599  001c 7219500a      	bres	_PC_ODR,#4
2600                     ; 15 	PC_DDR|=1<<5;
2602  0020 721a500c      	bset	_PC_DDR,#5
2603                     ; 16 	PC_CR1|=1<<5;
2605  0024 721a500d      	bset	_PC_CR1,#5
2606                     ; 17 	PC_CR2&=~(1<<5);
2608  0028 721b500e      	bres	_PC_CR2,#5
2609                     ; 18 	BT_NEXT_0();
2611  002c 721b500a      	bres	_PC_ODR,#5
2612                     ; 20 	PC_DDR|=1<<6;
2614  0030 721c500c      	bset	_PC_DDR,#6
2615                     ; 21 	PC_CR1|=1<<6;
2617  0034 721c500d      	bset	_PC_CR1,#6
2618                     ; 22 	PC_CR2&=~(1<<6);
2620  0038 721d500e      	bres	_PC_CR2,#6
2621                     ; 23 	BT_CALL_0();
2623  003c 721d500a      	bres	_PC_ODR,#6
2624                     ; 25 	PC_DDR|=1<<7;
2626  0040 721e500c      	bset	_PC_DDR,#7
2627                     ; 26 	PC_CR1|=1<<7;
2629  0044 721e500d      	bset	_PC_CR1,#7
2630                     ; 27 	PC_CR2&=~(1<<7);
2632  0048 721f500e      	bres	_PC_CR2,#7
2633                     ; 28 	BT_PREV_0();
2635  004c 721f500a      	bres	_PC_ODR,#7
2636                     ; 29 }
2639  0050 81            	ret
2652                     	xdef	_BT_Init
2671                     	end
