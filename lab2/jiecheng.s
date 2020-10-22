    .bss
    .align  4
n:
    .zero   4
t: 
    .zero   4

    .section    .rodata
STR0:
    .string "%d"
STR1:
    .string "The result is %d\n"
STR2:
    .string "Too small!\n" # < 1
STR3:
    .string "Too big!\n"  # > 12
    .text
    .globl  main
    .type   main,@function
main:
start:
    pushl   $n
    pushl   $STR0
    call    scanf
    addl    $8,%esp
    movl    $1,t
    movl    $1,%eax
    movl    n,%ebx
    cmpl    %eax,%ebx
    jl      L3
    movl    $12,%eax
    movl    n,%ebx
    cmpl    %ebx,%eax
    jl      L4
    jmp     L1
L0:
    movl    t,%eax
    movl    n,%ebx
    imull    %ebx,%eax
    movl    %eax,t
    movl    n,%eax
    subl    $1,%eax
    movl    %eax,n
    jmp     L1
L1:
    movl    $1,%eax
    cmpl    n,%eax
    jl      L0
L2:
    pushl   t
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
