   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
 275                     ; 28 void TM_OneWire_Init(TM_OneWire_t* OneWireStruct, GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin) {
 277                     	switch	.text
 278  0000               _TM_OneWire_Init:
 280  0000 89            	pushw	x
 281       00000000      OFST:	set	0
 284                     ; 32         GPIO_Init(GPIOx,GPIO_Pin,GPIO_MODE_OUT_OD_HIZ_FAST);
 286  0001 4bb0          	push	#176
 287  0003 7b08          	ld	a,(OFST+8,sp)
 288  0005 88            	push	a
 289  0006 1e07          	ldw	x,(OFST+7,sp)
 290  0008 cd0000        	call	_GPIO_Init
 292  000b 85            	popw	x
 293                     ; 35 	OneWireStruct->GPIOx = GPIOx;
 295  000c 1e01          	ldw	x,(OFST+1,sp)
 296  000e 1605          	ldw	y,(OFST+5,sp)
 297  0010 ff            	ldw	(x),y
 298                     ; 36 	OneWireStruct->GPIO_Pin = GPIO_Pin;
 300  0011 7b07          	ld	a,(OFST+7,sp)
 301  0013 1e01          	ldw	x,(OFST+1,sp)
 302  0015 e702          	ld	(2,x),a
 303                     ; 37 }
 306  0017 85            	popw	x
 307  0018 81            	ret
 357                     ; 39 uint8_t TM_OneWire_Reset(TM_OneWire_t* OneWireStruct) {
 358                     	switch	.text
 359  0019               _TM_OneWire_Reset:
 361  0019 89            	pushw	x
 362  001a 88            	push	a
 363       00000001      OFST:	set	1
 366                     ; 43 	ONEWIRE_LOW(OneWireStruct);
 368  001b e602          	ld	a,(2,x)
 369  001d 88            	push	a
 370  001e fe            	ldw	x,(x)
 371  001f cd0000        	call	_GPIO_WriteLow
 373  0022 84            	pop	a
 374                     ; 44 	ONEWIRE_DELAY(480);
 376  0023 ae01e0        	ldw	x,#480
 377  0026 cd0000        	call	_Delay_US
 379                     ; 47 	ONEWIRE_HIGH(OneWireStruct);
 381  0029 1e02          	ldw	x,(OFST+1,sp)
 382  002b e602          	ld	a,(2,x)
 383  002d 88            	push	a
 384  002e 1e03          	ldw	x,(OFST+2,sp)
 385  0030 fe            	ldw	x,(x)
 386  0031 cd0000        	call	_GPIO_WriteHigh
 388  0034 84            	pop	a
 389                     ; 48 	ONEWIRE_DELAY(70);
 391  0035 ae0046        	ldw	x,#70
 392  0038 cd0000        	call	_Delay_US
 394                     ; 51 	i = GPIO_ReadInputPin(OneWireStruct->GPIOx, OneWireStruct->GPIO_Pin);
 396  003b 1e02          	ldw	x,(OFST+1,sp)
 397  003d e602          	ld	a,(2,x)
 398  003f 88            	push	a
 399  0040 1e03          	ldw	x,(OFST+2,sp)
 400  0042 fe            	ldw	x,(x)
 401  0043 cd0000        	call	_GPIO_ReadInputPin
 403  0046 5b01          	addw	sp,#1
 404  0048 6b01          	ld	(OFST+0,sp),a
 406                     ; 54 	ONEWIRE_DELAY(410);
 408  004a ae019a        	ldw	x,#410
 409  004d cd0000        	call	_Delay_US
 411                     ; 57 	return i;
 413  0050 7b01          	ld	a,(OFST+0,sp)
 416  0052 5b03          	addw	sp,#3
 417  0054 81            	ret
 467                     ; 60 void TM_OneWire_WriteBit(TM_OneWire_t* OneWireStruct, uint8_t bit) {
 468                     	switch	.text
 469  0055               _TM_OneWire_WriteBit:
 471  0055 89            	pushw	x
 472       00000000      OFST:	set	0
 475                     ; 61 	if (bit) {
 477  0056 0d05          	tnz	(OFST+5,sp)
 478  0058 2722          	jreq	L522
 479                     ; 63 		ONEWIRE_LOW(OneWireStruct);
 481  005a e602          	ld	a,(2,x)
 482  005c 88            	push	a
 483  005d fe            	ldw	x,(x)
 484  005e cd0000        	call	_GPIO_WriteLow
 486  0061 84            	pop	a
 487                     ; 64 		ONEWIRE_DELAY(10);
 489  0062 ae000a        	ldw	x,#10
 490  0065 cd0000        	call	_Delay_US
 492                     ; 67 		ONEWIRE_HIGH(OneWireStruct);
 494  0068 1e01          	ldw	x,(OFST+1,sp)
 495  006a e602          	ld	a,(2,x)
 496  006c 88            	push	a
 497  006d 1e02          	ldw	x,(OFST+2,sp)
 498  006f fe            	ldw	x,(x)
 499  0070 cd0000        	call	_GPIO_WriteHigh
 501  0073 84            	pop	a
 502                     ; 70 		ONEWIRE_DELAY(55);
 504  0074 ae0037        	ldw	x,#55
 505  0077 cd0000        	call	_Delay_US
 508  007a 2024          	jra	L722
 509  007c               L522:
 510                     ; 73 		ONEWIRE_LOW(OneWireStruct);
 512  007c 1e01          	ldw	x,(OFST+1,sp)
 513  007e e602          	ld	a,(2,x)
 514  0080 88            	push	a
 515  0081 1e02          	ldw	x,(OFST+2,sp)
 516  0083 fe            	ldw	x,(x)
 517  0084 cd0000        	call	_GPIO_WriteLow
 519  0087 84            	pop	a
 520                     ; 74 		ONEWIRE_DELAY(65);
 522  0088 ae0041        	ldw	x,#65
 523  008b cd0000        	call	_Delay_US
 525                     ; 77 		ONEWIRE_HIGH(OneWireStruct);
 527  008e 1e01          	ldw	x,(OFST+1,sp)
 528  0090 e602          	ld	a,(2,x)
 529  0092 88            	push	a
 530  0093 1e02          	ldw	x,(OFST+2,sp)
 531  0095 fe            	ldw	x,(x)
 532  0096 cd0000        	call	_GPIO_WriteHigh
 534  0099 84            	pop	a
 535                     ; 80 		ONEWIRE_DELAY(5);
 537  009a ae0005        	ldw	x,#5
 538  009d cd0000        	call	_Delay_US
 540  00a0               L722:
 541                     ; 82 }
 544  00a0 85            	popw	x
 545  00a1 81            	ret
 595                     ; 84 uint8_t TM_OneWire_ReadBit(TM_OneWire_t* OneWireStruct) {
 596                     	switch	.text
 597  00a2               _TM_OneWire_ReadBit:
 599  00a2 89            	pushw	x
 600  00a3 88            	push	a
 601       00000001      OFST:	set	1
 604                     ; 85 	uint8_t bit = 0;
 606  00a4 0f01          	clr	(OFST+0,sp)
 608                     ; 88 	ONEWIRE_LOW(OneWireStruct);
 610  00a6 e602          	ld	a,(2,x)
 611  00a8 88            	push	a
 612  00a9 fe            	ldw	x,(x)
 613  00aa cd0000        	call	_GPIO_WriteLow
 615  00ad 84            	pop	a
 616                     ; 89 	ONEWIRE_DELAY(3);
 618  00ae ae0003        	ldw	x,#3
 619  00b1 cd0000        	call	_Delay_US
 621                     ; 92 	ONEWIRE_HIGH(OneWireStruct);
 623  00b4 1e02          	ldw	x,(OFST+1,sp)
 624  00b6 e602          	ld	a,(2,x)
 625  00b8 88            	push	a
 626  00b9 1e03          	ldw	x,(OFST+2,sp)
 627  00bb fe            	ldw	x,(x)
 628  00bc cd0000        	call	_GPIO_WriteHigh
 630  00bf 84            	pop	a
 631                     ; 93 	ONEWIRE_DELAY(10);
 633  00c0 ae000a        	ldw	x,#10
 634  00c3 cd0000        	call	_Delay_US
 636                     ; 96 	if (GPIO_ReadInputPin(OneWireStruct->GPIOx, OneWireStruct->GPIO_Pin)) {
 638  00c6 1e02          	ldw	x,(OFST+1,sp)
 639  00c8 e602          	ld	a,(2,x)
 640  00ca 88            	push	a
 641  00cb 1e03          	ldw	x,(OFST+2,sp)
 642  00cd fe            	ldw	x,(x)
 643  00ce cd0000        	call	_GPIO_ReadInputPin
 645  00d1 5b01          	addw	sp,#1
 646  00d3 4d            	tnz	a
 647  00d4 2704          	jreq	L552
 648                     ; 98 		bit = 1;
 650  00d6 a601          	ld	a,#1
 651  00d8 6b01          	ld	(OFST+0,sp),a
 653  00da               L552:
 654                     ; 102 	ONEWIRE_DELAY(50);
 656  00da ae0032        	ldw	x,#50
 657  00dd cd0000        	call	_Delay_US
 659                     ; 105 	return bit;
 661  00e0 7b01          	ld	a,(OFST+0,sp)
 664  00e2 5b03          	addw	sp,#3
 665  00e4 81            	ret
 722                     ; 108 void TM_OneWire_WriteByte(TM_OneWire_t* OneWireStruct, uint8_t byte) {
 723                     	switch	.text
 724  00e5               _TM_OneWire_WriteByte:
 726  00e5 89            	pushw	x
 727  00e6 88            	push	a
 728       00000001      OFST:	set	1
 731                     ; 109 	uint8_t i = 8;
 733  00e7 a608          	ld	a,#8
 734  00e9 6b01          	ld	(OFST+0,sp),a
 737  00eb 200d          	jra	L313
 738  00ed               L703:
 739                     ; 113 		TM_OneWire_WriteBit(OneWireStruct, byte & 0x01);
 741  00ed 7b06          	ld	a,(OFST+5,sp)
 742  00ef a401          	and	a,#1
 743  00f1 88            	push	a
 744  00f2 1e03          	ldw	x,(OFST+2,sp)
 745  00f4 cd0055        	call	_TM_OneWire_WriteBit
 747  00f7 84            	pop	a
 748                     ; 114 		byte >>= 1;
 750  00f8 0406          	srl	(OFST+5,sp)
 751  00fa               L313:
 752                     ; 111 	while (i--) {
 754  00fa 7b01          	ld	a,(OFST+0,sp)
 755  00fc 0a01          	dec	(OFST+0,sp)
 757  00fe 4d            	tnz	a
 758  00ff 26ec          	jrne	L703
 759                     ; 116 }
 762  0101 5b03          	addw	sp,#3
 763  0103 81            	ret
 820                     ; 118 uint8_t TM_OneWire_ReadByte(TM_OneWire_t* OneWireStruct) {
 821                     	switch	.text
 822  0104               _TM_OneWire_ReadByte:
 824  0104 89            	pushw	x
 825  0105 89            	pushw	x
 826       00000002      OFST:	set	2
 829                     ; 119 	uint8_t i = 8, byte = 0;
 831  0106 a608          	ld	a,#8
 832  0108 6b01          	ld	(OFST-1,sp),a
 836  010a 0f02          	clr	(OFST+0,sp)
 839  010c 200f          	jra	L353
 840  010e               L743:
 841                     ; 121 		byte >>= 1;
 843  010e 0402          	srl	(OFST+0,sp)
 845                     ; 122 		byte |= (TM_OneWire_ReadBit(OneWireStruct) << 7);
 847  0110 1e03          	ldw	x,(OFST+1,sp)
 848  0112 ad8e          	call	_TM_OneWire_ReadBit
 850  0114 97            	ld	xl,a
 851  0115 a680          	ld	a,#128
 852  0117 42            	mul	x,a
 853  0118 9f            	ld	a,xl
 854  0119 1a02          	or	a,(OFST+0,sp)
 855  011b 6b02          	ld	(OFST+0,sp),a
 857  011d               L353:
 858                     ; 120 	while (i--) {
 860  011d 7b01          	ld	a,(OFST-1,sp)
 861  011f 0a01          	dec	(OFST-1,sp)
 863  0121 4d            	tnz	a
 864  0122 26ea          	jrne	L743
 865                     ; 125 	return byte;
 867  0124 7b02          	ld	a,(OFST+0,sp)
 870  0126 5b04          	addw	sp,#4
 871  0128 81            	ret
 910                     ; 128 uint8_t TM_OneWire_First(TM_OneWire_t* OneWireStruct) {
 911                     	switch	.text
 912  0129               _TM_OneWire_First:
 914  0129 89            	pushw	x
 915       00000000      OFST:	set	0
 918                     ; 130 	TM_OneWire_ResetSearch(OneWireStruct);
 920  012a ad11          	call	_TM_OneWire_ResetSearch
 922                     ; 133 	return TM_OneWire_Search(OneWireStruct, ONEWIRE_CMD_SEARCHROM);
 924  012c 4bf0          	push	#240
 925  012e 1e02          	ldw	x,(OFST+2,sp)
 926  0130 ad12          	call	_TM_OneWire_Search
 928  0132 5b01          	addw	sp,#1
 931  0134 85            	popw	x
 932  0135 81            	ret
 970                     ; 136 uint8_t TM_OneWire_Next(TM_OneWire_t* OneWireStruct) {
 971                     	switch	.text
 972  0136               _TM_OneWire_Next:
 976                     ; 138    return TM_OneWire_Search(OneWireStruct, ONEWIRE_CMD_SEARCHROM);
 978  0136 4bf0          	push	#240
 979  0138 ad0a          	call	_TM_OneWire_Search
 981  013a 5b01          	addw	sp,#1
 984  013c 81            	ret
1022                     ; 141 void TM_OneWire_ResetSearch(TM_OneWire_t* OneWireStruct) {
1023                     	switch	.text
1024  013d               _TM_OneWire_ResetSearch:
1028                     ; 143 	OneWireStruct->LastDiscrepancy = 0;
1030  013d 6f03          	clr	(3,x)
1031                     ; 144 	OneWireStruct->LastDeviceFlag = 0;
1033  013f 6f05          	clr	(5,x)
1034                     ; 145 	OneWireStruct->LastFamilyDiscrepancy = 0;
1036  0141 6f04          	clr	(4,x)
1037                     ; 146 }
1040  0143 81            	ret
1162                     ; 148 uint8_t TM_OneWire_Search(TM_OneWire_t* OneWireStruct, uint8_t command) {
1163                     	switch	.text
1164  0144               _TM_OneWire_Search:
1166  0144 89            	pushw	x
1167  0145 5207          	subw	sp,#7
1168       00000007      OFST:	set	7
1171                     ; 155 	id_bit_number = 1;
1173  0147 a601          	ld	a,#1
1174  0149 6b04          	ld	(OFST-3,sp),a
1176                     ; 156 	last_zero = 0;
1178  014b 0f03          	clr	(OFST-4,sp)
1180                     ; 157 	rom_byte_number = 0;
1182  014d 0f05          	clr	(OFST-2,sp)
1184                     ; 158 	rom_byte_mask = 1;
1186  014f a601          	ld	a,#1
1187  0151 6b06          	ld	(OFST-1,sp),a
1189                     ; 159 	search_result = 0;
1191  0153 0f01          	clr	(OFST-6,sp)
1193                     ; 162 	if (!OneWireStruct->LastDeviceFlag) {
1195  0155 6d05          	tnz	(5,x)
1196  0157 2703          	jreq	L05
1197  0159 cc0251        	jp	L325
1198  015c               L05:
1199                     ; 164 		if (TM_OneWire_Reset(OneWireStruct)) {
1201  015c cd0019        	call	_TM_OneWire_Reset
1203  015f 4d            	tnz	a
1204  0160 2711          	jreq	L525
1205                     ; 166 			OneWireStruct->LastDiscrepancy = 0;
1207  0162 1e08          	ldw	x,(OFST+1,sp)
1208  0164 6f03          	clr	(3,x)
1209                     ; 167 			OneWireStruct->LastDeviceFlag = 0;
1211  0166 1e08          	ldw	x,(OFST+1,sp)
1212  0168 6f05          	clr	(5,x)
1213                     ; 168 			OneWireStruct->LastFamilyDiscrepancy = 0;
1215  016a 1e08          	ldw	x,(OFST+1,sp)
1216  016c 6f04          	clr	(4,x)
1217                     ; 169 			return 0;
1219  016e 4f            	clr	a
1221  016f ac6b026b      	jpf	L64
1222  0173               L525:
1223                     ; 173 		TM_OneWire_WriteByte(OneWireStruct, command);  
1225  0173 7b0c          	ld	a,(OFST+5,sp)
1226  0175 88            	push	a
1227  0176 1e09          	ldw	x,(OFST+2,sp)
1228  0178 cd00e5        	call	_TM_OneWire_WriteByte
1230  017b 84            	pop	a
1231  017c               L725:
1232                     ; 178 			id_bit = TM_OneWire_ReadBit(OneWireStruct);
1234  017c 1e08          	ldw	x,(OFST+1,sp)
1235  017e cd00a2        	call	_TM_OneWire_ReadBit
1237  0181 6b07          	ld	(OFST+0,sp),a
1239                     ; 179 			cmp_id_bit = TM_OneWire_ReadBit(OneWireStruct);
1241  0183 1e08          	ldw	x,(OFST+1,sp)
1242  0185 cd00a2        	call	_TM_OneWire_ReadBit
1244  0188 6b02          	ld	(OFST-5,sp),a
1246                     ; 182 			if ((id_bit == 1) && (cmp_id_bit == 1)) {
1248  018a 7b07          	ld	a,(OFST+0,sp)
1249  018c a101          	cp	a,#1
1250  018e 2609          	jrne	L535
1252  0190 7b02          	ld	a,(OFST-5,sp)
1253  0192 a101          	cp	a,#1
1254  0194 2603          	jrne	L25
1255  0196 cc0235        	jp	L335
1256  0199               L25:
1257                     ; 183 				break;
1259  0199               L535:
1260                     ; 186 				if (id_bit != cmp_id_bit) {
1262  0199 7b07          	ld	a,(OFST+0,sp)
1263  019b 1102          	cp	a,(OFST-5,sp)
1264  019d 2706          	jreq	L145
1265                     ; 188 					search_direction = id_bit;
1267  019f 7b07          	ld	a,(OFST+0,sp)
1268  01a1 6b07          	ld	(OFST+0,sp),a
1271  01a3 2045          	jra	L345
1272  01a5               L145:
1273                     ; 191 					if (id_bit_number < OneWireStruct->LastDiscrepancy) {
1275  01a5 1e08          	ldw	x,(OFST+1,sp)
1276  01a7 e603          	ld	a,(3,x)
1277  01a9 1104          	cp	a,(OFST-3,sp)
1278  01ab 231a          	jrule	L545
1279                     ; 192 						search_direction = ((OneWireStruct->ROM_NO[rom_byte_number] & rom_byte_mask) > 0);
1281  01ad 7b08          	ld	a,(OFST+1,sp)
1282  01af 97            	ld	xl,a
1283  01b0 7b09          	ld	a,(OFST+2,sp)
1284  01b2 1b05          	add	a,(OFST-2,sp)
1285  01b4 2401          	jrnc	L23
1286  01b6 5c            	incw	x
1287  01b7               L23:
1288  01b7 02            	rlwa	x,a
1289  01b8 e606          	ld	a,(6,x)
1290  01ba 1506          	bcp	a,(OFST-1,sp)
1291  01bc 2704          	jreq	L03
1292  01be a601          	ld	a,#1
1293  01c0 2001          	jra	L43
1294  01c2               L03:
1295  01c2 4f            	clr	a
1296  01c3               L43:
1297  01c3 6b07          	ld	(OFST+0,sp),a
1300  01c5 200f          	jra	L745
1301  01c7               L545:
1302                     ; 195 						search_direction = (id_bit_number == OneWireStruct->LastDiscrepancy);
1304  01c7 1e08          	ldw	x,(OFST+1,sp)
1305  01c9 e603          	ld	a,(3,x)
1306  01cb 1104          	cp	a,(OFST-3,sp)
1307  01cd 2604          	jrne	L63
1308  01cf a601          	ld	a,#1
1309  01d1 2001          	jra	L04
1310  01d3               L63:
1311  01d3 4f            	clr	a
1312  01d4               L04:
1313  01d4 6b07          	ld	(OFST+0,sp),a
1315  01d6               L745:
1316                     ; 199 					if (search_direction == 0) {
1318  01d6 0d07          	tnz	(OFST+0,sp)
1319  01d8 2610          	jrne	L345
1320                     ; 200 						last_zero = id_bit_number;
1322  01da 7b04          	ld	a,(OFST-3,sp)
1323  01dc 6b03          	ld	(OFST-4,sp),a
1325                     ; 203 						if (last_zero < 9) {
1327  01de 7b03          	ld	a,(OFST-4,sp)
1328  01e0 a109          	cp	a,#9
1329  01e2 2406          	jruge	L345
1330                     ; 204 							OneWireStruct->LastFamilyDiscrepancy = last_zero;
1332  01e4 7b03          	ld	a,(OFST-4,sp)
1333  01e6 1e08          	ldw	x,(OFST+1,sp)
1334  01e8 e704          	ld	(4,x),a
1335  01ea               L345:
1336                     ; 210 				if (search_direction == 1) {
1338  01ea 7b07          	ld	a,(OFST+0,sp)
1339  01ec a101          	cp	a,#1
1340  01ee 2613          	jrne	L555
1341                     ; 211 					OneWireStruct->ROM_NO[rom_byte_number] |= rom_byte_mask;
1343  01f0 7b08          	ld	a,(OFST+1,sp)
1344  01f2 97            	ld	xl,a
1345  01f3 7b09          	ld	a,(OFST+2,sp)
1346  01f5 1b05          	add	a,(OFST-2,sp)
1347  01f7 2401          	jrnc	L24
1348  01f9 5c            	incw	x
1349  01fa               L24:
1350  01fa 02            	rlwa	x,a
1351  01fb e606          	ld	a,(6,x)
1352  01fd 1a06          	or	a,(OFST-1,sp)
1353  01ff e706          	ld	(6,x),a
1355  0201 2012          	jra	L755
1356  0203               L555:
1357                     ; 213 					OneWireStruct->ROM_NO[rom_byte_number] &= ~rom_byte_mask;
1359  0203 7b08          	ld	a,(OFST+1,sp)
1360  0205 97            	ld	xl,a
1361  0206 7b09          	ld	a,(OFST+2,sp)
1362  0208 1b05          	add	a,(OFST-2,sp)
1363  020a 2401          	jrnc	L44
1364  020c 5c            	incw	x
1365  020d               L44:
1366  020d 02            	rlwa	x,a
1367  020e 7b06          	ld	a,(OFST-1,sp)
1368  0210 43            	cpl	a
1369  0211 e406          	and	a,(6,x)
1370  0213 e706          	ld	(6,x),a
1371  0215               L755:
1372                     ; 217 				TM_OneWire_WriteBit(OneWireStruct, search_direction);
1374  0215 7b07          	ld	a,(OFST+0,sp)
1375  0217 88            	push	a
1376  0218 1e09          	ldw	x,(OFST+2,sp)
1377  021a cd0055        	call	_TM_OneWire_WriteBit
1379  021d 84            	pop	a
1380                     ; 220 				id_bit_number++;
1382  021e 0c04          	inc	(OFST-3,sp)
1384                     ; 221 				rom_byte_mask <<= 1;
1386  0220 0806          	sll	(OFST-1,sp)
1388                     ; 224 				if (rom_byte_mask == 0) {
1390  0222 0d06          	tnz	(OFST-1,sp)
1391  0224 2606          	jrne	L135
1392                     ; 225 					rom_byte_number++;
1394  0226 0c05          	inc	(OFST-2,sp)
1396                     ; 226 					rom_byte_mask = 1;
1398  0228 a601          	ld	a,#1
1399  022a 6b06          	ld	(OFST-1,sp),a
1401  022c               L135:
1402                     ; 230 		} while (rom_byte_number < 8);
1404  022c 7b05          	ld	a,(OFST-2,sp)
1405  022e a108          	cp	a,#8
1406  0230 2403          	jruge	L45
1407  0232 cc017c        	jp	L725
1408  0235               L45:
1409  0235               L335:
1410                     ; 233 		if (!(id_bit_number < 65)) {
1412  0235 7b04          	ld	a,(OFST-3,sp)
1413  0237 a141          	cp	a,#65
1414  0239 2516          	jrult	L325
1415                     ; 235 			OneWireStruct->LastDiscrepancy = last_zero;
1417  023b 7b03          	ld	a,(OFST-4,sp)
1418  023d 1e08          	ldw	x,(OFST+1,sp)
1419  023f e703          	ld	(3,x),a
1420                     ; 238 			if (OneWireStruct->LastDiscrepancy == 0) {
1422  0241 1e08          	ldw	x,(OFST+1,sp)
1423  0243 6d03          	tnz	(3,x)
1424  0245 2606          	jrne	L565
1425                     ; 239 				OneWireStruct->LastDeviceFlag = 1;
1427  0247 1e08          	ldw	x,(OFST+1,sp)
1428  0249 a601          	ld	a,#1
1429  024b e705          	ld	(5,x),a
1430  024d               L565:
1431                     ; 242 			search_result = 1;
1433  024d a601          	ld	a,#1
1434  024f 6b01          	ld	(OFST-6,sp),a
1436  0251               L325:
1437                     ; 247 	if (!search_result || !OneWireStruct->ROM_NO[0]) {
1439  0251 0d01          	tnz	(OFST-6,sp)
1440  0253 2706          	jreq	L175
1442  0255 1e08          	ldw	x,(OFST+1,sp)
1443  0257 6d06          	tnz	(6,x)
1444  0259 260e          	jrne	L765
1445  025b               L175:
1446                     ; 248 		OneWireStruct->LastDiscrepancy = 0;
1448  025b 1e08          	ldw	x,(OFST+1,sp)
1449  025d 6f03          	clr	(3,x)
1450                     ; 249 		OneWireStruct->LastDeviceFlag = 0;
1452  025f 1e08          	ldw	x,(OFST+1,sp)
1453  0261 6f05          	clr	(5,x)
1454                     ; 250 		OneWireStruct->LastFamilyDiscrepancy = 0;
1456  0263 1e08          	ldw	x,(OFST+1,sp)
1457  0265 6f04          	clr	(4,x)
1458                     ; 251 		search_result = 0;
1460  0267 0f01          	clr	(OFST-6,sp)
1462  0269               L765:
1463                     ; 254 	return search_result;
1465  0269 7b01          	ld	a,(OFST-6,sp)
1467  026b               L64:
1469  026b 5b09          	addw	sp,#9
1470  026d 81            	ret
1563                     ; 257 int TM_OneWire_Verify(TM_OneWire_t* OneWireStruct) {
1564                     	switch	.text
1565  026e               _TM_OneWire_Verify:
1567  026e 89            	pushw	x
1568  026f 5214          	subw	sp,#20
1569       00000014      OFST:	set	20
1572                     ; 262 	for (i = 0; i < 8; i++)
1574  0271 5f            	clrw	x
1575  0272 1f13          	ldw	(OFST-1,sp),x
1577  0274               L346:
1578                     ; 263 	rom_backup[i] = OneWireStruct->ROM_NO[i];
1580  0274 1e15          	ldw	x,(OFST+1,sp)
1581  0276 72fb13        	addw	x,(OFST-1,sp)
1582  0279 e606          	ld	a,(6,x)
1583  027b 96            	ldw	x,sp
1584  027c 1c000b        	addw	x,#OFST-9
1585  027f 1f01          	ldw	(OFST-19,sp),x
1587  0281 1e13          	ldw	x,(OFST-1,sp)
1588  0283 72fb01        	addw	x,(OFST-19,sp)
1589  0286 f7            	ld	(x),a
1590                     ; 262 	for (i = 0; i < 8; i++)
1592  0287 1e13          	ldw	x,(OFST-1,sp)
1593  0289 1c0001        	addw	x,#1
1594  028c 1f13          	ldw	(OFST-1,sp),x
1598  028e 9c            	rvf
1599  028f 1e13          	ldw	x,(OFST-1,sp)
1600  0291 a30008        	cpw	x,#8
1601  0294 2fde          	jrslt	L346
1602                     ; 264 	ld_backup = OneWireStruct->LastDiscrepancy;
1604  0296 1e15          	ldw	x,(OFST+1,sp)
1605  0298 e603          	ld	a,(3,x)
1606  029a 5f            	clrw	x
1607  029b 97            	ld	xl,a
1608  029c 1f03          	ldw	(OFST-17,sp),x
1610                     ; 265 	ldf_backup = OneWireStruct->LastDeviceFlag;
1612  029e 1e15          	ldw	x,(OFST+1,sp)
1613  02a0 e605          	ld	a,(5,x)
1614  02a2 5f            	clrw	x
1615  02a3 97            	ld	xl,a
1616  02a4 1f05          	ldw	(OFST-15,sp),x
1618                     ; 266 	lfd_backup = OneWireStruct->LastFamilyDiscrepancy;
1620  02a6 1e15          	ldw	x,(OFST+1,sp)
1621  02a8 e604          	ld	a,(4,x)
1622  02aa 5f            	clrw	x
1623  02ab 97            	ld	xl,a
1624  02ac 1f07          	ldw	(OFST-13,sp),x
1626                     ; 269 	OneWireStruct->LastDiscrepancy = 64;
1628  02ae 1e15          	ldw	x,(OFST+1,sp)
1629  02b0 a640          	ld	a,#64
1630  02b2 e703          	ld	(3,x),a
1631                     ; 270 	OneWireStruct->LastDeviceFlag = 0;
1633  02b4 1e15          	ldw	x,(OFST+1,sp)
1634  02b6 6f05          	clr	(5,x)
1635                     ; 272 	if (TM_OneWire_Search(OneWireStruct, ONEWIRE_CMD_SEARCHROM)) {
1637  02b8 4bf0          	push	#240
1638  02ba 1e16          	ldw	x,(OFST+2,sp)
1639  02bc cd0144        	call	_TM_OneWire_Search
1641  02bf 5b01          	addw	sp,#1
1642  02c1 4d            	tnz	a
1643  02c2 2735          	jreq	L156
1644                     ; 274 		rslt = 1;
1646  02c4 ae0001        	ldw	x,#1
1647  02c7 1f09          	ldw	(OFST-11,sp),x
1649                     ; 275 		for (i = 0; i < 8; i++) {
1651  02c9 5f            	clrw	x
1652  02ca 1f13          	ldw	(OFST-1,sp),x
1654  02cc               L356:
1655                     ; 276 			if (rom_backup[i] != OneWireStruct->ROM_NO[i]) {
1657  02cc 96            	ldw	x,sp
1658  02cd 1c000b        	addw	x,#OFST-9
1659  02d0 1f01          	ldw	(OFST-19,sp),x
1661  02d2 1e13          	ldw	x,(OFST-1,sp)
1662  02d4 72fb01        	addw	x,(OFST-19,sp)
1663  02d7 f6            	ld	a,(x)
1664  02d8 1e15          	ldw	x,(OFST+1,sp)
1665  02da 72fb13        	addw	x,(OFST-1,sp)
1666  02dd e106          	cp	a,(6,x)
1667  02df 2707          	jreq	L166
1668                     ; 277 				rslt = 1;
1670  02e1 ae0001        	ldw	x,#1
1671  02e4 1f09          	ldw	(OFST-11,sp),x
1673                     ; 278 				break;
1675  02e6 2014          	jra	L366
1676  02e8               L166:
1677                     ; 275 		for (i = 0; i < 8; i++) {
1679  02e8 1e13          	ldw	x,(OFST-1,sp)
1680  02ea 1c0001        	addw	x,#1
1681  02ed 1f13          	ldw	(OFST-1,sp),x
1685  02ef 9c            	rvf
1686  02f0 1e13          	ldw	x,(OFST-1,sp)
1687  02f2 a30008        	cpw	x,#8
1688  02f5 2fd5          	jrslt	L356
1689  02f7 2003          	jra	L366
1690  02f9               L156:
1691                     ; 282 		rslt = 0;
1693  02f9 5f            	clrw	x
1694  02fa 1f09          	ldw	(OFST-11,sp),x
1696  02fc               L366:
1697                     ; 286 	for (i = 0; i < 8; i++) {
1699  02fc 5f            	clrw	x
1700  02fd 1f13          	ldw	(OFST-1,sp),x
1702  02ff               L566:
1703                     ; 287 		OneWireStruct->ROM_NO[i] = rom_backup[i];
1705  02ff 96            	ldw	x,sp
1706  0300 1c000b        	addw	x,#OFST-9
1707  0303 1f01          	ldw	(OFST-19,sp),x
1709  0305 1e13          	ldw	x,(OFST-1,sp)
1710  0307 72fb01        	addw	x,(OFST-19,sp)
1711  030a f6            	ld	a,(x)
1712  030b 1e15          	ldw	x,(OFST+1,sp)
1713  030d 72fb13        	addw	x,(OFST-1,sp)
1714  0310 e706          	ld	(6,x),a
1715                     ; 286 	for (i = 0; i < 8; i++) {
1717  0312 1e13          	ldw	x,(OFST-1,sp)
1718  0314 1c0001        	addw	x,#1
1719  0317 1f13          	ldw	(OFST-1,sp),x
1723  0319 9c            	rvf
1724  031a 1e13          	ldw	x,(OFST-1,sp)
1725  031c a30008        	cpw	x,#8
1726  031f 2fde          	jrslt	L566
1727                     ; 289 	OneWireStruct->LastDiscrepancy = ld_backup;
1729  0321 7b04          	ld	a,(OFST-16,sp)
1730  0323 1e15          	ldw	x,(OFST+1,sp)
1731  0325 e703          	ld	(3,x),a
1732                     ; 290 	OneWireStruct->LastDeviceFlag = ldf_backup;
1734  0327 7b06          	ld	a,(OFST-14,sp)
1735  0329 1e15          	ldw	x,(OFST+1,sp)
1736  032b e705          	ld	(5,x),a
1737                     ; 291 	OneWireStruct->LastFamilyDiscrepancy = lfd_backup;
1739  032d 7b08          	ld	a,(OFST-12,sp)
1740  032f 1e15          	ldw	x,(OFST+1,sp)
1741  0331 e704          	ld	(4,x),a
1742                     ; 294 	return rslt;
1744  0333 1e09          	ldw	x,(OFST-11,sp)
1747  0335 5b16          	addw	sp,#22
1748  0337 81            	ret
1804                     ; 297 void TM_OneWire_TargetSetup(TM_OneWire_t* OneWireStruct, uint8_t family_code) {
1805                     	switch	.text
1806  0338               _TM_OneWire_TargetSetup:
1808  0338 89            	pushw	x
1809  0339 88            	push	a
1810       00000001      OFST:	set	1
1813                     ; 301 	OneWireStruct->ROM_NO[0] = family_code;
1815  033a 7b06          	ld	a,(OFST+5,sp)
1816  033c 1e02          	ldw	x,(OFST+1,sp)
1817  033e e706          	ld	(6,x),a
1818                     ; 302 	for (i = 1; i < 8; i++) {
1820  0340 a601          	ld	a,#1
1821  0342 6b01          	ld	(OFST+0,sp),a
1823  0344               L327:
1824                     ; 303 		OneWireStruct->ROM_NO[i] = 0;
1826  0344 7b02          	ld	a,(OFST+1,sp)
1827  0346 97            	ld	xl,a
1828  0347 7b03          	ld	a,(OFST+2,sp)
1829  0349 1b01          	add	a,(OFST+0,sp)
1830  034b 2401          	jrnc	L26
1831  034d 5c            	incw	x
1832  034e               L26:
1833  034e 02            	rlwa	x,a
1834  034f 6f06          	clr	(6,x)
1835                     ; 302 	for (i = 1; i < 8; i++) {
1837  0351 0c01          	inc	(OFST+0,sp)
1841  0353 7b01          	ld	a,(OFST+0,sp)
1842  0355 a108          	cp	a,#8
1843  0357 25eb          	jrult	L327
1844                     ; 306 	OneWireStruct->LastDiscrepancy = 64;
1846  0359 1e02          	ldw	x,(OFST+1,sp)
1847  035b a640          	ld	a,#64
1848  035d e703          	ld	(3,x),a
1849                     ; 307 	OneWireStruct->LastFamilyDiscrepancy = 0;
1851  035f 1e02          	ldw	x,(OFST+1,sp)
1852  0361 6f04          	clr	(4,x)
1853                     ; 308 	OneWireStruct->LastDeviceFlag = 0;
1855  0363 1e02          	ldw	x,(OFST+1,sp)
1856  0365 6f05          	clr	(5,x)
1857                     ; 309 }
1860  0367 5b03          	addw	sp,#3
1861  0369 81            	ret
1899                     ; 311 void TM_OneWire_FamilySkipSetup(TM_OneWire_t* OneWireStruct) {
1900                     	switch	.text
1901  036a               _TM_OneWire_FamilySkipSetup:
1905                     ; 313 	OneWireStruct->LastDiscrepancy = OneWireStruct->LastFamilyDiscrepancy;
1907  036a e604          	ld	a,(4,x)
1908  036c e703          	ld	(3,x),a
1909                     ; 314 	OneWireStruct->LastFamilyDiscrepancy = 0;
1911  036e 6f04          	clr	(4,x)
1912                     ; 317 	if (OneWireStruct->LastDiscrepancy == 0) {
1914  0370 6d03          	tnz	(3,x)
1915  0372 2604          	jrne	L157
1916                     ; 318 		OneWireStruct->LastDeviceFlag = 1;
1918  0374 a601          	ld	a,#1
1919  0376 e705          	ld	(5,x),a
1920  0378               L157:
1921                     ; 320 }
1924  0378 81            	ret
1970                     ; 322 uint8_t TM_OneWire_GetROM(TM_OneWire_t* OneWireStruct, uint8_t index) {
1971                     	switch	.text
1972  0379               _TM_OneWire_GetROM:
1974  0379 89            	pushw	x
1975       00000000      OFST:	set	0
1978                     ; 323 	return OneWireStruct->ROM_NO[index];
1980  037a 01            	rrwa	x,a
1981  037b 1b05          	add	a,(OFST+5,sp)
1982  037d 2401          	jrnc	L07
1983  037f 5c            	incw	x
1984  0380               L07:
1985  0380 02            	rlwa	x,a
1986  0381 e606          	ld	a,(6,x)
1989  0383 85            	popw	x
1990  0384 81            	ret
2047                     ; 326 void TM_OneWire_Select(TM_OneWire_t* OneWireStruct, uint8_t* addr) {
2048                     	switch	.text
2049  0385               _TM_OneWire_Select:
2051  0385 89            	pushw	x
2052  0386 88            	push	a
2053       00000001      OFST:	set	1
2056                     ; 328 	TM_OneWire_WriteByte(OneWireStruct, ONEWIRE_CMD_MATCHROM);
2058  0387 4b55          	push	#85
2059  0389 cd00e5        	call	_TM_OneWire_WriteByte
2061  038c 84            	pop	a
2062                     ; 330 	for (i = 0; i < 8; i++) {
2064  038d 0f01          	clr	(OFST+0,sp)
2066  038f               L7201:
2067                     ; 331 		TM_OneWire_WriteByte(OneWireStruct, *(addr + i));
2069  038f 7b06          	ld	a,(OFST+5,sp)
2070  0391 97            	ld	xl,a
2071  0392 7b07          	ld	a,(OFST+6,sp)
2072  0394 1b01          	add	a,(OFST+0,sp)
2073  0396 2401          	jrnc	L47
2074  0398 5c            	incw	x
2075  0399               L47:
2076  0399 02            	rlwa	x,a
2077  039a f6            	ld	a,(x)
2078  039b 88            	push	a
2079  039c 1e03          	ldw	x,(OFST+2,sp)
2080  039e cd00e5        	call	_TM_OneWire_WriteByte
2082  03a1 84            	pop	a
2083                     ; 330 	for (i = 0; i < 8; i++) {
2085  03a2 0c01          	inc	(OFST+0,sp)
2089  03a4 7b01          	ld	a,(OFST+0,sp)
2090  03a6 a108          	cp	a,#8
2091  03a8 25e5          	jrult	L7201
2092                     ; 333 }
2095  03aa 5b03          	addw	sp,#3
2096  03ac 81            	ret
2154                     ; 335 void TM_OneWire_SelectWithPointer(TM_OneWire_t* OneWireStruct, uint8_t *ROM) {
2155                     	switch	.text
2156  03ad               _TM_OneWire_SelectWithPointer:
2158  03ad 89            	pushw	x
2159  03ae 88            	push	a
2160       00000001      OFST:	set	1
2163                     ; 337 	TM_OneWire_WriteByte(OneWireStruct, ONEWIRE_CMD_MATCHROM);
2165  03af 4b55          	push	#85
2166  03b1 cd00e5        	call	_TM_OneWire_WriteByte
2168  03b4 84            	pop	a
2169                     ; 339 	for (i = 0; i < 8; i++) {
2171  03b5 0f01          	clr	(OFST+0,sp)
2173  03b7               L5601:
2174                     ; 340 		TM_OneWire_WriteByte(OneWireStruct, *(ROM + i));
2176  03b7 7b06          	ld	a,(OFST+5,sp)
2177  03b9 97            	ld	xl,a
2178  03ba 7b07          	ld	a,(OFST+6,sp)
2179  03bc 1b01          	add	a,(OFST+0,sp)
2180  03be 2401          	jrnc	L001
2181  03c0 5c            	incw	x
2182  03c1               L001:
2183  03c1 02            	rlwa	x,a
2184  03c2 f6            	ld	a,(x)
2185  03c3 88            	push	a
2186  03c4 1e03          	ldw	x,(OFST+2,sp)
2187  03c6 cd00e5        	call	_TM_OneWire_WriteByte
2189  03c9 84            	pop	a
2190                     ; 339 	for (i = 0; i < 8; i++) {
2192  03ca 0c01          	inc	(OFST+0,sp)
2196  03cc 7b01          	ld	a,(OFST+0,sp)
2197  03ce a108          	cp	a,#8
2198  03d0 25e5          	jrult	L5601
2199                     ; 342 }
2202  03d2 5b03          	addw	sp,#3
2203  03d4 81            	ret
2260                     ; 344 void TM_OneWire_GetFullROM(TM_OneWire_t* OneWireStruct, uint8_t *firstIndex) {
2261                     	switch	.text
2262  03d5               _TM_OneWire_GetFullROM:
2264  03d5 89            	pushw	x
2265  03d6 88            	push	a
2266       00000001      OFST:	set	1
2269                     ; 346 	for (i = 0; i < 8; i++) {
2271  03d7 0f01          	clr	(OFST+0,sp)
2273  03d9               L3211:
2274                     ; 347 		*(firstIndex + i) = OneWireStruct->ROM_NO[i];
2276  03d9 7b06          	ld	a,(OFST+5,sp)
2277  03db 97            	ld	xl,a
2278  03dc 7b07          	ld	a,(OFST+6,sp)
2279  03de 1b01          	add	a,(OFST+0,sp)
2280  03e0 2401          	jrnc	L401
2281  03e2 5c            	incw	x
2282  03e3               L401:
2283  03e3 02            	rlwa	x,a
2284  03e4 89            	pushw	x
2285  03e5 7b04          	ld	a,(OFST+3,sp)
2286  03e7 97            	ld	xl,a
2287  03e8 7b05          	ld	a,(OFST+4,sp)
2288  03ea 1b03          	add	a,(OFST+2,sp)
2289  03ec 2401          	jrnc	L601
2290  03ee 5c            	incw	x
2291  03ef               L601:
2292  03ef 02            	rlwa	x,a
2293  03f0 e606          	ld	a,(6,x)
2294  03f2 85            	popw	x
2295  03f3 f7            	ld	(x),a
2296                     ; 346 	for (i = 0; i < 8; i++) {
2298  03f4 0c01          	inc	(OFST+0,sp)
2302  03f6 7b01          	ld	a,(OFST+0,sp)
2303  03f8 a108          	cp	a,#8
2304  03fa 25dd          	jrult	L3211
2305                     ; 349 }
2308  03fc 5b03          	addw	sp,#3
2309  03fe 81            	ret
2389                     ; 351 uint8_t TM_OneWire_CRC8(uint8_t *addr, uint8_t len) {
2390                     	switch	.text
2391  03ff               _TM_OneWire_CRC8:
2393  03ff 89            	pushw	x
2394  0400 5204          	subw	sp,#4
2395       00000004      OFST:	set	4
2398                     ; 352 	uint8_t crc = 0, inbyte, i, mix;
2400  0402 0f04          	clr	(OFST+0,sp)
2403  0404 202d          	jra	L7711
2404  0406               L3711:
2405                     ; 355 		inbyte = *addr++;
2407  0406 1e05          	ldw	x,(OFST+1,sp)
2408  0408 1c0001        	addw	x,#1
2409  040b 1f05          	ldw	(OFST+1,sp),x
2410  040d 1d0001        	subw	x,#1
2411  0410 f6            	ld	a,(x)
2412  0411 6b02          	ld	(OFST-2,sp),a
2414                     ; 356 		for (i = 8; i; i--) {
2416  0413 a608          	ld	a,#8
2417  0415 6b03          	ld	(OFST-1,sp),a
2419  0417               L3021:
2420                     ; 357 			mix = (crc ^ inbyte) & 0x01;
2422  0417 7b04          	ld	a,(OFST+0,sp)
2423  0419 1802          	xor	a,(OFST-2,sp)
2424  041b a401          	and	a,#1
2425  041d 6b01          	ld	(OFST-3,sp),a
2427                     ; 358 			crc >>= 1;
2429  041f 0404          	srl	(OFST+0,sp)
2431                     ; 359 			if (mix) {
2433  0421 0d01          	tnz	(OFST-3,sp)
2434  0423 2706          	jreq	L1121
2435                     ; 360 				crc ^= 0x8C;
2437  0425 7b04          	ld	a,(OFST+0,sp)
2438  0427 a88c          	xor	a,	#140
2439  0429 6b04          	ld	(OFST+0,sp),a
2441  042b               L1121:
2442                     ; 362 			inbyte >>= 1;
2444  042b 0402          	srl	(OFST-2,sp)
2446                     ; 356 		for (i = 8; i; i--) {
2448  042d 0a03          	dec	(OFST-1,sp)
2452  042f 0d03          	tnz	(OFST-1,sp)
2453  0431 26e4          	jrne	L3021
2454  0433               L7711:
2455                     ; 354 	while (len--) {
2457  0433 7b09          	ld	a,(OFST+5,sp)
2458  0435 0a09          	dec	(OFST+5,sp)
2459  0437 4d            	tnz	a
2460  0438 26cc          	jrne	L3711
2461                     ; 367 	return crc;
2463  043a 7b04          	ld	a,(OFST+0,sp)
2466  043c 5b06          	addw	sp,#6
2467  043e 81            	ret
2480                     	xdef	_TM_OneWire_FamilySkipSetup
2481                     	xdef	_TM_OneWire_TargetSetup
2482                     	xdef	_TM_OneWire_Verify
2483                     	xdef	_TM_OneWire_CRC8
2484                     	xdef	_TM_OneWire_SelectWithPointer
2485                     	xdef	_TM_OneWire_Select
2486                     	xdef	_TM_OneWire_GetFullROM
2487                     	xdef	_TM_OneWire_GetROM
2488                     	xdef	_TM_OneWire_Next
2489                     	xdef	_TM_OneWire_First
2490                     	xdef	_TM_OneWire_ResetSearch
2491                     	xdef	_TM_OneWire_Search
2492                     	xdef	_TM_OneWire_ReadBit
2493                     	xdef	_TM_OneWire_WriteBit
2494                     	xdef	_TM_OneWire_WriteByte
2495                     	xdef	_TM_OneWire_ReadByte
2496                     	xdef	_TM_OneWire_Reset
2497                     	xdef	_TM_OneWire_Init
2498                     	xref	_Delay_US
2499                     	xref	_GPIO_ReadInputPin
2500                     	xref	_GPIO_WriteLow
2501                     	xref	_GPIO_WriteHigh
2502                     	xref	_GPIO_Init
2521                     	end
