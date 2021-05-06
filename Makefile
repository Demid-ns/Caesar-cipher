ASFLAGS = -g
LDFLAGS = -static

all: task

task:
	as $(ASFLAGS) -o task.o -c task.s
	ld $(LDFLAGS) -o task task.o

clean:
	rm -rf *.o task
