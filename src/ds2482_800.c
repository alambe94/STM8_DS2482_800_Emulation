#include "ds2482_800.h"
#include "stm8s.h"



uint8_t  Configuration_Register =     0x00;
uint8_t  Status_Register =            0x00;
uint8_t  Channel_Selection_Register = 0x00;
uint8_t  Read_Data_Register =         0x00;

uint8_t  DS2482_Busy = RESET;
uint8_t* Register_PTR = &Configuration_Register; //Current Read ponter of I2C read cammand

State_Machine_t Current_State = WAIT_FOR_CMD;
uint8_t         Received_Cammand = 0x00;
uint8_t         Received_Parameter = 0x00;
uint8_t         Cammand_Valid_Flag = 0x00;
uint8_t         Cammand_Execute_Flag = 0x00;







void DS2482_Init()
{
  //set up i2c as slave
  //config gpio
  
  /*************input***************************/
  GPIO_Init(DS2482_AD_0_PORT,DS2482_AD_0_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_1_PORT,DS2482_AD_1_PIN,GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(DS2482_AD_2_PORT,DS2482_AD_2_PIN,GPIO_MODE_IN_PU_NO_IT);
  /*************input***************************/

  /*************output***************************/
  GPIO_Init(DS2482_IO_0_PORT,DS2482_IO_0_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_1_PORT,DS2482_IO_1_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_2_PORT,DS2482_IO_2_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_3_PORT,DS2482_IO_3_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_4_PORT,DS2482_IO_4_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_5_PORT,DS2482_IO_5_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_6_PORT,DS2482_IO_6_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(DS2482_IO_7_PORT,DS2482_IO_7_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  /*************output***************************/

  /*************i2c***************************/
  uint8_t own_address = 0x18; //Default
  
  GPIO_Init(I2C_SDA_PORT,I2C_SDA_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  GPIO_Init(I2C_SCL_PORT,I2C_SCL_PIN,GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  own_address |= GPIO_READ_PIN(DS2482_AD_0_PORT,DS2482_AD_0_PIN)<<0;
  own_address |= GPIO_READ_PIN(DS2482_AD_1_PORT,DS2482_AD_1_PIN)<<1;
  own_address |= GPIO_READ_PIN(DS2482_AD_2_PORT,DS2482_AD_2_PIN)<<2;
  
  I2C_Init(400000, 
           own_address, 
           I2C_DUTYCYCLE_2,
           I2C_ACK_NONE , 
           I2C_ADDMODE_7BIT, 
           16);
  
  I2C_StretchClockCmd(ENABLE);
  I2C_ITConfig(I2C_IT_ERR, ENABLE);
  I2C_ITConfig(I2C_IT_EVT, ENABLE);
  I2C_ITConfig(I2C_IT_BUF, ENABLE);
  
  /*************i2c***************************/

}


void DS2482_Reset(void)
{
  
}

void DS2482_OW_RESET(void)
{
  
}

void DS2482_OW_Write_Single_Bit(uint8_t data_bit)
{
  
}
void DS2482_OW_Write_Single_Byte(uint8_t data_byte)
{
  
}
   
void DS2482_Select_Channel(uint8_t channel)
{
  switch(channel)
  {
  case CHANNEL_0_CODE:
    Channel_Selection_Register = CHANNEL_0_RETURN;
    break;
    
  case CHANNEL_1_CODE:
    Channel_Selection_Register = CHANNEL_1_RETURN;
    break;
    
  case CHANNEL_2_CODE:
    Channel_Selection_Register = CHANNEL_2_RETURN;
    break;
    
  case CHANNEL_3_CODE:
    Channel_Selection_Register = CHANNEL_3_RETURN;
    break;
    
  case CHANNEL_4_CODE:
    Channel_Selection_Register = CHANNEL_4_RETURN;
    break;
    
  case CHANNEL_5_CODE:
    Channel_Selection_Register = CHANNEL_5_RETURN;
    break;
    
  case CHANNEL_6_CODE:
    I2C_GIVE_ACK();
    Channel_Selection_Register = CHANNEL_6_RETURN;
    break;
    
  case CHANNEL_7_CODE:
    Channel_Selection_Register = CHANNEL_7_RETURN;
    break;
    
  default:
    break;
    
  }
}


void DS2482_Select_Read_PTR(uint8_t PTR)
{
  switch(PTR)
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
    break;
    
  }
}


void DS2482_Loop()
{

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
      
    case WAIT_FOR_CMD:
      {
        switch(data_reg)
        {
        case DEVICE_RESET_CMD:
        case OW_RESET_CMD:
        case OW_READ_BYTE_CMD:
          I2C_GIVE_ACK();
          Received_Cammand = data_reg;
          Current_State = WAIT_FOR_CMD;
          break;
        case SET_READ_POINTER_CMD:
        case WRITE_CONFIGURATION_CMD:
        case CHANNEL_SELECT_CMD:
        case OW_SINGLE_BIT_CMD:
        case OW_WRITE_BYTE_CMD:
        case OW_TRIPLET_CMD:
          I2C_GIVE_ACK();
          Received_Cammand = data_reg;
          Current_State = WAIT_FOR_PARAM;
          break;
        default:
          I2C_GIVE_NACK();// none of the commands matched, give NACK
          Cammand_Valid_Flag = RESET;
          break;
        }
      }
      break;
      
      
    case WAIT_FOR_PARAM:
      switch(Received_Cammand)
      {
        /* no parameter for these commands */
      case DEVICE_RESET_CMD:  
      case OW_RESET_CMD:
      case OW_READ_BYTE_CMD:
        break;
        /* 1 byte parameter for these commands */
      case WRITE_CONFIGURATION_CMD:
        temp1 = (data_reg>>4)&0x0F;
        temp2 = (data_reg)&0x0F;
        if(temp1 & temp2)
        {
        I2C_GIVE_NACK();
        Cammand_Valid_Flag = RESET;
        }
        Received_Parameter = data_reg;
        Current_State = WAIT_FOR_CMD;
        break;
      case OW_SINGLE_BIT_CMD:
      case OW_WRITE_BYTE_CMD:
      case OW_TRIPLET_CMD:
        I2C_GIVE_ACK();
        Received_Parameter = data_reg;
        Current_State = WAIT_FOR_CMD;
        break;
        
         /* check for valid parameter for these commands */
      case SET_READ_POINTER_CMD:
        switch(data_reg)
        {
        case STATUS_REGISTER_PTR:
        case READ_DATA_REGISTER_PTR:
        case CHANNEL_SELECTION_REGISTER_PTR:
        case CONFIGURATION_REGISTER_PTR:
          I2C_GIVE_ACK();
          Received_Parameter = data_reg;
          Current_State = WAIT_FOR_CMD;
          break;
        default:
          I2C_GIVE_NACK();
          Cammand_Valid_Flag = RESET;
          break;
        }
      case CHANNEL_SELECT_CMD:
        switch(data_reg)
        {
        case CHANNEL_0_CODE:
        case CHANNEL_1_CODE:
        case CHANNEL_2_CODE:
        case CHANNEL_3_CODE:
        case CHANNEL_4_CODE:
        case CHANNEL_5_CODE:
        case CHANNEL_6_CODE:
        case CHANNEL_7_CODE:
          I2C_GIVE_ACK();
          Received_Parameter = data_reg;
          Current_State = WAIT_FOR_CMD;
          break;
        default:
          I2C_GIVE_NACK();
          Cammand_Valid_Flag = RESET;
          break;
        }
        break;
      default:
        break;
        
      }
      break;
    default:
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
    //stop of comm
    if(Cammand_Valid_Flag == SET)
    {
      // call to OW_ routines with cammand and parameter
      Cammand_Execute_Flag = SET;
      Cammand_Valid_Flag = RESET;
    }
  }
  /* Slave address matched (= Start Comm) */
  if (sr1 & I2C_SR1_ADDR)
  {	 
    //start of comm
    I2C_GIVE_ACK();
    Cammand_Valid_Flag = SET;  // initially set 
  }

  /* Byte to transmit ? */
  if (sr1 & I2C_SR1_TXE)
  {
    I2C->DR = *Register_PTR;
  }
}







