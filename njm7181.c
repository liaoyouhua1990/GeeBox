#include"NJM7181.h"

u8 njm7181_sleep=0;
u8 njm7181_signal=0;

static u8 njm7181_exti=1;
static u8 njm7181_flag=0;

void NJM7181_Init(void)
{
	_asm("sim");
	PA_DDR&=~(1<<2);//Ðü¸¡ÖÐ¶Ï
	PA_CR1&=~(1<<2);
	PA_CR2|=(1<<2);
	EXTI_CR1|=(1<<0);//ÉÏÉýÑØ´¥·¢
	EXTI_CR1|=(1<<1);//ÏÂ½µÑØ´¥·¢
	_asm("rim");
}

void NJM7181_Scan_ISR(void)
{
	if(njm7181_flag==0)
	{
		njm7181_exti=1;
	}
}

void NJM7181_Scan_Ser(void)
{
	static u16 count=0;

	if(njm7181_flag)
	{
		count++;
		if(count>5000)
		{
			count=0;
			njm7181_flag=0;
			if(NJM7181_DET)
			{
				njm7181_signal=1;//ÓÐÉùÒôÊä³ö
			}
			else
			{
				njm7181_signal=0;//ÎÞÉùÒôÊä³ö
			}
		}
	}
	else
	{
		if(njm7181_exti)
		{
			njm7181_exti=0;
			njm7181_flag=1;
		}
	}	
}

void NJM7181_Nsignal_Ser(void)
{
	static u8 flag=0;
	static u32 count=0;

	NJM7181_Scan_Ser();
	if(njm7181_signal)
	{
		njm7181_sleep=0;
		count=0;
	}
	else
	{
		flag=1;
	}
	if(flag)
	{
		count++;
		if(count>3846153)//15min=3846153
		{
			count=0;
			njm7181_sleep=1;
			flag=0;
		}
	}
}


