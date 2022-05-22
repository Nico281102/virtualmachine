All: main

shutdown: 
	sudo shutdown -h now | vm

main.o: main.s
	clang --target=aarch64-elf $(CFLAGS) -g -c main.s -o main.o
	llvm-objdump-11 -d -s main.o > main.assembled.dump
	readelf -a main.o > main.assembled.readelf.dump


main: main.o
	ld.lld -m aarch64elf -nostdlib main.o -o main_exe
	#ld -nostdlib main.o -o main_exe
	#clang main.o -o main_exe
	llvm-objdump-11 -d -s  main_exe > main.linked.dump
	readelf -a main_exe > main.linked.readelf.dump

clean:
	rm -r -f *_exe *.o *.dump