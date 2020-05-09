-- MySQL Script generated by MySQL Workbench
-- sáb 09 may 2020 12:29:55 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
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
-- Table `mydb`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`languages` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `language_lang` CHAR(8) NOT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE INDEX `language_lang_UNIQUE` (`language_lang` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`stocks` (
  `stock_id` INT NOT NULL AUTO_INCREMENT,
  `stock_user_id` INT NOT NULL,
  `stock_name` VARCHAR(45) NULL,
  PRIMARY KEY (`stock_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`locations` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `location_user_id` INT NOT NULL,
  `location_name` VARCHAR(45) NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`images` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `image_path` VARCHAR(45) NULL,
  PRIMARY KEY (`image_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`barcodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`barcodes` (
  `barcode_id` INT NOT NULL AUTO_INCREMENT,
  `barcode_code` VARCHAR(45) NULL,
  PRIMARY KEY (`barcode_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL,
  `user_email` VARCHAR(255) NULL COMMENT '  ',
  `user_password` VARCHAR(32) NOT NULL,
  `user_create_datetime` DATETIME(10) NULL,
  `user_first_name` VARCHAR(45) NULL,
  `user_last_name` VARCHAR(45) NULL,
  `user_address` VARCHAR(255) NULL,
  `user_country` VARCHAR(45) NULL,
  `user_city` VARCHAR(45) NULL,
  `user_language_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC),
  CONSTRAINT `language_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`languages` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
