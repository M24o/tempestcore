-- 9144
DELETE FROM `spell_script_names` WHERE `spell_id`=21977 AND `ScriptName`='spell_warr_warriors_wrath';
DELETE FROM `spell_script_names` WHERE `spell_id`=12975 AND `ScriptName`='spell_warr_last_stand';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(12975,'spell_warr_last_stand'),
(21977,'spell_warr_warriors_wrath');

-- 9148
DELETE FROM `spell_bonus_data` WHERE `entry` IN (703);
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(703, -1, -1, -1, 0.07, 'Rogue - Garrote');

-- 9149
DELETE FROM `spell_script_names` WHERE `spell_id`=55709 AND `ScriptName`='spell_hun_pet_heart_of_the_phoenix';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(55709, 'spell_hun_pet_heart_of_the_phoenix');

-- 9162
DELETE FROM `spell_script_names` WHERE `spell_id`=54044 AND `ScriptName`='spell_hun_pet_carrion_feeder';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(54044, 'spell_hun_pet_carrion_feeder');

-- 9166
DELETE FROM `spell_proc_event` WHERE `entry` IN (53178,53179,62764,62765);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(53178,0x00,9,0x00000000,0x10000000,0x00000000,0x00000000,0x00000000,0,100,0), -- GuardDog(Rank1)
(53179,0x00,9,0x00000000,0x10000000,0x00000000,0x00000000,0x00000000,0,100,0), -- GuardDog(Rank2)
(62764,0x00,9,0x00000000,0x10000000,0x00000000,0x00000000,0x00000000,0,100,0), -- Silverback(Rank1)
(62765,0x00,9,0x00000000,0x10000000,0x00000000,0x00000000,0x00000000,0,100,0); -- Silverback(Rank2)

-- 9176
UPDATE `spell_proc_event` SET `procFlags`=0x10000 WHERE `entry` IN (53178,53179,62764,62765);

-- 9189
ALTER TABLE `transports` ADD `ScriptName` char(64) NOT NULL DEFAULT '' AFTER `period`;

-- 9191
ALTER TABLE `instance_template` DROP `access_id`;

-- 9193
ALTER TABLE `battleground_template` ADD `ScriptName` char(64) NOT NULL DEFAULT '' AFTER `Weight`;
