.include "defs.h"

.section .data
msg: .string "Input string:\n" /* Start message */
newLine: .string "\n" /* Symbols for new line */

.section .bss
txt: .byte 0 /* text to read from user */

.section .text
.global _start

_start:
	movq $msg, %rax /* ;moving message to rax */
	movq $0, %rbx

_startMesLen:
	incq %rax /* inc rax to get the next memory adress */
	incq %rbx
	movb (%rax), %cl /* cl is pointer to letter of a start message */
	cmp $0, %cl /* if cl is 0 => we reach the final symbol of start message */
	jne _startMesLen /* calculating length until 0 */

	/* Start message output */
	movq $SYS_WRITE, %rax
	movq $STDOUT, %rdi
	movq $msg, %rsi
	movq %rbx, %rdx /*rbx = length of the start message */
	syscall

_getText:
	/*reading user input */
	movq $SYS_READ, %rax
	movq $STDIN, %rdi
	movq $txt, %rsi
	movq $32, %rdx
	syscall

	/* moving text to modify inside rbx */
	movq $txt, %rbx

_modifyText:
	movb (%rbx), %cl /* cl is pointer to letter of a txt */
	cmp $0, %cl /* if cl is 0 => we reach the filan symbol of txt */
	je _lineEnd

	addb $13, %cl /* +13 to every byte */
	movb %cl, txt

	/* modified letter output */
	movq $SYS_WRITE, %rax
	movq $STDOUT, %rdi
	movq $txt, %rsi
	movq $1, %rdx
	syscall

	/* inc rbx to get the next memory adress  */
	incq %rbx
	jmp _modifyText
	
_lineEnd:
	/* add a new line symbol to the end of modified text */
	movq $SYS_WRITE, %rax
	movq $STDOUT, %rdi
	movq $newLine, %rsi
	movq $2, %rdx
	syscall

	movq $SYS_EXIT, %rax
	movq $STDIN, %rdi
	syscall

	

