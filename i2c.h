#ifndef  _I2C_H_
#define  _I2C_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

void I2C_Init(void);
void I2C_Start(void);
void I2C_Stop(void);
u8 I2C_ReadAck(void);
void I2C_WriteAck(u8 ack);
void I2C_WriteByte(u8 byte);
u8 I2C_ReadByte(void);

#endif
