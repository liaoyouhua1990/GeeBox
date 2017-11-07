#include"TPS2546.h"

u8 tps2546_charge=0;

static u8 tps2546_exti=1;
static u8 tps2546_flag=0;

void TPS2546_Init(void)
{
	_asm("sim");
	PC_DDR&=~(1<<4);//�����ж�
	PC_CR1&=~(1<<4);
	PC_CR2|=(1<<4);
	EXTI_CR1|=(1<<4);//�����ش���
	EXTI_CR1|=(1<<5);//�½��ش���
	_asm("rim");
}

void TPS2546_Scan_ISR(void)
{
	if(tps2546_flag==0)
	{
		tps2546_exti=1;
	}
}

void TPS2546_Scan_Ser(void)
{
	static u16 count=0;

	if(tps2546_flag)
	{
		count++;
		if(count>200)
		{
			count=0;
			tps2546_flag=0;
			if(TPS2546_DET)
			{
				tps2546_charge=0;//�����
			}
			else
			{
				tps2546_charge=1;//���
			}
		}
	}
	else
	{
		if(tps2546_exti)
		{
			tps2546_exti=0;
			tps2546_flag=1;
		}
	}	
}


