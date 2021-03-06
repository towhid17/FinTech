-- MySQL Script generated by MySQL Workbench
-- Thu Feb 17 20:37:56 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- drop table if exists `mydb`.`oneTimeIncome`;
-- drop table if exists `mydb`.`periodicIncome`;
-- drop table if exists `mydb`.`Income`;
-- drop table if exists `mydb`.`Client`;
-- 

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
-- DROP TABLE `mydb`.`Client`;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `clientID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(70) NOT NULL UNIQUE,
  `passhash` VARCHAR(60) NOT NULL UNIQUE,
  PRIMARY KEY (`clientID`))
ENGINE = InnoDB;

-- CREATE TABLE Client_seq
-- (
--   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
-- );
-- 
-- DELIMITER $$
-- CREATE TRIGGER tg_table1_insert
-- BEFORE INSERT ON `mydb`.`Client`
-- FOR EACH ROW
-- BEGIN
--   INSERT INTO table1_seq VALUES (NULL);
--   SET NEW.clientID = PREV.clientID + 1;
-- END$$
-- DELIMITER ;



-- -----------------------------------------------------
-- Table `mydb`.`Income`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Income` (
  `IncomeID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `amount` INT(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `clientID` INT NOT NULL,
--   PRIMARY KEY (`IncomeID`, `cilentID`),
  PRIMARY KEY (`IncomeID`),
  -- INDEX `fk_Income_Client_idx` (`cilentID` ASC) VISIBLE,
  CONSTRAINT `fk_Income_Client`
    FOREIGN KEY (`clientID`)
    REFERENCES `mydb`.`Client` (`clientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`periodicIncome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`periodicIncome` (
  `periodicIncomeID` INT NOT NULL AUTO_INCREMENT,
  `period` INT NOT NULL,
  `startTime` DATETIME NOT NULL,
  `endTime` DATETIME NOT NULL,
  `IncomeID` INT NOT NULL,
  `clientID` INT NOT NULL,
--   PRIMARY KEY (`periodicIncomeID`, `IncomeID`, `clientID`),
  PRIMARY KEY (`periodicIncomeID`),
  CONSTRAINT `fk_periodicIncome_Income1`
--     FOREIGN KEY (`IncomeID` , `clientID`)
--     REFERENCES `mydb`.`Income` (`IncomeID` , `cilentID`)
    FOREIGN KEY (`IncomeID`) REFERENCES `mydb`.`Income` (`IncomeID`),
  CONSTRAINT `fk_periodicIncome_Income2`
    FOREIGN KEY (`clientID`) REFERENCES `mydb`.`Client` (`clientID`)
    
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oneTimeIncome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oneTimeIncome` (
  `oneTimeIncomeID` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NOT NULL,
  `IncomeID` INT NOT NULL,
  `clientID` INT NOT NULL,
--   PRIMARY KEY (`oneTimeIncomeID`, `IncomeID`, `clientID`),
  PRIMARY KEY (`oneTimeIncomeID`),
--   CONSTRAINT `fk_oneTimeIncome_Income1`
--     FOREIGN KEY (`IncomeID` , `clientID`)
--     REFERENCES `mydb`.`Income` (`IncomeID` , `cilentID`)
  CONSTRAINT `fk_oneTimeIncome_Income1`
    FOREIGN KEY (`IncomeID`) REFERENCES `mydb`.`Income` (`IncomeID`),
  CONSTRAINT `fk_oneTimeIncome_Income2`
    FOREIGN KEY (`clientID`) REFERENCES `mydb`.`Client` (`clientID`)
    
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
