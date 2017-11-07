#include"ADC.h"

u8 adc_cap=0;

void ADC_Init(void)
{
	ADC_CR2|=(1<<3);//A/D��������Ҷ���
	ADC_CR1|=(1<<6);//8��Ƶ
	ADC_CR1|=(1<<0);//��ʼת��
}

u16 ADC_Sampling(u8 channel)
{
	u16 word=0;
	u8 byte_high=0;
	u8 byte_low=0;
	u16 i=0;
	
	ADC_CSR=0x00;
	ADC_CSR|=(channel&0x0f);//ѡ��ͨ��
	ADC_CR1|=(1<<0);//����ת��
	while((ADC_CSR&0x80)==0)//�ȴ�ADC����
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


