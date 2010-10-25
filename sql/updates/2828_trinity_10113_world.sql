-- 10023
DELETE FROM `command` WHERE `name` IN ('achievement add', 'achievement');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('achievement add',4,'Syntax: .achievement add $achievement\nAdd an achievement to the targeted player.\n$achievement: can be either achievement id or achievement link'),
('achievement',4,'Syntax: .achievement $subcommand\nType .achievement to see the list of possible subcommands or .help achievement $subcommand to see info on subcommands');
-- 10060
DROP TABLE IF EXISTS `creature_text`;
CREATE TABLE `creature_text` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `text` longtext,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `probability` float NOT NULL DEFAULT '0',
  `emote` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `duration` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `sound` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) DEFAULT '',
  PRIMARY KEY (`entry`,`groupid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 10076
DELETE FROM `command` WHERE `name` LIKE 'reload creature_text';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('reload creature_text',3,'Syntax: .reload creature_text\r\nReload creature_text table.');
-- 10078
DELETE FROM `spell_proc_event` WHERE `entry` IN (16176,16235,16240);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(16176,0x00,11,0x000001C0,0x00000000,0x00000010,0x00000000,0x00000002,0,0,0), -- Ancestral Healing (Rank 1)
(16235,0x00,11,0x000001C0,0x00000000,0x00000010,0x00000000,0x00000002,0,0,0), -- Ancestral Healing (Rank 2)
(16240,0x00,11,0x000001C0,0x00000000,0x00000010,0x00000000,0x00000002,0,0,0); -- Ancestral Healing (Rank 3)
-- 10083
UPDATE `trinity_string` SET `content_default` = '%d (Entry: %d) - |cffffffff|Hgameobject:%d|h[%s X:%f Y:%f Z:%f MapId:%d]|h|r ' WHERE `entry` = 517;
-- 10091
DELETE FROM `spell_proc_event` WHERE `entry` IN (60503, 68051, 52437, 74396);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(60503, 0x01, 4, 0x00000004, 0x00000000, 0x00000000, 0x00000010, 0x00000000, 0, 0, 0),
(68051, 0x01, 4, 0x00000004, 0x00000000, 0x00000000, 0x00000010, 0x00000000, 0, 0, 0),
(52437, 0x01, 4, 0x20000000, 0x00000000, 0x00000000, 0x00000010, 0x00000000, 0, 0, 0),
(74396, 0x10, 3, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000003, 0, 0, 0);
-- 10099
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-11113) AND `ScriptName` = 'spell_mage_blast_wave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-11113,'spell_mage_blast_wave');
-- 10113
-- Allow any mage spell to drop Fingers of Frost charge
UPDATE `spell_proc_event` SET `SchoolMask` = 0x54, `SpellFamilyMask0` = 0x28E212F7, `SpellFamilyMask1` = 0x00119048 WHERE `entry` = 74396;
-- Let Nature's Grace proc only from non-periodic magic spells
UPDATE `spell_proc_event` SET `SchoolMask` = 0x48, `SpellFamilyName` = 7, `SpellFamilyMask0` = 0x00000067, `SpellFamilyMask1` = 0x03800002 WHERE `entry` IN (16880, 61345, 61346);
