   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2563                     ; 11 @far @interrupt void NonHandledInterrupt (void)
2563                     ; 12 {
2564                     	switch	.text
2565  0000               f_NonHandledInterrupt:
2570                     ; 16 	return;
2573  0000 80            	iret
2596                     ; 19 @far @interrupt void EXTI2_Handle(void)
2596                     ; 20 {
2597                     	switch	.text
2598  0001               f_EXTI2_Handle:
2601  0001 3b0002        	push	c_x+2
2602  0004 be00          	ldw	x,c_x
2603  0006 89            	pushw	x
2604  0007 3b0002        	push	c_y+2
2605  000a be00          	ldw	x,c_y
2606  000c 89            	pushw	x
2609                     ; 21 	NPCA110_AuxScan_ISR();
2611  000d cd0000        	call	_NPCA110_AuxScan_ISR
2613                     ; 22 }
2616  0010 85            	popw	x
2617  0011 bf00          	ldw	c_y,x
2618  0013 320002        	pop	c_y+2
2619  0016 85            	popw	x
2620  0017 bf00          	ldw	c_x,x
2621  0019 320002        	pop	c_x+2
2622  001c 80            	iret
2645                     ; 24 @far @interrupt void EXTI0_Handle(void)
2645                     ; 25 {
2646                     	switch	.text
2647  001d               f_EXTI0_Handle:
2650  001d 3b0002        	push	c_x+2
2651  0020 be00          	ldw	x,c_x
2652  0022 89            	pushw	x
2653  0023 3b0002        	push	c_y+2
2654  0026 be00          	ldw	x,c_y
2655  0028 89            	pushw	x
2658                     ; 26 	NJM7181_Scan_ISR();
2660  0029 cd0000        	call	_NJM7181_Scan_ISR
2662                     ; 27 }
2665  002c 85            	popw	x
2666  002d bf00          	ldw	c_y,x
2667  002f 320002        	pop	c_y+2
2668  0032 85            	popw	x
2669  0033 bf00          	ldw	c_x,x
2670  0035 320002        	pop	c_x+2
2671  0038 80            	iret
2673                     .const:	section	.text
2674  0000               __vectab:
2675  0000 82            	dc.b	130
2677  0001 00            	dc.b	page(__stext)
2678  0002 0000          	dc.w	__stext
2679  0004 82            	dc.b	130
2681  0005 00            	dc.b	page(f_NonHandledInterrupt)
2682  0006 0000          	dc.w	f_NonHandledInterrupt
2683  0008 82            	dc.b	130
2685  0009 00            	dc.b	page(f_NonHandledInterrupt)
2686  000a 0000          	dc.w	f_NonHandledInterrupt
2687  000c 82            	dc.b	130
2689  000d 00            	dc.b	page(f_NonHandledInterrupt)
2690  000e 0000          	dc.w	f_NonHandledInterrupt
2691  0010 82            	dc.b	130
2693  0011 00            	dc.b	page(f_NonHandledInterrupt)
2694  0012 0000          	dc.w	f_NonHandledInterrupt
2695  0014 82            	dc.b	130
2697  0015 1d            	dc.b	page(f_EXTI0_Handle)
2698  0016 001d          	dc.w	f_EXTI0_Handle
2699  0018 82            	dc.b	130
2701  0019 00            	dc.b	page(f_NonHandledInterrupt)
2702  001a 0000          	dc.w	f_NonHandledInterrupt
2703  001c 82            	dc.b	130
2705  001d 01            	dc.b	page(f_EXTI2_Handle)
2706  001e 0001          	dc.w	f_EXTI2_Handle
2707  0020 82            	dc.b	130
2709  0021 00            	dc.b	page(f_NonHandledInterrupt)
2710  0022 0000          	dc.w	f_NonHandledInterrupt
2711  0024 82            	dc.b	130
2713  0025 00            	dc.b	page(f_NonHandledInterrupt)
2714  0026 0000          	dc.w	f_NonHandledInterrupt
2715  0028 82            	dc.b	130
2717  0029 00            	dc.b	page(f_NonHandledInterrupt)
2718  002a 0000          	dc.w	f_NonHandledInterrupt
2719  002c 82            	dc.b	130
2721  002d 00            	dc.b	page(f_NonHandledInterrupt)
2722  002e 0000          	dc.w	f_NonHandledInterrupt
2723  0030 82            	dc.b	130
2725  0031 00            	dc.b	page(f_NonHandledInterrupt)
2726  0032 0000          	dc.w	f_NonHandledInterrupt
2727  0034 82            	dc.b	130
2729  0035 00            	dc.b	page(f_NonHandledInterrupt)
2730  0036 0000          	dc.w	f_NonHandledInterrupt
2731  0038 82            	dc.b	130
2733  0039 00            	dc.b	page(f_NonHandledInterrupt)
2734  003a 0000          	dc.w	f_NonHandledInterrupt
2735  003c 82            	dc.b	130
2737  003d 00            	dc.b	page(f_NonHandledInterrupt)
2738  003e 0000          	dc.w	f_NonHandledInterrupt
2739  0040 82            	dc.b	130
2741  0041 00            	dc.b	page(f_NonHandledInterrupt)
2742  0042 0000          	dc.w	f_NonHandledInterrupt
2743  0044 82            	dc.b	130
2745  0045 00            	dc.b	page(f_NonHandledInterrupt)
2746  0046 0000          	dc.w	f_NonHandledInterrupt
2747  0048 82            	dc.b	130
2749  0049 00            	dc.b	page(f_NonHandledInterrupt)
2750  004a 0000          	dc.w	f_NonHandledInterrupt
2751  004c 82            	dc.b	130
2753  004d 00            	dc.b	page(f_NonHandledInterrupt)
2754  004e 0000          	dc.w	f_NonHandledInterrupt
2755  0050 82            	dc.b	130
2757  0051 00            	dc.b	page(f_NonHandledInterrupt)
2758  0052 0000          	dc.w	f_NonHandledInterrupt
2759  0054 82            	dc.b	130
2761  0055 00            	dc.b	page(f_NonHandledInterrupt)
2762  0056 0000          	dc.w	f_NonHandledInterrupt
2763  0058 82            	dc.b	130
2765  0059 00            	dc.b	page(f_NonHandledInterrupt)
2766  005a 0000          	dc.w	f_NonHandledInterrupt
2767  005c 82            	dc.b	130
2769  005d 00            	dc.b	page(f_NonHandledInterrupt)
2770  005e 0000          	dc.w	f_NonHandledInterrupt
2771  0060 82            	dc.b	130
2773  0061 00            	dc.b	page(f_NonHandledInterrupt)
2774  0062 0000          	dc.w	f_NonHandledInterrupt
2775  0064 82            	dc.b	130
2777  0065 00            	dc.b	page(f_NonHandledInterrupt)
2778  0066 0000          	dc.w	f_NonHandledInterrupt
2779  0068 82            	dc.b	130
2781  0069 00            	dc.b	page(f_NonHandledInterrupt)
2782  006a 0000          	dc.w	f_NonHandledInterrupt
2783  006c 82            	dc.b	130
2785  006d 00            	dc.b	page(f_NonHandledInterrupt)
2786  006e 0000          	dc.w	f_NonHandledInterrupt
2787  0070 82            	dc.b	130
2789  0071 00            	dc.b	page(f_NonHandledInterrupt)
2790  0072 0000          	dc.w	f_NonHandledInterrupt
2791  0074 82            	dc.b	130
2793  0075 00            	dc.b	page(f_NonHandledInterrupt)
2794  0076 0000          	dc.w	f_NonHandledInterrupt
2795  0078 82            	dc.b	130
2797  0079 00            	dc.b	page(f_NonHandledInterrupt)
2798  007a 0000          	dc.w	f_NonHandledInterrupt
2799  007c 82            	dc.b	130
2801  007d 00            	dc.b	page(f_NonHandledInterrupt)
2802  007e 0000          	dc.w	f_NonHandledInterrupt
2853                     	xdef	__vectab
2854                     	xref	__stext
2855                     	xdef	f_EXTI0_Handle
2856                     	xdef	f_EXTI2_Handle
2857                     	xdef	f_NonHandledInterrupt
2858                     	xref	_NJM7181_Scan_ISR
2859                     	xref	_NPCA110_AuxScan_ISR
2860                     	xref.b	c_x
2861                     	xref.b	c_y
2880                     	end
