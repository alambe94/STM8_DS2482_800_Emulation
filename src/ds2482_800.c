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

TM_OneWire_t One_Wire_Struct_CH0;
TM_OneWire_t One_Wire_Struct_CH1;
TM_OneWire_t One_Wire_Struct_CH2;
TM_OneWire_t One_Wire_Struct_CH3;
TM_OneWire_t One_Wire_Struct_CH4;
TM_OneWire_t One_Wire_Struct_CH5;
TM_OneWire_t One_Wire_Struct_CH6;
TM_OneWire_t One_Wire_Struct_CH7;

TM_OneWire_t* Current_OW_CH_PTR = &One_Wire_Struct_CH0; //Current Read ponter of I2C read cammand



void DS2482_Init()
{
  //config gpio
  
  /*************input***************************/
  GPIO_Init(DS2482_AD_0_PORT,DS2482_AD_0_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_1_PORT,DS2482_AD_1_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_2_PORT,DS2482_AD_2_PIN,GPIO_MODE_IN_PU_NO_IT);
  /*************input***************************/
  
  /*************output***************************/
  TM_OneWire_Init(&One_Wire_Struct_CH0, DS2482_IO_0_PORT, DS2482_IO_0_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH1, DS2482_IO_1_PORT, DS2482_IO_1_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH2, DS2482_IO_2_PORT, DS2482_IO_2_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH3, DS2482_IO_3_PORT, DS2482_IO_3_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH4, DS2482_IO_4_PORT, DS2482_IO_4_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH5, DS2482_IO_5_PORT, DS2482_IO_5_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH6, DS2482_IO_6_PORT, DS2482_IO_6_PIN);
  TM_OneWire_Init(&One_Wire_Struct_CH7, DS2482_IO_7_PORT, DS2482_IO_7_PIN);
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

void DS2482_Device_Reset(void)
{
    //reset status
  Register_PTR = &Status_Register; // point to status register
}


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


void DS2482_Write_CFG(uint8_t param)
{
  Configuration_Register = param;
  Register_PTR = &Configuration_Register;
}



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
    Current_OW_CH_PTR = &One_Wire_Struct_CH0;
    break;
  case CHANNEL_1_CODE:
    Channel_Selection_Register = CHANNEL_1_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH1;
    break;
  case CHANNEL_2_CODE:
    Channel_Selection_Register = CHANNEL_2_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH2;
    break;
  case CHANNEL_3_CODE:
    Channel_Selection_Register = CHANNEL_3_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH3;
    break;
  case CHANNEL_4_CODE:
    Channel_Selection_Register = CHANNEL_4_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH4;
    break;
  case CHANNEL_5_CODE:
    Channel_Selection_Register = CHANNEL_5_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH5;
    break;
  case CHANNEL_6_CODE:
    Channel_Selection_Register = CHANNEL_6_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH6;
    break;
  case CHANNEL_7_CODE:
    Channel_Selection_Register = CHANNEL_7_RETURN;
    Current_OW_CH_PTR = &One_Wire_Struct_CH7;
    break;
  default:
    //error
    break;
  }
}


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







