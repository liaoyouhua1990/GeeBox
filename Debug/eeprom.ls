   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2611                     ; 3 void EEPROM_WriteByte(u8 address,u8 byte)
2611                     ; 4 {
2613                     	switch	.text
2614  0000               _EEPROM_WriteByte:
2616  0000 89            	pushw	x
2617  0001 5204          	subw	sp,#4
2618       00000004      OFST:	set	4
2621                     ; 5 	u8 *p=0;
2623  0003 1e01          	ldw	x,(OFST-3,sp)
2624                     ; 6 	u8 i=0;
2626  0005 0f03          	clr	(OFST-1,sp)
2627                     ; 7 	u8 j=0;
2629  0007 0f04          	clr	(OFST+0,sp)
2630                     ; 9 	p=(u8 *)0x4000+address;
2632  0009 a640          	ld	a,#64
2633  000b 97            	ld	xl,a
2634  000c a600          	ld	a,#0
2635  000e 1b05          	add	a,(OFST+1,sp)
2636  0010 2401          	jrnc	L6
2637  0012 5c            	incw	x
2638  0013               L6:
2639  0013 02            	rlwa	x,a
2640  0014 1f01          	ldw	(OFST-3,sp),x
2641  0016 01            	rrwa	x,a
2642  0017               L7761:
2643                     ; 12 		FLASH_DUKR=0xae;
2645  0017 35ae5064      	mov	_FLASH_DUKR,#174
2646                     ; 13 		FLASH_DUKR=0x56;
2648  001b 35565064      	mov	_FLASH_DUKR,#86
2649                     ; 14 		i++;
2651  001f 0c03          	inc	(OFST-1,sp)
2652                     ; 16 	while(((FLASH_IAPSR&0x08)==0)&&(i<10));
2654  0021 c6505f        	ld	a,_FLASH_IAPSR
2655  0024 a508          	bcp	a,#8
2656  0026 2606          	jrne	L5071
2658  0028 7b03          	ld	a,(OFST-1,sp)
2659  002a a10a          	cp	a,#10
2660  002c 25e9          	jrult	L7761
2661  002e               L5071:
2662                     ; 17 	*p=byte;
2664  002e 7b06          	ld	a,(OFST+2,sp)
2665  0030 1e01          	ldw	x,(OFST-3,sp)
2666  0032 f7            	ld	(x),a
2668  0033 2002          	jra	L3171
2669  0035               L7071:
2670                     ; 20 		j++;
2672  0035 0c04          	inc	(OFST+0,sp)
2673  0037               L3171:
2674                     ; 18 	while(((FLASH_IAPSR&0x04)==0)&&(j<10))
2676  0037 c6505f        	ld	a,_FLASH_IAPSR
2677  003a a504          	bcp	a,#4
2678  003c 2606          	jrne	L7171
2680  003e 7b04          	ld	a,(OFST+0,sp)
2681  0040 a10a          	cp	a,#10
2682  0042 25f1          	jrult	L7071
2683  0044               L7171:
2684                     ; 22 }
2687  0044 5b06          	addw	sp,#6
2688  0046 81            	ret
2741                     ; 24 u8 EEPROM_ReadByte(u8 address)
2741                     ; 25 {
2742                     	switch	.text
2743  0047               _EEPROM_ReadByte:
2745  0047 88            	push	a
2746  0048 5203          	subw	sp,#3
2747       00000003      OFST:	set	3
2750                     ; 26 	u8 *p=0;
2752  004a 1e01          	ldw	x,(OFST-2,sp)
2753                     ; 27 	u8 byte=0;
2755  004c 7b03          	ld	a,(OFST+0,sp)
2756  004e 97            	ld	xl,a
2757                     ; 29 	p=(u8 *)0x4000+address;
2759  004f a640          	ld	a,#64
2760  0051 97            	ld	xl,a
2761  0052 a600          	ld	a,#0
2762  0054 1b04          	add	a,(OFST+1,sp)
2763  0056 2401          	jrnc	L21
2764  0058 5c            	incw	x
2765  0059               L21:
2766  0059 02            	rlwa	x,a
2767  005a 1f01          	ldw	(OFST-2,sp),x
2768  005c 01            	rrwa	x,a
2769                     ; 30 	byte=*p;
2771  005d 1e01          	ldw	x,(OFST-2,sp)
2772  005f f6            	ld	a,(x)
2773  0060 6b03          	ld	(OFST+0,sp),a
2774                     ; 31 	return byte;
2776  0062 7b03          	ld	a,(OFST+0,sp)
2779  0064 5b04          	addw	sp,#4
2780  0066 81            	ret
2803                     ; 34 void EEPROM_Init(void)
2803                     ; 35 {
2804                     	switch	.text
2805  0067               _EEPROM_Init:
2809                     ; 39 }
2812  0067 81            	ret
2825                     	xdef	_EEPROM_ReadByte
2826                     	xdef	_EEPROM_WriteByte
2827                     	xdef	_EEPROM_Init
2846                     	end
