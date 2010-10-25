-- 9205
DELETE FROM `spell_script_names` WHERE `spell_id`=58601 AND `ScriptName`='spell_gen_remove_flight_auras';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(58601, 'spell_gen_remove_flight_auras');

-- 9213
DELETE FROM `spell_script_names` WHERE `spell_id`=21977 AND `ScriptName`='spell_warr_warriors_wrath';

-- 9237
ALTER TABLE `achievement_criteria_data` ADD `ScriptName` char(64) NOT NULL DEFAULT '' AFTER `value2`;

UPDATE `battleground_template` SET `Comment`= 'Alterac Valley' WHERE `battleground_template`.`id`=1;
UPDATE `battleground_template` SET `Comment`= 'Warsong Gulch' WHERE `battleground_template`.`id`=2;
UPDATE `battleground_template` SET `Comment`= 'Arathi Basin' WHERE `battleground_template`.`id`=3;
UPDATE `battleground_template` SET `Comment`= 'Nagrand Arena' WHERE `battleground_template`.`id`=4;
UPDATE `battleground_template` SET `Comment`= 'Blades''s Edge Arena' WHERE `battleground_template`.`id`=5;
UPDATE `battleground_template` SET `Comment`= 'All Arena' WHERE `battleground_template`.`id`=6;
UPDATE `battleground_template` SET `Comment`= 'Eye of The Storm' WHERE `battleground_template`.`id`=7;
UPDATE `battleground_template` SET `Comment`= 'Ruins of Lordaeron' WHERE `battleground_template`.`id`=8;
UPDATE `battleground_template` SET `Comment`= 'Strand of the Ancients' WHERE `battleground_template`.`id`=9;
UPDATE `battleground_template` SET `Comment`= 'Dalaran Sewers' WHERE `battleground_template`.`id`=10;
UPDATE `battleground_template` SET `Comment`= 'The Ring of Valor' WHERE `battleground_template`.`id`=11;
UPDATE `battleground_template` SET `Comment`= 'Isle of Conquest' WHERE `battleground_template`.`id`=30;
UPDATE `battleground_template` SET `Comment`= 'Random battleground' WHERE `battleground_template`.`id`=32;

DELETE FROM `outdoorpvp_template` WHERE `TypeId` IN (1,2,3,4,5,6);
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `Comment`) VALUES
(1, 'outdoorpvp_hp', 'Hellfire Peninsula'),
(2, 'outdoorpvp_na', 'Nagrand'),
(3, 'outdoorpvp_tf', 'Terokkar Forest'),
(4, 'outdoorpvp_zm', 'Zangarmarsh'),
(5, 'outdoorpvp_si', 'Silithus'),
(6, 'outdoorpvp_ep', 'Eastern Plaguelands');

-- 9240
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (3693,6641,6642,6643,6644) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(3693,11,0,0, 'achievement_storm_glory'),
(6641,11,0,0, 'achievement_school_of_hard_knocks'),
(6642,11,0,0, 'achievement_school_of_hard_knocks'),
(6643,11,0,0, 'achievement_school_of_hard_knocks'),
(6644,11,0,0, 'achievement_school_of_hard_knocks');

-- 9246
-- Remove by script name in case someone ever applied these names to other stuff
UPDATE `instance_template` SET `script`='' WHERE `script`='instance_blackrock_spire';
UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_rookey_whelp';
UPDATE `gameobject_template` SET `ScriptName`='' WHERE `ScriptName`='go_rookey_egg';

-- 9290
-- Intravenous Healing Potion Fix
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=61263;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES (61263,61267,0, 'Intravenous Healing Effect' );
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES (61263,61268,0, 'Intravenous Mana Regeneration Effect' );

-- 9332
DELETE FROM `spell_proc_event` WHERE `entry` IN (71642,71611,71640,71634,71645,71602,71606,71637,71540,71402,72417,72413,72419);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(71642,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Althor's Abacus (Heroic)
(71611,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Althor's Abacus
(71640,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,30), -- Corpse Tongue Coin (Heroic)
(71634,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,30), -- Corpse Tongue Coin
(71645,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Dislodged Foreign Object (Heroic)
(71602,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Dislodged Foreign Object
(71606,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,100), -- Phylactery of the Nameless Lich
(71637,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,100), -- Phylactery of the Nameless Lich (Heroic)
(71540,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Whispering Fanged Skull (Heroic)
(71402,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,45), -- Whispering Fanged Skull
(72417,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,60), -- Item - Icecrown Reputation Ring Caster Trigger
(72413,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,60), -- Item - Icecrown Reputation Ring Melee
(72419,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,60); -- Item - Icecrown Reputation Ring Healer Trigger

-- 9377
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (3804,3805,3806,3807,3808,3809,3810,3811,3812,3813,1234,1239,5605,5606) AND `type` IN (0,11);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(3804,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3805,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3806,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3807,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3808,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3809,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3810,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3811,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3812,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(3813,11,0,0, 'achievement_resilient_victory'), -- Resilient Victory
(1234,11,0,0, 'achievement_bg_control_all_nodes'), -- Territorial Dominance
(1239,11,0,0, 'achievement_bg_control_all_nodes'), -- Eye of the Storm Domination
(5605,11,0,0, 'achievement_save_the_day'), -- Save the Day
(5606,11,0,0, 'achievement_save_the_day'); -- Save the Day

