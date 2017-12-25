use festivali;
DELIMITER $$


DROP TRIGGER IF EXISTS prvi $$ 
CREATE TRIGGER prvi BEFORE INSERT ON Kupuje
FOR EACH ROW
BEGIN

	IF( (select count(*) from Kupuje 
             where karta = new.karta and festival = new.festival and film = new.film) > 0 ) 
	THEN 
	SIGNAL SQLSTATE '45000' SET message_text = 'Greska: Ta karta je vec kupljena ili ne postoji ta projekcija';
	 END IF;

END $$

DROP TRIGGER IF EXISTS drugi $$ 
CREATE TRIGGER drugi AFTER INSERT ON Kupuje
FOR EACH ROW
BEGIN
update Karta 
	set slobodno_zauzeto  = "Zauzeto"
	where new.karta = id_karte and festival = new.festival and film = new.film;
END $$



DROP TRIGGER IF EXISTS treci $$ 
CREATE TRIGGER treci BEFORE INSERT ON Karta
FOR EACH ROW
BEGIN
  

      
      set new.slobodno_zauzeto = 'Slobodno';
      set new.cena = 300;
     
 
END $$










