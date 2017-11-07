#ifndef _EEPROM_H_
#define _EEPROM_H_

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#include<stm8s103k3.h>

void EEPROM_Init(void);
void EEPROM_WriteByte(u8 address,u8 byte);
u8 EEPROM_ReadByte(u8 address);


#endif

