#include"BAT.h"
#include"ADC.h"

u8 bat_style=0;

void BAT_Init(void)
{	
	ADC_Init();
}

void BAT_VoltageScan_Ser(void)
{
	static u32 count=0;
	static u16 buffer[6]={0,0,0,0,0,0};
	static u8 i=0;
	static u16 volue=0;
	static u8 mode=0;
	
	switch(mode)
	{
		case 0:
		{
			count++;//359us
			if(count>928)//333ms=928
			{
				count=0;
				mode=1;
			}
		}
		break;

		case 1:
		{
			buffer[i]=ADC_Sampling(4);
			mode=0;
			i++;
			if(i==3)
			{
				i=0;
				mode=2;
				buffer[0]=(buffer[0]+buffer[1]+buffer[2])/3;
			}
		}
		break;

		case 2:
		{
			count++;//359us
			if(count>2786)//1s=2786
			{
				count=0;
				mode=3;
			}
		}
		break;

		case 3:
		{
			count++;//359us
			if(count>928)//333ms=928
			{
				count=0;
				mode=4;
			}
		}
		break;

		case 4:
		{
			buffer[i+3]=ADC_Sampling(4);
			mode=3;
			i++;
			if(i==3)
			{
				i=0;
				buffer[3]=(buffer[3]+buffer[4]+buffer[5])/3;
				mode=5;
			}
		}
		break;

		case 5:
		{
			buffer[5]=(buffer[0]+buffer[3])/2;
			if(buffer[5]<BAT_VLB)//小于6.8V
			{
				bat_style=BAT_LOW;//低压
			}
			else if(buffer[5]>BAT_VLT)//大于6.9V
			{
				bat_style=0;//低压取消
			}
			mode=0;
		}
		break;
	}
}

