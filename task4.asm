section .data
    prompt db "Enter sensor value: ", 0
    motor_on_msg db "Motor is ON", 10, 0
    motor_off_msg db "Motor is OFF", 10, 0
    alarm_msg db "Alarm is triggered!", 10, 0
    no_alarm_msg db "No alarm", 10, 0

section .bss
    sensor_value resb 4   ; To store user input (4 bytes for a 32-bit number)

section .text
    global _start

_start:
    ; Prompt user for input
    mov eax, 4             ; syscall: write
    mov ebx, 1             ; file descriptor (stdout)
    lea ecx, [prompt]
    mov edx, 19            ; Length of prompt message
    int 0x80

    ; Read user input (sensor value as a string)
    mov eax, 3             ; syscall: read
    mov ebx, 0             ; file descriptor (stdin)
    lea ecx, [sensor_value]
    mov edx, 4             ; Read up to 4 bytes
    int 0x80

    ; Convert input (ASCII to integer)
    lea esi, [sensor_value] ; Point to the start of the input string
    xor eax, eax            ; Clear eax (accumulator for result)
    xor ebx, ebx            ; Clear ebx (temporary register for digit)

convert_loop:
    movzx ecx, byte [esi]   ; Load next byte (character)
    cmp ecx, 10              ; Check if we reached the newline or null terminator
    je done_conversion       ; If newline (ASCII 10) or null (ASCII 0), stop conversion
    sub ecx, 48              ; Convert ASCII to integer (subtract '0')
    imul eax, eax, 10        ; Multiply the result by 10 (shift left one decimal place)
    add eax, ecx             ; Add the new digit
    inc esi                  ; Move to the next character
    jmp convert_loop

done_conversion:
    ; Perform logic based on sensor value
    cmp eax, 100
    jg trigger_alarm

    cmp eax, 50
    jg turn_on_motor

    jmp stop_motor

trigger_alarm:
    ; Display "Alarm is triggered!"
    mov eax, 4
    mov ebx, 1
    lea ecx, [alarm_msg]
    mov edx, 20
    int 0x80
    jmp exit

turn_on_motor:
    ; Display "Motor is ON"
    mov eax, 4
    mov ebx, 1
    lea ecx, [motor_on_msg]
    mov edx, 14
    int 0x80
    jmp exit

stop_motor:
    ; Display "Motor is OFF"
    mov eax, 4
    mov ebx, 1
    lea ecx, [motor_off_msg]
    mov edx, 15
    int 0x80
    jmp exit

exit:
    ; Exit program
    mov eax, 1             ; syscall: exit
    xor ebx, ebx           ; status 0
    int 0x80
