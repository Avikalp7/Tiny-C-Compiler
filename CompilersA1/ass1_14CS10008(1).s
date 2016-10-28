	.file	"ass1_14CS10008.c"							# source file name
	.section	.rodata									# read only data section
	.align 8											# alginment with 8 bit boundary
.LC0:													# Label of f-string - 1st printf
	.string	"Enter how many elements you want:"
.LC1:													# Label of f-string scanf
	.string	"%d"
.LC2:													# Label of f-string - 2nd printf
	.string	"Enter the %d elements:\n"
.LC3:													# Label of f-string - 3rd printf
	.string	"\nEnter the item to search"
.LC4:													# Label of f-string - 4th printf
	.string	"\n%d found in position: %d\n"
.LC5:													# Label of f-string - 5th printf
	.string	"\n%d inserted in position: %d\n"		
.LC6:													# Label of f-string - 6th printf
	.string	"The list of %d elements:\n"
.LC7:													# Label of f-string - 7th printf
	.string	"%6d"										
	.text
	.globl	main										# main is a global name
	.type	main, @function								# main is a function
main:													# main starts
.LFB0:													
	.cfi_startproc										# Call Frame Information
	pushq	%rbp										# Save old base pointer on stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp									# stack pointer is the new base pointer
	.cfi_def_cfa_register 6
	subq	$416, %rsp									# rsp <-- rsp - 416, space for local variables.
	movl	$.LC0, %edi									# edi <-- .LC0, 1st parameter of printf
	call	puts										# Call puts for printf
	leaq	-416(%rbp), %rax							# transfer address of rbp - 416 to rax (address for variable n)
	movq	%rax, %rsi									# rsi <-- rax,  2nd parameter for scanf
	movl	$.LC1, %edi									# edi <-- .LC1, 1st parameter for scanf
	movl	$0, %eax									# eax <-- 0
	call	__isoc99_scanf								# calling scanf for "%d" and storing return value in eax
	movl	-416(%rbp), %eax							# eax <-- n
	movl	%eax, %esi									# esi <-- eax, parameter for printf
	movl	$.LC2, %edi									# edi <-- .LC2, parameter for printf
	movl	$0, %eax									# eax <-- 0
	call	printf										# calling printf corresponding to .LC2, i.e. "Enter the %d elements:\n"
	movl	$0, -408(%rbp)								# i <-- 0 in For loop
	jmp	.L2    											# goto .L2
.L3:													# inner for loop
	leaq	-400(%rbp), %rax							# rax <-- array start
	movl	-408(%rbp), %edx							# edx <-- i
	movslq	%edx, %rdx									# rdx <-- i in 64 bit long word
	salq	$2, %rdx									# rdx <-- i*4
	addq	%rdx, %rax									# rax <-- array start + i*4 => rax = a[i]
	movq	%rax, %rsi									# rsi <-- rax
	movl	$.LC1, %edi									# edi <-- .LC1
	movl	$0, %eax									# eax <-- 0 for the scanf call
	call	__isoc99_scanf								# calling scanf for .LC1 i.e. %d corresponding to &a[i]
	addl	$1, -408(%rbp)								# i <-- i + 1 increment in for loop
.L2:													# Conditional checking in for loop
	movl	-416(%rbp), %eax 							# eax <-- n
	cmpl	%eax, -408(%rbp)							# comparing --> i < n
	jl	.L3 											# jump to .L3, i.e. inner part of for loop if i < n
	movl	-416(%rbp), %edx 							# edx <-- n
	leaq	-400(%rbp), %rax 							# transfer address of a[0] to rax
	movl	%edx, %esi 									# esi <-- n as esi register stores the 2nd parameter for the function
	movq	%rax, %rdi 									# transfer address of a[0] to rdi
	call	inst_sort 									# calling inst_sort(a,n)
	movl	$.LC3, %edi 								# edi <-- .LC3 i.e printf statement "Enter the item to search" 
	call	puts 										# calling puts for above statement
	leaq	-412(%rbp), %rax 							# transfer address of rbp - 412 to rax
	movq	%rax, %rsi 									# rsi <-- rax
	movl	$.LC1, %edi 								# edi <-- .LC1, parameter for scanf
	movl	$0, %eax 									# eax <-- 0
	call	__isoc99_scanf 								# call to scanf 
	movl	-412(%rbp), %edx 							# edx <-- item
	movl	-416(%rbp), %ecx 							# ecx <-- n
	leaq	-400(%rbp), %rax 							# rax <-- a[0]
	movl	%ecx, %esi 									# esi <-- ecx , esi register is used to store 2nd parameter for bsearch function
	movq	%rax, %rdi 									# rdi <-- start of array a, rdi register is used to store 1st parameter for bsearch function
	call	bsearch 									# call to function bsearch
	movl	%eax, -404(%rbp) 							# loc <-- eax i.e register storing return value
	movl	-404(%rbp), %eax 							# eax <-- loc
	cltq 												# sign extend eax
	movl	-400(%rbp,%rax,4), %edx 					# edx <-- a + 4*loc i.e. edx <-- a[loc]
	movl	-412(%rbp), %eax 							# eax <-- item
	cmpl	%eax, %edx 									# compare item(eax) and a[loc](edx) compare item, a[loc]
	jne	.L4 											# if(item != a[loc]) jump to .L4
	movl	-404(%rbp), %eax 							# eax <-- loc
	leal	1(%rax), %edx 								# edx <-- rax + 1 ;edx = loc + 1, parameter for printf
	movl	-412(%rbp), %eax 			    			# eax <-- item
	movl	%eax, %esi									# esi <-- item, 2nd parameter for printf
	movl	$.LC4, %edi 								# edi <-- .LC4 
	movl	$0, %eax 									# eax <-- 0 
	call	printf										# call to printf
	jmp	.L5 											# goto .L5 
.L4: 													# entering else block
	movl	-412(%rbp), %edx 							# edx <-- item
	movl	-416(%rbp), %ecx 							# ecx <-- n
	leaq	-400(%rbp), %rax 							# transfer address of starting of a to rax
	movl	%ecx, %esi 									# esi <-- n, register used to store the 2nd parameter of function insert
	movq	%rax, %rdi 									# rdi <-- start of array a, register to store 1st parameter of function insert
	call	insert 										# call to function insert
	movl	%eax, -404(%rbp) 							# loc <-- eax (return value)
	movl	-416(%rbp), %eax 							# eax <-- n
	addl	$1, %eax 									# eax <-- n + 1
	movl	%eax, -416(%rbp)							# n <-- eax + 1 i.e. n <-- n+1
	movl	-404(%rbp), %eax 							# eax <-- loc
	leal	1(%rax), %edx 								# edx <-- loc + 1, parameter for printf
	movl	-412(%rbp), %eax 							# eax <-- item
	movl	%eax, %esi 									# esi <-- item, 2nd parameter for printf
	movl	$.LC5, %edi 								# edi <-- .LC5, 1st parameter for printf
	movl	$0, %eax 									# eax <-- 0
	call	printf 										# call to printf  
.L5:			
	movl	-416(%rbp), %eax 							# eax <-- n
	movl	%eax, %esi 									# move esi <-- n, 2nd parameter for printf
	movl	$.LC6, %edi 								# edi <-- .LC6, 1st parameter for 6th printf
	movl	$0, %eax 									# eax <-- 0
 	call	printf										# call to printf
	movl	$0, -408(%rbp) 								# i <-- 0 
	jmp	.L6 											# goto .L6 
.L7: 										
	movl	-408(%rbp), %eax 							# eax <-- i
	cltq 												# sign extend eax 
	movl	-400(%rbp,%rax,4), %eax 					# eax <-- rbp - 400 + rax*4, i.e. eax = a[i]
	movl	%eax, %esi 									# esi <-- a[i], 2nd parameter for next printf
	movl	$.LC7, %edi 								# edi <-- .LC7, 1st parameter of next printf
	movl	$0, %eax 									# eax <-- 0
	call	printf										# call to printf
	addl	$1, -408(%rbp) 								# i <-- i + 1
.L6:
	movl	-416(%rbp), %eax 							# eax <-- n
	cmpl	%eax, -408(%rbp) 							# compare i, n in for loop
	jl	.L7 											# if (i < n) goto .L7
	movl	$10, %edi 									# move 10 to edi corresponding to '\n', 1st parameter for putchar
	call	putchar 									# call to putchar
	movl	$0, %eax 									# eax <-- 0 register storing return value of main
	leave 												# clearing stack
	.cfi_def_cfa 7, 8
	ret 												# return from main
	.cfi_endproc
.LFE0:
	.size	main, .-main	
	.globl	inst_sort 									# inst_sort is global
	.type	inst_sort, @function 						# inst_sort is a function
inst_sort: 												# inst_ sort starting 
.LFB1:
	.cfi_startproc 										# Call Frame Information
	pushq	%rbp 										# save old base pointer
	.cfi_def_cfa_offset 16 
	.cfi_offset 6, -16
	movq	%rsp, %rbp 									# stack pointer is new base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp) 							# rbp - 24 <-- num
	movl	%esi, -28(%rbp) 							# rbp - 28 <-- n (2nd param)
	movl	$1, -8(%rbp) 								# j <-- 1
	jmp	.L10 											# goto .L10
.L14:
	movl	-8(%rbp), %eax 								# eax <-- j
	cltq 												# sign extend eax
	leaq	0(,%rax,4), %rdx 							# rdx <-- 4*j
	movq	-24(%rbp), %rax 							# rax <-- satar of num array
	addq	%rdx, %rax 									# rax = rax + rdx i.e start of num array + 4*j i.e num[j]
	movl	(%rax), %eax 								# eax <-- num[j]
	movl	%eax, -4(%rbp) 								# k <-- num[j]
	movl	-8(%rbp), %eax 								# eax <-- j
	subl	$1, %eax 									# Initialising j for for loop, eax <-- j - 1
	movl	%eax, -12(%rbp) 							# rbp - 12 is made eax => rbp - 12 is assigned i
	jmp	.L11 											# goto .L11
.L13:
	movl	-12(%rbp), %eax 							# eax <-- i
	cltq 												# sign extend eax 
	addq	$1, %rax 									# rax <-- i + 1 
	leaq	0(,%rax,4), %rdx 							# rdx = 4 * (i+1)
	movq	-24(%rbp), %rax 							# rax <- start of num array
	addq	%rax, %rdx									# rdx = start of num array + 4 * (i+1), rdx <-- num[i+1]
	movl	-12(%rbp), %eax 							# eax <-- i
	cltq 												# sign extend eax 
	leaq	0(,%rax,4), %rcx 							# rcx = 4 * i as after cltq rax stores i
	movq	-24(%rbp), %rax 							# rax <-- start of num array
	addq	%rcx, %rax 									# rax = start of num array + 4*i i.e rax = num[i]
	movl	(%rax), %eax 								# eax <-- num[i]
	movl	%eax, (%rdx) 								# rdx <-- eax i.e num[i+1] = num[i]
	subl	$1, -12(%rbp) 								# Entering initialisation for for loop, assinning i <-- i + 1: 
.L11:
	cmpl	$0, -12(%rbp) 								# compare i, 0
	js	.L12 											# if (i < 0) , goto .L12
	movl	-12(%rbp), %eax 							# eax <-- i
	cltq 												# sign extend eax 
	leaq	0(,%rax,4), %rdx 							# rdx = rax*4 i.e rdx = 4*i
	movq	-24(%rbp), %rax								# rax <-- start of num array
	addq	%rdx, %rax 									# rax = rax + rdx, i.e. rax = num + 4*i => rax = num[i]
	movl	(%rax), %eax 								# eax <-- rax i.e. eax <-- num[i]
	cmpl	-4(%rbp), %eax 								# compare num[i], k
	jg	.L13 											# if(num[i] > k) goto .L13 
.L12:
	movl	-12(%rbp), %eax 							# eax <-- i
	cltq 												# sign extend eax
	addq	$1, %rax 									# rax = rax + 1 i.e rax <= i+1
	leaq	0(,%rax,4), %rdx 							# rdx = 4*rax
	movq	-24(%rbp), %rax 							# rax <-- address of num array start
	addq	%rax, %rdx 									# rax = rax + rdx => rax = start of num array  + 4*(i+1) => rax = num[i+1]
	movl	-4(%rbp), %eax 								# eax <-- k
	movl	%eax, (%rdx) 								# rdx <-- eax i.e num[i+1] <-- k
	addl	$1, -8(%rbp) 								# j <-- j + 1
.L10: 											
	movl	-8(%rbp), %eax 								# eax <-- j
	cmpl	-28(%rbp), %eax 							# compare j, n 
	jl	.L14 											# if (j < n), goto .L14 
	popq	%rbp 										# popping rbp from stack and restoring initial value 
	.cfi_def_cfa 7, 8
	ret 												# return
	.cfi_endproc
.LFE1:
	.size	inst_sort, .-inst_sort 
	.globl	bsearch 									# bsearch is global name
	.type	bsearch, @function 							# bsearch is a function		
bsearch:
.LFB2:
	.cfi_startproc
	pushq	%rbp 							 			# Save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp 									# Stack pointer is new base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp) 							# rbp - 28 <-- rdi i.e address of a[0]
	movl	%esi, -28(%rbp) 							# rbp - 24 <-- esi i.e n
	movl	%edx, -32(%rbp) 							# rbp - 32 <-- edx i.e item
	movl	$1, -8(%rbp) 								# bottom <-- 1
	movl	-28(%rbp), %eax 							# eax <-- n
	movl	%eax, -12(%rbp) 							# top <-- n
.L19:
	movl	-12(%rbp), %eax 							# eax <-- top
	movl	-8(%rbp), %edx 								# edx <-- bottom
	addl	%edx, %eax 									# eax <-- edx + eax i.e. bottom + top
	movl	%eax, %edx 									# edx <-- eax
	shrl	$31, %edx 									# Checking leftmost bit. edx = 0 only if (bottom + top) >=0 otherwise edx = 1
	addl	%edx, %eax 									# eax to eax + edx, eax = bottom + top + (bottom + top < 0) adding 1 and right shifting to divide by 2
	sarl	%eax 										# eax >>= 1, division by 2
	movl	%eax, -4(%rbp) 								# mid <-- (bottom+top)/2 
	movl	-4(%rbp), %eax 								# eax <-- mid
	cltq 												# signed extend eax
	leaq	0(,%rax,4), %rdx 							# rdx = 4 * rax i.e 4*mid
	movq	-24(%rbp), %rax 							# rax <-- start of array a
	addq	%rdx, %rax 									# rax = rax + rdx, rax <-- a[mid]
	movl	(%rax), %eax 								# eax <-- a[mid]
	cmpl	-32(%rbp), %eax 							# compare item, a[mid]
	jle	.L16 											# if (a[mid] <= item) goto .L16
	movl	-4(%rbp), %eax 								# mid <-- eax in if condition
	subl	$1, %eax 									# eax <-- mid - 1
	movl	%eax, -12(%rbp) 							# top <-- eax i.e mid - 1
	jmp	.L17 											# goto .L17 
.L16:
	movl	-4(%rbp), %eax 								# eax <-- mid
	cltq 												# signed extend eax 
	leaq	0(,%rax,4), %rdx							# rdx <-- 4*mid
	movq	-24(%rbp), %rax 							# rax <-- start of array a
	addq	%rdx, %rax 									# rax = rax + rdx, rax <-- a start + 4 * mid i.e a[mid]
	movl	(%rax), %eax 								# eax <- a[mid]
	cmpl	-32(%rbp), %eax 							# compare a[mid], item
	jge	.L17 											# if (a[mid] >= item) goto .L17
	movl	-4(%rbp), %eax 								# eax <-- mid 
	addl	$1, %eax 									# eax <-- mid + 1
	movl	%eax, -8(%rbp) 								# bottom <-- eax i.e mid + 1
.L17: 													# goto while loop, .L17
	movl	-4(%rbp), %eax 								# eax <-- mid
	cltq 												# signed extend eax
	leaq	0(,%rax,4), %rdx 							# rdx <-- 4*mid
	movq	-24(%rbp), %rax 							# rax <-- start of array a
	addq	%rdx, %rax 									# rax = rax + rdx, rax =  start of arr a + 4*mid 
	movl	(%rax), %eax 	 							# eax <-- rax = am[mid]
	cmpl	-32(%rbp), %eax 							# compare a[mid], item
	je	.L18 											# if (a[mid] == item), jump to .L18
	movl	-8(%rbp), %eax 								# eax <-- bottom
	cmpl	-12(%rbp), %eax 							# compare top, bottom
	jle	.L19 											# if (bottom <= top) goto .L19
.L18:
	movl	-4(%rbp), %eax 								# eax <-- mid
	popq	%rbp 										# popping base pointer from stack and restoring initial value
	.cfi_def_cfa 7, 8
	ret 												# return
	.cfi_endproc
.LFE2:
	.size	bsearch, .-bsearch
	.globl	insert 								# insert is a global name
	.type	insert, @function 					# insert is a function
insert:											# insert starting
.LFB3:
	.cfi_startproc
	pushq	%rbp 								# push old base pointer to stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp 							# stack pointer is the new base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp) 					# rbp - 24 <-- start of num array
	movl	%esi, -28(%rbp) 					# rbp - 28 <-- n, 2nd parameter
	movl	%edx, -32(%rbp) 					# rbp - 32 <-- k, 3rd parameter
	movl	-28(%rbp), %eax 					# eax <-- n
	subl	$1, %eax 							# eax <-- n - 1
	movl	%eax, -4(%rbp) 						# rbp - 4 <-- n-1
	jmp	.L22 									# goto .L22
.L24: 											# Entering for loop :  
	movl	-4(%rbp), %eax 						# eax <-- i
	cltq 										# signed extend eax
	addq	$1, %rax 							# rax <-- i + 1 (rax now stored i after cltq)
	leaq	0(,%rax,4), %rdx 					# rdx <-- 4 * (i+1)
	movq	-24(%rbp), %rax 					# rax <-- start of num array
	addq	%rax, %rdx 							# rdx = start of num array + 4*(i+1) i.e num[i+1]
	movl	-4(%rbp), %eax 						# eax <-- i
	cltq	 									# signed extend eax 
	leaq	0(,%rax,4), %rcx 					# rdx = 4*rax i.e 4*i
	movq	-24(%rbp), %rax 					# rax = start of num array
	addq	%rcx, %rax 							# rax = start of num array + 4*i i.e num[i]
	movl	(%rax), %eax 						# eax <-- num[i]
	movl	%eax, (%rdx) 						# rdx <-- eax i.e. num[i+1]=num[i]
	subl	$1, -4(%rbp)						# Initiating in for loop, i <-- i - 1
.L22:
	cmpl	$0, -4(%rbp) 						# compare i , 0
	js	.L23 									# if (i < 0) goto .L23 
	movl	-4(%rbp), %eax 						# eax <-- i
	cltq 										# signed extend eax
	leaq	0(,%rax,4), %rdx  					# rdx = 4 * i (rx stored i after cltq)
	movq	-24(%rbp), %rax 					# rax <-- start of num array
	addq	%rdx, %rax 							# rax <-- start of num array + 4 * i i.e num[i]
	movl	(%rax), %eax 						# eax <-- num[i]
	cmpl	-32(%rbp), %eax 					# compare k, num[i]
	jg	.L24 									# if (num[i] > k) goto .L24
.L23:
	movl	-4(%rbp), %eax 						# eax <-- i
	cltq 										# signed extend eax
	addq	$1, %rax 							# rax <-- i + 1
	leaq	0(,%rax,4), %rdx 					# rdx <-- 4 * (i+1) (rax stored i after cltq and i+1 after addq)
	movq	-24(%rbp), %rax 					# rax <-- start of num array
	addq	%rax, %rdx 							# rdx <--  + 4 * (i+1) -> num[i+1]
	movl	-32(%rbp), %eax 					# eax <-- k
	movl	%eax, (%rdx) 						# k <--num[i+1]
	movl	-4(%rbp), %eax 						# eax <-- i
	addl	$1, %eax 							# eax <-- i + 1, return value
	popq	%rbp 								# pop from stack and restore initial value
	.cfi_def_cfa 7, 8 
	ret 										# return
	.cfi_endproc
.LFE3:
	.size	insert, .-insert
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
