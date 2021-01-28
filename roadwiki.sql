-- MySQL Script generated by MySQL Workbench
-- Wed Jan 27 13:04:04 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema roadwiki
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema roadwiki
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `roadwiki` DEFAULT CHARACTER SET utf8 ;
USE `roadwiki` ;

-- -----------------------------------------------------
-- Table `roadwiki`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`user` (
  `uid` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(30) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `createDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `image` VARCHAR(50) NULL,
  PRIMARY KEY (`uid`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`keyword` (
  `kwid` INT NOT NULL AUTO_INCREMENT,
  `word` VARCHAR(45) NULL,
  PRIMARY KEY (`kwid`),
  UNIQUE INDEX `kwid_UNIQUE` (`kwid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`userkeyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`userkeyword` (
  `uid` INT NOT NULL,
  `priority` INT NULL,
  `kwid` INT NOT NULL,
  PRIMARY KEY (`uid`, `kwid`),
  INDEX `kwid_idx` (`kwid` ASC) VISIBLE,
  CONSTRAINT `fk_user_userkeyword`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_keyword_userkeyword`
    FOREIGN KEY (`kwid`)
    REFERENCES `roadwiki`.`keyword` (`kwid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`posting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`posting` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `classifier` VARCHAR(45) NOT NULL,
  `tag` VARCHAR(20) NULL,
  `title` VARCHAR(30) NOT NULL,
  `content` TEXT NOT NULL,
  `createDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `modifyDate` TIMESTAMP NULL,
  `image` VARCHAR(50) NULL,
  `likeCnt` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`pid`),
  UNIQUE INDEX `pid_UNIQUE` (`pid` ASC) VISIBLE,
  INDEX `uid_idx` (`uid` ASC) INVISIBLE,
  CONSTRAINT `fk_user_posting`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`comment` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `pid` INT NOT NULL,
  `content` TEXT NOT NULL,
  `createDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `modifyDate` TIMESTAMP NULL,
  `likeCnt` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `cid_UNIQUE` (`cid` ASC) VISIBLE,
  INDEX `uid_idx` (`uid` ASC) VISIBLE,
  INDEX `parentid_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_user_comment`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posting_comment`
    FOREIGN KEY (`pid`)
    REFERENCES `roadwiki`.`posting` (`pid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`postinglikeuser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`postinglikeuser` (
  `uid` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`pid`, `uid`),
  INDEX `pid_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_posting_postinglikeuser`
    FOREIGN KEY (`pid`)
    REFERENCES `roadwiki`.`posting` (`pid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_postinglikeuser`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`commentlikeuser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`commentlikeuser` (
  `uid` INT NOT NULL,
  `cid` INT NOT NULL,
  PRIMARY KEY (`cid`, `uid`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `fk_user_commentlikeuser`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_commentlikeuser`
    FOREIGN KEY (`cid`)
    REFERENCES `roadwiki`.`comment` (`cid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`roadmap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`roadmap` (
  `rmid` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `rmorder` INT NULL,
  `permission` INT NULL DEFAULT 1,
  `createDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `tmp` TEXT NULL,
  UNIQUE INDEX `rid_UNIQUE` (`rmid` ASC) VISIBLE,
  INDEX `uid_idx` (`uid` ASC) VISIBLE,
  PRIMARY KEY (`rmid`),
  CONSTRAINT `fk_user_roadmap`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`curriculumtext`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`curriculumtext` (
  `crtid` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  PRIMARY KEY (`crtid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`curriculummemo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`curriculummemo` (
  `crmid` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  PRIMARY KEY (`crmid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`curriculum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`curriculum` (
  `rmid` INT NOT NULL,
  `crid` INT NOT NULL AUTO_INCREMENT,
  `crtid` INT NULL,
  `crmid` INT NULL,
  `parentid` INT NULL,
  `depth` INT NULL,
  `title` VARCHAR(45) NULL,
  PRIMARY KEY (`crid`),
  INDEX `rmid_idx` (`rmid` ASC) VISIBLE,
  INDEX `crtid_idx` (`crtid` ASC) VISIBLE,
  INDEX `parentid_idx` (`parentid` ASC) VISIBLE,
  INDEX `crmid_idx` (`crmid` ASC) VISIBLE,
  CONSTRAINT `fk_roadmap_curriculum`
    FOREIGN KEY (`rmid`)
    REFERENCES `roadwiki`.`roadmap` (`rmid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curriculumtext_curriculum`
    FOREIGN KEY (`crtid`)
    REFERENCES `roadwiki`.`curriculumtext` (`crtid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curriculum_curriculum`
    FOREIGN KEY (`parentid`)
    REFERENCES `roadwiki`.`curriculum` (`crid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curriculmmemo_curriculum`
    FOREIGN KEY (`crmid`)
    REFERENCES `roadwiki`.`curriculummemo` (`crmid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`recomment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`recomment` (
  `rcid` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `cid` INT NOT NULL,
  `content` TEXT NOT NULL,
  `createDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `modifyDate` TIMESTAMP NULL,
  `likeCnt` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`rcid`),
  UNIQUE INDEX `rcid_UNIQUE` (`rcid` ASC) VISIBLE,
  INDEX `fk_comment_recomment_idx` (`cid` ASC) VISIBLE,
  INDEX `fk_user_recomment_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `fk_comment_recomment`
    FOREIGN KEY (`cid`)
    REFERENCES `roadwiki`.`comment` (`cid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_recomment`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roadwiki`.`rcoomentlikeuser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`rcoomentlikeuser` (
  `uid` INT NOT NULL,
  `rcid` INT NOT NULL,
  PRIMARY KEY (`uid`, `rcid`),
  INDEX `fk_recomment_recommentlikeuser_idx` (`rcid` ASC) VISIBLE,
  CONSTRAINT `fk_user_recommentlikeuser`
    FOREIGN KEY (`uid`)
    REFERENCES `roadwiki`.`user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recomment_recommentlikeuser`
    FOREIGN KEY (`rcid`)
    REFERENCES `roadwiki`.`recomment` (`rcid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use roadwiki;

insert into keyword 
values
(1, "Python"),
(2, "Java"),
(3, "C"),
(4, "Vue"),
(5, "Spring"),
(6, "Frontend"),
(7, "Backend"),
(8, "Database"),
(9, "AI"),
(10, "기타") ;

insert into user(password,email,name) values('1234','ssafy@ssafy.com','김싸피');
insert into user(password,email,name) values('1234','abcd@abc.com','김동화');
insert into user(password,email,name) values('1234','root@root.com','김루트');
update user set uid = -1 where uid = 3;

insert into posting(uid, classifier, tag, title, content) 
values
(1, "board", "tag", "첫 글", "첫 본문"),
(2, "board", "tag", "두번째", "본문"),
(2, "board", "tag", "글입니다", "내용"),
(1, "board", "tag", "readme", "안녕하세요"),
(1, "board", "tag", "title", "안녕하세요안녕하세요"),
(1, "board", "tag", "제", "본문입니다"),
(2, "board", "tag", "목", "읽어주세요"),
(2, "board", "tag", "제목", "없음"),
(2, "board", "tag", "read", "본문입니다본문입니다"),
(1, "board", "tag", "get", "내용");

insert into roadmap(uid,name,rmorder,tmp) 
select 1,"김싸피의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 1,"김싸피의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 1,"김싸피의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 1,"김싸피의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 1,"김싸피의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 2,"김동화의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 2,"김동화의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 2,"김동화의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 2,"김동화의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select 2,"김동화의 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
insert into roadmap(uid,name,rmorder,tmp) 
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1) ,'{"class":"go.GraphLinksModel","linkFromPortIdProperty":"fromPort","linkToPortIdProperty":"toPort","nodeDataArray":[{"key":1,"loc":"175 100","text":"back","__gohashid":1506},{"key":2,"loc":"175 200","text":"Gradually beat in 1 cup sugar and 2 cups sifted flour","__gohashid":1507}],"linkDataArray":[{"from":1,"to":2,"fromPort":"B","toPort":"T","__gohashid":1509,"points":{"__gohashid":1639,"s":true,"j":[{"G":175,"H":122.19914805335318,"s":true},{"G":175,"H":132.19914805335318,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":142.0622756958008,"s":true},{"G":175,"H":151.92540333824837,"s":true},{"G":175,"H":161.92540333824837,"s":true}],"u":8,"Ma":null,"rh":null}}]}' from roadmap where uid = 1;
