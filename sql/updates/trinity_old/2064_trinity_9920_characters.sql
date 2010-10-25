-- 9911
ALTER TABLE `guild_bank_eventlog` CHANGE `ItemStackCount` `ItemStackCount` SMALLINT(4) UNSIGNED DEFAULT '0' NOT NULL;
-- 9920
DROP TABLE IF EXISTS `pool_quest_save`;
CREATE TABLE `pool_quest_save` (
  `pool_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
