#ifndef GPIO_H_
#define GPIO_H_

#ifdef __USE_CMSIS
#include "LPC17xx.h"
#endif

#include <stdint.h>
#include <stdbool.h>

#define CHECK_BIT(var,pos) ((var) & (1<<(pos)))
#define LED_BLACK	0
#define LED_RED		1
#define LED_GREEN	2
#define LED_YELLOW	3
#define LED_BLUE	4
#define LED_PURPLE  5
#define LED_CYAN	6
#define LED_WHITE	7

//Initialize the port and pin as outputs.
void GPIOinitOut(uint8_t portNum, uint32_t pinNum);
//Initialize the port and pin as outputs.
void GPIOinitIn(uint8_t portNum, uint32_t pinNum);
// Set the pin HIGH
void setGPIO(uint8_t portNum, uint32_t pinNum);
// Set the pin LOW
void clearGPIO(uint8_t portNum, uint32_t pinNum);
// Read GPIO
int getGPIO(uint8_t portNum, uint32_t pinNum);
// Set GPIOS for leds
void initLED();
// set LED color
bool setLED(uint8_t color);
// turn off all LED
void LEDOff();

#endif 
