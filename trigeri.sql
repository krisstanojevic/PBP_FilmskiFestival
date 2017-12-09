use festivali;
DELIMITER $$
DROP TRIGGER IF EXISTS prvi $$ 
CREATE TRIGGER prvi AFTER INSERT ON Kupuje
FOR EACH ROW
BEGIN
update Projektuje 
	set broj_mesta  = broj_mesta - 1
	where festival = (select Stampa.festival from Stampa  where Stampa.karta = new.karta ) 
	and film =  (select Stampa.film from Stampa where Stampa.karta = new.karta ) ;
END $$


DROP TRIGGER IF EXISTS drugi $$ 
CREATE TRIGGER drugi BEFORE INSERT ON Kupuje
FOR EACH ROW
BEGIN

	IF((select broj_mesta from Projektuje p where 
	p.festival = (select Stampa.festival from Stampa  where Stampa.karta = new.karta ) 
	and p.film =  (select Stampa.film from Stampa where Stampa.karta = new.karta )
	
	
	)<=0)
	THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: Ne moze vise da se kupi karta jer nema slobodnih mesta za ovu projekciju';
	END IF;
END $$


DROP TRIGGER IF EXISTS treci $$ 
CREATE TRIGGER treci AFTER INSERT ON Kupuje
FOR EACH ROW
BEGIN
update Karta 
	set slobodno_zauzeto  = "Zauzeto"
	where new.karta = id_karte ;
END $$



DROP TRIGGER IF EXISTS cetvrti $$ 
CREATE TRIGGER cetvrti AFTER INSERT ON Projektuje
FOR EACH ROW
BEGIN
  DECLARE ukupno TINYINT;
  DECLARE broj TINYINT;
  set ukupno = new.broj_mesta+1;
    if (ukupno <=0)
    then begin
      set ukupno = ukupno - 1;
      set broj = new.festival+new.film + ukupno;
      if(not exists(select id_karte from Karta k where broj = k.id_karte))
	then 
	  insert into Karta values(broj,NULL,'Slobodno',NULL);
      
      end if;
      
    end; 
    end if;
  	
	
END $$

