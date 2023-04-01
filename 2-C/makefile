helper.o: helper.c
	gcc -c -o helper.o helper.c

main.o: main.c
	gcc -c -o main.o main.c

memory: helper.o main.o
	gcc helper.o main.o -o memory 

run: clean memory
	./memory

clean:
	rm -f ./*.o
	rm -f ./memory