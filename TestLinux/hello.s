	.file	"hello.cpp"
	.section	.text._ZStorSt13_Ios_OpenmodeS_,"axG",@progbits,_ZStorSt13_Ios_OpenmodeS_,comdat
	.weak	_ZStorSt13_Ios_OpenmodeS_
	.type	_ZStorSt13_Ios_OpenmodeS_, @function
_ZStorSt13_Ios_OpenmodeS_:
.LFB574:
	pushl	%ebp
.LCFI0:
	movl	%esp, %ebp
.LCFI1:
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	orl	%edx, %eax
	popl	%ebp
	ret
.LFE574:
	.size	_ZStorSt13_Ios_OpenmodeS_, .-_ZStorSt13_Ios_OpenmodeS_
	.text
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB1078:
	pushl	%ebp
.LCFI2:
	movl	%esp, %ebp
.LCFI3:
	subl	$24, %esp
.LCFI4:
	cmpl	$1, 8(%ebp)
	jne	.L5
	cmpl	$65535, 12(%ebp)
	jne	.L5
	movl	$_ZStL8__ioinit, (%esp)
	call	_ZNSt8ios_base4InitC1Ev
	movl	$_ZNSt8ios_base4InitD1Ev, %eax
	movl	$__dso_handle, 8(%esp)
	movl	$_ZStL8__ioinit, 4(%esp)
	movl	%eax, (%esp)
	call	__cxa_atexit
.L5:
	leave
	ret
.LFE1078:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.type	_GLOBAL__I__Z5helloPKc, @function
_GLOBAL__I__Z5helloPKc:
.LFB1079:
	pushl	%ebp
.LCFI5:
	movl	%esp, %ebp
.LCFI6:
	subl	$8, %esp
.LCFI7:
	movl	$65535, 4(%esp)
	movl	$1, (%esp)
	call	_Z41__static_initialization_and_destruction_0ii
	leave
	ret
.LFE1079:
	.size	_GLOBAL__I__Z5helloPKc, .-_GLOBAL__I__Z5helloPKc
	.section	.ctors,"aw",@progbits
	.align 4
	.long	_GLOBAL__I__Z5helloPKc
	.section	.rodata
.LC0:
	.string	"test.log"
	.align 4
.LC1:
	.string	"dsjdfjkadkf\n\262\342\312\324\304\254\310\317\261\340\302\353\267\275\312\275\243\254\272\331\272\331\n"
.LC2:
	.string	"Hello %s!\n"
.globl _Unwind_Resume
	.text
.globl _Z5helloPKc
	.type	_Z5helloPKc, @function
_Z5helloPKc:
.LFB1013:
	pushl	%ebp
.LCFI8:
	movl	%esp, %ebp
.LCFI9:
	pushl	%esi
.LCFI10:
	pushl	%ebx
.LCFI11:
	subl	$320, %esp
.LCFI12:
	leal	-9(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSaIcEC1Ev
	leal	-9(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$.LC0, 4(%esp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
.LEHB0:
	call	_ZNSsC1EPKcRKSaIcE
.LEHE0:
	leal	-9(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSaIcED1Ev
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
.LEHB1:
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev
.LEHE1:
	jmp	.L18
.L17:
	movl	%eax, -308(%ebp)
	movl	%edx, -304(%ebp)
.L10:
	movl	-304(%ebp), %esi
	movl	-308(%ebp), %ebx
	leal	-9(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSaIcED1Ev
	movl	%ebx, -308(%ebp)
	movl	%esi, -304(%ebp)
	movl	-308(%ebp), %eax
	movl	%eax, (%esp)
.LEHB2:
	call	_Unwind_Resume
.LEHE2:
.L18:
	movl	$16, 4(%esp)
	movl	$1, (%esp)
	call	_ZStorSt13_Ios_OpenmodeS_
	movl	%eax, -300(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
.LEHB3:
	call	_ZNKSs5c_strEv
	movl	-300(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode
	movl	$.LC1, 4(%esp)
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSo5flushEv
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
.LEHE3:
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
.LEHB4:
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev
.LEHE4:
	jmp	.L19
.L15:
	movl	%eax, -308(%ebp)
	movl	%edx, -304(%ebp)
.L12:
	movl	-304(%ebp), %esi
	movl	-308(%ebp), %ebx
	leal	-292(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev
	movl	%ebx, -308(%ebp)
	movl	%esi, -304(%ebp)
	jmp	.L13
.L19:
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
.LEHB5:
	call	_ZNSsD1Ev
.LEHE5:
	addl	$320, %esp
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
.L16:
	movl	%eax, -308(%ebp)
	movl	%edx, -304(%ebp)
.L13:
	movl	-304(%ebp), %esi
	movl	-308(%ebp), %ebx
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	_ZNSsD1Ev
	movl	%ebx, -308(%ebp)
	movl	%esi, -304(%ebp)
	movl	-308(%ebp), %eax
	movl	%eax, (%esp)
.LEHB6:
	call	_Unwind_Resume
.LEHE6:
.LFE1013:
	.size	_Z5helloPKc, .-_Z5helloPKc
.globl __gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA1013:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE1013-.LLSDACSB1013
.LLSDACSB1013:
	.uleb128 .LEHB0-.LFB1013
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L17-.LFB1013
	.uleb128 0x0
	.uleb128 .LEHB1-.LFB1013
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L16-.LFB1013
	.uleb128 0x0
	.uleb128 .LEHB2-.LFB1013
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 .LEHB3-.LFB1013
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L15-.LFB1013
	.uleb128 0x0
	.uleb128 .LEHB4-.LFB1013
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L16-.LFB1013
	.uleb128 0x0
	.uleb128 .LEHB5-.LFB1013
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 .LEHB6-.LFB1013
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0x0
	.uleb128 0x0
.LLSDACSE1013:
	.text
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.weakref	_ZL20__gthrw_pthread_oncePiPFvvE,pthread_once
	.weakref	_ZL27__gthrw_pthread_getspecificj,pthread_getspecific
	.weakref	_ZL27__gthrw_pthread_setspecificjPKv,pthread_setspecific
	.weakref	_ZL22__gthrw_pthread_createPmPK14pthread_attr_tPFPvS3_ES3_,pthread_create
	.weakref	_ZL22__gthrw_pthread_cancelm,pthread_cancel
	.weakref	_ZL26__gthrw_pthread_mutex_lockP15pthread_mutex_t,pthread_mutex_lock
	.weakref	_ZL29__gthrw_pthread_mutex_trylockP15pthread_mutex_t,pthread_mutex_trylock
	.weakref	_ZL28__gthrw_pthread_mutex_unlockP15pthread_mutex_t,pthread_mutex_unlock
	.weakref	_ZL26__gthrw_pthread_mutex_initP15pthread_mutex_tPK19pthread_mutexattr_t,pthread_mutex_init
	.weakref	_ZL30__gthrw_pthread_cond_broadcastP14pthread_cond_t,pthread_cond_broadcast
	.weakref	_ZL25__gthrw_pthread_cond_waitP14pthread_cond_tP15pthread_mutex_t,pthread_cond_wait
	.weakref	_ZL26__gthrw_pthread_key_createPjPFvPvE,pthread_key_create
	.weakref	_ZL26__gthrw_pthread_key_deletej,pthread_key_delete
	.weakref	_ZL30__gthrw_pthread_mutexattr_initP19pthread_mutexattr_t,pthread_mutexattr_init
	.weakref	_ZL33__gthrw_pthread_mutexattr_settypeP19pthread_mutexattr_ti,pthread_mutexattr_settype
	.weakref	_ZL33__gthrw_pthread_mutexattr_destroyP19pthread_mutexattr_t,pthread_mutexattr_destroy
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0x0
	.byte	0x1
	.string	"zPL"
	.uleb128 0x1
	.sleb128 -4
	.byte	0x8
	.uleb128 0x6
	.byte	0x0
	.long	__gxx_personality_v0
	.byte	0x0
	.byte	0xc
	.uleb128 0x4
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x1
	.align 4
.LECIE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB1078
	.long	.LFE1078-.LFB1078
	.uleb128 0x4
	.long	0x0
	.byte	0x4
	.long	.LCFI2-.LFB1078
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI3-.LCFI2
	.byte	0xd
	.uleb128 0x5
	.align 4
.LEFDE3:
.LSFDE7:
	.long	.LEFDE7-.LASFDE7
.LASFDE7:
	.long	.LASFDE7-.Lframe1
	.long	.LFB1013
	.long	.LFE1013-.LFB1013
	.uleb128 0x4
	.long	.LLSDA1013
	.byte	0x4
	.long	.LCFI8-.LFB1013
	.byte	0xe
	.uleb128 0x8
	.byte	0x85
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI9-.LCFI8
	.byte	0xd
	.uleb128 0x5
	.byte	0x4
	.long	.LCFI12-.LCFI9
	.byte	0x83
	.uleb128 0x4
	.byte	0x86
	.uleb128 0x3
	.align 4
.LEFDE7:
	.ident	"GCC: (SUSE Linux) 4.3.2 [gcc-4_3-branch revision 141291]"
	.section	.comment.SUSE.OPTs,"MS",@progbits,1
	.ascii	"ospwg"
	.section	.note.GNU-stack,"",@progbits
