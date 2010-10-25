-- -------------------------------------------------------------------------
-- ------------------------- Myth Project UPDATE ---------------------------
-- -------------------------------------------------------------------------
-- THIS IS UPDATE FOR "Characters" Database.
-- NOTE: This Update pack is optimized for TRINITY AUTH DB.
-- Contain all trinity updates for Characters database since 8787 rev.
-- HOW TO USE:
--  IF YOU HAVE Characters DB, WITH LAST TRINITY UPDATES BEFORE 8787 REV. SKIP 1),2) STEPS.
-- 1) Create database for Characters database 
-- 2) Install clear Characters database from sql\base
-- 3) If you have StartUP errors, Please do that:
--    3.1) Host them in to text hosts. (for example http://paste2.org/new-paste)
--    3.2) Please post them in our forum, don`t forget link of your error logs. 
--    3.3) DON`T CREATE DUBLICATE ISSUES!!!
-- 4) If you have some fixes, please post it in issue tracker too.
-- 5) Thanks you for visit MythProject.
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- ------------------------- TrinityCore UPDATE ----------------------------
-- -------------------------------------------------------------------------
-- 8972
ALTER TABLE `characters`
   ADD COLUMN `deleteInfos_Account` int(11) UNSIGNED default NULL AFTER actionBars,
   ADD COLUMN `deleteInfos_Name` varchar(12) default NULL AFTER deleteInfos_Account,
   ADD COLUMN `deleteDate` bigint(20) default NULL AFTER deleteInfos_Name;
-- 8986
DELETE FROM `worldstates` WHERE `entry`=20004;
INSERT INTO `worldstates` (`entry`,`value`,`comment`) VALUES (20004,0, 'cleaning_flags');
-- 9083
ALTER TABLE `characters` CHANGE `dungeon_difficulty` `instance_mode_mask`  tinyint(2) UNSIGNED NOT NULL DEFAULT 0 AFTER `instance_id`;
-- 9090
-- Add new fields
ALTER TABLE `item_instance`
 ADD `creatorGuid` int(10) unsigned NOT NULL default '0' AFTER `owner_guid`,
 ADD `giftCreatorGuid` int(10) unsigned NOT NULL default '0' AFTER `creatorGuid`,
 ADD `count` int(10) unsigned NOT NULL default '1' AFTER `giftCreatorGuid`,
 ADD `duration` int(10) unsigned NOT NULL AFTER `count`,
 ADD `charges` text NOT NULL AFTER `duration`,
 ADD `flags` int(10) unsigned NOT NULL default '0' AFTER `charges`,
 ADD `enchantments` text NOT NULL AFTER `flags`,
 ADD `randomPropertyId` int(11) NOT NULL default '0' AFTER `enchantments`,
 ADD `durability` int(10) unsigned NOT NULL default '0' AFTER `randomPropertyId`,
 ADD `playedTime` int(10) unsigned NOT NULL default '0' AFTER `durability`;
-- Temporarily change delimiter to prevent SQL syntax errors
DELIMITER ||
-- Function to convert ints from unsigned to signed
DROP FUNCTION IF EXISTS `uint32toint32` ||
CREATE FUNCTION `uint32toint32`(input INT(10) UNSIGNED) RETURNS INT(11) SIGNED DETERMINISTIC
BEGIN
  RETURN input;
END||
-- Restore original delimiter
DELIMITER ;
-- Move data to new fields
UPDATE `item_instance` SET
`creatorGuid` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',10))+2,
length(SUBSTRING_INDEX(`data`,' ',10+1))-length(SUBSTRING_INDEX(data,' ',10))-1),

`giftCreatorGuid` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',12))+2,
length(SUBSTRING_INDEX(`data`,' ',12+1))-length(SUBSTRING_INDEX(data,' ',12))-1),

`count` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',14))+2,
length(SUBSTRING_INDEX(`data`,' ',14+1))-length(SUBSTRING_INDEX(data,' ',14))-1),

`duration` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',15))+2,
length(SUBSTRING_INDEX(`data`,' ',15+1))-length(SUBSTRING_INDEX(data,' ',15))-1),

`charges` = CONCAT_WS(' ',
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',16))+2,
length(SUBSTRING_INDEX(`data`,' ',16+1))-length(SUBSTRING_INDEX(data,' ',16))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',17))+2,
length(SUBSTRING_INDEX(`data`,' ',17+1))-length(SUBSTRING_INDEX(data,' ',17))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',18))+2,
length(SUBSTRING_INDEX(`data`,' ',18+1))-length(SUBSTRING_INDEX(data,' ',18))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',19))+2,
length(SUBSTRING_INDEX(`data`,' ',19+1))-length(SUBSTRING_INDEX(data,' ',19))-1)),
uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',20))+2,
length(SUBSTRING_INDEX(`data`,' ',20+1))-length(SUBSTRING_INDEX(data,' ',20))-1))),

`flags` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',21))+2,
length(SUBSTRING_INDEX(`data`,' ',21+1))-length(SUBSTRING_INDEX(data,' ',21))-1),

`enchantments` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',22))+2,
length(SUBSTRING_INDEX(`data`,' ',57+1))-length(SUBSTRING_INDEX(data,' ',22))-1),

`randomPropertyId` = uint32toint32(SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',59))+2,
length(SUBSTRING_INDEX(`data`,' ',59+1))-length(SUBSTRING_INDEX(data,' ',59))-1)),

`durability` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',60))+2,
length(SUBSTRING_INDEX(`data`,' ',60+1))-length(SUBSTRING_INDEX(data,' ',60))-1),

`playedTime` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',62))+2,
length(SUBSTRING_INDEX(`data`,' ',62+1))-length(SUBSTRING_INDEX(data,' ',62))-1);

-- Drop function
DROP FUNCTION IF EXISTS `uint32toint32`;
-- Fix heroic item flag
UPDATE `item_instance` SET `flags`=`flags`&~0x8 WHERE
SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',3))+2,
length(SUBSTRING_INDEX(`data`,' ',3+1))-length(SUBSTRING_INDEX(data,' ',3))-1)
NOT IN (5043,5044,17302,17305,17308,21831);
-- Drop old field
ALTER TABLE `item_instance` DROP `data`;
-- 9092
ALTER TABLE `corpse`
 ADD COLUMN `displayId` int(10) unsigned NOT NULL default '0' AFTER `phaseMask`,
 ADD COLUMN `itemCache` text NOT NULL AFTER `displayId`,
 ADD COLUMN `bytes1` int(10) unsigned NOT NULL default '0' AFTER `itemCache`,
 ADD COLUMN `bytes2` int(10) unsigned NOT NULL default '0' AFTER `bytes1`,
 ADD COLUMN `guild` int(10) unsigned NOT NULL default '0' AFTER `bytes2`,
 ADD COLUMN `flags` int(10) unsigned NOT NULL default '0' AFTER `guild`,
 ADD COLUMN `dynFlags` int(10) unsigned NOT NULL default '0' AFTER `flags`;

UPDATE `corpse` SET
`displayId` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',10))+2,
length(SUBSTRING_INDEX(`data`,' ',10+1))-length(SUBSTRING_INDEX(data,' ',10))-1),

`itemCache` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',11))+2,
length(SUBSTRING_INDEX(`data`,' ',29+1))-length(SUBSTRING_INDEX(data,' ',11))-1),

`bytes1` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',30))+2,
length(SUBSTRING_INDEX(`data`,' ',30+1))-length(SUBSTRING_INDEX(data,' ',30))-1),

`bytes2` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',31))+2,
length(SUBSTRING_INDEX(`data`,' ',31+1))-length(SUBSTRING_INDEX(data,' ',31))-1),

`guild` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',32))+2,
length(SUBSTRING_INDEX(`data`,' ',32+1))-length(SUBSTRING_INDEX(data,' ',32))-1),

`flags` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',33))+2,
length(SUBSTRING_INDEX(`data`,' ',33+1))-length(SUBSTRING_INDEX(data,' ',33))-1),

`dynFlags` = SUBSTRING(`data`,
length(SUBSTRING_INDEX(`data`,' ',34))+2,
length(SUBSTRING_INDEX(`data`,' ',34+1))-length(SUBSTRING_INDEX(data,' ',34))-1);

ALTER TABLE `corpse` DROP `data`;
-- 9160
SET @allowedFlags := 0x00000001 | 0x00000008 | 0x00000200 | 0x00001000 | 0x00008000 | 0x00010000;
UPDATE `item_instance` SET `flags` = (`flags` & @allowedFlags);
-- 9632
DROP TABLE IF EXISTS `character_arena_stats`;
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
-- 9668
DROP TABLE IF EXISTS `gm_subsurveys`;
CREATE TABLE `gm_subsurveys` (
  `surveyid` int(10) NOT NULL auto_increment,
  `subsurveyid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `rank` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `comment` longtext NOT NULL,
  PRIMARY KEY (`surveyid`,`subsurveyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
 
DROP TABLE IF EXISTS `gm_surveys`;
CREATE TABLE `gm_surveys` (
  `surveyid` int(10) NOT NULL auto_increment,
  `player` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `mainSurvey` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `overall_comment` longtext NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`surveyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
 
ALTER TABLE `gm_tickets` ADD COLUMN `completed` int(11) NOT NULL DEFAULT '0' AFTER `comment`;
ALTER TABLE `gm_tickets` ADD COLUMN `escalated` int(11) NOT NULL DEFAULT '0' AFTER `completed`;
ALTER TABLE `gm_tickets` ADD COLUMN `viewed` int(11) NOT NULL DEFAULT '0' AFTER `escalated`;
 
DROP TABLE IF EXISTS `lag_reports`;
CREATE TABLE `lag_reports` (
  `report_id` int(10) NOT NULL auto_increment,
  `player` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `lag_type` int(10) NOT NULL DEFAULT '0',
  `map` int(11) NOT NULL DEFAULT '0',
  `posX` float NOT NULL default '0',
  `posY` float NOT NULL default '0',
  `posZ` float NOT NULL default '0',
  PRIMARY KEY  (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
-- Table structure for table `character_arena_stats`
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
-- Set the correct engine
ALTER TABLE `bugreport` ENGINE=InnoDB;
ALTER TABLE `channels` ENGINE=InnoDB;
-- 9716
DROP TABLE `auctionhousebot`;
-- 9758
ALTER TABLE `game_event_save` ADD `next_start_timestamp` BIGINT(11) UNSIGNED NOT NULL DEFAULT '0';
UPDATE `game_event_save` SET `next_start_timestamp` = UNIX_TIMESTAMP(`next_start`);
ALTER TABLE `game_event_save` DROP `next_start`;
ALTER TABLE `game_event_save` CHANGE `next_start_timestamp` `next_start` BIGINT(11) UNSIGNED NOT NULL DEFAULT '0';
-- 9792
ALTER TABLE `instance_reset` ADD INDEX ( `difficulty` );
ALTER TABLE `groups` ADD INDEX ( `leaderGuid` );
ALTER TABLE `instance` ADD INDEX ( `difficulty` );
-- 9856
ALTER TABLE `group_member` ADD `roles` smallint(6) unsigned NOT NULL default '0';
-- 9911
ALTER TABLE `guild_bank_eventlog` CHANGE `ItemStackCount` `ItemStackCount` SMALLINT(4) UNSIGNED DEFAULT '0' NOT NULL;
-- 9920
DROP TABLE IF EXISTS `pool_quest_save`;
CREATE TABLE `pool_quest_save` (
  `pool_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 10000
DROP TABLE IF EXISTS `character_banned`;
CREATE TABLE `character_banned` (
  `guid` int(11) NOT NULL default '0' COMMENT 'Account id',
  `bandate` bigint(40) NOT NULL default '0',
  `unbandate` bigint(40) NOT NULL default '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`guid`,`bandate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ban List';
-- 10030
DROP TABLE IF EXISTS `item_soulbound_trade_data`;
CREATE TABLE `item_soulbound_trade_data` (
  `itemGuid` int(11) unsigned NOT NULL COMMENT 'Item GUID',
  `allowedPlayers` text NOT NULL COMMENT 'Space separated GUID list of players who can receive this item in trade',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Item Refund System';
-- 10084
UPDATE `character_queststatus` SET `itemcount1` = 0 WHERE `itemcount1` > 65535;
UPDATE `character_queststatus` SET `itemcount2` = 0 WHERE `itemcount2` > 65535;
UPDATE `character_queststatus` SET `itemcount3` = 0 WHERE `itemcount3` > 65535;
UPDATE `character_queststatus` SET `itemcount4` = 0 WHERE `itemcount4` > 65535;

ALTER TABLE `character_queststatus` CHANGE `status` `status` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `mobcount1` `mobcount1` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `mobcount2` `mobcount2` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `mobcount3` `mobcount3` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `mobcount4` `mobcount4` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `itemcount1` `itemcount1` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `itemcount2` `itemcount2` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `itemcount3` `itemcount3` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0,
CHANGE `itemcount4` `itemcount4` SMALLINT( 3 ) UNSIGNED NOT NULL DEFAULT 0;

-- -------------------------------------------------------------------------
-- --------------------------- MythCore UPDATE -----------------------------
-- -------------------------------------------------------------------------
-- Wintergrasp
DROP TABLE IF EXISTS `worldstates`;
DROP TABLE IF EXISTS `battlefield`;
CREATE TABLE `battlefield`(
   `id` INT NOT NULL AUTO_INCREMENT,
   `Timer` INT DEFAULT '60000',
   `Wartime` BOOLEAN DEFAULT '0',
   `DefenderTeam` INT DEFAULT '0',
   PRIMARY KEY (`id`)
);
