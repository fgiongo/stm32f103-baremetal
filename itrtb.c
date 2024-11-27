#include <stdint.h>
#include "itrtb.h"

void Default_Handler(void)
{
    while (1);
}

void Reset_Handler(void)
{
    init();
    main();
}

void init(void)
{
    // Init da secao .data)
    uint32_t *origem = &_valores_globais;
    uint32_t *dest = &_inicio_globais_ini;
    while (dest < &_fim_globais_ini)
    {
        *dest++ = *origem++;
    }

    // Init da secao .bss)
    dest = &_inicio_globais_nini;
    while (dest < &_fim_globais_nini)
    {
        *dest++ = 0;
    }
}

