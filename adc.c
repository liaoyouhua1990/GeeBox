#include"ADC.h"

u8 adc_cap=0;

void ADC_Init(void)
{
	ADC_CR2|=(1<<3);//A/D结果数据右对齐
	ADC_CR1|=(1<<6);//8分频
	ADC_CR1|=(1<<0);//开始转换
}

u16 ADC_Sampling(u8 channel)
{
	u16 word=0;
	u8 byte_high=0;
	u8 byte_low=0;
	u16 i=0;
	
	ADC_CSR=0x00;
	ADC_CSR|=(channel&0x0f);//选择通道
	ADC_CR1|=(1<<0);//启动转换
	while((ADC_CSR&0x80)==0)//等待ADC结束
	{
		i++;
		if(i>1000)
		{
			i=0;
			break;
		}
	}
	byte_low=ADC_DRL;
	byte_high=ADC_DRH;
	word=byte_high*256+byte_low;
	return word;
}


