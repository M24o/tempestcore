-- 9632

CREATE TABLE `character_arena_stats` (
`guid`  int(10) NOT NULL ,
`slot`  smallint(1) NOT NULL ,
`personal_rating`  int(10) NOT NULL ,
`matchmaker_rating`  int(10) NOT NULL ,
PRIMARY KEY (`guid`, `slot`)
);

UPDATE `arena_team_stats` SET `rating`=0;

ALTER TABLE `arena_team_member`
DROP COLUMN `personal_rating`;

DROP TABLE IF EXISTS `character_arena_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character_arena_stats` (
  `guid`  int(10) NOT NULL ,
  `slot`  smallint(1) NOT NULL ,
  `personal_rating`  int(10) NOT NULL ,
  `matchmaker_rating`  int(10) NOT NULL ,
  PRIMARY KEY (`guid`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;