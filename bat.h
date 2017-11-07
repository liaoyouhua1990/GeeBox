#ifndef  _BAT_H_
#define  _BAT_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

//参考电压3.271V
//每差11个数为0.1V
#define BAT_VLB 751 //6.8V=0.0090552045*751
#define BAT_VLT 773 //7.0V=0.0090552045*773

#define BAT_LOW 1 //低压
#define BAT_OWE 2 //欠压

extern u8 bat_style;

void BAT_Init(void);
void BAT_VoltageScan_Ser(void);

#endif

