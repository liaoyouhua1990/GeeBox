#ifndef  _ADC_H_
#define  _ADC_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define ADC_VL 1
#define ADC_VM 2
#define ADC_VH 3

extern u8 adc_cap;

void ADC_Init(void);
u16 ADC_Sampling(u8 channel);

#endif