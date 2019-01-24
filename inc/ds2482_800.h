#ifndef _DS2482_800_H
#define _DS2482_800_H

#include "stm8s.h"
#include "main.h"


#define I2C_SDA_PIN          GPIO_PIN_5
#define I2C_SDA_PORT         GPIOB

#define I2C_SCL_PIN          GPIO_PIN_4
#define I2C_SCL_PORT         GPIOB


/****************I2C Address Pins, Ports*********************/
#define DS2482_AD_0_PIN    GPIO_PIN_5
#define DS2482_AD_0_PORT   GPIOD

#define DS2482_AD_1_PIN    GPIO_PIN_6
#define DS2482_AD_1_PORT   GPIOD

#define DS2482_AD_2_PIN    GPIO_PIN_1
#define DS2482_AD_2_PORT   GPIOA
/****************I2C Address Pins, Ports*********************/




/**********DS2482 Channels Pins, Ports***************/
#define DS2482_IO_0_PIN   GPIO_PIN_3
#define DS2482_IO_0_PORT  GPIOC

#define DS2482_IO_1_PIN   GPIO_PIN_4
#define DS2482_IO_1_PORT  GPIOC

#define DS2482_IO_2_PIN   GPIO_PIN_5
#define DS2482_IO_2_PORT  GPIOC

#define DS2482_IO_3_PIN   GPIO_PIN_6
#define DS2482_IO_3_PORT  GPIOC

#define DS2482_IO_4_PIN   GPIO_PIN_7
#define DS2482_IO_4_PORT  GPIOC

#define DS2482_IO_5_PIN   GPIO_PIN_2
#define DS2482_IO_5_PORT  GPIOD

#define DS2482_IO_6_PIN   GPIO_PIN_3
#define DS2482_IO_6_PORT  GPIOD

#define DS2482_IO_7_PIN   GPIO_PIN_4
#define DS2482_IO_7_PORT  GPIOD
/**********DS2482 Channels Pins, Ports***************/



//DEVICE REGISTERS Bit fields

//Configuration_Register
#define  DS2482_APU (1<<0)    //Active Pullup (APU) 
#define  DS2482_SPU (1<<2)    //Strong Pullup (SPU)
#define  DS2482_OWS (1<<3)    //1-Wire Speed  (1WS)

#define  DS2482_APU_N (1<<4)  //APU Compliment
#define  DS2482_SPU_N (1<<6)  //SPU Compliment
#define  DS2482_OWS_N (1<<7)  //OWS Compliment

//Status Register
#define  DS2482_OWB   (1<<0)    //1-Wire Busy (1WB)
#define  DS2482_PPD   (1<<1)    //Presence Pulse Detect (PPD)
#define  DS2482_SD    (1<<2)    //Short Detected (SD)
#define  DS2482_LL    (1<<3)    //Logic Level (LL)
#define  DS2482_RST   (1<<4)    //Device Reset (RST)
#define  DS2482_SBR   (1<<5)    //Single Bit Result (SBR)
#define  DS2482_TSB   (1<<6)    //Triplet Second Bit (TSB)
#define  DS2482_DIR   (1<<7)    //Branch Direction Taken (DIR)


//FUNCTION COMMANDS

/*********************************************/
//Device Reset (Parameter 0 byte)
#define  DEVICE_RESET_CMD               (0xF0)
/*********************************************/



/*********************************************/
//Set Read Pointer cammand
#define  SET_READ_POINTER_CMD           (0xE1)

//Set Read Pointer valid Command Parameter
#define  STATUS_REGISTER_PTR            (0xF0)
#define  READ_DATA_REGISTER_PTR         (0xE1)
#define  CHANNEL_SELECTION_REGISTER_PTR (0xD2)
#define  CONFIGURATION_REGISTER_PTR     (0xC3)
/*********************************************/

/*********************************************/
//Write Configuration (Parameter 1 byte)
#define  WRITE_CONFIGURATION_CMD        (0xD2)
/*********************************************/

/*********************************************/
//Channel Select (Parameter 1 byte)
#define  CHANNEL_SELECT_CMD             (0XC3)

#define  CHANNEL_0_CODE             (0XF0)
#define  CHANNEL_1_CODE             (0XE1)
#define  CHANNEL_2_CODE             (0XD2)
#define  CHANNEL_3_CODE             (0XC3)
#define  CHANNEL_4_CODE             (0XB4)
#define  CHANNEL_5_CODE             (0XA5)
#define  CHANNEL_6_CODE             (0X96)
#define  CHANNEL_7_CODE             (0X87)

#define  CHANNEL_0_RETURN           (0XB8)
#define  CHANNEL_1_RETURN           (0XB1)
#define  CHANNEL_2_RETURN           (0XAA)
#define  CHANNEL_3_RETURN           (0XA3)
#define  CHANNEL_4_RETURN           (0X9C)
#define  CHANNEL_5_RETURN           (0X95)
#define  CHANNEL_6_RETURN           (0X8E)
#define  CHANNEL_7_RETURN           (0X87)
/*********************************************/


//1-Wire Reset (Parameter 0 byte)
#define  OW_RESET_CMD               (0XB4)

//1-Wire Single Bit (Parameter 1 byte (only MSB))
#define  OW_SINGLE_BIT_CMD          (0X87)

//1-Wire Write Byte (Parameter 1 byte)
#define  OW_WRITE_BYTE_CMD          (0XA5)

//1-Wire Read Byte (Parameter 0 byte)
#define  OW_READ_BYTE_CMD           (0X96)

//1-Wire Single Bit (Parameter 1 byte (only MSB))
//1-Wire Triplet
#define  OW_TRIPLET_CMD             (0X78)



typedef enum
{
WAIT_FOR_CMD,
WAIT_FOR_PARAM
}State_Machine_t;


void DS2482_Init();
void DS2482_Loop();




#endif // _DS2482_800_H
