-- 9108
ALTER TABLE `battleground_template` ADD `Comment` CHAR(32) NOT NULL ;

-- 9109
CREATE TABLE IF NOT EXISTS `creature_transport` (
  `guid` int(16) NOT NULL AUTO_INCREMENT COMMENT 'GUID of NPC on transport - not the same as creature.guid',
  `transport_entry` int(8) NOT NULL COMMENT 'Transport entry',
  `npc_entry` int(8) NOT NULL COMMENT 'NPC entry',
  `TransOffsetX` float NOT NULL DEFAULT '0',
  `TransOffsetY` float NOT NULL DEFAULT '0',
  `TransOffsetZ` float NOT NULL DEFAULT '0',
  `TransOffsetO` float NOT NULL DEFAULT '0',
  `emote` int(16) NOT NULL,
  PRIMARY KEY (`transport_entry`,`guid`),
  UNIQUE KEY `entry` (`transport_entry`,`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 9120
DELETE FROM `spell_proc_event` WHERE `entry` IN (51459,51462,51463,51464,51465,49219,49627,49628);
INSERT INTO `spell_proc_event`(`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(51459,0,0,0,0,0,4,0,0,0,0), -- Necrosis Rank 1
(51462,0,0,0,0,0,4,0,0,0,0), -- Necrosis Rank 2
(51463,0,0,0,0,0,4,0,0,0,0), -- Necrosis Rank 3
(51464,0,0,0,0,0,4,0,0,0,0), -- Necrosis Rank 4
(51465,0,0,0,0,0,4,0,0,0,0), -- Necrosis Rank 5
(49219,0,0,0,0,0,4,0,0,0,0), -- Blood-Caked Blade Rank 1
(49627,0,0,0,0,0,4,0,0,0,0), -- Blood-Caked Blade Rank 2
(49628,0,0,0,0,0,4,0,0,0,0); -- Blood-Caked Blade Rank 3

-- 9122
DELETE FROM `spell_script_names` WHERE `spell_id`=37877 AND `ScriptName`='spell_pal_blessing_of_faith';
DELETE FROM `spell_script_names` WHERE `spell_id`=-20473 AND `ScriptName`='spell_pal_holy_shock';
DELETE FROM `spell_script_names` WHERE `spell_id`=20425 AND `ScriptName`='spell_pal_judgement_of_command';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(37877,'spell_pal_blessing_of_faith'),
(-20473,'spell_pal_holy_shock'),
(20425,'spell_pal_judgement_of_command');

-- 9123
DELETE FROM `spell_proc_event` WHERE `entry` IN (56342,56343,56344);
INSERT INTO `spell_proc_event`(`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
( 56342, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22), -- Lock and Load
( 56343, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22), -- Lock and Load
( 56344, 0x00,   9, 0x00000018, 0x08000000, 0x00024000, 0x00000000, 0x00000000,   0,   0,  22); -- Lock and Load

-- 9124
DELETE FROM `spell_proc_event` WHERE `entry` IN (12322,12999,13000,13001,13002);
INSERT INTO `spell_proc_event`(`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
( 12322, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   3,   0,   0), -- Unbridled Wrath (Rank 1)
( 12999, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   6,   0,   0), -- Unbridled Wrath (Rank 2)
( 13000, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   9,   0,   0), -- Unbridled Wrath (Rank 3)
( 13001, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  12,   0,   0), -- Unbridled Wrath (Rank 4)
( 13002, 0x00,   0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,  15,   0,   0); -- Unbridled Wrath (Rank 5)

-- 9130
DELETE FROM `spell_bonus_data` WHERE `entry` IN(10444);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(10444, 0, 0, 0, 0, 'Shaman - Flametongue Trigger');

-- 9131
DELETE FROM spell_ranks WHERE `spell_id` IN (52987, 52988);
INSERT INTO spell_ranks (`first_spell_id`, `spell_id`, `rank`) VALUES
(47757, 52987, 3),
(47757, 52988, 4);

-- RE-FIXED
-- 9026
-- script texts
DELETE FROM `script_texts` WHERE `npc_entry` IN (7607,7604);
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(7607,-1209000, 'Oh no! Here they come!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0, 'Weegli Blastfuse SAY_WEEGLI_OHNO'),
(7607,-1209001, 'OK. Here I go.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0 ,'Weegli Blastfuse SAY_WEEGLI_OK_I_GO'),
(7604,-1209002, 'Placeholder 1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0, 'Sergeant Bly SAY_1'),
(7604,-1209003, 'Placeholder 2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,0, 'Sergeant Bly SAY_2');

-- 9135
ALTER TABLE `battleground_template` ADD `Weight` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 AFTER `HordeStartO`;

-- 9136
DELETE FROM `trinity_string` WHERE `entry`=1130;
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(1130, 'Can''t dump deleted characters, aborting.');