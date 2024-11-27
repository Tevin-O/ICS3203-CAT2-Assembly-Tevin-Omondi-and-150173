section .data
    array db 5, 10, 15, 20, 25          ; Original array of 5 integers
    n dw 5                              ; Number of elements in the array
    msg_result db "Reversed Array: ", 0 ; Result message

section .text
    global _start

_start:
    ; Step 1: Print the result message
    mov eax, 4                          ; System call for write
    mov ebx, 1                          ; File descriptor for stdout
    mov ecx, msg_result                 ; Address of the message
    mov edx, 17                         ; Length of the message
    int 0x80

    ; Step 2: Initialize indices for reversing
    xor esi, esi                        ; Start index (0)
    mov edi, n                          ; End index (n - 1)
    dec edi                             ; Convert to zero-based index

reverse_loop:
    ; Step 3: Check if indices have met or crossed
    cmp esi, edi
    jge print_array                     ; Exit loop if start >= end

    ; Step 4: Swap elements at start and end
    mov al, [array + esi]               ; Load array[start] into AL
    mov bl, [array + edi]               ; Load array[end] into BL
    mov [array + esi], bl               ; Store BL at array[start]
    mov [array + edi], al               ; Store AL at array[end]
    inc esi                             ; Move start index forward
    dec edi                             ; Move end index backward
    jmp reverse_loop                    ; Repeat loop

print_array:
    ; Step 5: Print the reversed array
    mov esi, 0                          ; Reset index to 0
print_loop:
    mov al, [array + esi]               ; Load each element
    add al, '0'                         ; Convert to ASCII
    mov [array + esi], al               ; Store ASCII in array (optional)
    mov eax, 4                          ; Write syscall
    mov ebx, 1                          ; Stdout
    lea ecx, [array + esi]              ; Address of the element
    mov edx, 1                          ; Length of one character
    int 0x80                            ; Print character
    inc esi                             ; Move to the next element
    cmp esi, n                          ; Check if end of array
    jl print_loop                       ; Repeat loop if not done

    ; Step 6: Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
