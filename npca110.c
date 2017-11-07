#include"NPCA110.h"
#include"I2C.h"
#include"CONFIG.h"

u8 npca110_aux=0;

static u8 npca110_exti=1;
static u8 npca110_busy=0;

static const u8 cfg_tab[]={    
    0x00, 0xa5, 0x00,// Setup Configuration Start 
    0x00, 0xa5, 0x00,// Setup Configuration Start 
    0x00, 0xa5, 0x00,// Setup Configuration Start 
	0x00, 0xB8, 0x00,	// Get NPCA110x Chip Version 	 
	0x00, 0xB7, 0x00,  // Get NPCA110x Software Version 	
	0xFF, 0xB5, 0xF1,  // Get NPCA110x Chip Flavor 
	0x00, 0xC5, 0x00, // Software Reset (NOTE: Add 30msec delay)
	0x00, 0xa5, 0x00,// Setup Configuration Start 
    0xff, 0xab, 0xf3,// Set GPIO Selection 2 
    0x00, 0x00, 0xd0,// ==>  SDI0 (NPCA110B only),  GPO18,  GPO07/SDO1,  
};

//-5.52
static const u8 ain1_tab[]={
	0x00, 0xA4, 0x11,  // Load Router Gain Start 
	0x00, 0x00, 0x00,  // M1 - SDI0 to Processing path 
	0x00, 0x00, 0x00,   // M2 - SDI1 to Processing path 
	0x00, 0x00, 0x00,   // M3 - SDI2 to Processing path 
	0x08, 0x88, 0xFD,   // M4 - ADC  to Processing path 
	0x00, 0x00, 0x00,   // M5 - SDI0 to UnProcessing path 
	0x00, 0x00, 0x00,   // M6 - SDI1 to UnProcessing path 
	0x00, 0x00, 0x00,   // M7 - SDI2 to UnProcessing path 
	0x00, 0x00, 0x00,   // M8 - ADC  to UnProcessing path 
	0x00, 0x00, 0x00,   // M9 - SDO0 from Processed path 
	0x00, 0x00, 0x00,   // M10- SDO1 from Processed path 
	0x7F, 0xFF, 0xFF,   // M11- DAC1 from Processed path 
	0x00, 0x00, 0x00,   // M12- SDO0 from UnProcessed path 
	0x00, 0x00, 0x00,   // M13- SDO1 from UnProcessed path 
	0x00, 0x00, 0x00,   // M14- DAC1 from UnProcessed path 
	0x00, 0x00, 0x00,   // M15- DAC2/SDO2 from Subwoofer path 
	0x00, 0x00, 0x00,   // M16- DAC2/SDO2 UnProcessed path 
	0x3A, 0x81, 0xDD,   // M17- DAC2/SDO2 Processed path 
	0x00, 0xC8, 0x00,  // Load Router Gain End 
 
	0xFF, 0xAD, 0x83,	// Set ADC Input Control 
	0x00, 0x00, 0x88,  // ==>  Stereo,  LIN1(30K),  RIN1(30K).  
	0xFF, 0xAD, 0x86,  // CODEC Latch 
	0x00, 0x00, 0x00, 
	0xFF, 0xAD, 0x86,  // CODEC Latch 
	0x00, 0x00, 0x01, 
	0xFF, 0xAD, 0x86,  // CODEC Latch 
	0x00, 0x00, 0x00, 
};

//-3.07
static const u8 dig_tab[]={
	0x00, 0xA4, 0x11,  // Load Router Gain Start 
	0x0B, 0x0F, 0x10,  // M1 - SDI0 to Processing path 
	0x00, 0x00, 0x00,   // M2 - SDI1 to Processing path 
	0x00, 0x00, 0x00,   // M3 - SDI2 to Processing path 
	0x00, 0x00, 0x00,   // M4 - ADC  to Processing path 
	0x00, 0x00, 0x00,   // M5 - SDI0 to UnProcessing path 
	0x00, 0x00, 0x00,   // M6 - SDI1 to UnProcessing path 
	0x00, 0x00, 0x00,   // M7 - SDI2 to UnProcessing path 
	0x00, 0x00, 0x00,   // M8 - ADC  to UnProcessing path 
	0x00, 0x00, 0x00,   // M9 - SDO0 from Processed path 
	0x00, 0x00, 0x00,   // M10- SDO1 from Processed path 
	0x7F, 0xFF, 0xFF,   // M11- DAC1 from Processed path 
	0x00, 0x00, 0x00,   // M12- SDO0 from UnProcessed path 
	0x00, 0x00, 0x00,   // M13- SDO1 from UnProcessed path 
	0x00, 0x00, 0x00,   // M14- DAC1 from UnProcessed path 
	0x00, 0x00, 0x00,   // M15- DAC2/SDO2 from Subwoofer path 
	0x00, 0x00, 0x00,   // M16- DAC2/SDO2 UnProcessed path 
	0x3A, 0x81, 0xDD,   // M17- DAC2/SDO2 Processed path 
	0x00, 0xC8, 0x00,  // Load Router Gain End 
};

static const u16 volume_tab[13]={
200,250,300,325,350,375,400,410,420,430,440,445,450	
};

static void NPCA110_Wait(u32 t);
static void NPCA110_WriteNByte(u8 *p,u8 n);

static void NPCA110_Wait(u32 t)
{
	while(t--);
}

void NPCA110_WriteNByte(u8 *p,u8 n)
{
	u8 i=0;
	
	for(i=0;i<n;i++)
	{
		I2C_WriteByte(*(p+i));
		I2C_ReadAck();
	}
}

void NPCA110_Init(void)
{
	PA_DDR|=1<<3;
	PA_CR1|=1<<3;
	PA_CR2&=~(1<<3);
	NPCA110_RST_0();
	NPCA110_Wait(10);
	NPCA110_RST_1();
	NPCA110_Wait(10);
	
	_asm("sim");
	PC_DDR&=~(1<<3);//上拉中断
	PC_CR1|=(1<<3);
	PC_CR2|=(1<<3);
	EXTI_CR1|=(1<<4);//下降沿触发
	EXTI_CR1|=(1<<5);//上升沿触发
	_asm("rim");
	
	I2C_Init();
}

void NPCA110_WriteCofig(void)
{
	u16 i=0;

	for(i=0;i<7;i++)
	{
		I2C_Start();
		I2C_WriteByte(0xe6);
		I2C_ReadAck();
		NPCA110_WriteNByte(&cfg_tab[3*i],3);
		I2C_Stop();
	}
	NPCA110_Wait(5000);
	for(i=7;i<10;i++)
	{
		I2C_Start();
		I2C_WriteByte(0xe6);
		I2C_ReadAck();
		NPCA110_WriteNByte(&cfg_tab[3*i],3);
		I2C_Stop();
	}
	for(i=2;i<703;i++)
	{
		I2C_Start();
		I2C_WriteByte(0xe6);
		I2C_ReadAck();
		NPCA110_WriteNByte(&g_abMaxxDSPCommands[3*i],3);
		I2C_Stop();
	}
}

void NPCA110_AuxScan_Ser(void)
{
	static u32 count=0;
	static u8 mode=0;
	static u8 out=0;
	static u8 in=0;

	if(npca110_busy)
	{
		count++;
		if(count>100)
		{
			count=0;
			mode++;
			if(mode>100)
			{
				mode=0;
				npca110_busy=0;
				if(out>in)
				{
					npca110_aux=AUX_PULL;
				}
				else
				{
					npca110_aux=AUX_INSERT;
				}
				out=0;
				in=0;
			}
			if(NPCA110_AUX)
			{
				out++;
			}
			else
			{
				in++;
			}
		}
	}
	else
	{
		if(npca110_exti)
		{
			npca110_exti=0;
			npca110_busy=1;
			npca110_aux=AUX_SHAKE;
		}
	}	
}

void NPCA110_AuxScan_ISR(void)
{
	if(npca110_busy==0)
	{
		npca110_exti=1;
	}
}

void NPCA110_WriteAn1(void)
{
	u8	i=0;
	
	for(i=0;i<27;i++)
	{
		I2C_Start();
		I2C_WriteByte(0xe6);
		I2C_ReadAck();
		NPCA110_WriteNByte(&ain1_tab[3*i],3);
		I2C_Stop();
	}
}

void NPCA110_WriteDig(void)
{
	u8	i=0;
	
	for(i=0;i<19;i++)
	{
		I2C_Start();
		I2C_WriteByte(0xe6);
		I2C_ReadAck();
		NPCA110_WriteNByte(&dig_tab[3*i],3);
		I2C_Stop();
	}
}

void NPCA110_WriteVolume(u8 volume)
{
	u16 word=0;
	u8 byte_high=0;
	u8 byte_low=0;

	word=volume_tab[volume];//-40db=200/5(2db一个等级)
	byte_high=word>>8;
	byte_low=word&0xff;
	I2C_Start();
	I2C_WriteByte(0xe6);
	I2C_ReadAck();
	I2C_WriteByte(byte_high);
	I2C_ReadAck();
	I2C_WriteByte(0xd0);
	I2C_ReadAck();
	I2C_WriteByte(byte_low);
	I2C_ReadAck();
	I2C_Stop();
}

void NPCA110_WriteMute(void)
{
	I2C_Start();
	I2C_WriteByte(0xe6);
	I2C_ReadAck();
	I2C_WriteByte(0x00);
	I2C_ReadAck();
	I2C_WriteByte(0xc7);
	I2C_ReadAck();
	I2C_WriteByte(0x01);
	I2C_ReadAck();
	I2C_Stop();
}

void NPCA110_WriteNMute(void)
{
	I2C_Start();
	I2C_WriteByte(0xe6);
	I2C_ReadAck();
	I2C_WriteByte(0x00);
	I2C_ReadAck();
	I2C_WriteByte(0xc7);
	I2C_ReadAck();
	I2C_WriteByte(0x00);
	I2C_ReadAck();
	I2C_Stop();
}

