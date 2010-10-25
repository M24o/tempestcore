-- 9671
-- Unstable Affliction / Immolate stacking from same caster
DELETE FROM `spell_group` where `id`=1112;
INSERT INTO spell_group (id, spell_id) VALUES
(1112, 348),
(1112, 30108);
-- Unstable Affliction / Immolate stacking from same caster
DELETE FROM `spell_group_stack_rules` where `group_id`=1112;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES (1112, 2);

-- 9681
DELETE FROM `spell_proc_event` WHERE `entry` in (30293,30295,30296);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
( 30293, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0),
( 30295, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0),
( 30296, 0x00,   5, 0x00000381, 0x008200C0, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0);

-- 9692
DELETE FROM `spell_proc_event` WHERE entry IN (70652,70756);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
( 70652, 0x00,  15, 0x00000008, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 Tank 4P Bonus
( 70756, 0x00,  10, 0x00200000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0); -- Item - Paladin T10 Holy 4P Bonus

-- 9695
DELETE FROM `spell_proc_event` WHERE entry IN (70656);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
( 70656, 0x00,  15, 0x00000000, 0x00000000, 0x00000000, 0x00014000, 0x00000000,   0,   0,   0); -- Item - Death Knight T10 Melee 4P Bonus

-- 9700
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12977,12967,12986,12982) AND `type` IN (0,11);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12977,11,0,0, 'achievement_flu_shot_shortage'),
(12967,11,0,0, 'achievement_flu_shot_shortage'),
(12986,11,0,0, 'achievement_flu_shot_shortage'),
(12982,11,0,0, 'achievement_flu_shot_shortage');

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631090 AND -1631078;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36626,-1631078, 'NOOOO! You kill Stinky! You pay!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16907,1,0,0, 'SAY_STINKY_DEAD'),
(36626,-1631079, 'Fun time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16901,1,0,0, 'SAY_AGGRO'),
(36678,-1631080, 'Just an ordinary gas cloud. But watch out, because that''s no ordinary gas cloud!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17119,1,0,432, 'SAY_GASEOUS_BLIGHT'),
(36626,-1631081, 'Festergut farts.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16911,2,0,0, 'EMOTE_GAS_SPORE'),
(36626,-1631082, 'Festergut releases Gas Spores!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'EMOTE_WARN_GAS_SPORE'),
(36626,-1631083, 'Gyah! Uhhh, I not feel so good...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16906,1,0,0, 'SAY_PUNGENT_BLIGHT'),
(36626,-1631084, 'Festergut begins to cast |cFFFF7F00Pungent Blight!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'EMOTE_WARN_PUNGENT_BLIGHT'),
(36626,-1631085, 'Festergut vomits.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'EMOTE_PUNGENT_BLIGHT'),
(36626,-1631086, 'Daddy, I did it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16902,1,0,0, 'SAY_KILL_1'),
(36626,-1631087, 'Dead, dead, dead!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16903,1,0,0, 'SAY_KILL_2'),
(36626,-1631088, 'Fun time over!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16905,1,0,0, 'SAY_BERSERK'),
(36626,-1631089, 'Da ... Ddy...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16904,1,0,0, 'SAY_DEATH'),
(36678,-1631090, 'Oh, Festergut. You were always my favorite. Next to Rotface. The good news is you left behind so much gas, I can practically taste it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17124,1,0,0, 'SAY_FESTERGUT_DEATH');

UPDATE `creature_template` SET `ScriptName`='boss_festergut' WHERE `entry`=36626;
UPDATE `creature_template` SET `ScriptName`='npc_stinky_icc' WHERE `entry`=37025;
UPDATE `creature_template` SET `ScriptName`='boss_professor_putricide' WHERE `entry`=36678;

DELETE FROM `spell_script_names` WHERE `spell_id`=73032 AND `ScriptName`='spell_stinky_precious_decimate';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (73032,73031,71219,69195) AND `ScriptName`='spell_festergut_pungent_blight';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (72219,72551,72552,72553) AND `ScriptName`='spell_festergut_gastric_bloat';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (69290,71222,73033,73034) AND `ScriptName`='spell_festergut_blighted_spores';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(71123,'spell_stinky_precious_decimate'),
(73032,'spell_festergut_pungent_blight'),
(73031,'spell_festergut_pungent_blight'),
(71219,'spell_festergut_pungent_blight'),
(69195,'spell_festergut_pungent_blight'),
(72219,'spell_festergut_gastric_bloat'),
(72551,'spell_festergut_gastric_bloat'),
(72552,'spell_festergut_gastric_bloat'),
(72553,'spell_festergut_gastric_bloat'),
(69290,'spell_festergut_blighted_spores'),
(71222,'spell_festergut_blighted_spores'),
(73033,'spell_festergut_blighted_spores'),
(73034,'spell_festergut_blighted_spores');

DELETE FROM `vehicle_accessory` WHERE `entry`=36678;
INSERT INTO `vehicle_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(36678,38309,0,1, 'Professor Putricide - trigger'),
(36678,38308,1,1, 'Professor Putricide - trigger');

-- 9701
DELETE FROM `spell_bonus_data` WHERE `entry` IN (48568,48567,33745);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(48568,0,0,0,0.01,'Druid - Lacerate Rank 3($AP*0.05/number of ticks)'),
(48567,0,0,0,0.01,'Druid - Lacerate Rank 2($AP*0.05/number of ticks)'),
(33745,0,0,0,0.01,'Druid - Lacerate Rank 1($AP*0.05/number of ticks)');

-- 9702
DELETE FROM `playercreateinfo_spell` WHERE `Spell`=75445;
INSERT INTO `playercreateinfo_spell` VALUES (0, 9, 75445, 'Demonic Immolate');

-- 9708
-- Set the correct engine
ALTER TABLE `spell_group_stack_rules` ENGINE=MyISAM;
ALTER TABLE `creature_classlevelstats` ENGINE=MyISAM;
ALTER TABLE `season_linked_event` ENGINE=MyISAM;
-- Set the correct engine
ALTER TABLE `bugreport` ENGINE=InnoDB;
ALTER TABLE `channels` ENGINE=InnoDB;

-- 9709
ALTER TABLE `creature_respawn` ENGINE = InnoDB;

-- 8371
DELETE FROM `spell_bonus_data` WHERE `entry` IN (56131,56160,52752,55533);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(56131, 0, 0, 0, 0, 'Priest - Glyph of Dispel Magic'),
(56160, 0, 0, 0, 0, 'Priest - Glyph of Power Word: Shield'),
(52752, 0, 0, 0, 0, 'Ancestral Awakening'),
(55533, 0, 0, 0, 0, 'Shaman - Glyph of Healing Wave');

-- 9712
-- Battle Shout
DELETE FROM `spell_threat` WHERE `entry` IN (6673,5242,6192,11549,11550,11551,2048,47436);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(6673,1), 	-- Rank 1
(5242,12),	-- Rank 2
(6192,22),	-- Rank 3
(11549,32), 	-- Rank 4
(11550,42), 	-- Rank 5
(11551,52), 	-- Rank 6 , Rank 7 already in tdb
(2048,69),	-- Rank 8
(47436,78);	-- Rank 9

-- Cleave
DELETE FROM `spell_threat` WHERE `entry` IN (47519,47520);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47519,175),  -- Rank 7
(47520,225);   -- Rank 8

-- Commanding Shout
DELETE FROM `spell_threat` WHERE `entry` IN (469,47439,47440);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(469,68), 	-- Rank 1
(47439,77), 	-- Rank 2
(47440,80);	-- Rank 3

-- Demoralizing Shout
DELETE FROM `spell_threat` WHERE `entry` IN (25202,25203,47437);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(25202,49),   -- Rank 6
(25203,56),   -- Rank 7
(47437,63);   -- Rank 8

-- Devastate
DELETE FROM `spell_threat` WHERE `entry` IN (47497,47498);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47497,101),  -- Rank 4
(47498,101);   -- Rank 5

-- Heroic Strike
DELETE FROM `spell_threat` WHERE `entry` IN (47449,47450);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47449,233),  -- Rank 12
(47450,259);  -- Rank 13

-- Revenge
DELETE FROM `spell_threat` WHERE `entry` IN (57823);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(57823,530);   -- Rank 9

-- Improved Revenge (Talented)
DELETE FROM `spell_threat` WHERE `entry` IN (12797,12799);
 INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(12797,25),   -- Rank 1
(12799,25);    -- Rank 2

-- Shield Bash
DELETE FROM `spell_threat` WHERE `entry`=72;
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(72,36);

-- Shield Slam
DELETE FROM `spell_threat` WHERE `entry` IN (47487,47488);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47487,546),    -- Rank 7
(47488,770); 	-- Rank 8

-- Sunder Armor (rank 7)
DELETE FROM `spell_threat` WHERE `entry`=47467;
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47467,345);

-- Thunder Clap
DELETE FROM `spell_threat` WHERE `entry` IN (47501,47502);
INSERT INTO `spell_threat`(`entry`,`Threat`) VALUES
(47501,457), -- Rank 8
(47502,555);  -- Rank 9

-- 9713
DELETE FROM `spell_bonus_data` WHERE `entry` IN (56161);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(56161, 0, 0, 0, 0, 'Priest - Glyph of Prayer of Healing');

-- 9715
DELETE FROM `spell_proc_event` WHERE `entry` IN (51692, 51696);
INSERT INTO `spell_proc_event` VALUES 
( 51692, 0x00,   8, 0x00000204, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Waylay (Rank 1)
( 51696, 0x00,   8, 0x00000204, 0x00000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0); -- Waylay (Rank 2)

-- 9722
-- Base XP for Levels 71 to 79
DELETE FROM `exploration_basexp` WHERE `level` IN (71,72,73,74,75,76,77,78,79);
INSERT INTO `exploration_basexp` (`level`,`basexp`) VALUES 
(71,1330),
(72,1370),
(73,1410),
(74,1440),
(75,1470),
(76,1510),
(77,1530),
(78,1600),
(79,1630);

-- 9743
DELETE FROM `command` WHERE `name` IN ('reload lfg_dungeon_encounters','reload lfg_dungeon_rewards');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('reload lfg_dungeon_encounters',3,'Syntax: .reload lfg_dungeon_encounters\nReload lfg_dungeon_encounters table.'),
('reload lfg_dungeon_rewards',3,'Syntax: .reload lfg_dungeon_rewards\nReload lfg_dungeon_rewards table.');

DROP TABLE IF EXISTS `lfg_dungeon_encounters`;
CREATE TABLE `lfg_dungeon_encounters` (
  `achievementId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Achievement marking final boss completion',
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  PRIMARY KEY (`achievementId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `lfg_dungeon_rewards`;
CREATE TABLE `lfg_dungeon_rewards` (
  `dungeonId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  `maxLevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Max level at which this reward is rewarded',
  `firstQuestId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for first dungeon this day',
  `firstMoneyVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Money multiplier for completing the dungeon first time in a day with less players than max',
  `firstXPVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Experience multiplier for completing the dungeon first time in a day with less players than max',
  `otherQuestId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for Nth dungeon this day',
  `otherMoneyVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Money multiplier for completing the dungeon Nth time in a day with less players than max',
  `otherXPVar` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Experience multiplier for completing the dungeon Nth time in a day with less players than max',
  PRIMARY KEY (`dungeonId`,`maxLevel`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;