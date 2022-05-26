All: main

shutdown: 
	sudo shutdown -h now
	vm

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

cmain.o: cmain.c
	clang --target=aarch64-elf $(CFLAGS) -g -c cmain.c -o cmain.o
	llvm-objdump-11 -d -s cmain.o > cmain.assembled.dump
	readelf -a cmain.o > cmain.assembled.readelf.dump


cmain: cmain.o
	ld.lld -m aarch64elf -nostdlib cmain.o -o cmain_exe
	#ld -nostdlib cmain.o -o cmain_exe
	#clang cmain.o -o cmain_exe
	llvm-objdump-11 -d -s  cmain_exe > cmain.linked.dump
	readelf -a cmain_exe > cmain.linked.readelf.dump

clean:
	rm -r -f *_exe *.o *.dump