# Definição das mensagens e variáveis
.data
menu: .asciiz "1 - Fahrenheit -> Celsius\n2 - Fibonacci\n3 - Enésimo par\n4 - Sair\n"
erro: .asciiz "Opção inválida. Tente novamente.\n"
newline: .asciiz "\n"

prompt_fahrenheit: .asciiz "Digite a temperatura em Fahrenheit: "
resultado_celsius: .asciiz "A temperatura em Celsius é: "

.text
.globl main

main:
    # imprimir o menu
    li $v0, 4           # Carrega o valor 4 em $v0 (código para imprimir string)
    la $a0, menu        # Carrega o endereço da mensagem 'menu' em $a0
    syscall             # Executa a chamada de sistema para imprimir a mensagem

    # ler a entrada do usuário
    li $v0, 5           # Carrega o valor 5 em $v0 (código para ler um inteiro)
    syscall             # Executa a chamada de sistema para ler um inteiro
    move $t0, $v0       # Move o valor lido para o registrador $t0

    # verificar a entrada do usuário e executar a opção correspondente
    beq $t0, 1, opcao1  # Se $t0 for igual a 1, pula para a etiqueta 'opcao1'
    beq $t0, 2, opcao2  # Se $t0 for igual a 2, pula para a etiqueta 'opcao2'
    beq $t0, 3, opcao3  # Se $t0 for igual a 3, pula para a etiqueta 'opcao3'
    beq $t0, 4, sair    # Se $t0 for igual a 4, pula para a etiqueta 'sair'

    # se a entrada do usuário não for válida, imprimir uma mensagem de erro e voltar ao início do loop
    li $v0, 4           # Carrega o valor 4 em $v0 (código para imprimir string)
    la $a0, erro        # Carrega o endereço da mensagem 'erro' em $a0
    syscall             # Executa a chamada de sistema para imprimir a mensagem
    j main              # Volta ao início do loop

opcao1:
    # Exibe o prompt para digitar a temperatura em Fahrenheit
    li $v0, 4           # Carrega o valor 4 em $v0 (código para imprimir string)
    la $a0, prompt_fahrenheit   # Carrega o endereço da mensagem 'prompt_fahrenheit' em $a0
    syscall             # Executa a chamada de sistema para imprimir a mensagem

    # Lê a temperatura em Fahrenheit
    li $v0, 5           # Carrega o valor 5 em $v0 (código para ler um inteiro)
    syscall             # Executa a chamada de sistema para ler um inteiro
    move $t1, $v0       # Move o valor lido para o registrador $t1

    # Converte de Fahrenheit para Celsius
    sub $t2, $t1, 32    # Subtrai 32 de $t1 e armazena o resultado em $t2
    li $t3, 5           # Carrega o valor 5 em $t3
    mul $t2, $t2, $t3   # Multiplica $t2 por $t3 e armazena o resultado em $t2
    div $t2, $t2, 9     # Divide $t2 por 9 e armazena o resultado em $t2

    # Exibe a temperatura em Celsius
    li $v0, 4           # Carrega o valor 4 em $v0 (código para imprimir string)
    la $a0, resultado_celsius   # Carrega o endereço da mensagem 'resultado_celsius' em $a0
    syscall             # Executa a chamada de sistema para imprimir a mensagem

    move $a0, $t2       # Move o valor de $t2 para $a0 (valor em Celsius)
    li $v0, 1           # Carrega o valor 1 em $v0 (código para imprimir um inteiro)
    syscall             # Executa a chamada de sistema para imprimir o inteiro

    # Exibe uma nova linha
    li $v0, 4           # Carrega o valor 4 em $v0 (código para imprimir string)
    la $a0, newline     # Carrega o endereço da mensagem 'newline' em $a0
    syscall             # Executa a chamada de sistema para imprimir a mensagem

    j main              # Volta ao início do loop


sair:
    # Sai do programa
    li $v0, 10          # Carrega o valor 10 em $v0 (código para encerrar o programa)
    syscall             # Executa a chamada de sistema para encerrar o programa