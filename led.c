#include"LED.h"

void LED_Init(void)
{	
	PD_DDR|=1<<1;
	PD_CR1|=1<<1;
	PD_CR2&=~(1<<1);
	LED_BAT_1();
}

void LED_Flash_Ser(void)
{
	static u32 count=0;

	count++;
	if(count>5000)
	{	
		count=0;
		LED_BAT_x();
	}
}


