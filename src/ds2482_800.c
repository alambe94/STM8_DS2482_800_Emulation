#include "ds2482_800.h"
#include "tm_onewire.h"

#include "stm8s.h"



uint8_t  Configuration_Register =     0x00;
uint8_t  Status_Register =            0x00;
uint8_t  Channel_Selection_Register = 0x00;
uint8_t  Read_Data_Register =         0x00;

uint8_t  DS2482_Busy = RESET;
uint8_t* Register_PTR = &Status_Register; //Current Read ponter of I2C read cammand

State_Machine_t Current_State = WAIT_FOR_CMD;
uint8_t         Received_Cammand = 0x00;
uint8_t         Received_Parameter = 0x00;
uint8_t         Cammand_Valid_Flag = 0x00;
uint8_t         Cammand_Execute_Flag = 0x00;

TM_OneWire_t One_Wire_Struct_Ch0;
TM_OneWire_t One_Wire_Struct_Ch1;
TM_OneWire_t One_Wire_Struct_Ch2;
TM_OneWire_t One_Wire_Struct_Ch3;
TM_OneWire_t One_Wire_Struct_Ch4;
TM_OneWire_t One_Wire_Struct_Ch5;
TM_OneWire_t One_Wire_Struct_Ch6;
TM_OneWire_t One_Wire_Struct_Ch7;

TM_OneWire_t* Current_OW_CH_PTR = &One_Wire_Struct_Ch0; //Current Read ponter of I2C read cammand



void DS2482_Init()
{
  //config gpio
  
  /*************input***************************/
  GPIO_Init(DS2482_AD_0_PORT,DS2482_AD_0_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_1_PORT,DS2482_AD_1_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_2_PORT,DS2482_AD_2_PIN,GPIO_MODE_IN_PU_NO_IT);
  /*************input***************************/
  
  /*************output***************************/
  TM_OneWire_Init(&One_Wire_Struct_Ch0, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch1, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch2, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch3, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch4, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch5, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch6, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_Ch7, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  /*************output***************************/
  
  /*************i2c***************************/
  uint8_t own_address = 0x18; //Default
  
  GPIO_Init(I2C_SDA_PORT,I2C_SDA_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(I2C_SCL_PORT,I2C_SCL_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  //own_address |= GPIO_READ_PIN(DS2482_AD_0_PORT,DS2482_AD_0_PIN)<<0;
  //own_address |= GPIO_READ_PIN(DS2482_AD_1_PORT,DS2482_AD_1_PIN)<<1;
  //own_address |= GPIO_READ_PIN(DS2482_AD_2_PORT,DS2482_AD_2_PIN)<<2;
  
  own_address = own_address<<1;
  
  I2C_Init(400000, 
           own_address, 
           I2C_DUTYCYCLE_2,
           I2C_ACK_CURR, 
           I2C_ADDMODE_7BIT, 
           16);
  
  I2C_StretchClockCmd(ENABLE);
  I2C_ITConfig(I2C_IT_ERR, ENABLE);
  I2C_ITConfig(I2C_IT_EVT, ENABLE);
  I2C_ITConfig(I2C_IT_BUF, ENABLE);
  
  /*************i2c***************************/
  
}


/*    DS2482_Device_Reset

Command Code:
F0h

Command Parameter: 
None

Description:
Performs a global reset of device state machine logic, which in turn
selects IO0 as the active 1-Wire channel.
Terminates any ongoing 1-Wire communication.

Typical Use: 
Device initialization after power-up; re-initialization (reset) as desired.

Restriction: 
None (can be executed at any time)

Error Response: 
None

Command Duration: 
Maximum 525ns, counted from falling SCL edge of the command code
acknowledge bit.

1-Wire Activity: 
Ends maximum 262.5ns after the falling SCL edge of the command code
acknowledge bit.

Read Pointer Position: 
Status Register (for busy polling)

Status Bits Affected: 
RST set to 1,
1WB, PPD, SD, SBR, TSB, DIR set to 0

Configuration Bits Affected: 
1WS, APU, SPU set to 0

*/

void DS2482_Device_Reset(void)
{
    //reset status
  Register_PTR = &Status_Register; // point to status register
}


/*  DS2482_Set_Read_PTR
Command Code: 
E1h

Command Parameter: 
Pointer Code

Description: 
Sets the read pointer to the specified register. Overwrites the read pointer
position of any 1-Wire communication command in progress.

Typical Use: 
To prepare reading the result from a 1-Wire Byte command; random read
access of registers.

Restriction: 
None (can be executed at any time)

Error Response:
 If the pointer code is not valid, the pointer code will not be acknowledged
and the command will be ignored.

Command Duration: 
None; the read pointer is updated on the rising SCL edge of the pointer
code acknowledge bit.

1-Wire Activity: 
Not Affected

Read Pointer Position: 
As Specified by the Pointer Code

Status Bits Affected: 
None

Configuration Bits Affected:
None

*/

void DS2482_Set_Read_PTR(uint8_t param)
{
  switch(param)
  {
  case STATUS_REGISTER_PTR:
    Register_PTR = &Status_Register;
    break;
  case READ_DATA_REGISTER_PTR:
    Register_PTR = &Read_Data_Register;
    break;
  case CHANNEL_SELECTION_REGISTER_PTR:
    Register_PTR = &Channel_Selection_Register;
    break;
  case CONFIGURATION_REGISTER_PTR:
    Register_PTR = &Configuration_Register;
    break;
  default:
    //error
    break;
  }
}


/* DS2482_Write_CFG
Command Code: 
D2h

Command Parameter Configuration: 
Byte

Description:
Writes a new configuration byte. The new settings take effect
immediately. NOTE: When writing to the Configuration Register, the new
data is accepted only if the upper nibble (bits 7 to 4) is the one's
complement of the lower nibble (bits 3 to 0). When read, the upper nibble
is always 0h.

Typical Use:
Defining the features for subsequent 1-Wire communication.

Restriction: 
1-Wire activity must have ended before the DS2482 can process this
command.

Error Response: 
Command code and parameter will not be acknowledged if 1WB = 1 at the
time the command code is received and the command will be ignored.

Command Duration: 
None; the configuration register is updated on the rising SCL edge of the
configuration byte acknowledge bit.

1-Wire Activity: 
None

Read Pointer Position: 
Configuration Register (to verify write)

Status Bits Affected: 
RST set to 0

Configuration Bits Affected: 
1WS, SPU, APU updated

*/

void DS2482_Write_CFG(uint8_t param)
{
  Configuration_Register = param;
  Register_PTR = &Configuration_Register;
}


/* DS2482_Select_Channel
Command Code: 
C3h

Command Parameter:
Selection Code

Description
Sets the 1-Wire IO channel for subsequent 1-Wire communication
commands. NOTE: The selection code read back is different from the
code written. See the table below for the respective values.

Typical Use: 
Selecting a 1-Wire IO channel other that IO0; randomly selecting one of
the available 1-Wire IO channels.

Restriction: 
1-Wire activity must have ended before the DS2482 can process this
command.

Error Response:
Command code and parameter will not be acknowledged if 1WB = 1 at the
time the command code is received and the command will be ignored.
If the selection code is not valid, the selection code will not be
acknowledged and the command will be ignored.

Command Duration: 
None; the channel selection register is updated on the rising SCL edge of
the selection code acknowledge bit.

1-Wire Activity: 
None

Read Pointer Position: 
Channel Selection Register (to verify write)

Status Bits Affected: 
None

Configuration Bits: 
Affected None

*/

void DS2482_Select_Channel(uint8_t channel)
{
  /*Sets the 1-Wire IO channel for subsequent 1-Wire communication
  commands. NOTE: The selection code read back is different from the
  code written. See the table below for the respective values. */
  //implement one wire protocol
  Register_PTR = &Channel_Selection_Register;
  
  switch(channel)
  {
  case CHANNEL_0_CODE:
    Channel_Selection_Register = CHANNEL_0_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch0;
    break;
  case CHANNEL_1_CODE:
    Channel_Selection_Register = CHANNEL_1_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch1;
    break;
  case CHANNEL_2_CODE:
    Channel_Selection_Register = CHANNEL_2_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch2;
    break;
  case CHANNEL_3_CODE:
    Channel_Selection_Register = CHANNEL_3_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch3;
    break;
  case CHANNEL_4_CODE:
    Channel_Selection_Register = CHANNEL_4_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch4;
    break;
  case CHANNEL_5_CODE:
    Channel_Selection_Register = CHANNEL_5_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch5;
    break;
  case CHANNEL_6_CODE:
    Channel_Selection_Register = CHANNEL_6_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch6;
    break;
  case CHANNEL_7_CODE:
    Channel_Selection_Register = CHANNEL_7_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_Ch7;
    break;
  default:
    //error
    break;
  }
}


/*
Command Code: 
B4h

Command Parameter: 
None

Description:
Generates a 1-Wire Reset/Presence Detect cycle (Figure 4) at the
selected IO channel. The state of the 1-Wire line is sampled at tSI and tMSP
and the result is reported to the host processor through the status register,
bits PPD and SD.

Typical Use: 
To initiate or end any 1-Wire communication sequence.

Restriction:
1-Wire activity must have ended before the DS2482 can process this
command. Strong pullup (see SPU bit) should not be used in conjunction
with the 1-Wire Reset command. If SPU is enabled, the PPD bit may not
be valid and may cause a violation of the device's absolute maximum
rating.

Error Response: 
Command code will not be acknowledged if 1WB = 1 at the time the
command code is received and the command will be ignored.

Command Duration:
tRSTL + tRSTH + maximum 262.5ns, counted from the falling SCL edge of the
command code acknowledge bit.

1-Wire Activity: 
Begins maximum 262.5ns after the falling SCL edge of the command
code acknowledge bit.

Read Pointer Position: 
Status Register (for busy polling)

Status Bits Affected
1WB (set to 1 for tRSTL + tRSTH),
PPD is updated at tRSTL + tMSP,
SD is updated at tRSTL + tSI

Configuration Bits Affected: 
1WS, APU, SPU apply

*/

void DS2482_OW_Reset(void)
{
  /*Generates a 1-Wire Reset/Presence Detect cycle (Figure 4) at the
  selected IO channel. The state of the 1-Wire line is sampled at tSI and tMSP
  and the result is reported to the host processor through the status register,
  bits PPD and SD.*/
  //implement one wire protocol
  Register_PTR = &Status_Register; // point to status register
  TM_OneWire_Reset(Current_OW_CH_PTR);
}



void DS2482_OW_Write_Single_Bit(uint8_t data_bit)
{
  //implement one wire protocol
    Register_PTR = &Status_Register; // point to status register
    TM_OneWire_WriteBit(Current_OW_CH_PTR,(data_bit & 0x80));
}
void DS2482_OW_Write_Single_Byte(uint8_t data_byte)
{
  //implement one wire protocol
    Register_PTR = &Status_Register; // point to status register
    TM_OneWire_WriteByte(Current_OW_CH_PTR,data_byte);
}

void DS2482_OW_Read_Single_Byte()
{
  /*Status Register (for busy polling)
  NOTE: To read the data byte received from the 1-Wire IO channel, issue
  the Set Read Pointer command and select the Read Data Register. Then
  access the DS2482 in read mode.*/
  Register_PTR = &Status_Register; // point to status register
  
  Read_Data_Register = TM_OneWire_ReadByte(Current_OW_CH_PTR);

  //implement one wire protocol
}



void DS2482_OW_Triplet(void)
{
    //implement one wire protocol
  Register_PTR = &Status_Register; // point to status register
}





void DS2482_Loop()
{
  if(Cammand_Execute_Flag ==SET)
  {
    /* Disable the acknowledgement */
    /* ignore incoming data OW busy*/
    I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
    
    Cammand_Execute_Flag = RESET;
    switch(Received_Cammand)
    {
    case DEVICE_RESET_CMD:
      DS2482_Device_Reset();
      break;
    case SET_READ_POINTER_CMD:
      DS2482_Set_Read_PTR(Received_Parameter);
      break;
    case WRITE_CONFIGURATION_CMD:
      DS2482_Write_CFG(Received_Parameter);
      break;
    case CHANNEL_SELECT_CMD:
      DS2482_Select_Channel(Received_Parameter);
      break;
    case OW_RESET_CMD:
      DS2482_OW_Reset();
      break;
    case OW_SINGLE_BIT_CMD:
      DS2482_OW_Write_Single_Bit(Received_Parameter);
      break;
    case OW_WRITE_BYTE_CMD:
      DS2482_OW_Write_Single_Byte(Received_Parameter);
      break;
    case OW_READ_BYTE_CMD:
      DS2482_OW_Read_Single_Byte();
      break;
    case OW_TRIPLET_CMD:
      DS2482_OW_Triplet();
      break;
    default:
      //error
      break;
      
    }
    /* Enable the acknowledgement */
    I2C->CR2 |= I2C_CR2_ACK;
  }
}



INTERRUPT_HANDLER(I2C_IRQHandler, 19)
{
  static uint8_t sr1;					
  static uint8_t sr2;
  static uint8_t sr3;
  sr3 = sr3;
  uint8_t data_reg;
  uint8_t temp1;
  uint8_t temp2;
  
  
  // save the I2C registers configuration
  sr1 = I2C->SR1;
  sr2 = I2C->SR2;
  sr3 = I2C->SR3;
  
  /* Communication error? */
  if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
  {		
    I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
    I2C->SR2= 0;					    // clear all error flags
  }
  
  /* Byte received ? */
  if (sr1 & I2C_SR1_RXNE)
  {
    data_reg = I2C->DR;
    switch(Current_State)
    {
      /********************* WAIT_FOR_CMD************************/     
    case WAIT_FOR_CMD:
      {
        Received_Cammand = data_reg;
        switch(Received_Cammand)
        {
        case DEVICE_RESET_CMD:
        case OW_RESET_CMD:
        case OW_READ_BYTE_CMD:
          Current_State = WAIT_FOR_CMD;
          break;
        case SET_READ_POINTER_CMD:
        case WRITE_CONFIGURATION_CMD:
        case CHANNEL_SELECT_CMD:
        case OW_SINGLE_BIT_CMD:
        case OW_WRITE_BYTE_CMD:
        case OW_TRIPLET_CMD:
          Current_State = WAIT_FOR_PARAM;
          break;
        default:
          Cammand_Valid_Flag = RESET;
          break;
        }
      }
      break;
      /********************* WAIT_FOR_CMD************************/     
      
      
      
      
      /********************* WAIT_FOR_PARAM************************/     
    case WAIT_FOR_PARAM:
      {
        Received_Parameter = data_reg;
        Current_State = WAIT_FOR_CMD;
        switch(Received_Cammand)
        {
          /* dont check parameter for these commands */
        case DEVICE_RESET_CMD:  
        case OW_RESET_CMD:
        case OW_READ_BYTE_CMD:
        case OW_SINGLE_BIT_CMD:
        case OW_WRITE_BYTE_CMD:
        case OW_TRIPLET_CMD:
          break;
          
          /* check for valid parameter for these commands */
          
        case WRITE_CONFIGURATION_CMD:
          {
            temp1 = (data_reg>>4)&0x0F;
            temp2 = (data_reg)&0x0F;
            if(temp1 & temp2)
            {
              Cammand_Valid_Flag = RESET;
            }
            Received_Parameter = data_reg;
            Current_State = WAIT_FOR_CMD;
          }
          break;
          
        case SET_READ_POINTER_CMD:
          { 
            switch(Received_Parameter)
            {
            case STATUS_REGISTER_PTR:
            case READ_DATA_REGISTER_PTR:
            case CHANNEL_SELECTION_REGISTER_PTR:
            case CONFIGURATION_REGISTER_PTR:
              break;
            default:
              Cammand_Valid_Flag = RESET;
              break;
            }
          }
          break;
          
          
        case CHANNEL_SELECT_CMD:
          {
            switch(Received_Parameter)
            {
            case CHANNEL_0_CODE:
            case CHANNEL_1_CODE:
            case CHANNEL_2_CODE:
            case CHANNEL_3_CODE:
            case CHANNEL_4_CODE:
            case CHANNEL_5_CODE:
            case CHANNEL_6_CODE:
            case CHANNEL_7_CODE:
              break;
            default:
              Cammand_Valid_Flag = RESET;
              break;
            }
          }
          break;
        default:
          Cammand_Valid_Flag = RESET;
          break; 
        }
      }
      /********************* WAIT_FOR_PARAM************************/     
      
      break;
    default:
      Cammand_Valid_Flag = RESET;
      break;
    }
  }
  /* NAK? (=end of slave transmit comm) */
  if (sr2 & I2C_SR2_AF)
  {	
    I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
    //stop comm
  }
  /* Stop bit from Master  (= end of slave receive comm) */
  if (sr1 & I2C_SR1_STOPF) 
  {
    I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
    
    if(Cammand_Valid_Flag == SET)
    {
      // call to OW_ routines with cammand and parameter
      Cammand_Execute_Flag = SET;
      Cammand_Valid_Flag = RESET;
    }
    else
    {
      //generate interuppt to inform invalid cammand
    }
  }
  /* Slave address matched (= Start Comm) */
  if (sr1 & I2C_SR1_ADDR)
  {	 
    //start of comm
    Cammand_Valid_Flag = SET;  // initially set 
  }
  
  /* Byte to transmit ? */
  if (sr1 & I2C_SR1_TXE)
  {
    I2C->DR = *Register_PTR;
  }
}







