   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2565                     ; 3 void POWER_Init(void)
2565                     ; 4 {
2567                     	switch	.text
2568  0000               _POWER_Init:
2572                     ; 5 	PD_DDR|=1<<5;
2574  0000 721a5011      	bset	_PD_DDR,#5
2575                     ; 6 	PD_CR1|=1<<5;
2577  0004 721a5012      	bset	_PD_CR1,#5
2578                     ; 7 	PD_CR2&=~(1<<5);
2580  0008 721b5013      	bres	_PD_CR2,#5
2581                     ; 8 	POWER_STBY_0();//¹Ø±ÕµçÔ´
2583  000c 721b500f      	bres	_PD_ODR,#5
2584                     ; 9 }
2587  0010 81            	ret
2600                     	xdef	_POWER_Init
2619                     	end
