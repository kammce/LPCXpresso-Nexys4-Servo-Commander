
#ifdef __USE_CMSIS
#include "LPC17xx.h"
#endif

#include <stdint.h>
#include <stdbool.h>

#include "GPIO.h"

//Initialize the port and pin as outputs.
void GPIOinitOut(uint8_t portNum, uint32_t pinNum)
{
	if (portNum == 0)
	{
		LPC_GPIO0->FIODIR |= (1 << pinNum);
	}
	else if (portNum == 1)
	{
		LPC_GPIO1->FIODIR |= (1 << pinNum);
	}
	else if (portNum == 2)
	{
		LPC_GPIO2->FIODIR |= (1 << pinNum);
	}
	else
	{
		puts("Not a valid port!\n");
	}
}
//Initialize the port and pin as outputs.
void GPIOinitIn(uint8_t portNum, uint32_t pinNum)
{
	if (portNum == 0)
	{
		LPC_GPIO0->FIODIR |= (0 << pinNum);
	}
	else if (portNum == 1)
	{
		LPC_GPIO1->FIODIR |= (0 << pinNum);
	}
	else if (portNum == 2)
	{
		LPC_GPIO2->FIODIR |= (0 << pinNum);
	}
	else
	{
		puts("Not a valid port!\n");
	}
}

void setGPIO(uint8_t portNum, uint32_t pinNum)
{
	if (portNum == 0)
	{
		LPC_GPIO0->FIOSET = (1 << pinNum);
		//printf("Pin 0.%d has been set.\n",pinNum);
	}
	else if (portNum == 1)
	{
		LPC_GPIO1->FIOSET = (1 << pinNum);
		//printf("Pin 2.%d has been set.\n",pinNum);
	}
	else if (portNum == 2)
	{
		LPC_GPIO2->FIOSET = (1 << pinNum);
		//printf("Pin 2.%d has been set.\n",pinNum);
	}
	//Can be used to set pins on other ports for future modification
	else
	{
		puts("Can only set port 0 or 2 is used, try again!\n");
	}
}

int getGPIO(uint8_t portNum, uint32_t pinNum)
{
	if (portNum == 0)
	{
		return (LPC_GPIO0->FIOPIN & (1 << pinNum)) >> pinNum;
	}
	else if (portNum == 1)
	{
		return (LPC_GPIO1->FIOPIN & (1 << pinNum)) >> pinNum;
	}
	else if (portNum == 2)
	{
		return (LPC_GPIO2->FIOPIN & (1 << pinNum)) >> pinNum;
	}
	//Can be used to set pins on other ports for future modification
	else
	{
		puts("Only read port 0 or 2 is used, try again!\n");
		return -1;
	}
}

//Deactivate the pin
void clearGPIO(uint8_t portNum, uint32_t pinNum)
{
	if (portNum == 0)
	{
		LPC_GPIO0->FIOCLR = (1 << pinNum);
		//printf("Pin 0.%d has been cleared.\n", pinNum);
	}
	else if (portNum == 1)
	{
		LPC_GPIO1->FIOCLR = (1 << pinNum);
		//printf("Pin 2.%d has been cleared.\n", pinNum);
	}
	else if (portNum == 2)
	{
		LPC_GPIO2->FIOCLR = (1 << pinNum);
		//printf("Pin 2.%d has been cleared.\n", pinNum);
	}
	//Can be used to clear pins on other ports for future modification
	else
	{
		puts("Can only clear port 0 or 2 is used, try again!\n");
	}
}
void initLED (void) {
	GPIOinitOut(2,10);
	GPIOinitOut(2,11);
	GPIOinitOut(2,12);
}

bool setLED(uint8_t color) {
	if(color > 7) {
		printf("Invalid color code %d\n", color);
		return false;
	}
	clearGPIO(2,10);
	clearGPIO(2,11);
	clearGPIO(2,12);

	if(CHECK_BIT(color, 0)) {
		setGPIO(2,10);
	}
	if(CHECK_BIT(color, 1)) {
		setGPIO(2,11);
	}
	if(CHECK_BIT(color, 2)) {
		setGPIO(2,12);
	}
	return true;
}
void LEDOff() {
	clearGPIO(2,10);
	clearGPIO(2,11);
	clearGPIO(2,12);
}
