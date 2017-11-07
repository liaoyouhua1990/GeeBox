#ifndef _POWER_H_
#define _POWER_H_

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#include<stm8s103k3.h>

#define POWER_STBY_1() PD_ODR|=1<<5
#define POWER_STBY_0() PD_ODR&=~(1<<5)
#define POWER_STBY_x() PD_ODR^=1<<5

void POWER_Init(void);

#endif

