#ifndef _MAIN_H
#define _MAIN_H

#include "stm8s.h"


/* Private defines -----------------------------------------------------------*/

#define GPIO_READ_PIN(PORT, PIN)  ((PORT->IDR & PIN)?1:0)
#define GPIO_SET_PIN(PORT, PIN)   (PORT->ODR |= PIN)
#define GPIO_RESET_PIN(PORT, PIN) (PORT->ODR &= ~PIN)


/*The T6 bit can be used to generate a software reset (the WDGA bit is set and then T6 bit is
cleared)*/
#define SOFTWARE_RST_MCU()             do{ WWDG->CR |= WWDG_CR_WDGA; \
                                           WWDG->CR &=~WWDG_CR_T6; \
                                         } while(0);


#endif 
