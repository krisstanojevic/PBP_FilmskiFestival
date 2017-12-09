use festivali;
DELIMITER $$


DROP TRIGGER IF EXISTS prvi $$ 
CREATE TRIGGER prvi BEFORE INSERT ON Kupuje
FOR EACH ROW
BEGIN

	
	 IF((select slobodno_zauzeto from Karta where new.karta = Karta.id_karte) like 'Zauzeto')
		THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: Ta karta je vec kupljena';
	 END IF;
END $$

DROP TRIGGER IF EXISTS drugi $$ 
CREATE TRIGGER drugi AFTER INSERT ON Kupuje
FOR EACH ROW
BEGIN
update Karta 
	set slobodno_zauzeto  = "Zauzeto"
	where new.karta = id_karte ;
END $$













