#ifndef _BT_H_
#define _BT_H_

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#include<stm8s103k3.h>

#define BT_EN_1() PD_ODR|=1<<6
#define BT_EN_0() PD_ODR&=~(1<<6)
#define BT_EN_x() PD_ODR^=1<<6

#define BT_PAIR_1() PC_ODR|=1<<4
#define BT_PAIR_0() PC_ODR&=~(1<<4)
#define BT_PAIR_x() PC_ODR^=1<<4

#define BT_NEXT_1() PC_ODR|=1<<5
#define BT_NEXT_0() PC_ODR&=~(1<<5)
#define BT_NEXT_x() PC_ODR^=1<<5

#define BT_CALL_1() PC_ODR|=1<<6
#define BT_CALL_0() PC_ODR&=~(1<<6)
#define BT_CALL_x() PC_ODR^=1<<6

#define BT_PREV_1() PC_ODR|=1<<7
#define BT_PREV_0() PC_ODR&=~(1<<7)
#define BT_PREV_x() PC_ODR^=1<<7

void BT_Init(void);

#endif

