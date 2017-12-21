DIR = FilmskiFestival
PROGRAM = FilmskiFestival.out
SRC = 1.c
FLAGS = -g -Wall `mysql_config --cflags --libs`

.PHONY: all create trigeri insert clean program

all: create trigger insert $(PROGRAM) 

$(PROGRAM): $(SRC)
	gcc $(SRC) -o $(PROGRAM) $(FLAGS)

create:
	mysql -u root -p < 'festivali/create.sql'
	
insert: trigger
	mysql -u root -p -D festivali < 'festivali/trigeri.sql'
	
trigger:
	mysql -u root -p -D festivali < 'festivali/insert.sql'
	
clean:
	-rm -f *.mwb.bak