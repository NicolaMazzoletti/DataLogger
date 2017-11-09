create database data_logger_db;
use data_logger_db;

CREATE TABLE `data_logger_db`.`sensore` (
  `IdSensore` INT NOT NULL AUTO_INCREMENT,
  `NomeSensore` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IdSensore`));
  
CREATE TABLE `data_logger_db`.`stazione` (
  `IdStazione` INT NOT NULL AUTO_INCREMENT,
  `NomeStazione` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IdStazione`));

CREATE TABLE `data_logger_db`.`valore` (
  `IdValore` INT NOT NULL AUTO_INCREMENT,
  `Valore` FLOAT NOT NULL,
  `Data_Ora` DATETIME NOT NULL,
  `VoltaggioBatteria` INT NOT NULL,
  `IdSensore` INT NOT NULL,
  `IdStazione` INT NOT NULL,
  PRIMARY KEY (`IdValore`),
  INDEX `IdStazione_idx` (`IdStazione` ASC),
  INDEX `IdSensore_idx` (`IdSensore` ASC),
  CONSTRAINT `IdSensore`
    FOREIGN KEY (`IdSensore`)
    REFERENCES `data_logger_db`.`sensore` (`IdSensore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdStazione`
    FOREIGN KEY (`IdStazione`)
    REFERENCES `data_logger_db`.`stazione` (`IdStazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



#Inserito i sensori disponibili al momento, in seguito se ne potranno aggiungere altri.
INSERT INTO `data_logger_db`.`sensore` (`IdSensore`, `NomeSensore`) VALUES ('1', 'Sensore_Temperatura');
INSERT INTO `data_logger_db`.`sensore` (`IdSensore`, `NomeSensore`) VALUES ('2', 'Sensore_Umidita');
INSERT INTO `data_logger_db`.`sensore` (`IdSensore`, `NomeSensore`) VALUES ('3', 'Sensore_Pressione');

#Inserito l'unica stazione che ho al momento, in seguito se ne potranno aggiungere altre.
INSERT INTO `data_logger_db`.`stazione`(`IdStazione`, `NomeStazione`) VALUES ('1', 'Stazione_UNO');
