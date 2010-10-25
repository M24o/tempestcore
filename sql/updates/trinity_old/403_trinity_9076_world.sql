
-- 9000
DELETE FROM spell_bonus_data WHERE entry IN (15407,58381);
INSERT INTO spell_bonus_data VALUES (58381,0.257,-1,-1,-1,'Priest - Mind Flay');

-- 9006
UPDATE `spell_group` SET `spell_id` = 46856 WHERE `id` = 1032;

-- 9008
DELETE FROM `trinity_string` WHERE (`entry`='5028');
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('5028', 'Lootid: %u');

-- 9010
ALTER TABLE `spell_scripts` ADD COLUMN `effIndex` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `id`;

-- 9012
DROP TABLE IF EXISTS `spell_script_names`;
CREATE TABLE `spell_script_names` (
  `spell_id` int(11) NOT NULL,
  `ScriptName` char(64) NOT NULL,
  UNIQUE (`spell_id`, `ScriptName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 9026
-- script texts
DELETE FROM `script_texts` WHERE `npc_entry` IN (7607,7604);
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(7607,-1209000,'Oh no! Here they come!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0,'Weegli Blastfuse SAY_WEEGLI_OHNO'),
(7607,-1209001,'OK. Here I go.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0,'Weegli Blastfuse SAY_WEEGLI_OK_I_GO'),
(7604,-1209002,'Placeholder 1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0,'Sergeant Bly SAY_1'),
(7604,-1209003,'Placeholder 2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0,'Sergeant Bly SAY_2');
-- script names
UPDATE `gameobject_template` SET `scriptName`='go_troll_cage' WHERE `entry`>=141070 AND `entry`<141075;

-- 9036
DROP TABLE IF EXISTS `reputation_reward_rate`;
CREATE TABLE `reputation_reward_rate` (
  `faction` mediumint(8) unsigned NOT NULL default '0',
  `quest_rate` float NOT NULL default '1',
  `creature_rate` float NOT NULL default '1',
  `spell_rate` float NOT NULL default '1',
  PRIMARY KEY  (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 9039
DROP TABLE IF EXISTS `reputation_spillover_template`;
CREATE TABLE `reputation_spillover_template` (
  `faction` smallint(6) unsigned NOT NULL default '0' COMMENT 'faction entry',
  `faction1` smallint(6) unsigned NOT NULL default '0' COMMENT 'faction to give spillover for',
  `rate_1` float NOT NULL default '0' COMMENT 'the given rep points * rate',
  `rank_1` tinyint(3) unsigned NOT NULL default '0' COMMENT 'max rank, above this will not give any spillover',
  `faction2` smallint(6) unsigned NOT NULL default '0',
  `rate_2` float NOT NULL default '0',
  `rank_2` tinyint(3) unsigned NOT NULL default '0',
  `faction3` smallint(6) unsigned NOT NULL default '0',
  `rate_3` float NOT NULL default '0',
  `rank_3` tinyint(3) unsigned NOT NULL default '0',
  `faction4` smallint(6) unsigned NOT NULL default '0',
  `rate_4` float NOT NULL default '0',
  `rank_4` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`faction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Reputation spillover reputation gain';

-- 9043
DELETE FROM `spell_script_names` WHERE `spell_id`=11958 AND `ScriptName`='spell_mage_cold_snap';
DELETE FROM `spell_script_names` WHERE `spell_id`=32826 AND `ScriptName`='spell_mage_polymorph_visual';
DELETE FROM `spell_script_names` WHERE `spell_id`=31687 AND `ScriptName`='spell_mage_summon_water_elemental';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(11958,'spell_mage_cold_snap'),
(32826,'spell_mage_polymorph_visual'),
(31687,'spell_mage_summon_water_elemental');

-- 9058
DELETE FROM `spell_script_names` WHERE `spell_id`=-47540 AND `ScriptName`='spell_pri_penance';
DELETE FROM `spell_script_names` WHERE `spell_id`=31231 AND `ScriptName`='spell_rog_cheat_death';
DELETE FROM `spell_script_names` WHERE `spell_id`=51662 AND `ScriptName`='spell_rog_hunger_for_blood';
DELETE FROM `spell_script_names` WHERE `spell_id`=14185 AND `ScriptName`='spell_rog_preparation';
DELETE FROM `spell_script_names` WHERE `spell_id`=5938 AND `ScriptName`='spell_rog_shiv';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-47540,'spell_pri_penance'),
(31231,'spell_rog_cheat_death'),
(51662,'spell_rog_hunger_for_blood'),
(14185,'spell_rog_preparation'),
(5938,'spell_rog_shiv');

-- 9059
DELETE FROM `spell_script_names` WHERE `spell_id`=53271 AND `ScriptName`='spell_hun_masters_call';
DELETE FROM `spell_script_names` WHERE `spell_id`=53478 AND `ScriptName`='spell_hun_last_stand_pet';
DELETE FROM `spell_script_names` WHERE `spell_id`=23989 AND `ScriptName`='spell_hun_readiness';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(53271,'spell_hun_masters_call'),
(53478,'spell_hun_last_stand_pet'),
(23989,'spell_hun_readiness');

-- 9063
DELETE FROM `spell_bonus_data` WHERE `entry`=33778;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(33778,0.589714,0,0,0, 'Druid - Lifebloom final heal');

-- 9070
UPDATE creature_template SET scriptname = 'npc_roxi_ramrocket' WHERE entry = 31247;

