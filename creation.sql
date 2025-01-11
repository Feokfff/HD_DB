SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOR-EIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`HubCustomer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HubCustomer` (
  `CustomerHashKey` VARCHAR(255) NOT NULL,
  `CustomerID` INT NOT NULL,
  `LoadDate` DATETIME(6) NULL,
  `RecordSource` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerHashKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HubMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HubMovie` (
  `MovieHashKey` VARCHAR(255) NOT NULL,
  `MovieID` INT NOT NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  PRIMARY KEY (`MovieHashKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HubGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HubGenre` (
  `GenreHashKey` VARCHAR(255) NOT NULL,
  `GenreID` INT NOT NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  PRIMARY KEY (`GenreHashKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HubInventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HubInventory` (
  `InventoryHashKey` VARCHAR(255) NOT NULL,
  `InventoryID` INT NOT NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  PRIMARY KEY (`InventoryHashKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LinkRental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LinkRental` (
  `RentalHashKey` VARCHAR(255) NOT NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubCustomer_CustomerHashKey` VARCHAR(255) NOT NULL,
  `HubMovie_MovieHashKey` VARCHAR(255) NOT NULL,
  `HubInventory_InventoryHashKey` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`RentalHashKey`, `HubMovie_MovieHashKey`, `HubCus-tomer_CustomerHashKey`, `HubInventory_InventoryHashKey`),
  INDEX `fk_LinkRental_HubCustomer_idx` (`HubCustom-er_CustomerHashKey` ASC) VISIBLE,
  INDEX `fk_LinkRental_HubMovie1_idx` (`HubMovie_MovieHashKey` ASC) VISIBLE,
  INDEX `fk_LinkRental_HubInventory1_idx` (`HubInvento-ry_InventoryHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_LinkRental_HubCustomer`
    FOREIGN KEY (`HubCustomer_CustomerHashKey`)
    REFERENCES `mydb`.`HubCustomer` (`CustomerHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LinkRental_HubMovie1`
    FOREIGN KEY (`HubMovie_MovieHashKey`)
    REFERENCES `mydb`.`HubMovie` (`MovieHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LinkRental_HubInventory1`
    FOREIGN KEY (`HubInventory_InventoryHashKey`)
    REFERENCES `mydb`.`HubInventory` (`InventoryHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LinkMovieGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LinkMovieGenre` (
  `MovieGenreHashKey` VARCHAR(255) NOT NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubMovie_MovieHashKey` VARCHAR(255) NOT NULL,
  `HubGenre_GenreHashKey` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MovieGenreHashKey`, `HubMovie_MovieHashKey`, `HubGenre_GenreHashKey`),
  INDEX `fk_LinkMovieGenre_HubMovie1_idx` (`HubMov-ie_MovieHashKey` ASC) VISIBLE,
  INDEX `fk_LinkMovieGenre_HubGenre1_idx` (`HubGen-re_GenreHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_LinkMovieGenre_HubMovie1`
    FOREIGN KEY (`HubMovie_MovieHashKey`)
    REFERENCES `mydb`.`HubMovie` (`MovieHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LinkMovieGenre_HubGenre1`
    FOREIGN KEY (`HubGenre_GenreHashKey`)
    REFERENCES `mydb`.`HubGenre` (`GenreHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SatCustomerDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SatCustomerDetails` (
  `FirstName` VARCHAR(255) NULL,
  `LastName` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubCustomer_CustomerHashKey` VARCHAR(255) NOT NULL,
  INDEX `fk_SatCustomerDetails_HubCustomer1_idx` (`HubCustom-er_CustomerHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_SatCustomerDetails_HubCustomer1`
    FOREIGN KEY (`HubCustomer_CustomerHashKey`)
    REFERENCES `mydb`.`HubCustomer` (`CustomerHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SatMovieDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SatMovieDetails` (
  `Title` VARCHAR(25) NULL,
  `ReleaseYear` DATE NULL,
  `Director` VARCHAR(45) NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubMovie_MovieHashKey` VARCHAR(255) NOT NULL,
  INDEX `fk_SatMovieDetails_HubMovie1_idx` (`HubMov-ie_MovieHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_SatMovieDetails_HubMovie1`
    FOREIGN KEY (`HubMovie_MovieHashKey`)
    REFERENCES `mydb`.`HubMovie` (`MovieHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SatGenreDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SatGenreDetails` (
  `GenreName` VARCHAR(45) NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubGenre_GenreHashKey` VARCHAR(255) NOT NULL,
  INDEX `fk_SatGenreDetails_HubGenre1_idx` (`HubGen-re_GenreHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_SatGenreDetails_HubGenre1`
    FOREIGN KEY (`HubGenre_GenreHashKey`)
    REFERENCES `mydb`.`HubGenre` (`GenreHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SatInventoryDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SatInventoryDetails` (
  `Condition` VARCHAR(45) NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `HubInventory_InventoryHashKey` VARCHAR(255) NOT NULL,
  INDEX `fk_SatInventoryDetails_HubInventory1_idx` (`HubInvento-ry_InventoryHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_SatInventoryDetails_HubInventory1`
    FOREIGN KEY (`HubInventory_InventoryHashKey`)
    REFERENCES `mydb`.`HubInventory` (`InventoryHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SatRentalDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SatRentalDetails` (
  `RentalDate` DATE NULL,
  `ReturnDate` DATE NULL,
  `LoadDate` DATETIME NULL,
  `RecordSource` VARCHAR(45) NULL,
  `LinkRental_RentalHashKey` VARCHAR(255) NOT NULL,
  INDEX `fk_SatRentalDetails_LinkRental1_idx` (`LinkRental_RentalHashKey` ASC) VISIBLE,
  CONSTRAINT `fk_SatRentalDetails_LinkRental1`
    FOREIGN KEY (`LinkRental_RentalHashKey`)
    REFERENCES `mydb`.`LinkRental` (`RentalHashKey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
