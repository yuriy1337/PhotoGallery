CREATE SCHEMA Photo-Gallery_development;
CREATE  TABLE `photogallery_development`.`albums` (
  `idalbums` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`idalbums`) );

ALTER TABLE `photogallery_development`.`albums` CHARACTER SET = utf8 , CHANGE COLUMN `idalbums` `id` INT(11) NOT NULL AUTO_INCREMENT
, DROP PRIMARY KEY
, ADD PRIMARY KEY (`id`) ;
