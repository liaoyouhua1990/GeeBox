#include"TPA3130.h"

void TPA3130_Init(void)
{
	PD_DDR|=1<<4;
	PD_CR1|=1<<4;
	PD_CR2&=~(1<<4);
	TPA3130_UMUTE_0();//¾²Òô
}


