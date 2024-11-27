section .data
    msg_positive db "POSITIVE", 0       ; positive numbers
    msg_negative db "NEGATIVE", 0       ; negative numbers
    msg_zero db "ZERO", 0               ; Message for zero
    msg_input db "Enter a number: ", 0  ; Prompt message

section .bss
    input resb 4                        ; Reserve 4 bytes for user input

section .text
    global _start

_start:
    ; Step 1: Print input message
    mov eax, 4                          ; System call number for write
    mov ebx, 1                          ; (stdout)
    mov ecx, msg_input                  ; Address of the input prompt
    mov edx, 16                         ; Length of the prompt
    int 0x80                            ; Make system call

    ; Step 2: Read user input
    mov eax, 3                          ; System call number for read
    mov ebx, 0                          ; (stdin)
    mov ecx, input                      ; Address to store input
    mov edx, 4                          ; Maximum input size
    int 0x80                            ; 

    ; Step 3: Convert ASCII input to integer
    mov esi, number        ; Point to the input string
    xor eax, eax           ; Clear EAX (to accumulate result)
    xor ebx, ebx           ; Clear EBX (to track negativity)

    ; Check for negative sign
    cmp byte [esi], '-'
    jne parse_digits       ; If not '-', jump to digit parsing
    inc esi                ; Move to next character
    mov bl, 1              ; Mark number as negative

parse_digits:
    xor ecx, ecx           ; Clear ECX (temporary storage)
parse_loop:
    mov cl, byte [esi]     ; Load the current character
    cmp cl, 0              ; Check for null terminator
    je finalize_conversion ; End of string
    sub cl, 48             ; Convert ASCII to integer
    imul eax, eax, 10      ; Multiply EAX by 10 (shift left)
    add eax, ecx           ; Add current digit to EAX
    inc esi                ; Move to next character
    jmp parse_loop         ; Repeat


    cmp bl, 0              ; Check if the number was negative
    je classification
    neg eax                ; Negate EAX to make it negative

    ; Step 4: Branching logic using conditional jumps
    cmp eax, 0                          ; Compare input to zero
    je zero_case                        ; Jump to zero case if equal
    jl negative_case                    ; Jump to negative case if less than zero
    jmp positive_case                   ; Unconditional jump to positive case

positive_case:
    ; Print "POSITIVE" message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_positive
    mov edx, 8                          ; Length of "POSITIVE"
    int 0x80
    jmp exit                            ; Exit program

negative_case:
    ; Print "NEGATIVE" message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_negative
    mov edx, 8                          ; Length of "NEGATIVE"
    int 0x80
    jmp exit                            ; Exit program

zero_case:
    ; Print "ZERO" message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_zero
    mov edx, 4                          ; Length of "ZERO"
    int 0x80

exit:
    ; Exit the program
    mov eax, 1                          ; System call number for exit
    xor ebx, ebx                        ; Exit code 0
    int 0x80
