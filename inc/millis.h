/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MILLIS_H
#define __MILLIS_H

#include "stm8s.h"
#include "stm8s_it.h"


/* Private function prototypes -----------------------------------------------*/
void Millis_Init(void);
void Delay_US(uint16_t time);
void Delay_MS(uint16_t time);

uint32_t millis(void);


#endif /* __MILLIS_H */
