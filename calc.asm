;calc.asm
section.data:
 	msg db "等于 %d", 0xa,0x0
	fmt db "%d%c%d",0x0
	
	iplus db "+",0x0
	iminus db "-",0x0
	itimes db "*",0x0
	idivide db "/",0x0

section.text:

global _start
	extern printf
	extern scanf
	extern exit

_start:
	push rbp
	mov rbp, rsp
	sub rsp, 0x10
	mov rdi, fmt
	lea rsi, [rbp-4]
	lea rdx, [rbp-5]
	lea rcx, [rbp-9]
	mov eax, 0
	call scanf

_analysis:
	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx
	mov eax, dword [rbp-4]
	mov bl, byte [rbp-5]
	mov ecx, dword [rbp-9]
	
	mov dl, byte [iplus]
	cmp bl,dl
	je _plus

	mov dl, byte [iminus]
	cmp bl, dl
	je _minus

	mov dl, byte [itimes]
	cmp bl, dl
	je _times
	
	mov dl, byte [idivide]
	cmp bl, dl
	je _divide
	jmp _exit

_plus:
	add rax, rcx
	jmp _print
_minus:
	sub rax, rcx
	jmp _print
_times:
	imul rax, rcx
	jmp _print
_divide:
	xor edx,edx
	idiv rcx
	jmp _print



_print:
	mov rdi, msg
	mov rsi, rax
	mov eax, 0
	call printf

_exit:
	mov eax, 0
	mov rdi, 0
	call exit
