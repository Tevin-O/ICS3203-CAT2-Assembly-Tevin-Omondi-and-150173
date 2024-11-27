# ICS3203-CAT2-Assembly-Omondi_Tevin_Warui_150173
The repository contains solutions to the tasks outlined in Assembly Language Programming CAT 2. 

# Table of Contents
Task 1: Control Flow and Conditional Logic

Task 2: Array Manipulation with Looping and Reversal

Task 3: Modular Program for Factorial Calculation

Task 4: Data Monitoring and Control Using Port-Based Simulation

# Task 1: Control Flow and Conditional Logic

The objective was to create a program that:

•	Prompts the user for a number.
•	Classifies the number as either POSITIVE, NEGATIVE, or ZERO using branching logic.

Key Features:

•	The program uses both conditional and unconditional jumps to handle the classification of the input number.
•	Documentation includes explanations of the jump instructions chosen to control program flow.

Commands to Run:

bash
```
cd Task1_ControlFlow1
nasm -f elf32 task1.asm -o task1.o -g
ld -m elf_i386 task1.o -o task1
./task1
```

Challenges:
Understanding how each jump affects the program flow and ensuring that the classification was accurate to ensure the task runs correctly.


# Task 2: Array Manipulation with Looping and Reversal 

The objective was to create a program that:

•	Accepts an array of integers as input.
•	Reverses the array in place using loops.
•	Outputs the reversed array.

Key Features:

•	No additional memory is allocated for the reversed array; it is manipulated directly.
•	Loops are used to reverse the array.
•	Documentation explains the reversal process and challenges related to direct memory manipulation.

Commands to Run:

bash
```
cd Task2_ArrayManipulation2
nasm -f elf32 task2.asm -o task2.o -g
ld -m elf_i386 task2.o -o task2
./task2
```

Challenges:

Handling memory directly, especially when reversing in place, required careful manipulation of array pointers and register values.
________________________________________

# Task 3: Modular Program for Factorial Calculation 

The objective was to create a program that:

•	Calculates the factorial of a user-provided number.
•	Uses a subroutine to perform the calculation.
•	Demonstrates stack usage to preserve registers.

Key Features:

•	The factorial calculation is done recursively using a subroutine.
•	Stack handling is demonstrated by preserving and restoring registers.
•	The final result is placed in a general-purpose register.

Commands to Run:

bash
```
cd Task3_Factorial3
nasm -f elf32 task3.asm -o task3.o -g
ld -m elf_i386 task3.o -o task3
./task3
```

Challenges:

Recursive subroutine implementation required proper register management, especially when preserving state using the stack.
________________________________________

# Task 4: Data Monitoring and Control Using Port-Based Simulation 

The object was to simulate a control system that:

•	Reads a sensor value.
•	Takes actions based on thresholds such as turning on a motor or triggering an alarm.

Key Features:

•	The program simulates reading from a sensor and performs actions such as turning the motor on or triggering an alarm based on the input value.
•	Memory locations are manipulated to reflect the system's state (e.g., motor or alarm status).

Commands to Run:

bash
```
cd Task4_DataMonitoring4
nasm -f elf32 task4.asm -o task4.o -g
ld -m elf_i386 task4.o -o task4
./task4
```
Challenges:

Simulating hardware control and manipulating memory for a simulated sensor input.