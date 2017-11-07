#ifndef  _LED_H_
#define  _LED_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define LED_BAT_1() PD_ODR|=1<<1
#define LED_BAT_0() PD_ODR&=~(1<<1)
#define LED_BAT_x() PD_ODR^=1<<1

void LED_Init(void);
void LED_Flash_Ser(void);

#endif

