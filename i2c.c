#include"I2C.h"

static void SCL_SET(u8 flag);
static void SDA_SET(u8 flag);
static u8 SDA_GET(void);
static void I2C_Wait(u8 t);

void SCL_SET(u8 flag)
{
	PB_DDR|=1<<4;
	PB_CR1|=1<<4;
	PB_CR2&=~(1<<4);
	if(flag)
	{
		PB_ODR|=(1<<4);	
	}
	else
	{
		PB_ODR&=~(1<<4);	
	}
}

void SDA_SET(u8 flag)
{
	PB_DDR|=1<<5;
	PB_CR1|=1<<5;
	PB_CR2&=~(1<<5);
	if(flag)
	{
		PB_ODR|=(1<<5);	
	}
	else
	{
		PB_ODR&=~(1<<5);	
	}
}

u8 SDA_GET(void)
{
	u8 flag=0;

	PB_DDR&=~(1<<5);
	PB_CR1|=(1<<5);
	PB_CR2&=~(1<<5);
	if(PB_IDR&(1<<5))
	{
		flag=1;
	}
	else
	{
		flag=0;
	}
	
	return flag;
}

void I2C_Wait(u8 t)
{
	while(t--);
}

void I2C_Init(void)
{
	SCL_SET(1);
	SDA_GET();
}

void I2C_WriteByte(u8 byte)
{
	u8 i=0;

	for(i=0;i<8;i++)
	{
		SCL_SET(0);
		I2C_Wait(2);
		if((byte<<i)&0x80)
		{
			SDA_SET(1);
		}
		else
		{
			SDA_SET(0);
		}
		I2C_Wait(2);
		SCL_SET(1);
		I2C_Wait(12);
	}
	SCL_SET(0);
	I2C_Wait(4);
}

u8 I2C_ReadByte(void)
{
	u8 i=0;
	u8 dat=0;

	for(i=0;i<8;i++)
	{
		SCL_SET(1);
		I2C_Wait(8);
		dat=dat<<1;
		if(SDA_GET())
		{
			dat++;
		}
		SCL_SET(0);
		I2C_Wait(10);
	}
	
	return dat;
}

void I2C_Start(void)
{
	SDA_SET(1);
	SCL_SET(1);
	I2C_Wait(4);
	SDA_SET(0);
	I2C_Wait(4);
}

void I2C_Stop(void)
{
	SDA_SET(0);
	SCL_SET(1);
	I2C_Wait(4);
	SDA_SET(1);
	I2C_Wait(4);
}

u8 I2C_ReadAck(void)
{
	u8 ack=0; 
	u8 i=0;

	SCL_SET(1);
	I2C_Wait(8);
	while((!ack)&&(i<50))
	{
		if(SDA_GET())
		{
			ack=0;
		}
		else
		{
			ack=1;		
		} 
		i++;
	}
	SCL_SET(0);
	I2C_Wait(8);
		
	return ack;
}

void I2C_WriteAck(u8 ack)
{
	if(ack)
	{
		SDA_SET(0);
	}
	else
	{
		SDA_SET(1);
	}
	I2C_Wait(2);
	SCL_SET(1);
	I2C_Wait(10);
	SCL_SET(0);
	SDA_GET();
	I2C_Wait(8);
}




 


