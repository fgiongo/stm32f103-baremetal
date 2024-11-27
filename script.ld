/* Linker script para STM32F103C8T6 (64K FLASH)
 * Autor: Fernando Giongo Oliveira
 * email: fgiongo@protonmail.com
 */
 

/*
 * Podemos definir blocos de memoria, aqui definimos 2:
 * FLASH e RAM. Nos parenteses, temos as regras de uso,
 * r para leitura, w para escrita e x para execucao.
 *
 * definimos os pontos de inicio (ORIGIN) e o tamanho (LENGTH)
 * de dada bloco. Essas informacoes precisam ser buscadas no
 * manual de programacao do STM32F103xx
 */
MEMORY
{
    FLASH ( rx ) : ORIGIN = 0x08000000, LENGTH = 64K
    RAM ( rwx )  : ORIGIN = 0x20000000, LENGTH = 20K
}

/*
 * A linguagem de comando do linker (ld) permite o uso de variaveis.
 *
 * Aqui vamos definir uma variavel para o valor inicial do stack
 * pointer. Na arquitetura arm-cortex-m3 a pilha cresce decrescentemente
 * portanto vamos colocar o stack pointer no valor mais alto possível
 * para poder utilizar o toda a memoria na pilha de ativacao.
 */
_init_stack_ptr = ORIGIN( RAM ) + LENGTH( RAM );

SECTIONS
{
    /* Vetor de rotinas de interrupcao */
    .rotint :
    {
	/* KEEP para evitar descarte pelo otimizador */
	KEEP(*( .rotint ))
    } > FLASH /* Escrever no bloco FLASH */


    /* Area de instrucoes do programa */
    .text :
    {
        *( .text* )
    } > FLASH

    /* Area de memoria somente-leitura */
    .rodata :
    {
	*( .rodata* )
    } > FLASH

    /* Ponteiro para valores iniciais das variaveis globais na FLASH */
    _valores_globais = LOADADDR( .data );

    /* Variaveis globais inicializadas */
    .data :
    {
	/* Ponteiro para memoria reservada para variaveis globais inicializadas
	 * na RAM */
	_inicio_globais_ini = .;

	*( .data* )

	/* Fim da memoria reservada */
	_fim_globais_ini = .;

    /*
     * Essa secao existe na RAM e na FLASH, porem os valores iniciais
     * estarao escritos somente na FLASH e precisam ser copiados para a RAM
     * por meio de uma rotina de inicializacao.
     */
    } > RAM AT > FLASH

    /* Variaveis globais nao-inicializadas */
    .bss :
    {

	/* Ponteiro para memoria reservada para variaveis globais
	 * nao-inicializadas na RAM */
	_inicio_globais_nini = .;

	*( .bss* )
	*( COMMON )

	/* Fim da memoria reservada */
	_fim_globais_nini = .;

    /* Essa secao existe somente em RAM, mas precisa ser inicializada com zeros
     * de acordo com a especificacao C/C++
     */
    } > RAM
}
