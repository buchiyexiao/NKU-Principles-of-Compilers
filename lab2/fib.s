    .bss
    .align  4
n:
    .zero   4

    .align  4
a:
    .zero   4

    .align  4
b:
    .zero   4

    .section    .rodata
STR0:
    .string "%d"
STR1:
    .string "The result is %d\n"
STR2:
    .string "Too small!\n" # < 1
STR3:
    .string "Too big!\n"  # > 46
    
    .text
    .globl  main
    .type   main,@function
main:
start:
    pushl   $n
    pushl   $STR0
    call    scanf
    movl    $0,a
    movl    $1,b
    addl    $8,%esp
    movl    $1,%eax
    movl    n,%ebx
    cmpl    %eax,%ebx
    jl      L3
    movl    $46,%eax
    movl    n,%ebx
    cmpl    %ebx,%eax
    jl      L4
    jmp     L1
L0:
    movl    b,%eax
    movl    a,%ebx
    addl    %ebx,%eax
    movl    %eax,b
    movl    b,%eax
    movl    a,%ebx
    subl    %ebx,%eax
    movl    %eax,a
    movl    n,%eax
    subl    $1,%eax
    movl    %eax,n
    jmp     L1    
L1:
    movl    $0,%eax
    movl    n,%ebx
    subl    $1,%ebx
    cmpl    %ebx,%eax
    jl      L0
L2:
    pushl   b
    pushl   $STR1
    call    printf
    addl    $8,%esp
    movl    $0,%eax
    ret
L3:
    pushl   $STR2
    call    printf
    addl    $4,%esp
    jmp     start
L4:
    pushl   $STR3
    call    printf
    addl    $4,%esp
    jmp     start
    .section    .note.GNU-stack,"",@progbits
