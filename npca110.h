#ifndef _NPCA110_H_
#define _NPCA110_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define VOLUME_MIN 0
#define VOLUME_MAX 12

#define AUX_SHAKE 0
#define AUX_INSERT 1
#define AUX_PULL 2

#define NPCA110_RST_1() PA_ODR|=1<<3
#define NPCA110_RST_0() PA_ODR&=~(1<<3)
#define NPCA110_RST_x() PA_ODR^=1<<3

#define NPCA110_AUX (PC_IDR&(1<<3))

extern u8 npca110_aux;

void NPCA110_Init(void);
void NPCA110_WriteCofig(void);
void NPCA110_AuxScan_Ser(void);
void NPCA110_AuxScan_ISR(void);
void NPCA110_WriteAn1(void);
void NPCA110_WriteDig(void);
void NPCA110_WriteVolume(u8 volume);
void NPCA110_WriteMute(void);
void NPCA110_WriteNMute(void);

#endif

