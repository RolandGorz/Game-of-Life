    .file   "conway.c"
    .text
.globl update
    .type   update, @function
update:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	8(%ebp), %eax
	movl	12(%ebp), %ecx #width
	movl	16(%ebp), %edx #height
	cmpl	$0, %ecx
	jle zerocheck
	cmpl	$0, %edx
	jle zerocheck
	imull	%ecx, %edx #multiply the width times height
	imull	$4, %edx #multiply by size of int
	addl	$36, %edx #extra space
	subl	%edx, %esp #make space for the list copy
	movl	%ecx, -4(%ebp) #width storage
	movl	16(%ebp), %edx
	movl	%edx, -8(%ebp) #height storage
	movl	$0, %edx
	movl	%edx, -12(%ebp) #needed counter
	movl	-8(%ebp), %ecx
copypoint:
	movl	%ecx, -8(%ebp) #update height
	movl	12(%ebp), %ecx #prepare width
	movl	(%eax), %ebx
copyvalue:	
	movl	%ecx, -4(%ebp) #update width
	movl	(%ebx), %edx
	movl	-12(%ebp), %ecx
	movl	%edx, -24(%ebp, %ecx, 4)
	movl	-4(%ebp), %ecx
	movl	-12(%ebp), %edx
	subl	$1, %edx
	movl	%edx, -12(%ebp)
	addl	$4, %ebx
	loop copyvalue
	addl	$4, %eax #move to the next pointer
	movl	-8(%ebp), %ecx #prepare height
	loop copypoint
	#everything is now saved hooray
	movl	8(%ebp), %eax
	movl	16(%ebp), %ecx #height
	leal	-24(%ebp), %edx
	movl	$0, -12(%ebp) #1 or 0 adder
	movl	%edx, -16(%ebp) #helps me move down the saved list
	movl	$0, -20(%ebp) #helps find start of row.
realpoint:
	movl	%ecx, -8(%ebp) #update height
	movl	12(%ebp), %ecx #prepare width
	movl	(%eax), %ebx
realvalue:
	movl	%ecx, -4(%ebp) #update width
	movl	-4(%ebp), %edx
	cmpl	%edx, 12(%ebp) 
	jne	addleft
checkup:
	cmpl	$0, -20(%ebp)
	jne addup
checkr:
	cmpl	$1, -4(%ebp)
	jne addr
checkd:
	cmpl	$1, -8(%ebp)
	jne add_down
done:
	movl	-16(%ebp), %edx
	movl	(%edx), %edx
	cmpl	$3, -12(%ebp)
	jne valuecheck
	movl	$1, (%ebx)
finishedvalues:
	movl	$0, -12(%ebp) #0 for new number
	addl	$4, %ebx
	addl	$-4, -16(%ebp)
	movl	-4(%ebp), %ecx
	loop realvalue
	addl	$4, %eax #move to the next pointer
	movl	-8(%ebp), %ecx #prepare height
	subl	$1, -20(%ebp)
	loop realpoint
zerocheck2:
	movl	-4(%ebp), %ebx
	leave
	ret
addleft:
	addl	$4, -16(%ebp)
	movl	-16(%ebp), %edx
	movl	(%edx), %edx
	addl	%edx, -12(%ebp)
	addl	$-4, -16(%ebp)
	jmp checkul
addul:
	addl	$4, -16(%ebp)
	movl	12(%ebp), %edx
	imull	$4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	addl	$-4, -16(%ebp)
	jmp checkup
addup:
	movl	12(%ebp), %edx
	imull	$4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	%ebx, %esi
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	jmp checkur
addur:
	addl	$-4, -16(%ebp)
	movl	12(%ebp), %edx
	imull	$4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	addl	$4, -16(%ebp)
	jmp checkr
addr:
	addl	$-4, -16(%ebp)
	movl	-16(%ebp), %edx
	movl	(%edx), %edx
	addl	%edx, -12(%ebp)
	addl	$4, -16(%ebp)
	jmp checkd
add_down:
	movl	12(%ebp), %edx
	imull	$-4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	jmp checkdr
adddr:
	addl	$-4, -16(%ebp)
	movl	12(%ebp), %edx
	imull	$-4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	addl	$4, -16(%ebp)
	jmp checkdl
adddl:
	addl	$4, -16(%ebp)
	movl	12(%ebp), %edx
	imull	$-4, %edx
	addl	%edx, -16(%ebp)
	movl	-16(%ebp), %ecx
	movl	(%ecx), %ecx
	addl	%ecx, -12(%ebp)
	imull	$-1, %edx
	addl	%edx, -16(%ebp)
	addl	$-4, -16(%ebp)
	jmp done
checkul:
	cmpl 	$0, -20(%ebp)
	jne addul
	jmp checkup
checkur:
	cmpl 	$1, -4(%ebp)
	jne addur
	jmp checkr
checkdr:
	cmpl	$1, -4(%ebp)
	jne adddr
	jmp checkdl
checkdl:
	movl 12(%ebp), %ecx
	cmpl %ecx, -4(%ebp)
	jne adddl
	jmp done
valuecheck:
	cmpl	$2, -12(%ebp)
	jge valuecheck2
	movl	$0, (%ebx)
	jmp finishedvalues
valuecheck2:
	cmpl	$3, -12(%ebp)
	jg ok
	jmp finishedvalues
ok:
	movl	$0, (%ebx)
	jmp finishedvalues
zerocheck:
	movl	$0, %eax
	jmp zerocheck2
