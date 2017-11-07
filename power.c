#include"POWER.h"

void POWER_Init(void)
{
	PD_DDR|=1<<5;
	PD_CR1|=1<<5;
	PD_CR2&=~(1<<5);
	POWER_STBY_0();//¹Ø±ÕµçÔ´
}




