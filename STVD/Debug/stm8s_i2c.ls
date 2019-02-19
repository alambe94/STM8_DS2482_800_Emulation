   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 67 void I2C_DeInit(void)
  42                     ; 68 {
  44                     	switch	.text
  45  0000               _I2C_DeInit:
  49                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  51  0000 725f5210      	clr	21008
  52                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  54  0004 725f5211      	clr	21009
  55                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  57  0008 725f5212      	clr	21010
  58                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  60  000c 725f5213      	clr	21011
  61                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  63  0010 725f5214      	clr	21012
  64                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  66  0014 725f521a      	clr	21018
  67                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  69  0018 725f521b      	clr	21019
  70                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  72  001c 725f521c      	clr	21020
  73                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  75  0020 3502521d      	mov	21021,#2
  76                     ; 78 }
  79  0024 81            	ret
 259                     .const:	section	.text
 260  0000               L44:
 261  0000 00061a81      	dc.l	400001
 262  0004               L05:
 263  0004 000186a1      	dc.l	100001
 264                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 264                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 264                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 264                     ; 99 {
 265                     	switch	.text
 266  0025               _I2C_Init:
 268  0025 520d          	subw	sp,#13
 269       0000000d      OFST:	set	13
 272                     ; 100   uint16_t result = 0x0004;
 274                     ; 101   uint16_t tmpval = 0;
 276                     ; 102   uint8_t tmpccrh = 0;
 278  0027 0f0b          	clr	(OFST-2,sp)
 280                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
 282  0029 0d17          	tnz	(OFST+10,sp)
 283  002b 270c          	jreq	L21
 284  002d 7b17          	ld	a,(OFST+10,sp)
 285  002f a101          	cp	a,#1
 286  0031 2706          	jreq	L21
 287  0033 7b17          	ld	a,(OFST+10,sp)
 288  0035 a102          	cp	a,#2
 289  0037 2603          	jrne	L01
 290  0039               L21:
 291  0039 4f            	clr	a
 292  003a 2010          	jra	L41
 293  003c               L01:
 294  003c ae0069        	ldw	x,#105
 295  003f 89            	pushw	x
 296  0040 ae0000        	ldw	x,#0
 297  0043 89            	pushw	x
 298  0044 ae0008        	ldw	x,#L131
 299  0047 cd0000        	call	_assert_failed
 301  004a 5b04          	addw	sp,#4
 302  004c               L41:
 303                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 305  004c 0d18          	tnz	(OFST+11,sp)
 306  004e 2706          	jreq	L02
 307  0050 7b18          	ld	a,(OFST+11,sp)
 308  0052 a180          	cp	a,#128
 309  0054 2603          	jrne	L61
 310  0056               L02:
 311  0056 4f            	clr	a
 312  0057 2010          	jra	L22
 313  0059               L61:
 314  0059 ae006a        	ldw	x,#106
 315  005c 89            	pushw	x
 316  005d ae0000        	ldw	x,#0
 317  0060 89            	pushw	x
 318  0061 ae0008        	ldw	x,#L131
 319  0064 cd0000        	call	_assert_failed
 321  0067 5b04          	addw	sp,#4
 322  0069               L22:
 323                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 325  0069 1e14          	ldw	x,(OFST+7,sp)
 326  006b a30400        	cpw	x,#1024
 327  006e 2403          	jruge	L42
 328  0070 4f            	clr	a
 329  0071 2010          	jra	L62
 330  0073               L42:
 331  0073 ae006b        	ldw	x,#107
 332  0076 89            	pushw	x
 333  0077 ae0000        	ldw	x,#0
 334  007a 89            	pushw	x
 335  007b ae0008        	ldw	x,#L131
 336  007e cd0000        	call	_assert_failed
 338  0081 5b04          	addw	sp,#4
 339  0083               L62:
 340                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 342  0083 0d16          	tnz	(OFST+9,sp)
 343  0085 2706          	jreq	L23
 344  0087 7b16          	ld	a,(OFST+9,sp)
 345  0089 a140          	cp	a,#64
 346  008b 2603          	jrne	L03
 347  008d               L23:
 348  008d 4f            	clr	a
 349  008e 2010          	jra	L43
 350  0090               L03:
 351  0090 ae006c        	ldw	x,#108
 352  0093 89            	pushw	x
 353  0094 ae0000        	ldw	x,#0
 354  0097 89            	pushw	x
 355  0098 ae0008        	ldw	x,#L131
 356  009b cd0000        	call	_assert_failed
 358  009e 5b04          	addw	sp,#4
 359  00a0               L43:
 360                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 362  00a0 0d19          	tnz	(OFST+12,sp)
 363  00a2 2709          	jreq	L63
 364  00a4 7b19          	ld	a,(OFST+12,sp)
 365  00a6 a111          	cp	a,#17
 366  00a8 2403          	jruge	L63
 367  00aa 4f            	clr	a
 368  00ab 2010          	jra	L04
 369  00ad               L63:
 370  00ad ae006d        	ldw	x,#109
 371  00b0 89            	pushw	x
 372  00b1 ae0000        	ldw	x,#0
 373  00b4 89            	pushw	x
 374  00b5 ae0008        	ldw	x,#L131
 375  00b8 cd0000        	call	_assert_failed
 377  00bb 5b04          	addw	sp,#4
 378  00bd               L04:
 379                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 381  00bd 96            	ldw	x,sp
 382  00be 1c0010        	addw	x,#OFST+3
 383  00c1 cd0000        	call	c_lzmp
 385  00c4 2712          	jreq	L24
 386  00c6 96            	ldw	x,sp
 387  00c7 1c0010        	addw	x,#OFST+3
 388  00ca cd0000        	call	c_ltor
 390  00cd ae0000        	ldw	x,#L44
 391  00d0 cd0000        	call	c_lcmp
 393  00d3 2403          	jruge	L24
 394  00d5 4f            	clr	a
 395  00d6 2010          	jra	L64
 396  00d8               L24:
 397  00d8 ae006e        	ldw	x,#110
 398  00db 89            	pushw	x
 399  00dc ae0000        	ldw	x,#0
 400  00df 89            	pushw	x
 401  00e0 ae0008        	ldw	x,#L131
 402  00e3 cd0000        	call	_assert_failed
 404  00e6 5b04          	addw	sp,#4
 405  00e8               L64:
 406                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 408  00e8 c65212        	ld	a,21010
 409  00eb a4c0          	and	a,#192
 410  00ed c75212        	ld	21010,a
 411                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 413  00f0 c65212        	ld	a,21010
 414  00f3 1a19          	or	a,(OFST+12,sp)
 415  00f5 c75212        	ld	21010,a
 416                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 418  00f8 72115210      	bres	21008,#0
 419                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 421  00fc c6521c        	ld	a,21020
 422  00ff a430          	and	a,#48
 423  0101 c7521c        	ld	21020,a
 424                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 426  0104 725f521b      	clr	21019
 427                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 429  0108 96            	ldw	x,sp
 430  0109 1c0010        	addw	x,#OFST+3
 431  010c cd0000        	call	c_ltor
 433  010f ae0004        	ldw	x,#L05
 434  0112 cd0000        	call	c_lcmp
 436  0115 2403          	jruge	L25
 437  0117 cc01ca        	jp	L331
 438  011a               L25:
 439                     ; 131     tmpccrh = I2C_CCRH_FS;
 441  011a a680          	ld	a,#128
 442  011c 6b0b          	ld	(OFST-2,sp),a
 444                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 446  011e 0d16          	tnz	(OFST+9,sp)
 447  0120 2642          	jrne	L531
 448                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 450  0122 96            	ldw	x,sp
 451  0123 1c0010        	addw	x,#OFST+3
 452  0126 cd0000        	call	c_ltor
 454  0129 a603          	ld	a,#3
 455  012b cd0000        	call	c_smul
 457  012e 96            	ldw	x,sp
 458  012f 1c0005        	addw	x,#OFST-8
 459  0132 cd0000        	call	c_rtol
 462  0135 7b19          	ld	a,(OFST+12,sp)
 463  0137 b703          	ld	c_lreg+3,a
 464  0139 3f02          	clr	c_lreg+2
 465  013b 3f01          	clr	c_lreg+1
 466  013d 3f00          	clr	c_lreg
 467  013f 96            	ldw	x,sp
 468  0140 1c0001        	addw	x,#OFST-12
 469  0143 cd0000        	call	c_rtol
 472  0146 ae4240        	ldw	x,#16960
 473  0149 bf02          	ldw	c_lreg+2,x
 474  014b ae000f        	ldw	x,#15
 475  014e bf00          	ldw	c_lreg,x
 476  0150 96            	ldw	x,sp
 477  0151 1c0001        	addw	x,#OFST-12
 478  0154 cd0000        	call	c_lmul
 480  0157 96            	ldw	x,sp
 481  0158 1c0005        	addw	x,#OFST-8
 482  015b cd0000        	call	c_ludv
 484  015e be02          	ldw	x,c_lreg+2
 485  0160 1f0c          	ldw	(OFST-1,sp),x
 488  0162 2046          	jra	L731
 489  0164               L531:
 490                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 492  0164 96            	ldw	x,sp
 493  0165 1c0010        	addw	x,#OFST+3
 494  0168 cd0000        	call	c_ltor
 496  016b a619          	ld	a,#25
 497  016d cd0000        	call	c_smul
 499  0170 96            	ldw	x,sp
 500  0171 1c0005        	addw	x,#OFST-8
 501  0174 cd0000        	call	c_rtol
 504  0177 7b19          	ld	a,(OFST+12,sp)
 505  0179 b703          	ld	c_lreg+3,a
 506  017b 3f02          	clr	c_lreg+2
 507  017d 3f01          	clr	c_lreg+1
 508  017f 3f00          	clr	c_lreg
 509  0181 96            	ldw	x,sp
 510  0182 1c0001        	addw	x,#OFST-12
 511  0185 cd0000        	call	c_rtol
 514  0188 ae4240        	ldw	x,#16960
 515  018b bf02          	ldw	c_lreg+2,x
 516  018d ae000f        	ldw	x,#15
 517  0190 bf00          	ldw	c_lreg,x
 518  0192 96            	ldw	x,sp
 519  0193 1c0001        	addw	x,#OFST-12
 520  0196 cd0000        	call	c_lmul
 522  0199 96            	ldw	x,sp
 523  019a 1c0005        	addw	x,#OFST-8
 524  019d cd0000        	call	c_ludv
 526  01a0 be02          	ldw	x,c_lreg+2
 527  01a2 1f0c          	ldw	(OFST-1,sp),x
 529                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 531  01a4 7b0b          	ld	a,(OFST-2,sp)
 532  01a6 aa40          	or	a,#64
 533  01a8 6b0b          	ld	(OFST-2,sp),a
 535  01aa               L731:
 536                     ; 147     if (result < (uint16_t)0x01)
 538  01aa 1e0c          	ldw	x,(OFST-1,sp)
 539  01ac 2605          	jrne	L141
 540                     ; 150       result = (uint16_t)0x0001;
 542  01ae ae0001        	ldw	x,#1
 543  01b1 1f0c          	ldw	(OFST-1,sp),x
 545  01b3               L141:
 546                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 548  01b3 ae0003        	ldw	x,#3
 549  01b6 7b19          	ld	a,(OFST+12,sp)
 550  01b8 cd0000        	call	c_bmulx
 552  01bb a60a          	ld	a,#10
 553  01bd cd0000        	call	c_sdivx
 555  01c0 5c            	incw	x
 556  01c1 1f09          	ldw	(OFST-4,sp),x
 558                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 560  01c3 7b0a          	ld	a,(OFST-3,sp)
 561  01c5 c7521d        	ld	21021,a
 563  01c8 2055          	jra	L341
 564  01ca               L331:
 565                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 567  01ca 96            	ldw	x,sp
 568  01cb 1c0010        	addw	x,#OFST+3
 569  01ce cd0000        	call	c_ltor
 571  01d1 3803          	sll	c_lreg+3
 572  01d3 3902          	rlc	c_lreg+2
 573  01d5 3901          	rlc	c_lreg+1
 574  01d7 3900          	rlc	c_lreg
 575  01d9 96            	ldw	x,sp
 576  01da 1c0005        	addw	x,#OFST-8
 577  01dd cd0000        	call	c_rtol
 580  01e0 7b19          	ld	a,(OFST+12,sp)
 581  01e2 b703          	ld	c_lreg+3,a
 582  01e4 3f02          	clr	c_lreg+2
 583  01e6 3f01          	clr	c_lreg+1
 584  01e8 3f00          	clr	c_lreg
 585  01ea 96            	ldw	x,sp
 586  01eb 1c0001        	addw	x,#OFST-12
 587  01ee cd0000        	call	c_rtol
 590  01f1 ae4240        	ldw	x,#16960
 591  01f4 bf02          	ldw	c_lreg+2,x
 592  01f6 ae000f        	ldw	x,#15
 593  01f9 bf00          	ldw	c_lreg,x
 594  01fb 96            	ldw	x,sp
 595  01fc 1c0001        	addw	x,#OFST-12
 596  01ff cd0000        	call	c_lmul
 598  0202 96            	ldw	x,sp
 599  0203 1c0005        	addw	x,#OFST-8
 600  0206 cd0000        	call	c_ludv
 602  0209 be02          	ldw	x,c_lreg+2
 603  020b 1f0c          	ldw	(OFST-1,sp),x
 605                     ; 167     if (result < (uint16_t)0x0004)
 607  020d 1e0c          	ldw	x,(OFST-1,sp)
 608  020f a30004        	cpw	x,#4
 609  0212 2405          	jruge	L541
 610                     ; 170       result = (uint16_t)0x0004;
 612  0214 ae0004        	ldw	x,#4
 613  0217 1f0c          	ldw	(OFST-1,sp),x
 615  0219               L541:
 616                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 618  0219 7b19          	ld	a,(OFST+12,sp)
 619  021b 4c            	inc	a
 620  021c c7521d        	ld	21021,a
 621  021f               L341:
 622                     ; 181   I2C->CCRL = (uint8_t)result;
 624  021f 7b0d          	ld	a,(OFST+0,sp)
 625  0221 c7521b        	ld	21019,a
 626                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 628  0224 7b0c          	ld	a,(OFST-1,sp)
 629  0226 a40f          	and	a,#15
 630  0228 1a0b          	or	a,(OFST-2,sp)
 631  022a c7521c        	ld	21020,a
 632                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 634  022d 72105210      	bset	21008,#0
 635                     ; 188   I2C_AcknowledgeConfig(Ack);
 637  0231 7b17          	ld	a,(OFST+10,sp)
 638  0233 cd0355        	call	_I2C_AcknowledgeConfig
 640                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 642  0236 7b15          	ld	a,(OFST+8,sp)
 643  0238 c75213        	ld	21011,a
 644                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 644                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 646  023b 1e14          	ldw	x,(OFST+7,sp)
 647  023d 4f            	clr	a
 648  023e 01            	rrwa	x,a
 649  023f 48            	sll	a
 650  0240 59            	rlcw	x
 651  0241 01            	rrwa	x,a
 652  0242 a406          	and	a,#6
 653  0244 5f            	clrw	x
 654  0245 6b08          	ld	(OFST-5,sp),a
 656  0247 7b18          	ld	a,(OFST+11,sp)
 657  0249 aa40          	or	a,#64
 658  024b 1a08          	or	a,(OFST-5,sp)
 659  024d c75214        	ld	21012,a
 660                     ; 194 }
 663  0250 5b0d          	addw	sp,#13
 664  0252 81            	ret
 720                     ; 202 void I2C_Cmd(FunctionalState NewState)
 720                     ; 203 {
 721                     	switch	.text
 722  0253               _I2C_Cmd:
 724  0253 88            	push	a
 725       00000000      OFST:	set	0
 728                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 730  0254 4d            	tnz	a
 731  0255 2704          	jreq	L06
 732  0257 a101          	cp	a,#1
 733  0259 2603          	jrne	L65
 734  025b               L06:
 735  025b 4f            	clr	a
 736  025c 2010          	jra	L26
 737  025e               L65:
 738  025e ae00cd        	ldw	x,#205
 739  0261 89            	pushw	x
 740  0262 ae0000        	ldw	x,#0
 741  0265 89            	pushw	x
 742  0266 ae0008        	ldw	x,#L131
 743  0269 cd0000        	call	_assert_failed
 745  026c 5b04          	addw	sp,#4
 746  026e               L26:
 747                     ; 207   if (NewState != DISABLE)
 749  026e 0d01          	tnz	(OFST+1,sp)
 750  0270 2706          	jreq	L571
 751                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 753  0272 72105210      	bset	21008,#0
 755  0276 2004          	jra	L771
 756  0278               L571:
 757                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 759  0278 72115210      	bres	21008,#0
 760  027c               L771:
 761                     ; 217 }
 764  027c 84            	pop	a
 765  027d 81            	ret
 801                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 801                     ; 226 {
 802                     	switch	.text
 803  027e               _I2C_GeneralCallCmd:
 805  027e 88            	push	a
 806       00000000      OFST:	set	0
 809                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 811  027f 4d            	tnz	a
 812  0280 2704          	jreq	L07
 813  0282 a101          	cp	a,#1
 814  0284 2603          	jrne	L66
 815  0286               L07:
 816  0286 4f            	clr	a
 817  0287 2010          	jra	L27
 818  0289               L66:
 819  0289 ae00e4        	ldw	x,#228
 820  028c 89            	pushw	x
 821  028d ae0000        	ldw	x,#0
 822  0290 89            	pushw	x
 823  0291 ae0008        	ldw	x,#L131
 824  0294 cd0000        	call	_assert_failed
 826  0297 5b04          	addw	sp,#4
 827  0299               L27:
 828                     ; 230   if (NewState != DISABLE)
 830  0299 0d01          	tnz	(OFST+1,sp)
 831  029b 2706          	jreq	L712
 832                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 834  029d 721c5210      	bset	21008,#6
 836  02a1 2004          	jra	L122
 837  02a3               L712:
 838                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 840  02a3 721d5210      	bres	21008,#6
 841  02a7               L122:
 842                     ; 240 }
 845  02a7 84            	pop	a
 846  02a8 81            	ret
 882                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 882                     ; 251 {
 883                     	switch	.text
 884  02a9               _I2C_GenerateSTART:
 886  02a9 88            	push	a
 887       00000000      OFST:	set	0
 890                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 892  02aa 4d            	tnz	a
 893  02ab 2704          	jreq	L001
 894  02ad a101          	cp	a,#1
 895  02af 2603          	jrne	L67
 896  02b1               L001:
 897  02b1 4f            	clr	a
 898  02b2 2010          	jra	L201
 899  02b4               L67:
 900  02b4 ae00fd        	ldw	x,#253
 901  02b7 89            	pushw	x
 902  02b8 ae0000        	ldw	x,#0
 903  02bb 89            	pushw	x
 904  02bc ae0008        	ldw	x,#L131
 905  02bf cd0000        	call	_assert_failed
 907  02c2 5b04          	addw	sp,#4
 908  02c4               L201:
 909                     ; 255   if (NewState != DISABLE)
 911  02c4 0d01          	tnz	(OFST+1,sp)
 912  02c6 2706          	jreq	L142
 913                     ; 258     I2C->CR2 |= I2C_CR2_START;
 915  02c8 72105211      	bset	21009,#0
 917  02cc 2004          	jra	L342
 918  02ce               L142:
 919                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 921  02ce 72115211      	bres	21009,#0
 922  02d2               L342:
 923                     ; 265 }
 926  02d2 84            	pop	a
 927  02d3 81            	ret
 963                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 963                     ; 274 {
 964                     	switch	.text
 965  02d4               _I2C_GenerateSTOP:
 967  02d4 88            	push	a
 968       00000000      OFST:	set	0
 971                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 973  02d5 4d            	tnz	a
 974  02d6 2704          	jreq	L011
 975  02d8 a101          	cp	a,#1
 976  02da 2603          	jrne	L601
 977  02dc               L011:
 978  02dc 4f            	clr	a
 979  02dd 2010          	jra	L211
 980  02df               L601:
 981  02df ae0114        	ldw	x,#276
 982  02e2 89            	pushw	x
 983  02e3 ae0000        	ldw	x,#0
 984  02e6 89            	pushw	x
 985  02e7 ae0008        	ldw	x,#L131
 986  02ea cd0000        	call	_assert_failed
 988  02ed 5b04          	addw	sp,#4
 989  02ef               L211:
 990                     ; 278   if (NewState != DISABLE)
 992  02ef 0d01          	tnz	(OFST+1,sp)
 993  02f1 2706          	jreq	L362
 994                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 996  02f3 72125211      	bset	21009,#1
 998  02f7 2004          	jra	L562
 999  02f9               L362:
1000                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
1002  02f9 72135211      	bres	21009,#1
1003  02fd               L562:
1004                     ; 288 }
1007  02fd 84            	pop	a
1008  02fe 81            	ret
1045                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
1045                     ; 297 {
1046                     	switch	.text
1047  02ff               _I2C_SoftwareResetCmd:
1049  02ff 88            	push	a
1050       00000000      OFST:	set	0
1053                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1055  0300 4d            	tnz	a
1056  0301 2704          	jreq	L021
1057  0303 a101          	cp	a,#1
1058  0305 2603          	jrne	L611
1059  0307               L021:
1060  0307 4f            	clr	a
1061  0308 2010          	jra	L221
1062  030a               L611:
1063  030a ae012b        	ldw	x,#299
1064  030d 89            	pushw	x
1065  030e ae0000        	ldw	x,#0
1066  0311 89            	pushw	x
1067  0312 ae0008        	ldw	x,#L131
1068  0315 cd0000        	call	_assert_failed
1070  0318 5b04          	addw	sp,#4
1071  031a               L221:
1072                     ; 301   if (NewState != DISABLE)
1074  031a 0d01          	tnz	(OFST+1,sp)
1075  031c 2706          	jreq	L503
1076                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
1078  031e 721e5211      	bset	21009,#7
1080  0322 2004          	jra	L703
1081  0324               L503:
1082                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
1084  0324 721f5211      	bres	21009,#7
1085  0328               L703:
1086                     ; 311 }
1089  0328 84            	pop	a
1090  0329 81            	ret
1127                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
1127                     ; 321 {
1128                     	switch	.text
1129  032a               _I2C_StretchClockCmd:
1131  032a 88            	push	a
1132       00000000      OFST:	set	0
1135                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1137  032b 4d            	tnz	a
1138  032c 2704          	jreq	L031
1139  032e a101          	cp	a,#1
1140  0330 2603          	jrne	L621
1141  0332               L031:
1142  0332 4f            	clr	a
1143  0333 2010          	jra	L231
1144  0335               L621:
1145  0335 ae0143        	ldw	x,#323
1146  0338 89            	pushw	x
1147  0339 ae0000        	ldw	x,#0
1148  033c 89            	pushw	x
1149  033d ae0008        	ldw	x,#L131
1150  0340 cd0000        	call	_assert_failed
1152  0343 5b04          	addw	sp,#4
1153  0345               L231:
1154                     ; 325   if (NewState != DISABLE)
1156  0345 0d01          	tnz	(OFST+1,sp)
1157  0347 2706          	jreq	L723
1158                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
1160  0349 721f5210      	bres	21008,#7
1162  034d 2004          	jra	L133
1163  034f               L723:
1164                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
1166  034f 721e5210      	bset	21008,#7
1167  0353               L133:
1168                     ; 336 }
1171  0353 84            	pop	a
1172  0354 81            	ret
1209                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
1209                     ; 346 {
1210                     	switch	.text
1211  0355               _I2C_AcknowledgeConfig:
1213  0355 88            	push	a
1214       00000000      OFST:	set	0
1217                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
1219  0356 4d            	tnz	a
1220  0357 2708          	jreq	L041
1221  0359 a101          	cp	a,#1
1222  035b 2704          	jreq	L041
1223  035d a102          	cp	a,#2
1224  035f 2603          	jrne	L631
1225  0361               L041:
1226  0361 4f            	clr	a
1227  0362 2010          	jra	L241
1228  0364               L631:
1229  0364 ae015c        	ldw	x,#348
1230  0367 89            	pushw	x
1231  0368 ae0000        	ldw	x,#0
1232  036b 89            	pushw	x
1233  036c ae0008        	ldw	x,#L131
1234  036f cd0000        	call	_assert_failed
1236  0372 5b04          	addw	sp,#4
1237  0374               L241:
1238                     ; 350   if (Ack == I2C_ACK_NONE)
1240  0374 0d01          	tnz	(OFST+1,sp)
1241  0376 2606          	jrne	L153
1242                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
1244  0378 72155211      	bres	21009,#2
1246  037c 2014          	jra	L353
1247  037e               L153:
1248                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
1250  037e 72145211      	bset	21009,#2
1251                     ; 360     if (Ack == I2C_ACK_CURR)
1253  0382 7b01          	ld	a,(OFST+1,sp)
1254  0384 a101          	cp	a,#1
1255  0386 2606          	jrne	L553
1256                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
1258  0388 72175211      	bres	21009,#3
1260  038c 2004          	jra	L353
1261  038e               L553:
1262                     ; 368       I2C->CR2 |= I2C_CR2_POS;
1264  038e 72165211      	bset	21009,#3
1265  0392               L353:
1266                     ; 371 }
1269  0392 84            	pop	a
1270  0393 81            	ret
1343                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1343                     ; 382 {
1344                     	switch	.text
1345  0394               _I2C_ITConfig:
1347  0394 89            	pushw	x
1348       00000000      OFST:	set	0
1351                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1353  0395 9e            	ld	a,xh
1354  0396 a101          	cp	a,#1
1355  0398 271e          	jreq	L051
1356  039a 9e            	ld	a,xh
1357  039b a102          	cp	a,#2
1358  039d 2719          	jreq	L051
1359  039f 9e            	ld	a,xh
1360  03a0 a104          	cp	a,#4
1361  03a2 2714          	jreq	L051
1362  03a4 9e            	ld	a,xh
1363  03a5 a103          	cp	a,#3
1364  03a7 270f          	jreq	L051
1365  03a9 9e            	ld	a,xh
1366  03aa a105          	cp	a,#5
1367  03ac 270a          	jreq	L051
1368  03ae 9e            	ld	a,xh
1369  03af a106          	cp	a,#6
1370  03b1 2705          	jreq	L051
1371  03b3 9e            	ld	a,xh
1372  03b4 a107          	cp	a,#7
1373  03b6 2603          	jrne	L641
1374  03b8               L051:
1375  03b8 4f            	clr	a
1376  03b9 2010          	jra	L251
1377  03bb               L641:
1378  03bb ae0180        	ldw	x,#384
1379  03be 89            	pushw	x
1380  03bf ae0000        	ldw	x,#0
1381  03c2 89            	pushw	x
1382  03c3 ae0008        	ldw	x,#L131
1383  03c6 cd0000        	call	_assert_failed
1385  03c9 5b04          	addw	sp,#4
1386  03cb               L251:
1387                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1389  03cb 0d02          	tnz	(OFST+2,sp)
1390  03cd 2706          	jreq	L651
1391  03cf 7b02          	ld	a,(OFST+2,sp)
1392  03d1 a101          	cp	a,#1
1393  03d3 2603          	jrne	L451
1394  03d5               L651:
1395  03d5 4f            	clr	a
1396  03d6 2010          	jra	L061
1397  03d8               L451:
1398  03d8 ae0181        	ldw	x,#385
1399  03db 89            	pushw	x
1400  03dc ae0000        	ldw	x,#0
1401  03df 89            	pushw	x
1402  03e0 ae0008        	ldw	x,#L131
1403  03e3 cd0000        	call	_assert_failed
1405  03e6 5b04          	addw	sp,#4
1406  03e8               L061:
1407                     ; 387   if (NewState != DISABLE)
1409  03e8 0d02          	tnz	(OFST+2,sp)
1410  03ea 270a          	jreq	L514
1411                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1413  03ec c6521a        	ld	a,21018
1414  03ef 1a01          	or	a,(OFST+1,sp)
1415  03f1 c7521a        	ld	21018,a
1417  03f4 2009          	jra	L714
1418  03f6               L514:
1419                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1421  03f6 7b01          	ld	a,(OFST+1,sp)
1422  03f8 43            	cpl	a
1423  03f9 c4521a        	and	a,21018
1424  03fc c7521a        	ld	21018,a
1425  03ff               L714:
1426                     ; 397 }
1429  03ff 85            	popw	x
1430  0400 81            	ret
1467                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1467                     ; 406 {
1468                     	switch	.text
1469  0401               _I2C_FastModeDutyCycleConfig:
1471  0401 88            	push	a
1472       00000000      OFST:	set	0
1475                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1477  0402 4d            	tnz	a
1478  0403 2704          	jreq	L661
1479  0405 a140          	cp	a,#64
1480  0407 2603          	jrne	L461
1481  0409               L661:
1482  0409 4f            	clr	a
1483  040a 2010          	jra	L071
1484  040c               L461:
1485  040c ae0198        	ldw	x,#408
1486  040f 89            	pushw	x
1487  0410 ae0000        	ldw	x,#0
1488  0413 89            	pushw	x
1489  0414 ae0008        	ldw	x,#L131
1490  0417 cd0000        	call	_assert_failed
1492  041a 5b04          	addw	sp,#4
1493  041c               L071:
1494                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1496  041c 7b01          	ld	a,(OFST+1,sp)
1497  041e a140          	cp	a,#64
1498  0420 2606          	jrne	L734
1499                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
1501  0422 721c521c      	bset	21020,#6
1503  0426 2004          	jra	L144
1504  0428               L734:
1505                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1507  0428 721d521c      	bres	21020,#6
1508  042c               L144:
1509                     ; 420 }
1512  042c 84            	pop	a
1513  042d 81            	ret
1536                     ; 427 uint8_t I2C_ReceiveData(void)
1536                     ; 428 {
1537                     	switch	.text
1538  042e               _I2C_ReceiveData:
1542                     ; 430   return ((uint8_t)I2C->DR);
1544  042e c65216        	ld	a,21014
1547  0431 81            	ret
1613                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1613                     ; 441 {
1614                     	switch	.text
1615  0432               _I2C_Send7bitAddress:
1617  0432 89            	pushw	x
1618       00000000      OFST:	set	0
1621                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
1623  0433 9e            	ld	a,xh
1624  0434 a501          	bcp	a,#1
1625  0436 2603          	jrne	L671
1626  0438 4f            	clr	a
1627  0439 2010          	jra	L002
1628  043b               L671:
1629  043b ae01bb        	ldw	x,#443
1630  043e 89            	pushw	x
1631  043f ae0000        	ldw	x,#0
1632  0442 89            	pushw	x
1633  0443 ae0008        	ldw	x,#L131
1634  0446 cd0000        	call	_assert_failed
1636  0449 5b04          	addw	sp,#4
1637  044b               L002:
1638                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
1640  044b 0d02          	tnz	(OFST+2,sp)
1641  044d 2706          	jreq	L402
1642  044f 7b02          	ld	a,(OFST+2,sp)
1643  0451 a101          	cp	a,#1
1644  0453 2603          	jrne	L202
1645  0455               L402:
1646  0455 4f            	clr	a
1647  0456 2010          	jra	L602
1648  0458               L202:
1649  0458 ae01bc        	ldw	x,#444
1650  045b 89            	pushw	x
1651  045c ae0000        	ldw	x,#0
1652  045f 89            	pushw	x
1653  0460 ae0008        	ldw	x,#L131
1654  0463 cd0000        	call	_assert_failed
1656  0466 5b04          	addw	sp,#4
1657  0468               L602:
1658                     ; 447   Address &= (uint8_t)0xFE;
1660  0468 7b01          	ld	a,(OFST+1,sp)
1661  046a a4fe          	and	a,#254
1662  046c 6b01          	ld	(OFST+1,sp),a
1663                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1665  046e 7b01          	ld	a,(OFST+1,sp)
1666  0470 1a02          	or	a,(OFST+2,sp)
1667  0472 c75216        	ld	21014,a
1668                     ; 451 }
1671  0475 85            	popw	x
1672  0476 81            	ret
1706                     ; 458 void I2C_SendData(uint8_t Data)
1706                     ; 459 {
1707                     	switch	.text
1708  0477               _I2C_SendData:
1712                     ; 461   I2C->DR = Data;
1714  0477 c75216        	ld	21014,a
1715                     ; 462 }
1718  047a 81            	ret
1943                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1943                     ; 579 {
1944                     	switch	.text
1945  047b               _I2C_CheckEvent:
1947  047b 89            	pushw	x
1948  047c 5206          	subw	sp,#6
1949       00000006      OFST:	set	6
1952                     ; 580   __IO uint16_t lastevent = 0x00;
1954  047e 5f            	clrw	x
1955  047f 1f04          	ldw	(OFST-2,sp),x
1957                     ; 581   uint8_t flag1 = 0x00 ;
1959                     ; 582   uint8_t flag2 = 0x00;
1961                     ; 583   ErrorStatus status = ERROR;
1963                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1965  0481 1e07          	ldw	x,(OFST+1,sp)
1966  0483 a30682        	cpw	x,#1666
1967  0486 2769          	jreq	L612
1968  0488 1e07          	ldw	x,(OFST+1,sp)
1969  048a a30202        	cpw	x,#514
1970  048d 2762          	jreq	L612
1971  048f 1e07          	ldw	x,(OFST+1,sp)
1972  0491 a31200        	cpw	x,#4608
1973  0494 275b          	jreq	L612
1974  0496 1e07          	ldw	x,(OFST+1,sp)
1975  0498 a30240        	cpw	x,#576
1976  049b 2754          	jreq	L612
1977  049d 1e07          	ldw	x,(OFST+1,sp)
1978  049f a30350        	cpw	x,#848
1979  04a2 274d          	jreq	L612
1980  04a4 1e07          	ldw	x,(OFST+1,sp)
1981  04a6 a30684        	cpw	x,#1668
1982  04a9 2746          	jreq	L612
1983  04ab 1e07          	ldw	x,(OFST+1,sp)
1984  04ad a30794        	cpw	x,#1940
1985  04b0 273f          	jreq	L612
1986  04b2 1e07          	ldw	x,(OFST+1,sp)
1987  04b4 a30004        	cpw	x,#4
1988  04b7 2738          	jreq	L612
1989  04b9 1e07          	ldw	x,(OFST+1,sp)
1990  04bb a30010        	cpw	x,#16
1991  04be 2731          	jreq	L612
1992  04c0 1e07          	ldw	x,(OFST+1,sp)
1993  04c2 a30301        	cpw	x,#769
1994  04c5 272a          	jreq	L612
1995  04c7 1e07          	ldw	x,(OFST+1,sp)
1996  04c9 a30782        	cpw	x,#1922
1997  04cc 2723          	jreq	L612
1998  04ce 1e07          	ldw	x,(OFST+1,sp)
1999  04d0 a30302        	cpw	x,#770
2000  04d3 271c          	jreq	L612
2001  04d5 1e07          	ldw	x,(OFST+1,sp)
2002  04d7 a30340        	cpw	x,#832
2003  04da 2715          	jreq	L612
2004  04dc 1e07          	ldw	x,(OFST+1,sp)
2005  04de a30784        	cpw	x,#1924
2006  04e1 270e          	jreq	L612
2007  04e3 1e07          	ldw	x,(OFST+1,sp)
2008  04e5 a30780        	cpw	x,#1920
2009  04e8 2707          	jreq	L612
2010  04ea 1e07          	ldw	x,(OFST+1,sp)
2011  04ec a30308        	cpw	x,#776
2012  04ef 2603          	jrne	L412
2013  04f1               L612:
2014  04f1 4f            	clr	a
2015  04f2 2010          	jra	L022
2016  04f4               L412:
2017  04f4 ae024a        	ldw	x,#586
2018  04f7 89            	pushw	x
2019  04f8 ae0000        	ldw	x,#0
2020  04fb 89            	pushw	x
2021  04fc ae0008        	ldw	x,#L131
2022  04ff cd0000        	call	_assert_failed
2024  0502 5b04          	addw	sp,#4
2025  0504               L022:
2026                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
2028  0504 1e07          	ldw	x,(OFST+1,sp)
2029  0506 a30004        	cpw	x,#4
2030  0509 260b          	jrne	L336
2031                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
2033  050b c65218        	ld	a,21016
2034  050e a404          	and	a,#4
2035  0510 5f            	clrw	x
2036  0511 97            	ld	xl,a
2037  0512 1f04          	ldw	(OFST-2,sp),x
2040  0514 201f          	jra	L536
2041  0516               L336:
2042                     ; 594     flag1 = I2C->SR1;
2044  0516 c65217        	ld	a,21015
2045  0519 6b03          	ld	(OFST-3,sp),a
2047                     ; 595     flag2 = I2C->SR3;
2049  051b c65219        	ld	a,21017
2050  051e 6b06          	ld	(OFST+0,sp),a
2052                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
2054  0520 7b03          	ld	a,(OFST-3,sp)
2055  0522 5f            	clrw	x
2056  0523 97            	ld	xl,a
2057  0524 1f01          	ldw	(OFST-5,sp),x
2059  0526 7b06          	ld	a,(OFST+0,sp)
2060  0528 5f            	clrw	x
2061  0529 97            	ld	xl,a
2062  052a 4f            	clr	a
2063  052b 02            	rlwa	x,a
2064  052c 01            	rrwa	x,a
2065  052d 1a02          	or	a,(OFST-4,sp)
2066  052f 01            	rrwa	x,a
2067  0530 1a01          	or	a,(OFST-5,sp)
2068  0532 01            	rrwa	x,a
2069  0533 1f04          	ldw	(OFST-2,sp),x
2071  0535               L536:
2072                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
2074  0535 1e04          	ldw	x,(OFST-2,sp)
2075  0537 01            	rrwa	x,a
2076  0538 1408          	and	a,(OFST+2,sp)
2077  053a 01            	rrwa	x,a
2078  053b 1407          	and	a,(OFST+1,sp)
2079  053d 01            	rrwa	x,a
2080  053e 1307          	cpw	x,(OFST+1,sp)
2081  0540 2606          	jrne	L736
2082                     ; 602     status = SUCCESS;
2084  0542 a601          	ld	a,#1
2085  0544 6b06          	ld	(OFST+0,sp),a
2088  0546 2002          	jra	L146
2089  0548               L736:
2090                     ; 607     status = ERROR;
2092  0548 0f06          	clr	(OFST+0,sp)
2094  054a               L146:
2095                     ; 611   return status;
2097  054a 7b06          	ld	a,(OFST+0,sp)
2100  054c 5b08          	addw	sp,#8
2101  054e 81            	ret
2154                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
2154                     ; 629 {
2155                     	switch	.text
2156  054f               _I2C_GetLastEvent:
2158  054f 5206          	subw	sp,#6
2159       00000006      OFST:	set	6
2162                     ; 630   __IO uint16_t lastevent = 0;
2164  0551 5f            	clrw	x
2165  0552 1f05          	ldw	(OFST-1,sp),x
2167                     ; 631   uint16_t flag1 = 0;
2169                     ; 632   uint16_t flag2 = 0;
2171                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
2173  0554 c65218        	ld	a,21016
2174  0557 a504          	bcp	a,#4
2175  0559 2707          	jreq	L176
2176                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
2178  055b ae0004        	ldw	x,#4
2179  055e 1f05          	ldw	(OFST-1,sp),x
2182  0560 201b          	jra	L376
2183  0562               L176:
2184                     ; 641     flag1 = I2C->SR1;
2186  0562 c65217        	ld	a,21015
2187  0565 5f            	clrw	x
2188  0566 97            	ld	xl,a
2189  0567 1f01          	ldw	(OFST-5,sp),x
2191                     ; 642     flag2 = I2C->SR3;
2193  0569 c65219        	ld	a,21017
2194  056c 5f            	clrw	x
2195  056d 97            	ld	xl,a
2196  056e 1f03          	ldw	(OFST-3,sp),x
2198                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
2200  0570 1e03          	ldw	x,(OFST-3,sp)
2201  0572 4f            	clr	a
2202  0573 02            	rlwa	x,a
2203  0574 01            	rrwa	x,a
2204  0575 1a02          	or	a,(OFST-4,sp)
2205  0577 01            	rrwa	x,a
2206  0578 1a01          	or	a,(OFST-5,sp)
2207  057a 01            	rrwa	x,a
2208  057b 1f05          	ldw	(OFST-1,sp),x
2210  057d               L376:
2211                     ; 648   return (I2C_Event_TypeDef)lastevent;
2213  057d 1e05          	ldw	x,(OFST-1,sp)
2216  057f 5b06          	addw	sp,#6
2217  0581 81            	ret
2433                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
2433                     ; 680 {
2434                     	switch	.text
2435  0582               _I2C_GetFlagStatus:
2437  0582 89            	pushw	x
2438  0583 89            	pushw	x
2439       00000002      OFST:	set	2
2442                     ; 681   uint8_t tempreg = 0;
2444  0584 0f02          	clr	(OFST+0,sp)
2446                     ; 682   uint8_t regindex = 0;
2448                     ; 683   FlagStatus bitstatus = RESET;
2450                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
2452  0586 a30180        	cpw	x,#384
2453  0589 274b          	jreq	L032
2454  058b a30140        	cpw	x,#320
2455  058e 2746          	jreq	L032
2456  0590 a30110        	cpw	x,#272
2457  0593 2741          	jreq	L032
2458  0595 a30108        	cpw	x,#264
2459  0598 273c          	jreq	L032
2460  059a a30104        	cpw	x,#260
2461  059d 2737          	jreq	L032
2462  059f a30102        	cpw	x,#258
2463  05a2 2732          	jreq	L032
2464  05a4 a30101        	cpw	x,#257
2465  05a7 272d          	jreq	L032
2466  05a9 a30220        	cpw	x,#544
2467  05ac 2728          	jreq	L032
2468  05ae a30208        	cpw	x,#520
2469  05b1 2723          	jreq	L032
2470  05b3 a30204        	cpw	x,#516
2471  05b6 271e          	jreq	L032
2472  05b8 a30202        	cpw	x,#514
2473  05bb 2719          	jreq	L032
2474  05bd a30201        	cpw	x,#513
2475  05c0 2714          	jreq	L032
2476  05c2 a30310        	cpw	x,#784
2477  05c5 270f          	jreq	L032
2478  05c7 a30304        	cpw	x,#772
2479  05ca 270a          	jreq	L032
2480  05cc a30302        	cpw	x,#770
2481  05cf 2705          	jreq	L032
2482  05d1 a30301        	cpw	x,#769
2483  05d4 2603          	jrne	L622
2484  05d6               L032:
2485  05d6 4f            	clr	a
2486  05d7 2010          	jra	L232
2487  05d9               L622:
2488  05d9 ae02ae        	ldw	x,#686
2489  05dc 89            	pushw	x
2490  05dd ae0000        	ldw	x,#0
2491  05e0 89            	pushw	x
2492  05e1 ae0008        	ldw	x,#L131
2493  05e4 cd0000        	call	_assert_failed
2495  05e7 5b04          	addw	sp,#4
2496  05e9               L232:
2497                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
2499  05e9 7b03          	ld	a,(OFST+1,sp)
2500  05eb 6b01          	ld	(OFST-1,sp),a
2502                     ; 691   switch (regindex)
2504  05ed 7b01          	ld	a,(OFST-1,sp)
2506                     ; 708     default:
2506                     ; 709       break;
2507  05ef 4a            	dec	a
2508  05f0 2708          	jreq	L576
2509  05f2 4a            	dec	a
2510  05f3 270c          	jreq	L776
2511  05f5 4a            	dec	a
2512  05f6 2710          	jreq	L107
2513  05f8 2013          	jra	L5101
2514  05fa               L576:
2515                     ; 694     case 0x01:
2515                     ; 695       tempreg = (uint8_t)I2C->SR1;
2517  05fa c65217        	ld	a,21015
2518  05fd 6b02          	ld	(OFST+0,sp),a
2520                     ; 696       break;
2522  05ff 200c          	jra	L5101
2523  0601               L776:
2524                     ; 699     case 0x02:
2524                     ; 700       tempreg = (uint8_t)I2C->SR2;
2526  0601 c65218        	ld	a,21016
2527  0604 6b02          	ld	(OFST+0,sp),a
2529                     ; 701       break;
2531  0606 2005          	jra	L5101
2532  0608               L107:
2533                     ; 704     case 0x03:
2533                     ; 705       tempreg = (uint8_t)I2C->SR3;
2535  0608 c65219        	ld	a,21017
2536  060b 6b02          	ld	(OFST+0,sp),a
2538                     ; 706       break;
2540  060d               L307:
2541                     ; 708     default:
2541                     ; 709       break;
2543  060d               L5101:
2544                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2546  060d 7b04          	ld	a,(OFST+2,sp)
2547  060f 1502          	bcp	a,(OFST+0,sp)
2548  0611 2706          	jreq	L7101
2549                     ; 716     bitstatus = SET;
2551  0613 a601          	ld	a,#1
2552  0615 6b02          	ld	(OFST+0,sp),a
2555  0617 2002          	jra	L1201
2556  0619               L7101:
2557                     ; 721     bitstatus = RESET;
2559  0619 0f02          	clr	(OFST+0,sp)
2561  061b               L1201:
2562                     ; 724   return bitstatus;
2564  061b 7b02          	ld	a,(OFST+0,sp)
2567  061d 5b04          	addw	sp,#4
2568  061f 81            	ret
2613                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2613                     ; 760 {
2614                     	switch	.text
2615  0620               _I2C_ClearFlag:
2617  0620 89            	pushw	x
2618  0621 89            	pushw	x
2619       00000002      OFST:	set	2
2622                     ; 761   uint16_t flagpos = 0;
2624                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2626  0622 01            	rrwa	x,a
2627  0623 9f            	ld	a,xl
2628  0624 a4fd          	and	a,#253
2629  0626 97            	ld	xl,a
2630  0627 4f            	clr	a
2631  0628 02            	rlwa	x,a
2632  0629 5d            	tnzw	x
2633  062a 2607          	jrne	L632
2634  062c 1e03          	ldw	x,(OFST+1,sp)
2635  062e 2703          	jreq	L632
2636  0630 4f            	clr	a
2637  0631 2010          	jra	L042
2638  0633               L632:
2639  0633 ae02fb        	ldw	x,#763
2640  0636 89            	pushw	x
2641  0637 ae0000        	ldw	x,#0
2642  063a 89            	pushw	x
2643  063b ae0008        	ldw	x,#L131
2644  063e cd0000        	call	_assert_failed
2646  0641 5b04          	addw	sp,#4
2647  0643               L042:
2648                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2650  0643 7b03          	ld	a,(OFST+1,sp)
2651  0645 97            	ld	xl,a
2652  0646 7b04          	ld	a,(OFST+2,sp)
2653  0648 a4ff          	and	a,#255
2654  064a 5f            	clrw	x
2655  064b 02            	rlwa	x,a
2656  064c 1f01          	ldw	(OFST-1,sp),x
2657  064e 01            	rrwa	x,a
2659                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2661  064f 7b02          	ld	a,(OFST+0,sp)
2662  0651 43            	cpl	a
2663  0652 c75218        	ld	21016,a
2664                     ; 769 }
2667  0655 5b04          	addw	sp,#4
2668  0657 81            	ret
2835                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2835                     ; 792 {
2836                     	switch	.text
2837  0658               _I2C_GetITStatus:
2839  0658 89            	pushw	x
2840  0659 5204          	subw	sp,#4
2841       00000004      OFST:	set	4
2844                     ; 793   ITStatus bitstatus = RESET;
2846                     ; 794   __IO uint8_t enablestatus = 0;
2848  065b 0f03          	clr	(OFST-1,sp)
2850                     ; 795   uint16_t tempregister = 0;
2852                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2854  065d a31680        	cpw	x,#5760
2855  0660 2737          	jreq	L642
2856  0662 a31640        	cpw	x,#5696
2857  0665 2732          	jreq	L642
2858  0667 a31210        	cpw	x,#4624
2859  066a 272d          	jreq	L642
2860  066c a31208        	cpw	x,#4616
2861  066f 2728          	jreq	L642
2862  0671 a31204        	cpw	x,#4612
2863  0674 2723          	jreq	L642
2864  0676 a31202        	cpw	x,#4610
2865  0679 271e          	jreq	L642
2866  067b a31201        	cpw	x,#4609
2867  067e 2719          	jreq	L642
2868  0680 a32220        	cpw	x,#8736
2869  0683 2714          	jreq	L642
2870  0685 a32108        	cpw	x,#8456
2871  0688 270f          	jreq	L642
2872  068a a32104        	cpw	x,#8452
2873  068d 270a          	jreq	L642
2874  068f a32102        	cpw	x,#8450
2875  0692 2705          	jreq	L642
2876  0694 a32101        	cpw	x,#8449
2877  0697 2603          	jrne	L442
2878  0699               L642:
2879  0699 4f            	clr	a
2880  069a 2010          	jra	L052
2881  069c               L442:
2882  069c ae031e        	ldw	x,#798
2883  069f 89            	pushw	x
2884  06a0 ae0000        	ldw	x,#0
2885  06a3 89            	pushw	x
2886  06a4 ae0008        	ldw	x,#L131
2887  06a7 cd0000        	call	_assert_failed
2889  06aa 5b04          	addw	sp,#4
2890  06ac               L052:
2891                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2893  06ac 7b05          	ld	a,(OFST+1,sp)
2894  06ae a407          	and	a,#7
2895  06b0 5f            	clrw	x
2896  06b1 97            	ld	xl,a
2897  06b2 1f01          	ldw	(OFST-3,sp),x
2899                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2901  06b4 c6521a        	ld	a,21018
2902  06b7 1402          	and	a,(OFST-2,sp)
2903  06b9 6b03          	ld	(OFST-1,sp),a
2905                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2907  06bb 7b05          	ld	a,(OFST+1,sp)
2908  06bd 97            	ld	xl,a
2909  06be 7b06          	ld	a,(OFST+2,sp)
2910  06c0 9f            	ld	a,xl
2911  06c1 a430          	and	a,#48
2912  06c3 97            	ld	xl,a
2913  06c4 4f            	clr	a
2914  06c5 02            	rlwa	x,a
2915  06c6 a30100        	cpw	x,#256
2916  06c9 2615          	jrne	L3311
2917                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2919  06cb c65217        	ld	a,21015
2920  06ce 1506          	bcp	a,(OFST+2,sp)
2921  06d0 270a          	jreq	L5311
2923  06d2 0d03          	tnz	(OFST-1,sp)
2924  06d4 2706          	jreq	L5311
2925                     ; 811       bitstatus = SET;
2927  06d6 a601          	ld	a,#1
2928  06d8 6b04          	ld	(OFST+0,sp),a
2931  06da 2017          	jra	L1411
2932  06dc               L5311:
2933                     ; 816       bitstatus = RESET;
2935  06dc 0f04          	clr	(OFST+0,sp)
2937  06de 2013          	jra	L1411
2938  06e0               L3311:
2939                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2941  06e0 c65218        	ld	a,21016
2942  06e3 1506          	bcp	a,(OFST+2,sp)
2943  06e5 270a          	jreq	L3411
2945  06e7 0d03          	tnz	(OFST-1,sp)
2946  06e9 2706          	jreq	L3411
2947                     ; 825       bitstatus = SET;
2949  06eb a601          	ld	a,#1
2950  06ed 6b04          	ld	(OFST+0,sp),a
2953  06ef 2002          	jra	L1411
2954  06f1               L3411:
2955                     ; 830       bitstatus = RESET;
2957  06f1 0f04          	clr	(OFST+0,sp)
2959  06f3               L1411:
2960                     ; 834   return  bitstatus;
2962  06f3 7b04          	ld	a,(OFST+0,sp)
2965  06f5 5b06          	addw	sp,#6
2966  06f7 81            	ret
3012                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
3012                     ; 872 {
3013                     	switch	.text
3014  06f8               _I2C_ClearITPendingBit:
3016  06f8 89            	pushw	x
3017  06f9 89            	pushw	x
3018       00000002      OFST:	set	2
3021                     ; 873   uint16_t flagpos = 0;
3023                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
3025  06fa a32220        	cpw	x,#8736
3026  06fd 2714          	jreq	L652
3027  06ff a32108        	cpw	x,#8456
3028  0702 270f          	jreq	L652
3029  0704 a32104        	cpw	x,#8452
3030  0707 270a          	jreq	L652
3031  0709 a32102        	cpw	x,#8450
3032  070c 2705          	jreq	L652
3033  070e a32101        	cpw	x,#8449
3034  0711 2603          	jrne	L452
3035  0713               L652:
3036  0713 4f            	clr	a
3037  0714 2010          	jra	L062
3038  0716               L452:
3039  0716 ae036c        	ldw	x,#876
3040  0719 89            	pushw	x
3041  071a ae0000        	ldw	x,#0
3042  071d 89            	pushw	x
3043  071e ae0008        	ldw	x,#L131
3044  0721 cd0000        	call	_assert_failed
3046  0724 5b04          	addw	sp,#4
3047  0726               L062:
3048                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
3050  0726 7b03          	ld	a,(OFST+1,sp)
3051  0728 97            	ld	xl,a
3052  0729 7b04          	ld	a,(OFST+2,sp)
3053  072b a4ff          	and	a,#255
3054  072d 5f            	clrw	x
3055  072e 02            	rlwa	x,a
3056  072f 1f01          	ldw	(OFST-1,sp),x
3057  0731 01            	rrwa	x,a
3059                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
3061  0732 7b02          	ld	a,(OFST+0,sp)
3062  0734 43            	cpl	a
3063  0735 c75218        	ld	21016,a
3064                     ; 883 }
3067  0738 5b04          	addw	sp,#4
3068  073a 81            	ret
3081                     	xdef	_I2C_ClearITPendingBit
3082                     	xdef	_I2C_GetITStatus
3083                     	xdef	_I2C_ClearFlag
3084                     	xdef	_I2C_GetFlagStatus
3085                     	xdef	_I2C_GetLastEvent
3086                     	xdef	_I2C_CheckEvent
3087                     	xdef	_I2C_SendData
3088                     	xdef	_I2C_Send7bitAddress
3089                     	xdef	_I2C_ReceiveData
3090                     	xdef	_I2C_ITConfig
3091                     	xdef	_I2C_FastModeDutyCycleConfig
3092                     	xdef	_I2C_AcknowledgeConfig
3093                     	xdef	_I2C_StretchClockCmd
3094                     	xdef	_I2C_SoftwareResetCmd
3095                     	xdef	_I2C_GenerateSTOP
3096                     	xdef	_I2C_GenerateSTART
3097                     	xdef	_I2C_GeneralCallCmd
3098                     	xdef	_I2C_Cmd
3099                     	xdef	_I2C_Init
3100                     	xdef	_I2C_DeInit
3101                     	xref	_assert_failed
3102                     	switch	.const
3103  0008               L131:
3104  0008 2e2e5c73746d  	dc.b	"..\stm8s_stdperiph"
3105  001a 5f6472697665  	dc.b	"_driver\src\stm8s_"
3106  002c 6932632e6300  	dc.b	"i2c.c",0
3107                     	xref.b	c_lreg
3108                     	xref.b	c_x
3128                     	xref	c_sdivx
3129                     	xref	c_bmulx
3130                     	xref	c_ludv
3131                     	xref	c_smul
3132                     	xref	c_lmul
3133                     	xref	c_rtol
3134                     	xref	c_lcmp
3135                     	xref	c_ltor
3136                     	xref	c_lzmp
3137                     	end
