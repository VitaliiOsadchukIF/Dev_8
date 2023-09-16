-- MySQL Script generated by MySQL Workbench
-- Fri Sep 15 13:55:06 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OSBB10
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OSBB10
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OSBB10` DEFAULT CHARACTER SET utf8 ;
USE `OSBB10` ;

-- -----------------------------------------------------
-- Table `OSBB10`.`buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OSBB10`.`buildings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `adress` VARCHAR(45) NOT NULL,
  `number_of_aparments` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OSBB10`.`apartments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OSBB10`.`apartments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_buildings` INT NOT NULL,
  `number` INT NOT NULL,
  `area` FLOAT NOT NULL,
  `number_of_rooms` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_buildings_idx` (`id_buildings` ASC) VISIBLE,
  CONSTRAINT `fk_buildings`
    FOREIGN KEY (`id_buildings`)
    REFERENCES `OSBB10`.`buildings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OSBB10`.`residents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OSBB10`.`residents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_apartments` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_apartment_idx` (`id_apartments` ASC) VISIBLE,
  CONSTRAINT `fk_apartment`
    FOREIGN KEY (`id_apartments`)
    REFERENCES `OSBB10`.`apartments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OSBB10`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OSBB10`.`owner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_apartments` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `property_rights` ENUM('owner', 'co-owner') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_apartments_idx` (`id_apartments` ASC) INVISIBLE,
  CONSTRAINT `fk_apartments`
    FOREIGN KEY (`id_apartments`)
    REFERENCES `OSBB10`.`apartments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner`
    FOREIGN KEY (`id_apartments`)
    REFERENCES `OSBB10`.`residents` (`id_apartments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OSBB10`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OSBB10`.`roles` (
  `id_owner` INT NOT NULL,
  `roles` VARCHAR(45) NOT NULL DEFAULT 'member',
  INDEX `fk_resident_idx` (`id_owner` ASC) VISIBLE,
  CONSTRAINT `fk_resident`
    FOREIGN KEY (`id_owner`)
    REFERENCES `OSBB10`.`owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;