SECTION .data
msg_input_a DB "a=", 0x0
msg_input_b DB "b=", 0x0
msg_input_format DB "%d", 0x0
msg_output DB "a*b=%d", 0xa, 0x0

SECTION .bss
a RESD 1
b RESD 1

SECTION .text
global _start
extern printf
extern scanf


_start:
push ebp
mov ebp, esp

push msg_input_a
call printf
add esp, 0x4 * 0x1

push a
push msg_input_format
call scanf
add esp, 0x4 * 0x2

push msg_input_b
call printf
add esp, 0x4 * 0x1

push b
push msg_input_format
call scanf
add esp, 0x4 * 0x2

push dword [ a ]
push dword [ b ]
call save_imul
add esp, 0x4 * 0x2

push eax
push msg_output
call printf
add esp, 0x4 * 0x2

leave
mov ebx, 0
mov eax, 1
int 0x80


save_imul: ;int save_imul(const int a, const int b)
push ebp
mov ebp, esp

push edx

mov eax, dword [ebp + 0xC]
mov ebx, dword [ebp + 0x8]
imul eax, ebx

pop edx

leave
ret
