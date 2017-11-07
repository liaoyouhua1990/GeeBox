#ifndef  _NJM7181_H_
#define  _NJM7181_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define NJM7181_DET (PA_IDR&(1<<2))

extern u8 njm7181_sleep;
extern u8 njm7181_signal;

void NJM7181_Init(void);
void NJM7181_Scan_ISR(void);
void NJM7181_Scan_Ser(void);
void NJM7181_Nsignal_Ser(void);

#endif
