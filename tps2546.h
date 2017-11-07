#ifndef  _TPS2546_H_
#define  _TPS2546_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define TPS2546_DET (PC_IDR&(1<<4))

extern u8 tps2546_charge;

void TPS2546_Init(void);
void TPS2546_Scan_ISR(void);
void TPS2546_Scan_Ser(void);

#endif
