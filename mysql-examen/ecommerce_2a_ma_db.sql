-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce_2a_ma
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce_2a_ma
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce_2a_ma` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce_2a_ma` ;

-- -----------------------------------------------------
-- Table `ecommerce_2a_ma`.`PRODUCTES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_2a_ma`.`PRODUCTES` ;

CREATE TABLE IF NOT EXISTS `ecommerce_2a_ma`.`PRODUCTES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `unitats_disponibles` INT NOT NULL,
  `preu` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_2a_ma`.`COMPRES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_2a_ma`.`COMPRES` ;

CREATE TABLE IF NOT EXISTS `ecommerce_2a_ma`.`COMPRES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_compra` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `preu_total_compra` DECIMAL(7,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_2a_ma`.`CLIENTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_2a_ma`.`CLIENTS` ;

CREATE TABLE IF NOT EXISTS `ecommerce_2a_ma`.`CLIENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `DNI` CHAR(9) NOT NULL,
  `nom` VARCHAR(50) NOT NULL,
  `cognom1` VARCHAR(100) NOT NULL,
  `cognom2` VARCHAR(100) NULL,
  `mail` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- CREATE UNIQUE INDEX `DNI_UNIQUE` ON `ecommerce_2a_ma`.`CLIENTS` (`DNI` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` ;

CREATE TABLE IF NOT EXISTS `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `compra_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `producte_id` INT NOT NULL,
  PRIMARY KEY (`id`, `compra_id`, `client_id`, `producte_id`),
  CONSTRAINT `fk_COMPRES_has_CLIENTS_COMPRES`
    FOREIGN KEY (`compra_id`)
    REFERENCES `ecommerce_2a_ma`.`COMPRES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMPRES_has_CLIENTS_CLIENTS1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ecommerce_2a_ma`.`CLIENTS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMPRES_has_CLIENTS_PRODUCTES1`
    FOREIGN KEY (`producte_id`)
    REFERENCES `ecommerce_2a_ma`.`PRODUCTES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_COMPRES_has_CLIENTS_CLIENTS1_idx` ON `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`client_id` ASC) VISIBLE;

-- CREATE INDEX `fk_COMPRES_has_CLIENTS_COMPRES_idx` ON `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`compra_id` ASC) VISIBLE;

-- CREATE INDEX `fk_COMPRES_has_CLIENTS_PRODUCTES1_idx` ON `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`producte_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ecommerce_2a_ma`.`PRODUCTES`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecommerce_2a_ma`;
INSERT INTO `ecommerce_2a_ma`.`PRODUCTES` (`id`, `nom`, `categoria`, `unitats_disponibles`, `preu`) VALUES (DEFAULT, '¿Cómo crear un ecommerce?', 'Llibreria', 8, 14.99);
INSERT INTO `ecommerce_2a_ma`.`PRODUCTES` (`id`, `nom`, `categoria`, `unitats_disponibles`, `preu`) VALUES (DEFAULT, 'Portàtil 15 pulgades 8G RAM, Intel i7', 'Informàtica', 3, 879.99);
INSERT INTO `ecommerce_2a_ma`.`PRODUCTES` (`id`, `nom`, `categoria`, `unitats_disponibles`, `preu`) VALUES (DEFAULT, 'Pack 5 Bolígrafs tinta blava BIC', 'Papereria', 200, 4.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ecommerce_2a_ma`.`COMPRES`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecommerce_2a_ma`;
INSERT INTO `ecommerce_2a_ma`.`COMPRES` (`id`, `data_compra`, `preu_total_compra`) VALUES (DEFAULT, DEFAULT, 879.99);
INSERT INTO `ecommerce_2a_ma`.`COMPRES` (`id`, `data_compra`, `preu_total_compra`) VALUES (DEFAULT, DEFAULT, 19.98);
INSERT INTO `ecommerce_2a_ma`.`COMPRES` (`id`, `data_compra`, `preu_total_compra`) VALUES (DEFAULT, DEFAULT, 4.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ecommerce_2a_ma`.`CLIENTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecommerce_2a_ma`;
INSERT INTO `ecommerce_2a_ma`.`CLIENTS` (`id`, `DNI`, `nom`, `cognom1`, `cognom2`, `mail`) VALUES (DEFAULT, '47568923T', 'Joan', 'Riera', 'Mateu', 'jr@riera.cat');
INSERT INTO `ecommerce_2a_ma`.`CLIENTS` (`id`, `DNI`, `nom`, `cognom1`, `cognom2`, `mail`) VALUES (DEFAULT, '68723409S', 'Anna', 'Serra', 'Pérez', 'annasp@gmail.com');
INSERT INTO `ecommerce_2a_ma`.`CLIENTS` (`id`, `DNI`, `nom`, `cognom1`, `cognom2`, `mail`) VALUES (DEFAULT, '72345628M', 'Maria', 'Martí', 'Cugat', 'maria.mc@hotmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE`
-- -----------------------------------------------------
START TRANSACTION;
USE `ecommerce_2a_ma`;
INSERT INTO `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`id`, `compra_id`, `client_id`, `producte_id`) VALUES (DEFAULT, 1, 1, 2);
INSERT INTO `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`id`, `compra_id`, `client_id`, `producte_id`) VALUES (DEFAULT, 2, 2, 1);
INSERT INTO `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`id`, `compra_id`, `client_id`, `producte_id`) VALUES (DEFAULT, 2, 2, 3);
INSERT INTO `ecommerce_2a_ma`.`COMPRA_CLIENT_PRODUCTE` (`id`, `compra_id`, `client_id`, `producte_id`) VALUES (DEFAULT, 3, 3, 3);

COMMIT;

