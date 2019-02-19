   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  14                     	bsct
  15  0000               _current_millis:
  16  0000 00000000      	dc.l	0
  52                     ; 11 void Millis_Init(void)
  52                     ; 12 {
  54                     	switch	.text
  55  0000               _Millis_Init:
  59                     ; 13 	TIM4_DeInit();
  61  0000 cd0000        	call	_TIM4_DeInit
  63                     ; 15         CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //f_master = HSI = 16Mhz
  65  0003 4f            	clr	a
  66  0004 cd0000        	call	_CLK_HSIPrescalerConfig
  68                     ; 17 	TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
  70  0007 ae077d        	ldw	x,#1917
  71  000a cd0000        	call	_TIM4_TimeBaseInit
  73                     ; 19 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  75  000d a601          	ld	a,#1
  76  000f cd0000        	call	_TIM4_ClearFlag
  78                     ; 21         TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  80  0012 ae0101        	ldw	x,#257
  81  0015 cd0000        	call	_TIM4_ITConfig
  83                     ; 23 	enableInterrupts();
  86  0018 9a            rim
  88                     ; 25 	TIM4_Cmd(ENABLE);
  91  0019 a601          	ld	a,#1
  92  001b cd0000        	call	_TIM4_Cmd
  94                     ; 26 }
  97  001e 81            	ret
 121                     ; 30 uint32_t millis(void)
 121                     ; 31 
 121                     ; 32 {
 122                     	switch	.text
 123  001f               _millis:
 127                     ; 33 	return current_millis;
 129  001f ae0000        	ldw	x,#_current_millis
 130  0022 cd0000        	call	c_ltor
 134  0025 81            	ret
 181                     ; 45 void Delay_US(uint16_t time)
 181                     ; 46 {
 182                     	switch	.text
 183  0026               _Delay_US:
 185  0026 89            	pushw	x
 186       00000000      OFST:	set	0
 189  0027 200d          	jra	L15
 190  0029               L74:
 191                     ; 49     nop();
 194  0029 9d            nop
 196                     ; 50     nop();
 200  002a 9d            nop
 202                     ; 51     nop();
 206  002b 9d            nop
 208                     ; 52     nop();
 212  002c 9d            nop
 214                     ; 53     nop();
 218  002d 9d            nop
 220                     ; 54     nop();
 224  002e 9d            nop
 226                     ; 55     nop();
 230  002f 9d            nop
 232                     ; 56     nop();
 236  0030 9d            nop
 238                     ; 57     nop();
 242  0031 9d            nop
 244                     ; 58     nop();
 248  0032 9d            nop
 250                     ; 59     nop();
 254  0033 9d            nop
 256                     ; 60     nop();
 260  0034 9d            nop
 262                     ; 61     nop();
 266  0035 9d            nop
 269  0036               L15:
 270                     ; 47   while(time--)
 272  0036 1e01          	ldw	x,(OFST+1,sp)
 273  0038 1d0001        	subw	x,#1
 274  003b 1f01          	ldw	(OFST+1,sp),x
 275  003d 1c0001        	addw	x,#1
 276  0040 a30000        	cpw	x,#0
 277  0043 26e4          	jrne	L74
 278                     ; 63 }
 281  0045 85            	popw	x
 282  0046 81            	ret
 317                     ; 66 void Delay_MS(uint16_t time)
 317                     ; 67 {
 318                     	switch	.text
 319  0047               _Delay_MS:
 321  0047 89            	pushw	x
 322       00000000      OFST:	set	0
 325  0048 2005          	jra	L57
 326  004a               L37:
 327                     ; 70     Delay_US(1000);
 329  004a ae03e8        	ldw	x,#1000
 330  004d add7          	call	_Delay_US
 332  004f               L57:
 333                     ; 68   while(time--)
 335  004f 1e01          	ldw	x,(OFST+1,sp)
 336  0051 1d0001        	subw	x,#1
 337  0054 1f01          	ldw	(OFST+1,sp),x
 338  0056 1c0001        	addw	x,#1
 339  0059 a30000        	cpw	x,#0
 340  005c 26ec          	jrne	L37
 341                     ; 72 }
 344  005e 85            	popw	x
 345  005f 81            	ret
 371                     ; 78 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23) 
 371                     ; 79 
 371                     ; 80 {   
 373                     	switch	.text
 374  0060               f_TIM4_UPD_OVF_IRQHandler:
 376  0060 8a            	push	cc
 377  0061 84            	pop	a
 378  0062 a4bf          	and	a,#191
 379  0064 88            	push	a
 380  0065 86            	pop	cc
 381  0066 3b0002        	push	c_x+2
 382  0069 be00          	ldw	x,c_x
 383  006b 89            	pushw	x
 384  006c 3b0002        	push	c_y+2
 385  006f be00          	ldw	x,c_y
 386  0071 89            	pushw	x
 389                     ; 82 	current_millis ++;
 391  0072 ae0000        	ldw	x,#_current_millis
 392  0075 a601          	ld	a,#1
 393  0077 cd0000        	call	c_lgadc
 395                     ; 83 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 397  007a a601          	ld	a,#1
 398  007c cd0000        	call	_TIM4_ClearITPendingBit
 400                     ; 84 }
 403  007f 85            	popw	x
 404  0080 bf00          	ldw	c_y,x
 405  0082 320002        	pop	c_y+2
 406  0085 85            	popw	x
 407  0086 bf00          	ldw	c_x,x
 408  0088 320002        	pop	c_x+2
 409  008b 80            	iret
 432                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 433                     	xdef	_current_millis
 434                     	xdef	_millis
 435                     	xdef	_Delay_MS
 436                     	xdef	_Delay_US
 437                     	xdef	_Millis_Init
 438                     	xref	_TIM4_ClearITPendingBit
 439                     	xref	_TIM4_ClearFlag
 440                     	xref	_TIM4_ITConfig
 441                     	xref	_TIM4_Cmd
 442                     	xref	_TIM4_TimeBaseInit
 443                     	xref	_TIM4_DeInit
 444                     	xref	_CLK_HSIPrescalerConfig
 445                     	xref.b	c_x
 446                     	xref.b	c_y
 465                     	xref	c_lgadc
 466                     	xref	c_ltor
 467                     	end
