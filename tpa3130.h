#ifndef _TPA3130_H_
#define _TPA3130_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define TPA3130_UMUTE_1() PD_ODR|=1<<4
#define TPA3130_UMUTE_0() PD_ODR&=~(1<<4)
#define TPA3130_UMUTE_x() PD_ODR^=1<<4

void TPA3130_Init(void);

#endif

