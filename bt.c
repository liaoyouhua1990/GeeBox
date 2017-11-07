#include"BT.h"

void BT_Init(void)
{
	PD_DDR|=1<<6;
	PD_CR1|=1<<6;
	PD_CR2&=~(1<<6);
	BT_EN_0();//¹Ø±ÕÀ¶ÑÀ

	PC_DDR|=1<<4;
	PC_CR1|=1<<4;
	PC_CR2&=~(1<<4);
	BT_PAIR_0();

	PC_DDR|=1<<5;
	PC_CR1|=1<<5;
	PC_CR2&=~(1<<5);
	BT_NEXT_0();

	PC_DDR|=1<<6;
	PC_CR1|=1<<6;
	PC_CR2&=~(1<<6);
	BT_CALL_0();

	PC_DDR|=1<<7;
	PC_CR1|=1<<7;
	PC_CR2&=~(1<<7);
	BT_PREV_0();
}



