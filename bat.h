#ifndef  _BAT_H_
#define  _BAT_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

//�ο���ѹ3.271V
//ÿ��11����Ϊ0.1V
#define BAT_VLB 751 //6.8V=0.0090552045*751
#define BAT_VLT 773 //7.0V=0.0090552045*773

#define BAT_LOW 1 //��ѹ
#define BAT_OWE 2 //Ƿѹ

extern u8 bat_style;

void BAT_Init(void);
void BAT_VoltageScan_Ser(void);

#endif

