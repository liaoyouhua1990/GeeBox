   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2565                     ; 3 void TPA3130_Init(void)
2565                     ; 4 {
2567                     	switch	.text
2568  0000               _TPA3130_Init:
2572                     ; 5 	PD_DDR|=1<<4;
2574  0000 72185011      	bset	_PD_DDR,#4
2575                     ; 6 	PD_CR1|=1<<4;
2577  0004 72185012      	bset	_PD_CR1,#4
2578                     ; 7 	PD_CR2&=~(1<<4);
2580  0008 72195013      	bres	_PD_CR2,#4
2581                     ; 8 	TPA3130_UMUTE_0();//¾²Òô
2583  000c 7219500f      	bres	_PD_ODR,#4
2584                     ; 9 }
2587  0010 81            	ret
2600                     	xdef	_TPA3130_Init
2619                     	end
