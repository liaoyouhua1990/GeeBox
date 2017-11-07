   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2565                     ; 3 void LV4052_Init(void)
2565                     ; 4 {
2567                     	switch	.text
2568  0000               _LV4052_Init:
2572                     ; 5 	PA_DDR|=1<<3;
2574  0000 72165002      	bset	_PA_DDR,#3
2575                     ; 6 	PA_CR1|=1<<3;
2577  0004 72165003      	bset	_PA_CR1,#3
2578                     ; 7 	PA_CR2&=~(1<<3);
2580  0008 72175004      	bres	_PA_CR2,#3
2581                     ; 9 	LV4052_CD4052_0();
2583  000c 72175000      	bres	_PA_ODR,#3
2584                     ; 10 }
2587  0010 81            	ret
2600                     	xdef	_LV4052_Init
2619                     	end
