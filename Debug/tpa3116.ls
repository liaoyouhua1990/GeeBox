   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2565                     ; 3 void TPA3116_Init(void)
2565                     ; 4 {
2567                     	switch	.text
2568  0000               _TPA3116_Init:
2572                     ; 5 	PD_DDR|=1<<6;
2574  0000 721c5011      	bset	_PD_DDR,#6
2575                     ; 6 	PD_CR1|=1<<6;
2577  0004 721c5012      	bset	_PD_CR1,#6
2578                     ; 7 	PD_CR2&=~(1<<6);
2580  0008 721d5013      	bres	_PD_CR2,#6
2581                     ; 8 	TPA3116_UMUTE_0();//¾²Òô
2583  000c 721d500f      	bres	_PD_ODR,#6
2584                     ; 9 }
2587  0010 81            	ret
2600                     	xdef	_TPA3116_Init
2619                     	end
