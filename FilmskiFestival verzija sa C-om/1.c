#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <stdarg.h>
#include <errno.h>


#define QUERY_SIZE 1024



static void error_fatal (char *format, ...)
{
	va_list arguments;		

	va_start (arguments, format);
	vfprintf (stderr, format, arguments);
	va_end (arguments);


	exit (EXIT_FAILURE);
}

void upit1(MYSQL *konekcija);
void upit2(MYSQL *konekcija);
void upit3(MYSQL *konekcija);
void upit4(MYSQL *konekcija);

int main(int argc, char **argv){
  
	MYSQL *konekcija;	
	konekcija = mysql_init (NULL);
	if (mysql_real_connect (konekcija, "localhost", "root", "qwe123", "festivali", 0, NULL, 0) == NULL)
			error_fatal ("Doslo je do greske u konekciji. %s\n", mysql_error (konekcija));

	int br_upita;
	printf("Odaberite upit [1, 2, 3, 4] (ctrl-d exit):\n");
	while (scanf("%d", &br_upita) == 1) {
		printf("--------------------------------------------------------------------------------\n");
		if (br_upita < 1 || br_upita > 4)
			error_fatal("Los broj upita!\n");
		switch (br_upita) {
			case 1:
				upit1(konekcija);
				break;
			case 2:
				upit2(konekcija);
				break;
			case 3:
				upit3(konekcija);
				break;
			case 4:
				upit4(konekcija);
				break;
			default:
				error_fatal("Nije trebalo ovo da se desi!\n");
		}
		printf("--------------------------------------------------------------------------------\n");
		printf("Odaberite upit [1, 2, 3, 4] (ctrl-d exit):\n");
	}

	mysql_close (konekcija);
	exit(EXIT_SUCCESS);
}
	
/*-- Prvi upit kupuje kartu za gledaoca. Unosimo gledaoca i broj karte.
--Pre unosa se proverava prvi triger da li je ta karta vec kupljena. Ukoliko 
-- je vec kupljena, izlazi upozorenje da je vec kupljena.
--posle unosa u Kupiti se aktivira drugi triger koji za tu kartu stavlja status da je kupljena */
void upit1(MYSQL *konekcija)
{
	char upit[QUERY_SIZE];
	int gledalac, karta, festival, film;
	
	printf("Unesite id gledaoca: ");
	scanf("%d", &gledalac);
	printf("Unesite id karte koju zelite da kupite: ");
	scanf("%d", &karta);
	printf("Unesite id festivala: ");
	scanf("%d", &festival);
	printf("Unesite id filma: ");
	scanf("%d", &film);

	sprintf(upit,"insert into Kupuje values (%d,%d,%d,%d)", gledalac, karta,festival,film);
	if (mysql_query (konekcija, upit) != 0)
		error_fatal ("Greska pri kupovini karete! %s\n", mysql_error (konekcija));
	int broj = mysql_affected_rows(konekcija);
	printf ("Kupljeno je  je: %d karte\n", broj);
}


/*-- Drugi upit */

void upit2(MYSQL *konekcija)
{

char upit[QUERY_SIZE];
	int festival, film, broj_mesta;
	char vreme[100];
	
	
	printf("Unesite id festivala: ");
	scanf("%d", &festival);
	printf("Unesite id filma: ");
	scanf("%d", &film);
	printf("Unesite broj: ");
	scanf("%d", &broj_mesta);
	printf("Unesite vreme: ");
	scanf("%s",vreme);

	sprintf(upit,"insert into Projektuje values (%d,%d,%d, '%s')", broj_mesta,festival,film,vreme);
	if (mysql_query (konekcija, upit) != 0)
		error_fatal ("Greska pri unosu nove projekcije! %s\n", mysql_error (konekcija));
	//int broj = mysql_affected_rows(konekcija);
	printf ("Uneta   je nova projekcija\n");

	
}



  /*-- Treci upit izdvaja za sve gledaoca  koje su kupili karte*/

void upit3(MYSQL *konekcija)
{
	char upit[QUERY_SIZE];
	sprintf(upit,"select g.ime, g.prezime, k.karta, k.film, k.festival from Kupuje k, Gledalac g where k.gledalac =g.id_gledaoca");
	if (mysql_query (konekcija, upit) != 0)
		error_fatal ("Greska pri izdvajanju filmova za gledaoce! %s\n", mysql_error (konekcija));

	MYSQL_RES *rezultat = mysql_use_result (konekcija);
	MYSQL_FIELD *polje = mysql_fetch_field (rezultat);

	printf("%s\t%s\t%s\t%s\t%s\n", polje[0].name, polje[1].name, polje[2].name,polje[3].name,polje[4].name );


	int broj = mysql_num_fields (rezultat);
	MYSQL_ROW red;	
	while ((red = mysql_fetch_row (rezultat)) != 0){
		int i;
		for (i = 0; i < broj; i++)
			printf ("%s\t", red[i]);
		printf ("\n");
	}
	mysql_free_result (rezultat);
}


/*-- Cetvrti upit izdvaja gledaoce koje rade za odredjene novine, u ponudi su tri novine Danas, Politika i Blic*/
void upit4(MYSQL *konekcija)
{
	char upit[QUERY_SIZE];
	char *izabrane_novine[] = {"Danas", "Politika", "Blic"};
	int n;

	printf("1 -- Danas\n2 -- Politika\n3 -- Blic\n\n");
	printf("Unesite ponudjene novine [1, 2, 3]: ");
	scanf("%d", &n);
	if (n < 1 || n > 3)
		error_fatal("Odaberite samo ponudjene novine!\n");
	
	sprintf(upit,"select ime, prezime from Novinari n, Gledalac g where n.gledalac = g.id_gledaoca and n.novine = '%s'", izabrane_novine[n - 1]);
	if (mysql_query (konekcija, upit) != 0)
		error_fatal ("Greska pri izdvajanju novinara koji rade za izabrane novine! %s\n", mysql_error (konekcija));

	MYSQL_RES *rezultat = mysql_use_result (konekcija);
	MYSQL_FIELD *polje = mysql_fetch_field (rezultat);
	printf("%s\t%s\n", polje[0].name, polje[1].name);


	int broj = mysql_num_fields (rezultat);
	MYSQL_ROW red;
	while ((red = mysql_fetch_row (rezultat)) != 0){
		int i;
		for (i = 0; i < broj; i++)
			printf ("%s\t", red[i]);
		printf ("\n");
	}
	mysql_free_result (rezultat);
}
