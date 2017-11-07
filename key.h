#ifndef  _KEY_H_
#define  _KEY_H_

#include<stm8s103k3.h>

#define u8 unsigned char
#define u16 unsigned int
#define u32 unsigned long

#define KEY_STBY (PA_IDR&(1<<1))

#define KEY_NO 0
#define KEY_DOWN_S 1
#define KEY_DOWN_L 2
#define KEY_UP_S 3
#define KEY_UP_L 4
#define KEY_STBY_S 5
#define KEY_STBY_L 6
#define KEY_CALL_S 7
#define KEY_CALL_L 8
#define KEY_PAIR_S 9
#define KEY_PAIR_L 10

extern u16 key_stby_t;
extern u8 key_style;

void KEY_Init(void);
void KEY_STBY_Scan_Ser(void);
void KEY_UP_Scan_Ser(void);
void KEY_DOWN_Scan_Ser(void);
void KEY_CALL_Scan_Ser(void);
void KEY_PAIR_Scan_Ser(void);

#endif

