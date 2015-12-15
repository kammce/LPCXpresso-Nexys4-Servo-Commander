#ifdef __USE_CMSIS
#include "LPC17xx.h"
#endif

#include "SPI.h"
#include "GPIO.h"

void initSPI1()
{
	LPC_SC->PCONP |= (1 << 10);     // SPI1 Power Enable
	LPC_SC->PCLKSEL0 &= ~(3 << 20); // Clear clock Bits
	LPC_SC->PCLKSEL0 |=  (1 << 20); // CLK / 1

	// Select MISO, MOSI, and SCK pin-select functionality
	LPC_PINCON->PINSEL0 &= ~( (3 << 14) | (3 << 16) | (3 << 18) );
	LPC_PINCON->PINSEL0 |=  ( (2 << 14) | (2 << 16) | (2 << 18) );

	LPC_SSP1->CR0 = 7;          // 8-bit mode
	LPC_SSP1->CR1 = (1 << 1);   // Enable SSP as Master
	LPC_SSP1->CPSR = 1;         // SCK speed = CPU / 8

	// Set pin 0.6 as output select
	GPIOinitOut(0,6);
	setGPIO(0,6);
}

char ExchangeByteSPI1(char out)
{
	LPC_SSP1->DR = out;
	while(LPC_SSP1->SR & (1 << 4)); // Wait until SSP is busy
	return LPC_SSP1->DR;
}
