#include <stdint.h>

// Reset and clock control registers base address
#define RCC_BASE ((uint32_t) 0x40021000)

// Advanced Peripheral Bus 2 (APB2) reset register offset
#define APB2_OFFSET ((uint32_t) 0x18)

// GPIO port C reset bit
#define GPIOC_RST ((uint32_t) (1 << 4))

// GPIO port C registers base address
#define GPIOC_BASE ((uint32_t) 0x40011000)

// GPIO port configuration register (high) offset
#define GPIO_CON_REG_H ((uint32_t) 0x04)

// GPIO x13 port configuration (output, 2MHz, open-drain)
#define GPIO_CONFIG ((uint32_t) (0x3 << 20))

// GPIO port bit set/reset register offset
#define GPIO_SET_RST_OFFSET ((uint32_t) 0xC)

// GPIO C13 bit set
#define GPIOC13_BIT ((uint32_t) (1 << 13))

int main (void)
{
    // Habilitar clock para GPIO PORT C
    volatile uint32_t *gpioc_clk_enable = (uint32_t *) (RCC_BASE + APB2_OFFSET);
    *gpioc_clk_enable |= GPIOC_RST;

    // Configurar GPIOC13 para OUTPUT em 2MHz, OPEN-DRAIN
    volatile uint32_t *gpioc_config_high = (uint32_t *) (GPIOC_BASE + GPIO_CON_REG_H);
    *gpioc_config_high |= GPIO_CONFIG;

    // Endereço do registrador de OUTPUT do pino GPIO C13
    volatile uint32_t *gpioc_set = (uint32_t *) (GPIOC_BASE + GPIO_SET_RST_OFFSET);

    while(1)
    {
        // Escrevendo HIGH em pino GPIO C13
        *gpioc_set |= GPIOC13_BIT;

        // Esperando
        for (uint32_t i = 0; i < 1000000; ++i)
        {
            __asm__ volatile("nop");
        }

        // Escrevendo LOW em pino GPIOC13
        *gpioc_set &= ~GPIOC13_BIT;

        // Esperando
        for (uint32_t i = 0; i < 1000000; ++i)
        {
            __asm__ volatile("nop");
        }
    }
    return 0;
}

