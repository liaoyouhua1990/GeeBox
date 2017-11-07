#include"EEPROM.h"

void EEPROM_WriteByte(u8 address,u8 byte)
{
	u8 *p=0;
	u8 i=0;
	u8 j=0;
	
	p=(u8 *)0x4000+address;
	do
	{
		FLASH_DUKR=0xae;
		FLASH_DUKR=0x56;
		i++;
	} 
	while(((FLASH_IAPSR&0x08)==0)&&(i<10));
	*p=byte;
	while(((FLASH_IAPSR&0x04)==0)&&(j<10))
	{
		j++;
	}
}

u8 EEPROM_ReadByte(u8 address)
{
	u8 *p=0;
	u8 byte=0;

	p=(u8 *)0x4000+address;
	byte=*p;
	return byte;
}

void EEPROM_Init(void)
{
	
}






