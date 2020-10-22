CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++17 -g -fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = 
OBJ = $(SRC:.cc=.o)
EXEC = main

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LBLIBS)

test_1:
	bison -d test_1.y ; gcc test_1.tab.c -o test_1 ; ./test_1

clean1:
	rm -rf test_1.tab.c test_1.tab.h test_1

test_2:
	bison -d test_2.y ; gcc test_2.tab.c -o test_2 ; ./test_2

clean2:
	rm -rf test_2.tab.c test_2.tab.h test_2

test_3:
	bison -d test_3.y ; gcc test_3.tab.c -o test_3 ; ./test_3

clean3:
	rm -rf test_3.tab.c test_3.tab.h test_3

test_4:
	bison -d test_4.y ; gcc test_4.tab.c -o test_4 ; ./test_4

clean4:
	rm -rf test_4.tab.c test_4.tab.h test_4