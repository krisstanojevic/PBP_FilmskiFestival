DROP DATABASE IF EXISTS festivali;
CREATE DATABASE festivali;
USE festivali;



DROP TABLE IF EXISTS Filmski_festival ;

CREATE TABLE IF NOT EXISTS Filmski_festival  (
  id_festivala INT NOT NULL PRIMARY KEY,
  naziv VARCHAR(45) NOT NULL,
  adresa VARCHAR(45) NOT NULL
)ENGINE = InnoDB;





DROP TABLE IF EXISTS Film ;

CREATE TABLE IF NOT EXISTS Film  (
  id_filma INT NOT NULL PRIMARY KEY,
  naziv VARCHAR(45) NOT NULL,
  trajanje INT NOT NULL
)ENGINE = InnoDB;



DROP TABLE IF EXISTS Projektuje ;

CREATE TABLE IF NOT EXISTS Projektuje (
 
  
   broj_mesta INT NOT NULL,
   festival INT NOT NULL,
   film INT NOT NULL,
   vreme VARCHAR(100) NOT NULL,
   
  INDEX k_festival (festival) ,
  INDEX k_film (film) ,
    FOREIGN KEY (festival)
    REFERENCES Filmski_festival (id_festivala)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
      FOREIGN KEY (film)
    REFERENCES Film (id_filma)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)ENGINE = InnoDB;


DROP TABLE IF EXISTS Brosura_filma ;

CREATE TABLE IF NOT EXISTS Brosura_filma  (
  ime_reditelja VARCHAR(45) NOT NULL,
  glavni_glumci VARCHAR(100) NOT NULL,
  godina INT NOT NULL,
  film INT NOT NULL,
   INDEX k_film (film) ,
    FOREIGN KEY (film)
    REFERENCES Film (id_filma)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)ENGINE = InnoDB;

DROP TABLE IF EXISTS Gledalac ;

CREATE TABLE IF NOT EXISTS Gledalac (
  id_gledaoca INT NOT NULL PRIMARY KEY,
  ime VARCHAR(45) NOT NULL,
  prezime VARCHAR(45) NOT NULL
)ENGINE = InnoDB;

DROP TABLE IF EXISTS Deca ;


CREATE TABLE IF NOT EXISTS Deca (
  popust INT NOT NULL,
  starost INT NOT NULL,
  gledalac INT NOT NULL,
  INDEX k_gledalac (gledalac) ,
    FOREIGN KEY (gledalac)
    REFERENCES Gledalac (id_gledaoca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
   
)ENGINE = InnoDB;

DROP TABLE IF EXISTS Odrasli ;


CREATE TABLE IF NOT EXISTS Odrasli (
  popust INT NOT NULL,
  gledalac INT NOT NULL,
  INDEX k_gledalac (gledalac) ,
    FOREIGN KEY (gledalac)
    REFERENCES Gledalac (id_gledaoca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
   
)ENGINE = InnoDB;



DROP TABLE IF EXISTS Novinari ;


CREATE TABLE IF NOT EXISTS Novinari (
  popust INT NOT NULL,
  novine VARCHAR(45) NOT NULL,
  gledalac INT NOT NULL,
  INDEX k_gledalac (gledalac) ,
    FOREIGN KEY (gledalac)
    REFERENCES Gledalac (id_gledaoca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
   
)ENGINE = InnoDB;

DROP TABLE IF EXISTS Karta ;

CREATE TABLE IF NOT EXISTS Karta (
  id_karte INT NOT NULL PRIMARY KEY,
  broj_sedista VARCHAR(10) NOT NULL,
  slobodno_zauzeto VARCHAR(45) NOT NULL,
  cena INT NOT NULL,
  festival INT NOT NULL,
  film INT NOT NULL,
  INDEX k_festival(festival) ,
  INDEX k_film (film) ,
 
    FOREIGN KEY (festival)
    REFERENCES Filmski_festival (id_festivala)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (film)
    REFERENCES Film (id_filma)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)ENGINE = InnoDB;


DROP TABLE IF EXISTS Kupuje ;

CREATE TABLE IF NOT EXISTS Kupuje (
  gledalac INT NOT NULL ,
  karta INT NOT NULL,
  festival INT NOT NULL,
  film INT NOT NULL,
  
  INDEX k_gledalac (gledalac) ,
  INDEX k_karta (karta) ,
  INDEX k_festival(festival) ,
  INDEX k_film (film) ,
    FOREIGN KEY (gledalac)
    REFERENCES Gledalac (id_gledaoca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
      FOREIGN KEY (karta)
    REFERENCES Karta (id_karte)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 
    FOREIGN KEY (festival)
    REFERENCES Filmski_festival (id_festivala)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (film)
    REFERENCES Film (id_filma)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)ENGINE = InnoDB;


