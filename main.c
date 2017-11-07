/***********状态机引擎法则:************

	1.一切设备皆文件 一切功能皆算法
	2.任意裁剪驱动 随意更换应用
	3.紧急用前台事件 轮询用后台服务
	4.短暂可用等待延时 持久必用计数延时
	5.设备驱动与设备应用分离
	6.独立设备驱动之间不能互相包含
	7.设备应用之间通过全局共享数据通信
	8.设备应用只调用改设备驱动或系统

	时间:2012-10-25
	程序员:廖佑华
	QQ:1355916440 
	
***************************************/
#include<stm8s103k3.h>
#include"BT.h"
#include"NPCA110.h"
#include"TPA3130.h"
#include"KEY.h"
#include"POWER.h"
#include"NJM7181.h"
#include"BAT.h"
#include"LED.h"

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define MODE_SLEEP 0
#define MODE_OFF 1
#define MODE_ON 2
#define MODE_PLAY 3

#define INPUT_BT 0
#define INPUT_AUX 1 

#define LIST_PREV 1
#define LIST_NEXT 2 

u8 status_mode=MODE_SLEEP;
u8 status_sync=0;
u8 status_volume=8;//4db
u8 status_input=INPUT_BT;
u8 status_pair=0;
u8 status_list=0;
u8 status_call=0;
u8 status_low=0;
u8 status_hang=0;

void KEY_Mode_Ser(void);
void KEY_Volume_Ser(void);
void KEY_Pair_Ser(void);
void KEY_List_Ser(void);
void KEY_Call_Ser(void);
void POWER_Mode_Ser(void);
void BT_Mode_Ser(void);
void BT_Bt_Ser(void);
void BT_Pair_Ser(void);
void BT_List_Ser(void);
void BT_Call_Ser(void);
void BT_Hang_Ser(void);
void NPCA110_Mode_Ser(void);
void NPCA110_Volume_Ser(void);
void NPCA110_Input_Ser(void);
void TPA3130_Mode_Ser(void);
void NJM7181_Mode_Ser(void);
void BAT_Mode_Ser(void);
void BAT_Low_Ser(void);
void LED_Mode_Ser(void);
void LED_Low_Ser(void);

void KEY_Mode_Ser(void)
{
	switch(status_mode)
	{
		case MODE_SLEEP:
		{
			key_stby_t=40000;
			KEY_STBY_Scan_Ser();
			switch(key_style)
			{
				case KEY_STBY_L:
				{
					key_style=0;
					status_mode=MODE_ON;
				}
				break;
			}
		}
		break;

		case MODE_PLAY:
		{
			key_stby_t=5000;
			KEY_STBY_Scan_Ser();
			switch(key_style)
			{
				case KEY_STBY_L:
				{
					key_style=0;
					status_mode=MODE_OFF;
				}
				break;
			}
			KEY_Volume_Ser();
			KEY_Pair_Ser();
			KEY_List_Ser();
			KEY_Call_Ser();
		}
		break;
	}
}

void KEY_Volume_Ser(void)
{
	KEY_UP_Scan_Ser();
	KEY_DOWN_Scan_Ser();
	switch(key_style)                                      
	{
		case KEY_DOWN_S:
		{
			key_style=KEY_NO;
			if(status_volume==VOLUME_MIN)
			{
				status_volume=VOLUME_MIN;
			}
			else
			{
				status_volume--;
			}
		}
		break;

		case KEY_UP_S:
		{
			key_style=KEY_NO;
			if(status_volume==VOLUME_MAX)
			{
				status_volume=VOLUME_MAX;
			}
			else
			{
				status_volume++;
			}
		}
		break;
	}
}

void KEY_Pair_Ser(void)
{
	KEY_PAIR_Scan_Ser();
	switch(key_style)                                      
	{
		case KEY_PAIR_S:
		case KEY_PAIR_L:
		{
			key_style=KEY_NO;
			status_pair=1;
		}
		break;
	}
}

void KEY_List_Ser(void)
{
	KEY_UP_Scan_Ser();
	KEY_DOWN_Scan_Ser();
	switch(key_style)                                      
	{
		case KEY_DOWN_L:
		{
			key_style=KEY_NO;
			status_list=LIST_PREV;
		}
		break;

		case KEY_UP_L:
		{
			key_style=KEY_NO;
			status_list=LIST_NEXT;
			
		}
		break;
	}
}

void KEY_Call_Ser(void)
{
	KEY_CALL_Scan_Ser();
	switch(key_style)                                      
	{
		case KEY_CALL_S:
		{
			key_style=KEY_NO;
			status_call=1;
		}
		break;

		case KEY_CALL_L:
		{
			key_style=KEY_NO;
			status_hang=1;
		}
		break;
	}
}

void POWER_Mode_Ser(void)
{
	static u32 count=0;
	
	switch(status_mode)
	{
		case MODE_ON:
		{
			switch(status_sync)
			{
				case 0:
				{
					POWER_STBY_1();//打开电源
					status_sync=1;
				}
				break;
			}
		}
		break;

		case MODE_OFF:
		{
			switch(status_sync)
			{
				case 8:
				{
					POWER_STBY_0();//关闭电源
					status_sync=0;
					status_mode=MODE_SLEEP;
				}
				break;
			}
		}
		break;
	}
}

void BT_Mode_Ser(void)
{
	static u32 count=0;
	
	switch(status_mode)
	{
		case MODE_ON:
		{
			switch(status_sync)
			{
				case 7:
				{
					BT_EN_1();
					status_sync=8;
				}
				break;

				case 8:
				{
					count++;//26us
					if(count>120000)//等待关机声完全发出
					{
						count=0;
						status_sync=0;
						status_mode=MODE_PLAY;
					}
				}
				break;
			}
		}
		break;

		case MODE_PLAY:
		{
			BT_Bt_Ser();
			BT_Pair_Ser();
			BT_List_Ser();
			BT_Call_Ser();
			BT_Hang_Ser();
		}
		break;

		case MODE_OFF:
		{
			switch(status_sync)
			{
				case 2:
				{
					BT_EN_0();//关蓝牙
					status_sync=3;
				}
				break;

				case 3:
				{
					count++;
					if(count>105000)//等待关机声完全发出
					{
						count=0;
						status_sync=4;
					}
				}
				break;
			}
		}
		break;
	}
}

void BT_Bt_Ser(void)
{
	static u8 status_input_old=0xff;
	static u32 count=0;
	static u8 flag=0;

	if(flag)
	{
		count++;//243us
		if(count>2057)//500ms=0.243*2057
		{
			count=0;
			flag=0;
			switch(status_input_old)
			{
				case INPUT_BT://BT
				{
					BT_EN_1();
				}
				break;	
				
				case INPUT_AUX://AUX
				{
					BT_EN_0();
				}
				break;	
			}
		}
	}
	else
	{
		if(status_input!=status_input_old)
		{
			status_input_old=status_input;
			flag=1;
		}
	}
}

void BT_Pair_Ser(void)
{
	static u8 flag=0;
	static u32 count=0;
	
	if(status_pair)
	{
		status_pair=0;
		flag=1;
	}
	if(flag)
	{
		BT_PAIR_1();
		count++;
		if(count>1000)
		{
			count=0;
			BT_PAIR_0();
			flag=0;
		}
	}
}

void BT_List_Ser(void)
{
	static u8 flag1=0;
	static u8 flag2=0;
	static u32 count=0;
	
	switch(status_list)
	{
		case LIST_PREV:
		{
			status_list=0;
			flag1=1;
			flag2=0;
		}
		break;

		case LIST_NEXT:
		{
			status_list=0;
			flag1=0;
			flag2=1;
		}
		break;
	}
	if(flag1)
	{
		BT_PREV_1();
		count++;
		if(count>1000)
		{
			count=0;
			flag1=0;
			BT_PREV_0();			
		}
	}
	if(flag2)
	{
		BT_NEXT_1();
		count++;
		if(count>1000)
		{
			count=0;
			flag2=0;
			BT_NEXT_0();
		}
	}
}

void BT_Call_Ser(void)
{
	static u8 flag=0;
	static u32 count=0;
	
	if(status_call)
	{
		status_call=0;
		flag=1;
	}
	if(flag)
	{
		BT_CALL_1();
		count++;
		if(count>1000)
		{
			count=0;
			BT_CALL_0();
			flag=0;
		}
	}
}

void BT_Hang_Ser(void)
{
	static u8 flag=0;
	static u32 count=0;
	
	if(status_hang)
	{
		status_hang=0;
		flag=1;
	}
	if(flag)
	{
		BT_CALL_1();
		count++;
		if(count>10000)
		{
			count=0;
			BT_CALL_0();
			flag=0;
		}
	}
}

void NPCA110_Mode_Ser(void)
{
	static u32 count=0;
	
	switch(status_mode)
	{
		case MODE_ON:
		{
			switch(status_sync)
			{
				case 1:
				{
					NPCA110_WriteCofig();
					NPCA110_WriteVolume(status_volume);
					switch(status_input)
					{
						case INPUT_BT:
						{			
							NPCA110_WriteDig();
						}
						break;
				
						case INPUT_AUX:
						{
							NPCA110_WriteAn1();
						}
						break;
					}
					NPCA110_WriteMute();
					status_sync=2;
				}
				break;

				case 2:
				{
					count++;
					if(count>1000)
					{
						count=0;
						status_sync=3;
					}
				}
				break;
				
				case 5:
				{
					NPCA110_WriteNMute();
					status_sync=6;
				}
				break;

				case 6:
				{
					count++;
					if(count>1000)
					{
						count=0;
						status_sync=7;
					}
				}
				break;
			}
		}
		break;
	
		case MODE_PLAY:
		{
			NPCA110_Volume_Ser();
			NPCA110_Input_Ser();
		}
		break;

		case MODE_OFF:
		{
			switch(status_sync)
			{
				case 0:
				{
					NPCA110_WriteNMute();
					NPCA110_WriteVolume(6);//0db关机声
					status_sync=1;
				}
				break;

				case 1:
				{
					count++;
					if(count>1000)
					{
						count=0;
						status_sync=2;
					}
				}
				break;
				
				case 6:
				{
					NPCA110_WriteMute();
					status_sync=7;
				}
				break;

				case 7:
				{
					count++;
					if(count>1000)
					{
						count=0;
						status_sync=8;
					}
				}
				break;
			}
		}
		break;
	}
}

void NPCA110_Volume_Ser(void)
{
	static u8 status_volume_old=0xff;

	if(status_volume!=status_volume_old)
	{
		status_volume_old=status_volume;
		if(status_volume_old)
		{
			NPCA110_WriteVolume(status_volume_old);
			NPCA110_WriteNMute();
		}
		else
		{
			NPCA110_WriteMute();
		}
	}
}

void NPCA110_Input_Ser(void)
{
	static u8 npca110_aux_old=0xff;
	
	NPCA110_AuxScan_Ser();
	if(npca110_aux!=npca110_aux_old)
	{
		npca110_aux_old=npca110_aux;
		status_input=npca110_aux_old;
		switch(npca110_aux_old)
		{
			case INPUT_BT:
			{
				NPCA110_WriteDig();
			}
			break;

			case INPUT_AUX:
			{
				NPCA110_WriteAn1();
			}
			break;
		}
	}
}

void TPA3130_Mode_Ser(void)
{	
	static u32 count=0;
	
	switch(status_mode)
	{
		case MODE_ON:
		{
			switch(status_sync)
			{
				case 3:
				{
					TPA3130_UMUTE_1();//取消静音
					status_sync=4;
				}
				break;

				case 4:
				{
					count++;
					if(count>1000)
					{
						count=0;
						status_sync=5;
					}					
				}
				break;
			}
		}
		break;

		case MODE_OFF:
		{
			switch(status_sync)
			{
				case 4:
				{
					TPA3130_UMUTE_0();//静音
					status_sync=5;
				}
				break;

				case 5:
				{
					count++;
					if(count>1000)//等待静音
					{
						count=0;
						status_sync=6;
					}
				}
				break;
			}
		}
		break;
	}
}

void NJM7181_Mode_Ser(void)
{
	switch(status_mode)
	{
		case MODE_PLAY:
		{
			NJM7181_Nsignal_Ser();
			if(njm7181_sleep)
			{
				njm7181_sleep=0;
				status_mode=MODE_OFF;
			}
		}
		break;
	}
}

void BAT_Mode_Ser(void)
{
	switch(status_mode)
	{
		case MODE_PLAY:
		{
			BAT_Low_Ser();
		}
		break;
	}
}

void BAT_Low_Ser(void)
{
	static u8 bat_low_old=0xff;
	
	BAT_VoltageScan_Ser();
	if(bat_style!=bat_low_old)
	{
		bat_low_old=bat_style;
		status_low=bat_low_old;
	}
}

void LED_Low_Ser(void)
{	
	if(status_low)
	{
		LED_Flash_Ser();
	}
	else
	{
		LED_BAT_1();
	}
}

void LED_Mode_Ser(void)
{
	switch(status_mode)
	{
		case MODE_PLAY:
		{
			LED_Low_Ser();
		}
		break;
	}
}

void main(void)
{	
	CLK_CKDIVR=0x08;//8M	

	KEY_Init();
	POWER_Init();
	BT_Init();
	NPCA110_Init();
	TPA3130_Init();
	NJM7181_Init();
	BAT_Init();
	LED_Init();

	while(1)
	{
/*****************KEY******************/
		KEY_Mode_Ser();
/*****************POWER****************/
		POWER_Mode_Ser();
/*****************BT*******************/
		BT_Mode_Ser();
/*****************NPCA110**************/
		NPCA110_Mode_Ser();
/*****************TPA3130**************/
		TPA3130_Mode_Ser();
/*****************NJM7181**************/
		NJM7181_Mode_Ser();
/*****************BAT******************/
		BAT_Mode_Ser();
/*****************LED******************/
		LED_Mode_Ser();
	}
}

