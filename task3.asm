section .data
    prompt db "Enter a number: ", 0
    result_msg db "Factorial: ", 0
    newline db 10, 0               ; Newline character

section .bss
    number resb 4                  ; User input
    result resd 1                  ; Factorial result

section .text
    global _start

_start:
    ; Prompt user for input
    mov eax, 4                     ; syscall: write
    mov ebx, 1                     ; stdout
    lea ecx, [prompt]
    mov edx, 15                    ; Length of the prompt
    int 0x80

    ; Read user input
    mov eax, 3                     ; syscall: read
    mov ebx, 0                     ; stdin
    lea ecx, [number]
    mov edx, 4
    int 0x80

    ; Convert input from ASCII to integer
    movzx eax, byte [number]       ; Load the byte from input
    sub eax, '0'                   ; Convert ASCII to integer

    ; Check if input is valid (factorial of negative numbers doesn't exist)
    cmp eax, 0
    jl invalid_input               ; Jump to invalid input handling

    ; Call factorial subroutine
    push eax                       ; Save input
    call factorial
    add esp, 4                     ; Clean stack
    mov [result], eax              ; Save factorial result

    ; Display "Factorial: "
    mov eax, 4                     ; syscall: write
    mov ebx, 1                     ; stdout
    lea ecx, [result_msg]
    mov edx, 10                    ; Length of "Factorial: "
    int 0x80

    ; Display the factorial result
    mov eax, [result]              ; Load result
    call print_number              ; Convert and print the number

    ; Print newline
    lea ecx, [newline]
    mov edx, 1                     ; Length of newline
    mov eax, 4                     ; syscall: write
    mov ebx, 1                     ; stdout
    int 0x80

    ; Exit program
    mov eax, 1                     ; syscall: exit
    xor ebx, ebx                   ; Exit status 0
    int 0x80

factorial:
    cmp eax, 1                     ; Base case: factorial(0) = factorial(1) = 1
    jle base_case                  ; If eax <= 1, jump to base_case

    push eax                       ; Save current number
    dec eax                        ; Decrement for recursion
    call factorial
    pop ebx                        ; Restore current number
    mul ebx                        ; Multiply result

    ret

base_case:
    mov eax, 1                     ; Factorial(0) = Factorial(1) = 1
    ret

invalid_input:
    mov eax, 4                     ; syscall: write
    mov ebx, 1                     ; stdout
    lea ecx, [error_msg]
    mov edx, 19                    ; Length of "Invalid input"
    int 0x80
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_number:
    ; Convert a number in EAX to ASCII and print it
    mov ebx, 10                    ; Divisor for base-10
    xor ecx, ecx                   ; ECX will hold the digit count
    xor edx, edx                   ; Clear remainder

convert_loop:
    div ebx                        ; EAX / 10, quotient in EAX, remainder in EDX
    add dl, '0'                    ; Convert remainder to ASCII
    push dx                        ; Store the digit on the stack
    inc ecx                        ; Increment digit count
    test eax, eax                  ; Check if quotient is 0
    jnz convert_loop               ; Repeat until no more digits

print_digits:
    pop edx                        ; Retrieve digits from the stack
    mov eax, 4                     ; syscall: write
    mov ebx, 1                     ; stdout
    lea ecx, [edx]
    mov edx, 1                     ; Write 1 character
    int 0x80
    loop print_digits              ; Repeat for all digits

    ret

section .data
    error_msg db "Invalid input", 0 ; Error message for invalid input
