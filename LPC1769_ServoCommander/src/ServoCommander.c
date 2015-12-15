/*
================================
 Name        : GPIO.c
 Author      : Khalil A. Estell
 Version     : 1.5
 Copyright   : 2015
 Description : main definition
=================================
*/

#ifdef __USE_CMSIS
#include "LPC17xx.h"
#endif

#include <cr_section_macros.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "GPIO.h"
#include "SPI.h"

/* 25 = 10 ticks per second */
#define TICKRATE_HZ1 (25*100)

volatile static uint32_t ticks = 0;

#ifdef __cplusplus
extern "C" {
#endif

void irq_handler();

void SysTick_Handler(void)
{
	++ticks;
	if (ticks > 50000) {
		ticks = 0;
	}
	return;
}

void delay_ms (uint16_t ms)
{
	uint32_t delay = 0;
	delay = ticks+(ms*2);
	if(delay >= 50000){
		delay -= 50000;
	}
	while(ticks <= delay){
		// do nothing bitch!!
	}
}
void sendPosition(char high, char low) {
	/**** READ ID From Chip ****/
	// Select Chip
	clearGPIO(0,6);
	// Send RDID (Read-ID) command
	ExchangeByteSPI1(high);
	// Send Address for manfacturer's id (0x000000)
	ExchangeByteSPI1(low);
	// Deselect Chip
	setGPIO(0,6);
}

void ReadString(char * dest, int limit) {
	char c = 0;
	int i = 0;
	// consume previous newline character
	getchar();
	for (i = 0; i < limit; ++i)
	{
		c = getchar();
		// DEBUG
		//printf("::%c::\n", c);
		if(c == 0 || c == '\n') {
			dest[i] = 0;
			break;
		}
		dest[i] = c;
	}
}

int main(void)
{
	/* Generic Initialization */
	SystemCoreClockUpdate();
	/* Enable and setup SysTick Timer at a periodic rate */
	SysTick_Config(SystemCoreClock / TICKRATE_HZ1);
	// Disabling the Systick interrupt using the following:
	SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
	// Re-enable the interrupt using:
	SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk;

	initSPI1();
	initLED();
	setLED(LED_CYAN);

	uint32_t channel = 0;
	uint32_t position = 0;
	char shifted_channel = 0;

	char init_prompt[] = "Welcome to the LPC1769 USB -> SPI Interface Program.\n\
Built by Khalil A. Estell of San Jose State University.\n\n";

	printf(init_prompt);
	while(1)
	{
		__WFI();
//		delay_ms(500);
//		clearGPIO(0,6);
//		delay_ms(500);
//		setGPIO(0,6);
		printf("Enter Channel (0-29): ");
		scanf("%u", &channel);
		printf("---------0x%X---------\n", channel);
		printf("Enter Position (0-2000): ");
		scanf("%u", &position);
		printf("---------0x%X---------\n", channel);
		shifted_channel = (char)((position >> 8) | (channel << 3)); // mask 0x7 0b0000_0111
		printf("Sending 0x%X and 0x%X\n", shifted_channel, (char)position);
		sendPosition(shifted_channel, (char)position);
	}
	//0 should never be returned, due to infinite while loop
	return 0;
}
