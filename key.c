#include"KEY.h"
#include"ADC.h"

u16 key_stby_t=0;
u8 key_style=KEY_NO;

void KEY_Init(void)
{	
	PA_DDR&=~(1<<1);
	PA_CR1|=(1<<1);

	ADC_Init();
}

void KEY_STBY_Scan_Ser(void)
{
	static u8 key_down_1=0;
	static u16 count1=0;
	static u16 count2=0;
	static u8 flag1=0;
	static u8 flag2=1;
	
	if(key_down_1)
	{
		count2++;//20us
		if(count2>key_stby_t)
		{
			count2=0;
			if(flag2)
			{
				flag2=0;
				key_style=KEY_STBY_L;
				flag1=1;
			}
		}
		if(KEY_STBY)
		{
			key_down_1=0;	
			count2=0;
			flag2=1;
			if(flag1)
			{
				flag1=0;
			}
			else
			{
				key_style=KEY_STBY_S;
			}	
		}
	}
	else
	{
		if(KEY_STBY==0)
		{
			count1++;
			if(count1>500)
			{
				count1=0;
				if(KEY_STBY==0)
				{
					key_down_1=1;
				}
			}	
		}
		else
		{
			count1=0;
		}
	}		
}

void KEY_UP_Scan_Ser(void)
{
	static u8 key_down_1=0;
	static u16 count1=0;
	static u16 count2=0;
	static u8 flag1=0;
	static u8 flag2=1;
	
	if(key_down_1)
	{
		count2++;
		if(count2>8000)
		{
			count2=0;
			if(flag2)
			{
				flag2=0;
				key_style=KEY_UP_L;
				flag1=1;
			}
		}
		if(ADC_Sampling(3)>842)//高于2.7V按键释放
		{
			key_down_1=0;	
			count2=0;
			flag2=1;
			if(flag1)
			{
				flag1=0;
			}
			else
			{
				key_style=KEY_UP_S;
			}	
		}
	}
	else
	{
		if((ADC_Sampling(3)<537)&&(ADC_Sampling(3)>477))//1.54V-1.74V之间有效
		{
			count1++;
			if(count1>50)
			{
				count1=0;
				if((ADC_Sampling(3)<537)&&(ADC_Sampling(3)>477))
				{
					key_down_1=1;
				}
			}	
		}
		else
		{
			count1=0;
		}
	}		
}

void KEY_DOWN_Scan_Ser(void)
{
	static u8 key_down_1=0;
	static u16 count1=0;
	static u16 count2=0;
	static u8 flag1=0;
	static u8 flag2=1;
	
	if(key_down_1)
	{
		count2++;
		if(count2>8000)
		{
			count2=0;
			if(flag2)
			{
				flag2=0;
				key_style=KEY_DOWN_L;
				flag1=1;
			}
		}
		if(ADC_Sampling(3)>842)//高于2.7V按键释放
		{
			key_down_1=0;	
			count2=0;
			flag2=1;
			if(flag1)
			{
				flag1=0;
			}
			else
			{
				key_style=KEY_DOWN_S;
			}	
		}
	}
	else
	{
		if((ADC_Sampling(3)<704)&&(ADC_Sampling(3)>644))//2.08V-2.28V之间有效
		{
			count1++;
			if(count1>50)
			{
				count1=0;
				if((ADC_Sampling(3)<704)&&(ADC_Sampling(3)>644))
				{
					key_down_1=1;
				}
			}	
		}
		else
		{
			count1=0;
		}
	}		
}

void KEY_CALL_Scan_Ser(void)
{
	static u8 key_down_1=0;
	static u16 count1=0;
	static u16 count2=0;
	static u8 flag1=0;
	static u8 flag2=1;
	
	if(key_down_1)
	{
		count2++;
		if(count2>8000)
		{
			count2=0;
			if(flag2)
			{
				flag2=0;
				key_style=KEY_CALL_L;
				flag1=1;
			}
		}
		if(ADC_Sampling(3)>842)//高于2.7V按键释放
		{
			key_down_1=0;	
			count2=0;
			flag2=1;
			if(flag1)
			{
				flag1=0;
			}
			else
			{
				key_style=KEY_CALL_S;
			}	
		}
	}
	else
	{
		if((ADC_Sampling(3)<373)&&(ADC_Sampling(3)>313))//1.01V-1.21V之间有效
		{
			count1++;
			if(count1>50)
			{
				count1=0;
				if((ADC_Sampling(3)<373)&&(ADC_Sampling(3)>313))
				{
					key_down_1=1;
				}
			}	
		}
		else
		{
			count1=0;
		}
	}		
}

void KEY_PAIR_Scan_Ser(void)
{
	static u8 key_down_1=0;
	static u16 count1=0;
	static u16 count2=0;
	static u8 flag1=0;
	static u8 flag2=1;
	
	if(key_down_1)
	{
		count2++;
		if(count2>8000)
		{
			count2=0;
			if(flag2)
			{
				flag2=0;
				key_style=KEY_PAIR_L;
				flag1=1;
			}
		}
		if(ADC_Sampling(3)>842)//高于2.7V按键释放
		{
			key_down_1=0;	
			count2=0;
			flag2=1;
			if(flag1)
			{
				flag1=0;
			}
			else
			{
				key_style=KEY_PAIR_S;
			}	
		}
	}
	else
	{
		if(ADC_Sampling(3)<30)//0.1V之内有效
		{
			count1++;
			if(count1>50)
			{
				count1=0;
				if(ADC_Sampling(3)<30)
				{
					key_down_1=1;
				}
			}	
		}
		else
		{
			count1=0;
		}
	}		
}

