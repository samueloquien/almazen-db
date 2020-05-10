-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema almazen-db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema almazen-db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `almazen-db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `almazen-db` ;

-- -----------------------------------------------------
-- Table `almazen-db`.`barcodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`barcodes` (
  `barcode_id` INT NOT NULL AUTO_INCREMENT,
  `barcode_code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`barcode_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`images` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `image_path` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`image_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`languages` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `language_lang` CHAR(8) NOT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE INDEX `language_lang_UNIQUE` (`language_lang` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`users` (
  `user_id` INT NOT NULL,
  `user_email` VARCHAR(255) NULL DEFAULT NULL COMMENT '  ',
  `user_password` VARCHAR(32) NOT NULL,
  `user_create_datetime` DATETIME(3) NULL DEFAULT NULL,
  `user_first_name` VARCHAR(45) NULL DEFAULT NULL,
  `user_last_name` VARCHAR(45) NULL DEFAULT NULL,
  `user_address` VARCHAR(255) NULL DEFAULT NULL,
  `user_country` VARCHAR(45) NULL DEFAULT NULL,
  `user_city` VARCHAR(45) NULL DEFAULT NULL,
  `user_language_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `user_language_id_idx` (`user_language_id` ASC) VISIBLE,
  CONSTRAINT `user_language_id`
    FOREIGN KEY (`user_language_id`)
    REFERENCES `almazen-db`.`languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`labels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`labels` (
  `label_id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`label_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `almazen-db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`products` (
  `prod_id` INT NOT NULL AUTO_INCREMENT,
  `prod_name` VARCHAR(45) NOT NULL,
  `prod_info` VARCHAR(300) NULL,
  `prod_barcode_id` INT NULL,
  `prod_image_id` INT NULL,
  `prod_brand` VARCHAR(45) NULL,
  PRIMARY KEY (`prod_id`),
  INDEX `prod_barcode_id_idx` (`prod_barcode_id` ASC) VISIBLE,
  INDEX `prod_image_id_idx` (`prod_image_id` ASC) VISIBLE,
  CONSTRAINT `prod_barcode_id`
    FOREIGN KEY (`prod_barcode_id`)
    REFERENCES `almazen-db`.`barcodes` (`barcode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prod_image_id`
    FOREIGN KEY (`prod_image_id`)
    REFERENCES `almazen-db`.`images` (`image_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_prod_id` INT NOT NULL,
  `item_user_id` INT NOT NULL,
  `item_date_acquisition` TIMESTAMP NULL,
  `item_date_expiracy` TIMESTAMP NULL,
  `item_quantity` INT NULL,
  `item_percent_left` FLOAT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `item_user_id_idx` (`item_user_id` ASC) VISIBLE,
  INDEX `item_prod_id_idx` (`item_prod_id` ASC) VISIBLE,
  CONSTRAINT `item_user_id`
    FOREIGN KEY (`item_user_id`)
    REFERENCES `almazen-db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_prod_id`
    FOREIGN KEY (`item_prod_id`)
    REFERENCES `almazen-db`.`products` (`prod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `almazen-db`.`items_labels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `almazen-db`.`items_labels` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `label_id` INT NOT NULL,
  PRIMARY KEY (`item_id`, `label_id`),
  INDEX `label_id_idx` (`label_id` ASC) VISIBLE,
  CONSTRAINT `item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `almazen-db`.`items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `label_id`
    FOREIGN KEY (`label_id`)
    REFERENCES `almazen-db`.`labels` (`label_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
