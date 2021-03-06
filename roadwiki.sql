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
-- Table `roadwiki`.`recommentlikeuser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roadwiki`.`recommentlikeuser` (
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


insert into user(password,email,name) values('1234','abc@abc.com','김싸피');
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
select -1,"웹 개발 로드맵", if(isnull(max(rmorder)), 1, max(rmorder)+1),'\"{ \\\"class\\\": \\\"GraphLinksModel\\\",\\n  \\\"linkFromPortIdProperty\\\": \\\"fromPort\\\",\\n  \\\"linkToPortIdProperty\\\": \\\"toPort\\\",\\n  \\\"nodeDataArray\\\": [ \\n{\\\"category\\\":\\\"Start\\\", \\\"text\\\":\\\"Start\\\", \\\"key\\\":-1, \\\"loc\\\":\\\"-7 -313.2125015258789\\\"},\\n{\\\"text\\\":\\\"OS and General Knowledge\\\", \\\"key\\\":-2, \\\"loc\\\":\\\"-46.80000000000001 -117.96250152587879\\\"},\\n{\\\"text\\\":\\\"Internet\\\", \\\"key\\\":-3, \\\"loc\\\":\\\"-7.349999999999966 -209.17312660217283\\\"},\\n{\\\"text\\\":\\\"Learn a Language\\\", \\\"key\\\":-4, \\\"loc\\\":\\\"54.60000000000008 -23.323126602172863\\\"},\\n{\\\"text\\\":\\\"Version Control\\\\nSystems\\\", \\\"key\\\":-5, \\\"loc\\\":\\\"-66.14999999999992 80.62687339782724\\\"},\\n{\\\"text\\\":\\\"More about \\\\nDatabases\\\", \\\"key\\\":-6, \\\"loc\\\":\\\"64.04999999999995 221.32687339782706\\\"},\\n{\\\"text\\\":\\\"Learn about APIs\\\", \\\"key\\\":-7, \\\"loc\\\":\\\"-63 324.22687339782715\\\"},\\n{\\\"text\\\":\\\"HTML\\\", \\\"key\\\":-8, \\\"loc\\\":\\\"-254.09999999999997 -157.72312660217287\\\"},\\n{\\\"text\\\":\\\"CSS\\\", \\\"key\\\":-9, \\\"loc\\\":\\\"-254.1 -90.52312660217285\\\"},\\n{\\\"text\\\":\\\"Python\\\", \\\"key\\\":-10, \\\"loc\\\":\\\"263.54999999999995 -80.02312660217285\\\"},\\n{\\\"text\\\":\\\"Java\\\", \\\"key\\\":-11, \\\"loc\\\":\\\"263.55000000000007 -23.323126602172863\\\"},\\n{\\\"text\\\":\\\"JavaScript\\\", \\\"key\\\":-12, \\\"loc\\\":\\\"271.9499999999998 33.376873397827126\\\"},\\n{\\\"text\\\":\\\"Github\\\", \\\"key\\\":-13, \\\"loc\\\":\\\"-250.95000000000002 80.41687560081488\\\"},\\n{\\\"category\\\":\\\"Comment\\\", \\\"text\\\":\\\"Make sure to learn..\\\", \\\"key\\\":-14, \\\"loc\\\":\\\"250.94999999999993 -150.5831243991852\\\"},\\n{\\\"text\\\":\\\"Relational \\\\nDatabases\\\", \\\"key\\\":-15, \\\"loc\\\":\\\"-66.15000000000003 156.0168756008149\\\"},\\n{\\\"text\\\":\\\"PostgreSQL\\\", \\\"key\\\":-16, \\\"loc\\\":\\\"-234.15 199.06687560081485\\\"}\\n ],\\n  \\\"linkDataArray\\\": [ \\n{\\\"from\\\":-3, \\\"to\\\":-2, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[-7.349999999999966,-188.72397854881964,-7.349999999999966,-178.72397854881964,-7.349999999999966,-167.53667621612544,-46.8,-167.53667621612544,-46.8,-156.3493738834312,-46.8,-146.3493738834312]},\\n{\\\"from\\\":-1, \\\"to\\\":-3, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[-7,-276.4625015258789,-7,-266.4625015258789,-7,-253.04238809070245,-7.349999999999966,-253.04238809070245,-7.349999999999966,-239.622274655526,-7.349999999999966,-229.622274655526]},\\n{\\\"from\\\":-2, \\\"to\\\":-4, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[-46.8,-89.5756291683264,-46.8,-79.5756291683264,-46.8,-66.67395191192622,54.600000000000065,-66.67395191192622,54.600000000000065,-53.77227465552605,54.600000000000065,-43.77227465552605]},\\n{\\\"from\\\":-4, \\\"to\\\":-5, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[54.60000000000008,-2.8739785488196787,54.60000000000008,7.126021451180321,54.60000000000008,24.683011245727577,-66.1499999999999,24.683011245727577,-66.1499999999999,42.240001040274834,-66.1499999999999,52.240001040274834]},\\n{\\\"from\\\":-6, \\\"to\\\":-7, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[64.04999999999995,249.71374575537945,64.04999999999995,259.7137457553795,64.04999999999995,276.74573554992674,-62.999999999999986,276.74573554992674,-62.999999999999986,293.777725344474,-62.999999999999986,303.777725344474]},\\n{\\\"from\\\":-2, \\\"to\\\":-8, \\\"fromPort\\\":\\\"L\\\", \\\"toPort\\\":\\\"R\\\", \\\"points\\\":[-114.30427500647818,-127.4247923117296,-124.30427500647818,-127.4247923117296,-167.76925582885744,-127.4247923117296,-167.76925582885744,-157.72312660217287,-211.2342366512367,-157.72312660217287,-221.2342366512367,-157.72312660217287]},\\n{\\\"from\\\":-2, \\\"to\\\":-9, \\\"fromPort\\\":\\\"L\\\", \\\"toPort\\\":\\\"R\\\", \\\"points\\\":[-114.30427500647818,-108.500210740028,-124.30427500647818,-108.500210740028,-170.410636138916,-108.500210740028,-170.410636138916,-90.52312660217285,-216.51699727135383,-90.52312660217285,-226.51699727135383,-90.52312660217285]},\\n{\\\"from\\\":-4, \\\"to\\\":-10, \\\"fromPort\\\":\\\"R\\\", \\\"toPort\\\":\\\"L\\\", \\\"points\\\":[129.8387110416345,-33.547700628849455,139.8387110416345,-33.547700628849455,178.01917190551757,-33.547700628849455,178.01917190551757,-80.02312660217285,216.19963276940067,-80.02312660217285,226.19963276940067,-80.02312660217285]},\\n{\\\"from\\\":-4, \\\"to\\\":-11, \\\"fromPort\\\":\\\"R\\\", \\\"toPort\\\":\\\"L\\\", \\\"points\\\":[129.8387110416345,-23.323126602172863,139.8387110416345,-23.323126602172863,182.28546066284184,-23.323126602172863,182.28546066284184,-23.323126602172863,224.73221028404922,-23.323126602172863,234.73221028404922,-23.323126602172863]},\\n{\\\"from\\\":-4, \\\"to\\\":-12, \\\"fromPort\\\":\\\"R\\\", \\\"toPort\\\":\\\"L\\\", \\\"points\\\":[129.8387110416345,-13.09855257549627,139.8387110416345,-13.09855257549627,176.0989212036132,-13.09855257549627,176.0989212036132,33.376873397827126,212.35913136559194,33.376873397827126,222.35913136559194,33.376873397827126]},\\n{\\\"from\\\":-5, \\\"to\\\":-13, \\\"fromPort\\\":\\\"L\\\", \\\"toPort\\\":\\\"R\\\", \\\"points\\\":[-133.23551279944684,80.62687339782724,-143.23551279944684,80.62687339782724,-174.03138427734373,80.62687339782724,-174.03138427734373,80.41687560081488,-204.82725575524063,80.41687560081488,-214.82725575524063,80.41687560081488]},\\n{\\\"from\\\":-5, \\\"to\\\":-15, \\\"fromPort\\\":\\\"B\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[-66.1499999999999,109.01374575537965,-66.1499999999999,119.01374575537965,-66.14999999999998,119.01374575537965,-66.14999999999998,117.6300032432625,-66.15000000000003,117.6300032432625,-66.15000000000003,127.6300032432625]},\\n{\\\"from\\\":-15, \\\"to\\\":-6, \\\"fromPort\\\":\\\"R\\\", \\\"toPort\\\":\\\"T\\\", \\\"points\\\":[-16.967143755728884,156.0168756008149,-6.967143755728884,156.0168756008149,64.04999999999995,156.0168756008149,64.04999999999995,169.47843832054477,64.04999999999995,182.94000104027464,64.04999999999995,192.94000104027464]},\\n{\\\"from\\\":-15, \\\"to\\\":-16, \\\"fromPort\\\":\\\"L\\\", \\\"toPort\\\":\\\"R\\\", \\\"points\\\":[-115.3328562442712,156.0168756008149,-125.3328562442712,156.0168756008149,-147.30640258789066,156.0168756008149,-147.30640258789066,199.06687560081485,-169.2799489315101,199.06687560081485,-179.2799489315101,199.06687560081485]}\\n ]}\"' from roadmap where uid = -1;
