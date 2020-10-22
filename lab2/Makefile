.PHONY:eg1,eg2,fib,all,clean,clean-all 
fib:
	gcc fib.s -m32 -o fib.out 
	qemu-i386 fib.out
jc:
	gcc jiecheng.s -m32 -o jiecheng.out 
	qemu-i386 jiecheng.out	
all:$(subst .c,.s,$(wildcard *.c))
%.s:%.c 
	gcc $< -m32 -std=c99 -S -o $@ -O0 -fno-asynchronous-unwind-tables -fno-builtin-fno-common -fno-ident -finhibit-size-directive -fno-pie -march=i386
clean-all:$(subst .c,-del,$(wildcard *.c)) clean 
clean: 
	rm -fr main.out
%-del:%.c
	rm -fr $(basename $<).s
armtest:	
	arm-linux-gnueabi-gcc example.S -o example 
	qemu-arm ./example
c2s:
	gcc	fib.c -S -m32 -O0 -o fib.s
eg1:
	gcc eg.s -m32 -o eg.out 
	qemu-i386 eg.out
eg2:
	rm eg.out