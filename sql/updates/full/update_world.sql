-- -------------------------------------------------------------------------
-- ------------------------- Myth Project UPDATE ---------------------------
-- -------------------------------------------------------------------------
-- THIS IS UPDATE FOR "WORLD" Database.
-- NOTE: This Update pack is optimized for MDB.
-- HOW TO USE:
-- 1) Create database for WORLD database 
-- 2) Download last MDB from our DB repository and install it, in to WORLD database.
-- 3) ONLY WHEN LAST MDB FROM OUR REPOSITORY IS INSTALLED, Apply this UPDATE PACK.
-- 4) If you have StartUP errors, Please do that:
--    3.1) Host them in to text hosts. (for example http://paste2.org/new-paste)
--    3.2) Please post them in our forum, don`t forget link of your error logs. 
--    3.3) DON`T CREATE DUBLICATE ISSUES!!!
-- 4) If you have some fixes, please post it in issue tracker too.
-- 5) Thanks you for visit MythProject.
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- ------------------------ TrinityCore UPDATES ----------------------------
-- -------------------------------------------------------------------------
-- NOTE: put in comments updates which are not needed ( /* text */) or -- text
-- OPTIMIZED FOR MYTDB DB Last revisions.
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

-- -------------------------------------------------------------------------
-- --------------------------- Vault Of Archavon ---------------------------
-- -------------------------------------------------------------------------
-- Fix From Forum
-- Author: Andrea
DELETE FROM creature WHERE id=33998;
-- -----------------------------------------------------------------------------------------------
-- --------------------------------------------- Nexus -------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- THIS SQL CONTAIN ALL NEXUS SQL NEEDED DATA FOR MYTH CORE.
-- -------------------------------------------------------------------------
-- ---------------------------- Eye of Eternity ----------------------------
-- -------------------------------------------------------------------------
-- Set instance script
UPDATE instance_template SET script = 'instance_eye_of_eternity' WHERE map = 616;

-- Update flags for NPCs/Vehicles
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30090; -- Vortex  'Arcane Overload', 'Hover Disk');
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35, VehicleId = 165 WHERE entry IN (30234, 30248); -- Hover Disk
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35 WHERE entry = 30118; -- Portal (Malygos)
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30282; -- Arcane Overload
UPDATE creature_template SET mindmg = 1, maxdmg = 1, dmg_multiplier = 1 WHERE entry = 30592; -- Static Field
UPDATE creature_template SET modelid1 = 11686, modelid2 = 11686 WHERE entry = 22517; -- Some world trigger

-- Set scriptnames and some misc data to bosses and GOs
UPDATE gameobject_template SET flags = 4, data0 = 43 WHERE gameobject_template.entry in (193967, 193905);
UPDATE creature_template SET ScriptName = 'boss_malygos', unit_flags = unit_flags & ~256 WHERE entry = 28859;
UPDATE creature SET MovementType = 0, spawndist = 0 WHERE id = 28859; -- Malygos, don't move
UPDATE creature_template SET ScriptName = 'mob_nexus_lord' WHERE entry = 30245; -- Nexus Lord
UPDATE creature_template SET ScriptName = 'mob_scion_of_eternity' WHERE entry = 30249; -- Scion of Eternity
UPDATE creature_template SET faction_A = 14, faction_H = 14, ScriptName = 'mob_power_spark' WHERE entry = 30084; -- Power Spark
UPDATE creature_template SET faction_A = 14, faction_H = 14 WHERE entry = 32187; -- Power Spark (1)
UPDATE creature_template SET ScriptName = 'npc_arcane_overload' WHERE entry = 30282; -- Arcane Overload

-- Fix Wyrmrest drakes creature info
UPDATE creature_template SET spell1 = 56091, spell2 = 56092, spell3 = 57090, spell4 = 57143, spell5 = 57108, spell6 = 57403, VehicleId = 165 WHERE entry IN (30161, 31752);

-- Delete faulty Alextrasza spawn
DELETE FROM creature WHERE guid = 132302;
DELETE FROM creature_addon WHERE guid = 132302;

-- And Surge of Power
DELETE FROM creature WHERE guid = 132303;
DELETE FROM creature_addon WHERE guid = 132303;

-- Fix Loot caches being not selectable
UPDATE gameobject_template SET faction = 35, flags = 0 WHERE entry IN (193967, 193905);

-- Fix loot for Malygos (Alexstrasza's Gift)
DELETE FROM reference_loot_template WHERE entry IN (50008,50009);
INSERT INTO reference_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(50008, 40474, 0, 1, 1, 1, 1), -- Surge Needle Ring
(50008, 40497, 0, 1, 1, 1, 1), -- Black Ice
(50008, 40489, 0, 1, 1, 1, 1), -- Greatstaff of the Nexus
(50008, 40526, 0, 1, 1, 1, 1), -- Gown of the Spell-Weaver
(50008, 40511, 0, 1, 1, 1, 1), -- Focusing Energy Epaulets
(50008, 40475, 0, 1, 1, 1, 1), -- Barricade of Eternity
(50008, 40488, 0, 1, 1, 1, 1), -- Ice Spire Scepter
(50008, 40491, 0, 1, 1, 1, 1), -- Hailstorm
(50008, 40519, 0, 1, 1, 1, 1), -- Footsteps of Malygos
(50008, 40486, 0, 1, 1, 1, 1), -- Necklace of the Glittering Chamber
(50009, 40592, 0, 1, 1, 1, 1), -- Boots of Healing Energies
(50009, 40566, 0, 1, 1, 1, 1), -- Unravelling Strands of Sanity
(50009, 40194, 0, 1, 1, 1, 1), -- Blanketing Robes of Snow
(50009, 40543, 0, 1, 1, 1, 1), -- Blue Aspect Helm
(50009, 40590, 0, 1, 1, 1, 1), -- Elevated Lair Pauldrons
(50009, 40560, 0, 1, 1, 1, 1), -- Leggings of the Wanton Spellcaster
(50009, 40589, 0, 1, 1, 1, 1), -- Legplates of Sovereignty
(50009, 40555, 0, 1, 1, 1, 1), -- Mantle of Dissemination
(50009, 40591, 0, 1, 1, 1, 1), -- Melancholy Sabatons
(50009, 40594, 0, 1, 1, 1, 1), -- Spaulders of Catatonia
(50009, 40588, 0, 1, 1, 1, 1), -- Tunic of the Artifact Guardian
(50009, 40549, 0, 1, 1, 1, 1), -- Boots of the Renewed Flight
(50009, 40539, 0, 1, 1, 1, 1), -- Chestguard of the Recluse
(50009, 40541, 0, 1, 1, 1, 1), -- Frosted Adroit Handguards
(50009, 40562, 0, 1, 1, 1, 1), -- Hood of Rationality
(50009, 40561, 0, 1, 1, 1, 1), -- Leash of Heedless Magic
(50009, 40532, 0, 1, 1, 1, 1), -- Living Ice Crystals
(50009, 40531, 0, 1, 1, 1, 1), -- Mark of Norgannon
(50009, 40564, 0, 1, 1, 1, 1), -- Winter Spectacle Gloves
(50009, 40558, 0, 1, 1, 1, 1); -- Arcanic Tramplers

DELETE FROM gameobject_loot_template WHERE entry IN (26094, 26097);
INSERT INTO gameobject_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(26094, 47241, 	100,1,0, 		2,	2), -- Emblem of Triumph x2
(26094, 1, 		100,1,0, -50008, 	2), -- 2 items ilevel 213
(26094, 44650, 	100,1,0, 		1,	1), -- Quest item, Judgement at the Eye of Eternity
(26094, 43953, 	1, 	1,0, 		1,	1), -- Reins of the Blue Drake 	
-- End of 10m Malygos loot

(26097, 47241, 100, 1, 0, 2, 		2), -- Emblem of Triumph x2
(26097, 	1, 100, 1, 0, -50009,	4), -- 4 items ilevel 226
(26097, 44651, 100, 1, 0, 1, 		1), -- Quest item, Heroic Judgement at the Eye of Eternity
(26097, 43952, 1,	1, 0, 1, 		1); -- Reins of the Azure Drake
-- End of 25m Malygos loot

-- Fix Malygos and his adds' damage
UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 7.5, mechanic_immune_mask = 1072918979 WHERE entry = 30245; -- Nexus Lord
UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 13,  mechanic_immune_mask = 1072918979 WHERE entry = 31750; -- Nexus Lord (1)
UPDATE creature_template SET mechanic_immune_mask = 1072918979 WHERE entry IN (30249, 31751);
UPDATE creature_template SET faction_A = 14, faction_H = 14 WHERE entry IN (31750, 31751);

-- Create entry for Heroic Malygos
DELETE FROM creature_template WHERE entry = 31734;
INSERT INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, 
modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction_A, faction_H, npcflag, speed_walk, speed_run, scale, 
rank, mindmg, maxdmg, dmgschool, attackpower, dmg_multiplier, baseattacktime, rangeattacktime, unit_class, unit_flags, dynamicflags, family, 
trainer_type, trainer_spell, trainer_class, trainer_race, minrangedmg, maxrangedmg, rangedattackpower, type, type_flags, lootid, pickpocketloot, 
skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, 
spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, Health_mod, Mana_mod, Armor_mod, RacialLeader, questItem1, 
questItem2, questItem3, questItem4, questItem5, questItem6, movementId, RegenHealth, equipment_id, mechanic_immune_mask, flags_extra, ScriptName, WDBVerified) VALUES 
(31734, 0, 0, 0, 0, 0, 26752, 0, 0, 0, 'Malygos', '', '', 0, 83, 83, 2, 16, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 64, 8, 0, 0, 0, 0, 0, 365, 529, 98, 2, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 500, 50, 1, 0, 44650, 0, 0, 0, 0, 0, 227, 1, 0, 0, 1, 'boss_malygos', 1);

UPDATE creature_template SET Health_mod = 1400, questItem1 = 44651, mechanic_immune_mask = 617299803, ScriptName = '', WDBVerified = 1 WHERE entry = 31734;
UPDATE creature_template SET mindmg = 4602, maxdmg = 5502, dmg_multiplier = 7.5, difficulty_entry_1 = 31734, mechanic_immune_mask = 617299803 WHERE entry = 28859;
UPDATE creature_template SET mindmg = 4602, maxdmg = 5502, dmg_multiplier = 13 WHERE entry = 31734;
UPDATE creature_template SET flags_extra = flags_extra | 1 WHERE entry IN (28859, 31734);

-- Fix sound entries for Malygos encounter
DELETE FROM script_texts WHERE entry BETWEEN -1616034 AND -1616000;
INSERT INTO script_texts (npc_entry, entry, content_default, sound, type, language, emote, comment) VALUES
(28859, -1616000, 'Lesser beings, intruding here! A shame that your excess courage does not compensate for your stupidity!', 14512, 1, 0, 0, 'Malygos INTRO 1'),
(28859, -1616001, 'None but the blue dragonflight are welcome here! Perhaps this is the work of Alexstrasza? Well then, she has sent you to your deaths.', 14513, 1, 0, 0, 'Malygos INTRO 2'),
(28859, -1616002, 'What could you hope to accomplish, to storm brazenly into my domain? To employ MAGIC? Against ME?', 14514, 1, 0, 0, 'Malygos INTRO 3'),
(28859, -1616003, 'I am without limits here... the rules of your cherished reality do not apply... In this realm, I am in control...', 14515, 1, 0, 0, 'Malygos INTRO 4'),
(28859, -1616004, 'I give you one chance. Pledge fealty to me, and perhaps I won\'t slaughter you for your insolence!', 14516, 1, 0, 0, 'Malygos INTRO 5'),
(28859, -1616005, 'My patience has reached its limit, I WILL BE RID OF YOU!', 14517, 1, 0, 0, 'Malygos AGGRO 1'),
(28859, -1616006, 'Watch helplessly as your hopes are swept away...', 14525, 1, 0, 0, 'Malygos VORTEX'),
(28859, -1616007, 'I AM UNSTOPPABLE!', 14533, 1, 0, 0, 'Malygos SPARK BUFF'),
(28859, -1616008, 'Your stupidity has finally caught up to you!', 14519, 1, 0, 0, 'Malygos SLAY 1-1'),
(28859, -1616009, 'More artifacts to confiscate...', 14520, 1, 0, 0, 'Malygos SLAY 1-2'),
(28859, -1616010, 'How very... naive...', 14521, 1, 0, 0, 'Malygos SLAY 1-3'),
(28859, -1616012, 'I had hoped to end your lives quickly, but you have proven more...resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must...And if it means your...extinction...THEN SO BE IT!', 14522, 1, 0, 0, 'Malygos PHASEEND 1'),
(28859, -1616013, 'Few have experienced the pain I will now inflict upon you!', 14523, 1, 0, 0, 'Malygos AGGRO 2'),
(28859, -1616014, 'YOU WILL NOT SUCCEED WHILE I DRAW BREATH!', 14518, 1, 0, 0, 'Malygos DEEP BREATH'),
(28859, -1616016, 'I will teach you IGNORANT children just how little you know of magic...', 14524, 1, 0, 0, 'Malygos ARCANE OVERLOAD'),
(28859, -1616020, 'Your energy will be put to good use!', 14526, 1, 0, 0, 'Malygos SLAY 2-1'),
(28859, -1616021, 'I AM THE SPELL-WEAVER! My power is INFINITE!', 14527, 1, 0, 0, 'Malygos SLAY 2-2'),
(28859, -1616022, 'Your spirit will linger here forever!', 14528, 1, 0, 0, 'Malygos SLAY 2-3'),
(28859, -1616017, 'ENOUGH! If you intend to reclaim Azeroth\'s magic, then you shall have it...', 14529, 1, 0, 0, 'Malygos PHASEEND 2'),
(28859, -1616018, 'Now your benefactors make their appearance...But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?', 14530, 1, 0, 0, 'Malygos PHASE 3 INTRO'),
(28859, -1616019, 'SUBMIT!', 14531, 1, 0, 0, 'Malygos AGGRO 3'),
(28859, -1616026, 'The powers at work here exceed anything you could possibly imagine!', 14532, 1, 0, 0, 'Malygos STATIC FIELD'),
(28859, -1616023, 'Alexstrasza! Another of your brood falls!', 14534, 1, 0, 0, 'Malygos SLAY 3-1'),
(28859, -1616024, 'Little more then gnats!', 14535, 1, 0, 0, 'Malygos SLAY 3-2'),
(28859, -1616025, 'Your red allies will share your fate...', 14536, 1, 0, 0, 'Malygos SLAY 3-3'),
(28859, -1616027, 'Still standing? Not for long...', 14537, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616028, 'Your cause is lost!', 14538, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616029, 'Your fragile mind will be shattered!', 14539, 1, 0, 0, 'Malygos SPELL 1'),
(28859, -1616030, 'UNTHINKABLE! The mortals will destroy... e-everything... my sister... what have you-', 14540, 1, 0, 0, 'Malygos DEATH'),
(32295, -1616031, 'I did what I had to, brother. You gave me no alternative.', 14406, 1, 0, 0, 'Alexstrasza OUTRO 1'),
(32295, -1616032, 'And so ends the Nexus War.', 14407, 1, 0, 0, 'Alexstrasza OUTRO 2'),
(32295, -1616033, 'This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos\' recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world\'s mightiest has fallen.', 14408, 1, 0, 0, 'Alexstrasza OUTRO 3'),
(32295, -1616034, 'The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life...goes on.', 14409, 1, 0, 0, 'Alexstrasza OUTRO 4');

UPDATE creature_template SET ScriptName="npc_alexsrtaza" WHERE entry=32295;

-- ---------------------
-- SQL : Eye of Eternity
-- Author: Blackdown
-- For MythCore
-- ----------------------

-- Set instance script
UPDATE instance_template SET script = 'instance_eye_of_eternity' WHERE map = 616;

-- For multilanguage
REPLACE INTO script_texts (npc_entry, entry, content_default, TYPE, COMMENT) VALUE
(28859, -1616035, "A Power Spark forms from a nearby rift!", 5, "Malygos WHISPER_POWER_SPARK");
REPLACE INTO script_texts (npc_entry, entry, content_default, TYPE, COMMENT) VALUE
(28859, -1616036, "Malygos fixes his eyes on you !", 5, "Malygos WHISPER_LOOK_ME");

-- Update flags for NPCs/Vehicles
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30090; -- Vortex  'Arcane Overload', 'Hover Disk');
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35, VehicleId = 165 WHERE entry IN (30234, 30248); -- Hover Disk
UPDATE creature_template SET flags_extra = flags_extra | 2, faction_A = 35, faction_H = 35 WHERE entry = 30118; -- Portal (Malygos)
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 30282; -- Arcane Overload
UPDATE creature_template SET mindmg = 1, maxdmg = 1, dmg_multiplier = 1 WHERE entry = 30592; -- Static Field
UPDATE creature_template SET modelid1 = 11686, modelid2 = 11686 WHERE entry = 22517; -- Some world trigger

-- Fix Wyrmrest drakes creature info
UPDATE creature_template SET spell1 = 56091, spell2 = 56092, spell3 = 57090, spell4 = 57143, spell5 = 57108, spell6 = 57403, VehicleId = 165 WHERE entry IN (30161, 31752);

-- Delete faulty Alextrasza spawn
DELETE FROM creature WHERE guid = 132302;
DELETE FROM creature_addon WHERE guid = 132302;

-- And Surge of Power
DELETE FROM creature WHERE guid = 132303;
DELETE FROM creature_addon WHERE guid = 132303;

-- Fix Loot caches being not selectable
UPDATE gameobject_template SET faction = 35, flags = 0 WHERE entry IN (193967, 193905);

-- Fix Surge of Power targeting
DELETE FROM `conditions` WHERE `SourceEntry`=56505;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,56505,18,1,22517);

-- Fix loot for Malygos (Alexstrasza's Gift)
-- End of 25m Malygos loot

-- Create entry for Heroic Malygos
UPDATE creature_template SET flags_extra = flags_extra | 1 WHERE entry IN (28859);-- Aсadir 50000

-- Spawn Focusing.
DELETE FROM gameobject WHERE id IN (193958, 193960);
INSERT INTO gameobject VALUES
(NULL, 193958, 616, 1, 1, 754.362, 1301.61, 266.171, 6.23742, 0, 0, 0.022883, -0.999738, 300, 0, 1), 
(NULL, 193960, 616, 2, 1, 754.362, 1301.61, 266.171, 6.23742, 0, 0, 0.022883, -0.999738, 300, 0, 1); 

-- Aggro Malygos
UPDATE creature_model_info SET combat_reach = '30' WHERE modelid = 26752;

-- Power spark  Malygos
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=56152;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,56152,18,1,28859);

-- Script GO Focusing Iris
UPDATE `gameobject_template` SET `ScriptName` = 'go_malygos_iris' WHERE `entry` IN (193960,193958); 
UPDATE creature_template SET InhabitType = 4, VehicleId = 223 WHERE entry IN (30234, 30248);
UPDATE creature_template SET spell6 = 57092, spell7 = 57403 WHERE entry IN (30161, 31752);
UPDATE creature_template SET  flags_extra =  flags_extra | 0x2 WHERE entry = 31253; -- Alexstrazsa
UPDATE creature_model_info SET combat_reach = 15 WHERE modelid = 26752;
DELETE FROM script_texts WHERE entry = -1616035;

-- -------------------------------------------------------------------------
-- --------------------------------- Nexus ---------------------------------
-- -------------------------------------------------------------------------

## First Boss should be interruptable
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask &~ 33554432 WHERE entry IN (26731,30510);

UPDATE creature_template SET AIName = '', ScriptName = 'boss_magus_telestra_arcane' WHERE entry = 26929;

DELETE FROM creature WHERE id IN (26798,26796,27949,27947);
INSERT INTO creature (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(26796,576,2,1,24366,0,424.185,185.37,-35.004,3.263,3600,0,0,337025,0,0,0), -- alli boss hero
(27949,576,1,1,24366,0,424.185,185.37,-35.004,3.263,3600,0,0,337025,0,0,0); -- alli commander non hero

## Remove Keristrasza's Broken Heart from loot Table
DELETE FROM creature_loot_template WHERE item = 43665;

## Spikes at Ormorok unselectable and unattackable
SET @spike_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 27099);
UPDATE creature_template SET unit_flags = unit_flags|2|33554432 WHERE entry IN (27099,@spike_h);

## Remove Reputation from Horde/Alliance Commander (nonhero) - old: 250
DELETE FROM creature_onkill_reputation WHERE creature_id IN (27947,27949);

-- -------------------------------------------------------------------------
-- -------------------------------- Ocolus ---------------------------------
-- -------------------------------------------------------------------------
-- Ruby drake
UPDATE creature_template SET mindmg = 422, maxdmg = 586, attackpower = 642, dynamicflags = 8, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103, spell1 = 50232, spell2 = 50248, spell3 = 50240, spell4 =  50253, spell5 = 53112, VehicleId = 70 WHERE entry = 27756;
-- Amber Drake
UPDATE creature_template SET mindmg = 422, maxdmg = 586, attackpower = 642, dynamicflags = 8, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103, spell1 = 49840, spell2 = 49838, spell3 = 49592, spell4 =  0, spell5 = 53112, VehicleId = 70 WHERE entry = 27755;
-- Emerald Drake
UPDATE creature_template SET mindmg = 422, maxdmg = 586, attackpower = 642, dynamicflags = 8, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103, spell1 = 50328, spell2 = 50341, spell3 = 50344, spell4 =  0, spell5 = 53112, VehicleId = 70 WHERE entry = 27692;

UPDATE creature_template SET npcflag=1 WHERE entry IN (27657,27658,27659);

UPDATE creature_template SET ScriptName='boss_drakos' WHERE entry = 27654;
UPDATE creature_template SET ScriptName='boss_urom' WHERE entry = 27655;
UPDATE creature_template SET ScriptName='mob_centrifige_construct' WHERE entry = 27641;
UPDATE creature_template SET ScriptName='boss_varos' WHERE entry = 27447;
UPDATE creature_template SET ScriptName='boss_eregos' WHERE entry = 27656;
UPDATE creature_template SET ScriptName='npc_planar_anomaly' WHERE entry = 30879;
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry` = 27658;

-- Planar anomaly
UPDATE creature_template SET InhabitType = 5, modelid1 =  28107, modelid3 = 28107 WHERE entry=30879;
-- Unstable Sphere
UPDATE creature_template SET minlevel = 80, maxlevel = 80, mindmg = 422, maxdmg = 586, faction_A = 16, faction_H = 16, attackpower = 642, dmg_multiplier = 1, minrangedmg = 345, maxrangedmg = 509, rangedattackpower = 103 WHERE entry = 28166;
-- Drakos the Interrogator
DELETE FROM `script_texts` WHERE npc_entry='27654';
INSERT INTO `script_texts` VALUES ('27654', -1578000, 'The prisoners shall not go free. The word of Malygos is law!','', '', '', '', '', '', '', '', 13594,1,0,0, 'drakos SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27654', -1578001, 'A fitting punishment!','', '', '', '', '', '', '', '', 13602, 1,0,0, 'drakos SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27654', -1578002, 'Sentence: executed!','', '', '', '', '', '', '', '', 13603,1,0,0, 'drakos SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27654', -1578003, 'Another casualty of war!','', '', '', '', '', '', '', '', 13604, 1,0,0, 'drakos SAY_KILL_3');
INSERT INTO `script_texts` VALUES ('27654', -1578004, 'The war... goes on.','', '', '', '', '', '', '', '', 13605,1,0,0,  'drakos SPELL_DEATH');
INSERT INTO `script_texts` VALUES ('27654', -1578005, 'It is too late to run!','', '', '', '', '', '', '', '', 13598, 1,0,0, 'drakos SAY_PULL_1');
INSERT INTO `script_texts` VALUES ('27654', -1578006, 'Gather \'round! ','', '', '', '', '', '', '', '', 13599, 1,0,0, 'drakos SAY_PULL_2');
INSERT INTO `script_texts` VALUES ('27654', -1578007, 'None shall escape!','', '', '', '', '', '', '', '', 13600, 1,0,0, 'drakos SAY_PULL_3');
INSERT INTO `script_texts` VALUES ('27654', -1578008, 'I condemn you to death!','', '', '', '', '', '', '', '', 13601,1,0,0,  'drakos SAY_PULL_4');
INSERT INTO `script_texts` VALUES ('27654', -1578009, 'Tremble, worms!','', '', '', '', '', '', '', '', 13595,1,0,0,  'drakos SAY_STOMP_1');
INSERT INTO `script_texts` VALUES ('27654', -1578010, 'I will crush you!', '', '', '', '', '', '', '', '', 13596, 1,0,0, 'drakos SAY_STOMP_2');
INSERT INTO `script_texts` VALUES ('27654', -1578011, 'Can you fly?', '', '', '', '', '', '', '', '', 13597, 1,0,0, 'drakos SAY_STOMP_3');
-- Mage-Lord Urom
DELETE FROM `script_texts` WHERE npc_entry= '27655';
INSERT INTO `script_texts` VALUES ('27655', -1578012, 'Poor blind fools!','', '', '', '', '', '', '', '', 13638,1,0,0, 'urom SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27655', -1578013, 'If only you understood!','', '', '', '', '', '', '', '', 13641,1,0,0, 'urom SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27655', -1578014, 'Now, do you see? DO YOU?!','', '', '', '', '', '', '', '', 13642,1,0,0, 'urom SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27655', -1578015, 'Unfortunate, but necessary.','', '', '', '', '', '', '', '', 13643,1,0,0, 'urom SAY_KILL_3');
INSERT INTO `script_texts` VALUES ('27655', -1578016, 'Everything I\'ve done... has been for Azeroth...','', '', '', '', '', '', '', '', 13644,1,0,0, 'urom SAY_DEATH');
INSERT INTO `script_texts` VALUES ('27655', -1578017, 'A taste... just a small taste... of the Spell-Weaver\'s power!','', '', '', '', '', '', '', '', 13639,1,0,0, 'urom SAY_EXPLOSION_1');
INSERT INTO `script_texts` VALUES ('27655', -1578018, 'So much unstable energy... but worth the risk to destroy you!','', '', '', '', '', '', '', '', 13640,1,0,0, 'urom SAY_EXPLOSION_2');
INSERT INTO `script_texts` VALUES ('27655', -1578019, 'What do we have here... those would defy the Spell-Weaver? Those without foresight or understanding. How could I make you see? Malygos is saving the world from itself! Bah! You are hardly worth my time!','', '', '', '', '', '', '', '', 13635,1,0,0, 'urom SAY_SUMMON_1');
INSERT INTO `script_texts` VALUES ('27655', -1578020, 'Clearly my pets failed. Perhaps another demonstration is in order.','', '', '', '', '', '', '', '', 13636,1,0,0, 'urom SAY_SUMMON_2');
INSERT INTO `script_texts` VALUES ('27655', -1578021, 'Still you fight. Still you cling to misguided principles. If you survive, you\'ll find me in the center ring.','', '', '', '', '', '', '', '', 13637,1,0,0, 'urom SAY_SUMMON_3');
-- Varos Cloudstrider
DELETE FROM `script_texts` WHERE npc_entry = '27447';
INSERT INTO `script_texts` VALUES ('27447', -1578022, 'There will be no mercy!','', '', '', '', '', '', '', '', 13649,1,0,0, 'varos SAY_AGGRO');
INSERT INTO `script_texts` VALUES ('27447', -1578023, 'You were warned.','', '', '', '', '', '', '', '', 13653,1,0,0, 'varos SAY_KILL_1');
INSERT INTO `script_texts` VALUES ('27447', -1578024, 'The Oculus is ours.','', '', '', '', '', '', '', '', 13654,1,0,0, 'varos SAY_KILL_2');
INSERT INTO `script_texts` VALUES ('27447', -1578025, 'They are... too strong! Underestimated their... fortitude.','', '', '', '', '', '', '', '', 13655,1,0,0, 'varos SAY_DEATH');
INSERT INTO `script_texts` VALUES ('27447', -1578026, 'Blast them! Destroy them!','', '', '', '', '', '', '', '', 13650,1,0,0, 'varos SAY_STRIKE_1');
INSERT INTO `script_texts` VALUES ('27447', -1578027, 'Take no prisoners! Attack!','', '', '', '', '', '', '', '', 13651,1,0,0, 'varos SAY_STRIKE_2');
INSERT INTO `script_texts` VALUES ('27447', -1578028, 'Strike now! Obliterate them!','', '', '', '', '', '', '', '', 13652,1,0,0, 'varos SAY_STRIKE_3');
-- Varos says when Drakos dies
INSERT INTO `script_texts` VALUES ('27447', -1578029, 'Intruders, your victory will be short-lived. I am Commander Varos Cloudstrider. My drakes control the skies and protest this conduit. I will see to it personally that the Oculus does not fall into your hands!','', '', '', '', '', '', '', '', 13648,1,0,0, 'varos SAY_SPAWN');

UPDATE gameobject_template SET flags=4 where entry IN (189986,193995);

-- Orb of the Nexus
UPDATE gameobject_template SET TYPE=10,flags=32,data0=0,data2=1887150,data3=0,data6=1 WHERE entry=188715;
DELETE FROM event_scripts WHERE id=1887150;
INSERT INTO event_scripts (id,delay,command,datalong,datalong2,dataint,x,y,z,o) VALUES 
(1887150,0,6,571,0,0,3877.953125,6984.460449,106.320236,0.023581);
-- Nexus Portal
UPDATE gameobject_template SET TYPE=10,flags=32,data0=0,data2=1899850,data3=0,data6=1 WHERE entry=189985;
DELETE FROM event_scripts WHERE id=1899850;
INSERT INTO event_scripts (id,delay,command,datalong,datalong2,dataint,x,y,z,o) VALUES 
(1899850,0,6,578,0,0,996.837646,1061.329834,359.476685,3.490091);
-- Missing rep (Thx Bloodycore)
DELETE FROM creature_onkill_reputation WHERE creature_id IN (27636,27642,28153,28236);
INSERT INTO creature_onkill_reputation (creature_id,RewOnKillRepFaction1,RewOnKillRepFaction2,MaxStanding1,IsTeamAward1,RewOnKillRepValue1,MaxStanding2,IsTeamAward2,RewOnKillRepValue2,TeamDependent) VALUES 
(27636,1037,1052,7,0,25,7,0,25,1),
(27642,1037,1052,7,0,5,7,0,5,1),
(28153,1037,1052,7,0,5,7,0,5,1),
(28236,1037,1052,7,0,25,7,0,25,1);

-- -------------------------------------------------------------------------
-- ----------------------------- Ruby Sanctum ------------------------------
-- -------------------------------------------------------------------------
DELETE FROM script_texts where `entry` <= -1752008 AND `entry` >= -1752016;
DELETE FROM script_texts where `entry` <= -1752001 AND `entry` >= -1752006;
DELETE FROM script_texts where `entry` <= -1752017 AND `entry` >= -1752036;

INSERT INTO script_texts (`entry`, `content_default`, `npc_entry`, `content_loc3`, `sound`, `type`, `language`) VALUES
('-1752008', 'Help! I am trapped within this tree! I require aid!', '0', '', '17490', '1', '0'),	 	
('-1752009', 'Thank you! I could not have held out for much longer.... A terrible thing has happened here.', '0', '', '17491', '1', '0'),	 	
('-1752010', 'We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.', '0', '', '17492', '0', '0'),	 	
('-1752011', 'The Black dragonkin materialized from thin air, and set upon us before we could react.', '0', '', '17493', '0', '0'), 	
('-1752012', 'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.', '0', '', '17494', '0', '0'), 	
('-1752013', 'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.', '0', '', '17495', '0', '0'),	
('-1752014', 'The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.', '0', '', '17496', '0', '0'),	
('-1752015', 'In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.', '0', '', '17497', '0', '0'),	
('-1752016', 'I know not the extent of their plans, heroes, but I know this: They cannot be allowed to succeed!', '0', '', '17498', '0', '0'),

( -1752001, "Ah, the entertainment has arrived.", 0, "", 17520, 1, 0),
( -1752002, "Baltharus leaves no survivors!", 0, "", 17521, 1, 0),
( -1752003, "This world has enough heroes.", 0, "", 17522, 1, 0),
( -1752004, "I..Didn''t saw...that coming...", 0, "", 17523, 1, 0),
( -1752005, "Twice the pain and half the fun.", 0, "", 17524, 1, 0),
( -1752006, "Your power wanes, ancient one.... Soon you will join your friends.", 0, "", 17525, 1, 0),

( -1752017, "Alexstrasza has chosen capable allies... A pity that I must END YOU!", 0, "", 17512, 1, 0),
( -1752018, "You thought you stood a chance?", 0, "", 17513, 1, 0),
( -1752019, "It''s for the best.", 0, "", 17514, 1, 0),
( -1752020, "HALION! I...", 0, "", 17515, 1, 0),
( -1752021, "Turn them to ashes, minions!", 0, "", 17516, 1, 0),

( -1752022, "You will sssuffer for this intrusion!", 0, "", 17528, 1, 0),
( -1752023, "As it should be...", 0, "", 17529, 1, 0),
( -1752024, "Halion will be pleased", 0, "", 17530, 1, 0),
( -1752025, "Hhrr...Grr..", 0, "", 17531, 1, 0),
( -1752026, "Burn in the master's flame!", 0, "", 17532, 1, 0),

(-1752027, 'Insects! You''re too late. The Ruby Sanctum is lost.',NULL,NULL,17499,0,0),
(-1752028, 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!',NULL,NULL,17500,0,0),
(-1752029, 'Another hero falls.',NULL,NULL,17501,0,0),
(-1752030, 'Hahahahaha.',NULL,NULL,17502,0,0),
(-1752031, 'Relish this victory, mortals, for it will be your last! This world will burn with the master''s return!',NULL,NULL,17503,0,0),
(-1752032, 'Not good enough.',NULL,NULL,17504,0,0),
(-1752033, 'The heavens burn!',NULL,NULL,17505,0,0),
(-1752034, 'Beware the shadow!',NULL,NULL,17506,0,0),
(-1752035, 'You will find only suffering within the realm of twilight! Enter if you dare!',NULL,NULL,17507,0,0),
(-1752036, 'I am the light and the darkness! Cower, mortals, before the herald of Deathwing!',NULL,NULL,17508,0,0);

UPDATE `instance_template` SET `script`='instance_ruby_sanctum' WHERE (`map`='724');
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus' WHERE `entry` = '39751';
UPDATE `creature_template` SET `ScriptName` = 'boss_baltharus_summon' WHERE `entry` = '39899';
UPDATE `creature_template` SET `ScriptName` = 'npc_xerestrasza' WHERE `entry` = '40429';
UPDATE `creature_template` SET `ScriptName` = 'boss_zarithrian' WHERE `entry` = '39746';
UPDATE `creature_template` SET `ScriptName` = 'boss_ragefire' WHERE `entry` = '39747';
UPDATE `creature_template` SET `ScriptName` = 'boss_halion' WHERE `entry`= '39863';
UPDATE `creature_template` SET `ScriptName` = 'boss_twilight_halion' WHERE `entry` = '40142';

REPLACE `spell_script_names` SET `ScriptName` = 'spell_halion_portal', `spell_id`=74812;

UPDATE `gameobject_template` SET `data10`=74807 WHERE `entry`=202794;
UPDATE `gameobject_template` SET `data10`=74812 WHERE `entry`=202796;


DELETE FROM `spell_linked_spell` WHERE (`spell_trigger`='-74562') AND (`spell_effect`='74610');
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger`='-74792') AND (`spell_effect`='74800');
INSERT INTO spell_linked_spell VALUES (-74562, 74610, 0, 'Fiery Combustion removed -> Combustion');
INSERT INTO spell_linked_spell VALUES (-74792, 74800, 0, 'Soul Consumption removed -> Consumption');

DELETE FROM creature WHERE `id`=39863 and `map`=724;
INSERT INTO creature VALUES (null,39863,724,15,1,0,0,3144.93,527.233,72.8887,0.110395,300,0,0,11156000,0,0,0);

UPDATE `creature_template` SET `ScriptName` = 'npc_onyx_flamecaller' WHERE `entry` = '39814';
UPDATE `creature_template` SET `ScriptName` = 'npc_meteor_strike', `flags_extra`=128 WHERE `entry` = '40041';
UPDATE `creature_template` SET `ScriptName` = 'npc_meteor_flame', `flags_extra`=128 WHERE `entry` = '40042';
UPDATE `creature_template` SET `ScriptName` = 'npc_spell_meteor_strike', `flags_extra`=128 WHERE `entry` = '40029';
UPDATE `creature_template` SET `name`='summon halion', `ScriptName` = 'npc_summon_halion', `flags_extra`=128 WHERE `entry` = '40044';

-- -------------------------------------------------------------------------
-- ------------------------------ Naxxramas --------------------------------
-- -------------------------------------------------------------------------
UPDATE creature_template SET ScriptName="mob_gluths_zombie" WHERE entry=16360;

-- Remove invisible state for Shadow Fissure c16129 used by Kel'Thuzad in Naxxramas and set proper baseattacktiem (by Ident thx Trazom for baseattacktime)
UPDATE `creature_template` SET `baseattacktime`=5000,`flags_extra`=`flags_extra`&~128 WHERE `entry`=16129;
-- *******************************************************************************************
-- Naxxramas
-- Delete Copse Scarabs
DELETE FROM `creature` WHERE `id`= 16698;
UPDATE `creature_template` SET `mindmg` = 400, `maxdmg` = 600, `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), `mindmg` = ROUND(`mindmg` - `attackpower` / 7), `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) WHERE `entry` = 16698;
-- Delete Gothik adds
DELETE FROM `creature` WHERE `id`IN (16124,16125,16126,16127,16148,16149,16150);
-- Faction Gothik adds
UPDATE `creature_template` SET faction_A = 21, faction_H = 21 WHERE `entry` IN (16124,16125,16126,16127,16148,16149,16150);
-- Grobbulus Wolke
UPDATE `creature_template` SET faction_A = 21, faction_H = 21 WHERE `entry` IN (16363);
-- Razevous Damage
UPDATE `creature_template` SET 
    `mindmg` = 13000, 
    `maxdmg` = 18000, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` = 16061;
-- several mobs
DELETE FROM `creature` WHERE `id` IN (16983,16981,16982,16984);
UPDATE `creature_template` SET faction_A = 21, faction_H = 21 WHERE `entry` IN (16983,16981,16982,16984); -- Noth Skelletions
DELETE FROM `creature` WHERE `id` IN (16286);
UPDATE `creature_template` SET faction_A = 21, faction_H = 21 WHERE `entry` IN (16286); -- Lortheb Spores
DELETE FROM `creature` WHERE `id` IN (16486); -- Web Wrap
UPDATE `creature_template` SET faction_A = 21, faction_H = 21 WHERE `entry` IN (16486,17055); -- Maexxna

UPDATE creature SET deathState = 1 WHERE id = 16381;
UPDATE areatrigger_teleport SET target_map = 0, target_position_x = 3118.5715 , target_position_y = -3754.5629 , target_position_z = 133.6039, target_orientation = 4.1361 WHERE id = 4156;

UPDATE creature SET spawntimesecs = '72000' WHERE map = 533;
UPDATE gameobject SET spawntimesecs = '72000' WHERE map = 533 AND id = 181366;
UPDATE gameobject SET spawntimesecs = '72000' WHERE map = 533 AND id IN (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496,181366);

UPDATE `creature_template` SET mechanic_immune_mask = 113983323 WHERE `entry` IN (15956,15953,15952,16028,15931,15932,15928,16061,16060,16064,16065,16062,16063,15954,15936,16011,15989,15990);
UPDATE `creature_template` SET maxlevel = 63, minlevel = 63  WHERE `entry` IN (15956,15953,15952,16028,15931,15932,15928,15930,15929,16061,16060,16064,16065,16062,16063,15954,15936,16011,15989,15990);
UPDATE `creature_template` SET maxlevel = 73, minlevel = 73 WHERE `entry` = 16363;
-- *******************************************************************************************
-- Doors
-- *******************************************************************************************
-- Spawns
-- Delete existing Spawns
DELETE FROM gameobject WHERE id IN (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496);
INSERT INTO `gameobject` (`guid`, `id`, `map`,`spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
-- 181126 Anub'Rekhan Door
('333000','181126','533','1','3202.7','-3476.08','287.061','0','0','0','0','0','6','0','1'),
-- 181195 Anub'Rekhan Gate
('333001','181195','533','1','3143.53','-3572.74','286','5.49778','0','0','0.382687','-0.923878','6','0','1'),
-- 181167 Grand Widow Faerlina Door
('333002','181167','533','1','3120.78','-3791','273.93','0','0','0','0','0','6','0','1'),
-- 181235 Grand Widow Faerlina - Web
('333003','181235','533','1','3322.53','-3695.4','259','3.14159','0','0','1','3.13916e-007','6','0','0'),
-- 181209 Maexxna - Outer Web Door 
('333004','181209','533','1','3425.68','-3846.1','309.109','3.14159','0','0','1','3.13916e-007','6','0','1'),
-- 181197 Maexxna - Inner Web Door
('333005','181197','533','1','3446.72','-3860.3','308.76','3.14159','0','0','0','0','6','0','1'),
-- 181124 Vaccuum - Enter Gate
('333006','181124','533','1','2765.75','-3384.38','267.685','0','0','0','0','1','6','0','1'),
-- 181125 Vaccuum - Exit Gate
('333007','181125','533','1','2617.74','-3336.81','267.684','0','0','0','0','1','25','0','1'),
-- 181170 Vaccuum - Combat Gate
('333008','181170','533','1','2692.04','-3361.4','267.684','0','0','0','0','1','6','0','1'),
-- 181119 Deathknight Door
('333009','181119','533','1','2587.76','-3017.16','240.5','3.14159','0','0','1','3.13916e-007','6','0','1'),
-- 181200 Noth - Entry Door
('333010','181200','533','1','2737.83','-3489.78','262.107','0','0','0','0','1','25','0','0'),
-- 181201 Noth - Exit Door
('333011','181201','533','1','2684.37','-3559.83','261.944','1.57079','0','0','0.707105','0.707109','25','0','1'),
-- 181202 Heigan the Unclean - Entry Door
('333012','181202','533','1','2823.47','-3685.07','274.079','0','0','0','0','1','25','0','0'),
-- 181203 Heigan the Unclean - Exit Door
('333013','181203','533','1','2771.42','-3737.02','273.619','1.57079','0','0','0.707105','0.707109','25','0','1'),
-- 181496 Heigan the Unclean - Exit Gate
('333020','181496','533','1','2909.82','-3817.88','273.926','0','0','0','0','1','6','0','1'),
-- 181241 Loatheb - Entrance Door
('333014','181241','533','1','2909.73','-3947.75','273.924','0','0','0','0','1','6','0','1'),
-- 181123 Patchwork - Exit Door
('333015','181123','533','1','3318.27','-3254.42','293.786','1.57079','0','0','0.707105','0.707109','6','0','1'),
-- 181120 Gluth - Exit Door
('333016','181120','533','1','3338.63','-3101.36','297.0','3.14159','0','0','1','1.26759e-006','6','0','1'),
-- 181121 Thaddius Door
('333017','181121','533','1','3424.77','-3014.72','295.608','0','0','0','0','1','25','0','1'),
-- 181225 Frostwyrm Waterfall Door
('333018','181225','533','1','3537.32','-5160.48','143.619','4.50667','0','0','0.775973','-0.630766','25','0','1'),
-- 181228 KelThuzad Door 
('333019','181228','533','1','3635.34','-5090.31','143.206','1.37','0','0','0.632673','0.774419','6','0','1');

UPDATE gameobject_template SET size = 1.2 WHERE entry = 181201;
UPDATE gameobject_template SET faction = 14 WHERE entry IN (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496,181366);

-- -------------------------------------------------------------------------
-- ------------------------------ Onyxia's Lair ----------------------------
-- -------------------------------------------------------------------------
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (12129,36561);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
('1212901','12129','0','0','100','7','7800','8200','9400','9600','11','15284','1','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Cleave'),
('1212902','12129','0','0','100','7','9200','9300','8400','8500','11','20203','0','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Fire Nova'),
('1212903','12129','0','0','100','7','11500','11700','23400','23600','11','12097','1','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Pierce Armor'),
('1212904','12129','0','0','100','7','12600','12800','5800','6000','11','18958','1','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Flame Lash'),
('1212905','12129','0','0','100','7','9200','9300','8400','8500','11','68969','0','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Fire Nova'),
('1212906','12129','0','0','100','7','12600','12800','5800','6000','11','69308','1','1','0','0','0','0','0','0','0','0','Onyxian Warder - Cast Flame Lash'),
(3656101,36561,0,0,75,7,15000,15000,30000,30000,11,68958,0,0,0,0,0,0,0,0,0,0, 'Onyxia Lair Guard - Cast Blast Nova'),
(3656102,36561,0,0,90,7,5000,5000,20000,20000,11,68960,1,0,0,0,0,0,0,0,0,0, 'Onyxia Lair Guard - Cast Ignite Weapon'),
(3656103,36561,0,0,80,7,7000,7000,9000,11000,11,15284,1,0,0,0,0,0,0,0,0,0, 'Onyxia Lair Guard - Cast Cleave' );

UPDATE creature_template SET  AIName='EventAI' WHERE entry IN (12129,36561);

-- -----------------------------------------------------------------------------------------------
-- -------------------------------------- Icecrown Citadel ---------------------------------------
-- -----------------------------------------------------------------------------------------------
-- THIS SQL CONTAIN ALL ICECROWN CITADEL SQL NEEDED DATA FOR MYTH CORE.
-- -------------------------------------------------------------------------
-- -------------------------- Icecrown Citadel -----------------------------
-- -------------------------------------------------------------------------
-- Cleanup
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (SELECT `id` FROM `creature` WHERE `map` = 631);

-- GameObject
UPDATE `gameobject_template` SET `ScriptName` = 'go_icecrown_teleporter' WHERE `entry` IN (202223,202235,202242,202243,202244,202245,202246);
UPDATE `gameobject_template` SET `flags` = 32 WHERE `entry` IN (202235,202242,202243,202244,202245,202246,202223);
UPDATE `gameobject_template` SET `ScriptName` = '', `data10` = 70308 WHERE `entry` = 201584;
UPDATE `gameobject` SET `phaseMask` = '1' WHERE `id` IN (202242,202243,202244,202245,202235,202223,202246);
UPDATE `gameobject` SET `state` = '1' WHERE `id` IN (201614,201613,201375);

-- Boss
UPDATE `creature_template` SET `ScriptName`='boss_rotface' WHERE `entry`= 36627;
UPDATE `creature_template` SET `ScriptName`='boss_professor_putricide' WHERE `entry` = 36678;
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_valanar_icc' WHERE `entry` = 37970;
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_keleset_icc' WHERE `entry` = 37972;
UPDATE `creature_template` SET `ScriptName`='boss_blood_elf_taldaram_icc' WHERE `entry` = 37973;
UPDATE `creature_template` SET `ScriptName`='boss_blood_queen_lanathel' WHERE `entry` = 37955;
UPDATE `creature_template` SET `ScriptName`='boss_valithria' WHERE `entry` = 36789;
UPDATE `creature_template` SET `ScriptName`='boss_sindragosa' WHERE `entry` = 36853;
UPDATE `creature_template` SET `ScriptName`='boss_the_lich_king' WHERE `entry` = 36597;

-- Mobs
UPDATE `creature_template` SET `ScriptName`='npc_tirion_icc' WHERE `entry`= 38995;
UPDATE `creature_template` SET `ScriptName`='npc_swarming_shadows' WHERE `entry` = 38163;
UPDATE `creature_template` SET `ScriptName`='npc_bloodbeast' WHERE `entry` = 38508;
UPDATE `creature_template` SET `ScriptName`='npc_cold_flame' WHERE `entry` = 36672;
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE `entry` = 38711;
UPDATE `creature_template` SET `ScriptName`='npc_volatile_ooze' WHERE `entry` = 37697;
UPDATE `creature_template` SET `ScriptName`='npc_ice_puls_icc' WHERE `entry` = 36633;
UPDATE `creature_template` SET `ScriptName`='npc_valkyr_icc' WHERE `entry` = 36609;
UPDATE `creature_template` SET `ScriptName`='npc_ghoul_icc' WHERE `entry` = 37695;
UPDATE `creature_template` SET `ScriptName`='npc_defile_icc' WHERE `entry` = 38757;
UPDATE `creature_template` SET `ScriptName`='npc_raging_spirit_icc' WHERE `entry`= 36701;
UPDATE `creature_template` SET `ScriptName`='npc_shambling_horror_icc' WHERE `entry` = 37698;
UPDATE `creature_template` SET `ScriptName`='npc_ooze_little' WHERE `entry`= 36897;
UPDATE `creature_template` SET `ScriptName`='npc_ooze_big' WHERE `entry`= 36899;
UPDATE `creature_template` SET `ScriptName`='npc_shade' WHERE `entry` = 38222;
UPDATE `creature_template` SET `ScriptName`='npc_skellmage_icc' WHERE `entry` = 37868;
UPDATE `creature_template` SET `ScriptName`='npc_fireskell_icc' WHERE `entry` = 36791;
UPDATE `creature_template` SET `ScriptName`='npc_suppressor_icc' WHERE `entry` = 37863;
UPDATE `creature_template` SET `ScriptName`='npc_manavoid_icc' WHERE `entry` = 38068;
UPDATE `creature_template` SET `ScriptName`='npc_glutabomination_icc' WHERE `entry` = 37886;
UPDATE `creature_template` SET `ScriptName`='npc_blistzombie_icc' WHERE `entry` = 37934;
UPDATE `creature_template` SET `ScriptName`='npc_dreamcloud_icc' WHERE `entry` = 37985;
UPDATE `creature_template` SET `ScriptName`='npc_dreamportal_icc' WHERE `entry` = 37945;
UPDATE `creature_template` SET `ScriptName`='npc_cult_fanatic_and_adherent' WHERE `entry` IN (37949,38010,38136,37890,38009,38135);
UPDATE `creature_template` SET `ScriptName`='npc_rimefang' WHERE `entry`= 37533;
UPDATE `creature_template` SET `ScriptName`='npc_spinestalker' WHERE `entry`= 37534;
UPDATE `creature_template` SET `ScriptName`='npc_ice_tomb' WHERE `entry`= 36980;
UPDATE `creature_template` SET `ScriptName`='npc_frost_bomb' WHERE `entry`= 37186;
UPDATE `creature_template` SET `ScriptName`='npc_icc_puddle_stalker' WHERE `entry`= 37824;
UPDATE `creature_template` SET `ScriptName`='npc_abomination' WHERE `entry` = 37672;
UPDATE `creature_template` SET `ScriptName`='npc_sticky_ooze' WHERE `entry`= 37006;
UPDATE `creature_template` SET `ScriptName`='npc_ooze_explode_stalker' WHERE `entry` = 38107;
UPDATE `creature_template` SET `ScriptName`='npc_gas_cloud_icc' WHERE `entry` = 37562;
UPDATE `creature_template` SET `ScriptName`='npc_bomb_icc' WHERE `entry` = 38159;
UPDATE `creature_template` SET `ScriptName`='npc_stinky_icc' WHERE `entry` = 37025;
UPDATE `creature_template` SET `ScriptName`='npc_precious_icc' WHERE `entry` = 37217;
UPDATE `creature_template` SET `ScriptName`='npc_icc_column_stalker' WHERE `entry` = 37918;

-- Other
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554434, `type_flags` = 1024 WHERE `entry` = 36672;
UPDATE `creature_template` SET `minlevel` = '80', `maxlevel` = '80', `faction_A` = '14', `faction_H` = '14', `unit_flags` = '0', `type_flags` = '0', `VehicleId` = '647' WHERE `entry` IN (38711,38970,38971,38972);
UPDATE `creature_template` SET `faction_A` = 21, `faction_H` = 21, `unit_flags` = 33600, `vehicleId` = 639 WHERE `entry` IN (37813,38402,38582,38583);
UPDATE `creature_template` SET `faction_A` = 1801, `faction_H` = 1801, `type_flags` = 67113036 WHERE `entry` IN (36789,38174);
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `minlevel` = '80', `maxlevel` = '80' WHERE `entry` IN (37006,37013,37986,38107,38548,36659,37690,37562,38159);
UPDATE `creature_template` SET `vehicleId` = 318 WHERE `entry` IN (36609,39120,39121,39122);
UPDATE `creature_model_info` SET `bounding_radius` = 5,`combat_reach` = 5 WHERE `modelid` = 31119;
UPDATE `creature_template` SET `mechanic_immune_mask` = 634339327 WHERE `entry` IN (36855,38106,38296,38297);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` IN (37007,38301);
UPDATE `creature_template` SET `spell1` = 70360, `spell2` = 70539, `spell3` = 70542, `VehicleId` = 591 WHERE `entry` IN (37672,38605,38786,38787);
UPDATE `creature_template` SET `dynamicflags` = 8, `npcflag` = 0, `unit_flags` = 32832 WHERE `entry` = 38995;

-- Not attackable and disable move flag
UPDATE `creature_template` SET `unit_flags` = 33555204 WHERE `entry` IN (37986,37824,38234,38317,36659,38548,37186,37006,37918);
UPDATE `creature_template` SET `unit_flags` = 33587972 WHERE `entry` = 37013;
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` IN (37986,38234,38317,36659,38548,37186,37013);
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 38234;

-- Instance
UPDATE `instance_template` SET `script`='instance_icecrown_citadel' WHERE `map` = 631;

-- Creature addon template

DELETE FROM `creature_addon` WHERE `guid` = 136107;
DELETE FROM `creature_template_addon` WHERE `entry`= 37690;
DELETE FROM `creature_template_addon` WHERE `entry`= 37672;
DELETE FROM `creature_template_addon` WHERE `entry`= 36659;

INSERT INTO creature_addon (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(136107, 0, 0, 0, 1, 0, '18950 0 18950 1 72242 0');

INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(37690, 0, 0, 0, 0, 0, '70345 0  70343 0'),
(37672, 0, 0, 0, 0, 0, '70385 0 70405 0');

-- Thanks YTDB

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (70781,70856,70857,70858,70859,70860,70861);
DELETE FROM `conditions` WHERE `SourceEntry` IN (69508,70881,70360);
DELETE FROM `conditions` WHERE `ConditionValue2` IN (SELECT `id` FROM `creature` WHERE `map` = 631);

REPLACE INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,70360,0,18,1,37690,0,0, '', ''),
(13,0,69125,0,18,1,37013,0,0, '', '');

-- creature
DELETE FROM `creature` WHERE `id` IN(37813, 37013, 36659);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(37013,631,1,1,11686,0,4291.18,3092.92,372.97,2.33874,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4312.14,3112.98,372.97,2.51327,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4244.04,3092.66,372.97,0.97738,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4223.47,3113.58,372.97,0.76794,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4222.44,3161.69,372.97,5.53269,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4243.89,3181.74,372.97,5.44543,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4312.36,3160.84,372.97,3.80482,300,0,0,25200,0,0,0),
(37013,631,1,1,11686,0,4291.45,3181.25,372.97,4.10152,300,0,0,25200,0,0,0),
(36659,631,15,1,11686,0,4267.87,3137.33,360.469,0,300,0,0,25200,0,0,0),
(37813,631,15,1,30790,0,-493.905,2211.35,541.114,3.18037,300,0,0,12299490,0,0,0);

-- Linked spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 72202;
DELETE FROM `spell_linked_spell` WHERE `spell_effect` IN(72202,69166,70347,72380);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(70360,70347,0,'Eat Ooze'),
(72379,72380,0,'Blood Nova'),
(72380,72202,0,'Blood Nova 10N'),
(72438,72202,0,'Blood Nova 25N'),
(72439,72202,0,'Blood Nova 10H'),
(72440,72202,0,'Blood Nova 25H'),
(72409,72202,0,'Rune of Blood 25N'),
(72447,72202,0,'Rune of Blood 10H'),
(72448,72202,0,'Rune of Blood 25H'),
(72449,72202,0,'Rune of Blood 25H'),
(69195,69166,0,'Pungent Blight 10N'),
(71279,69166,0,'Pungent Blight 25N'),
(73031,69166,0,'Pungent Blight 10H'),
(73032,69166,0,'Pungent Blight 25H');

-- 4
REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(37200,-1631029, 'Let''s get a move on then! Move ou...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16974,1,0,0, 'SAY_INTRO_ALLIANCE_1'),
(37813,-1631030, 'For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King''s armies grew. Even now the val''kyr work to raise your fallen as Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16701,1,0,0, 'SAY_INTRO_ALLIANCE_2'),
(37813,-1631031, 'Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16702,1,0,0, 'SAY_INTRO_ALLIANCE_3'),
(37200,-1631032, 'A lone orc against the might of the Alliance???',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16970,1,0,0, 'SAY_INTRO_ALLIANCE_4'),
(37200,-1631033, 'Charge!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16971,1,0,0, 'SAY_INTRO_ALLIANCE_5'),
(37813,-1631034, 'Dwarves...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16703,1,0,0, 'SAY_INTRO_ALLIANCE_6'),
(37813,-1631035, 'Deathbringer Saurfang immobilizes Muradin and his guards.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_INTRO_ALLIANCE_7'),
(37187,-1631036, 'Kor''kron, move out! Champions, watch your backs. The Scourge have been...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17103,1,0,22, 'SAY_INTRO_HORDE_1'),
(37813,-1631037, 'Join me, father. Join me and we will crush this world in the name of the Scourge -- for the glory of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16704,1,0,0, 'SAY_INTRO_HORDE_2'),
(37187,-1631038, 'My boy died at the Wrath Gate. I am here only to collect his body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17097,0,0,397, 'SAY_INTRO_HORDE_3'),
(37813,-1631039, 'Stubborn and old. What chance do you have? I am stronger, and more powerful than you ever were.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16705,1,0,5, 'SAY_INTRO_HORDE_4'),
(37187,-1631040, 'We named him Dranosh. It means "Heart of Draenor" in orcish. I would not let the warlocks take him. My boy would be safe, hidden away by the elders of Garadar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17098,0,0,1, 'SAY_INTRO_HORDE_5'),
(37187,-1631041, 'I made a promise to his mother before she died; that I would cross the Dark Portal alone - whether I lived or died, my son would be safe. Untainted...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17099,0,0,1, 'SAY_INTRO_HORDE_6'),
(37187,-1631042, 'Today, I fulfill that promise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17100,0,0,397, 'SAY_INTRO_HORDE_7'),
(37187,-1631043, 'High Overlord Saurfang charges!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17104,2,0,53, 'SAY_INTRO_HORDE_8'),
(37813,-1631044, 'Pathetic old orc. Come then heroes. Come and face the might of the Scourge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16706,1,0,15, 'SAY_INTRO_HORDE_9'),
(37813,-1631045, 'BY THE MIGHT OF THE LICH KING!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16694,1,0,0, 'SAY_AGGRO'),
(37813,-1631046, 'The ground runs red with your blood!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16699,1,0,0, 'SAY_MARK_OF_THE_FALLEN_CHAMPION'),
(37813,-1631047, 'Feast, my minions!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16700,1,0,0, 'SAY_BLOOD_BEASTS'),
(37813,-1631048, 'You are nothing!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16695,1,0,0, 'SAY_KILL_1'),
(37813,-1631049, 'Your soul will find no redemption here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16696,1,0,0, 'SAY_KILL_2'),
(37813,-1631050, 'Deathbringer Saurfang goes into frenzy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'SAY_FRENZY'),
(37813,-1631051, 'I have become...DEATH!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16698,1,0,0, 'SAY_BERSERK'),
(37813,-1631052, 'I... Am... Released.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16697,1,0,0, 'SAY_DEATH'),
(37200,-1631053, 'Muradin Bronzebeard gasps for air.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16975,2,0,0, 'SAY_OUTRO_ALLIANCE_1'),
(37200,-1631054, 'That was Saurfang''s boy - the Horde commander at the Wrath Gate. Such a tragic end...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16976,0,0,0, 'SAY_OUTRO_ALLIANCE_2'),
(37200,-1631055, 'What in the... There, in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16977,0,0,0, 'SAY_OUTRO_ALLIANCE_3'),
(    0,-1631056, 'A Horde Zeppelin flies up to the rise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_4'),
(37200,-1631057, 'Soldiers, fall in! Looks like the Horde are comin'' to take another shot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16978,1,0,0, 'SAY_OUTRO_ALLIANCE_5'),
(    0,-1631058, 'The Zeppelin docks, and High Overlord Saurfang hops out, confronting the Alliance soldiers and Muradin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_6'),
(37200,-1631059, 'Don''t force me hand, orc. We can''t let ye pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16972,0,0,0, 'SAY_OUTRO_ALLIANCE_7'),
(37187,-1631060, 'Behind you lies the body of my only son. Nothing will keep me from him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17094,0,0,0, 'SAY_OUTRO_ALLIANCE_8'),
(37200,-1631061, 'I... I can''t do it. Get back on yer ship and we''ll spare yer life.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16973,0,0,0, 'SAY_OUTRO_ALLIANCE_9'),
(    0,-1631062, 'A mage portal from Stormwind appears between the two and Varian Wrynn and Jaina Proudmoore emerge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_10'),
(37879,-1631063, 'Stand down, Muradin. Let a grieving father pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16690,0,0,0, 'SAY_OUTRO_ALLIANCE_11'),
(37187,-1631064, 'High Overlord Saurfang walks over to his son and kneels before his son''s body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_12'),
(37187,-1631065, '[Orcish] No''ku kil zil''nok ha tar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17096,0,0,0, 'SAY_OUTRO_ALLIANCE_13'),
(37187,-1631066, 'Higher Overlord Saurfang picks up the body of his son and walks over towards Varian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_14'),
(37187,-1631067, 'I will not forget this... kindness. I thank you, Highness',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17095,0,0,0, 'SAY_OUTRO_ALLIANCE_15'),
(37879,-1631068, 'I... I was not at the Wrath Gate, but the soldiers who survived told me much of what happened. Your son fought with honor. He died a hero''s death. He deserves a hero''s burial.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16691,0,0,0, 'SAY_OUTRO_ALLIANCE_16'),
(37188,-1631069, 'Lady Jaina Proudmoore cries.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16651,2,0,18, 'SAY_OUTRO_ALLIANCE_17'),
(37879,-1631070, 'Jaina? Why are you crying?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16692,0,0,0, 'SAY_OUTRO_ALLIANCE_18'),
(37188,-1631071, 'It was nothing, your majesty. Just... I''m proud of my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16652,0,0,0, 'SAY_OUTRO_ALLIANCE_19'),
(37879,-1631072, 'Bah! Muradin, secure the deck and prepare our soldiers for an assault on the upper citadel. I''ll send out another regiment from Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16693,0,0,0, 'SAY_OUTRO_ALLIANCE_20'),
(37200,-1631073, 'Right away, yer majesty!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16979,0,0,0, 'SAY_OUTRO_ALLIANCE_21'),
(37187,-1631074, 'High Overlord Saurfang coughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17105,2,0,0, 'SAY_OUTRO_HORDE_1'),
(37187,-1631075, 'High Overlord Saurfang weeps over the corpse of his son.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17106,2,0,15, 'SAY_OUTRO_HORDE_2'),
(37187,-1631076, 'You will have a proper ceremony in Nagrand next to the pyres of your mother and ancestors.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17101,0,0,0, 'SAY_OUTRO_HORDE_3'),
(37187,-1631077, 'Honor, young heroes... no matter how dire the battle... Never forsake it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17102,0,0,0, 'SAY_OUTRO_HORDE_4');

-- 5
REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
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

-- 6
REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36627,-1666015,'What? Precious? Noooooooooo!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16993,1,0,0,''),
(36627,-1666016,'WEEEEEE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16986,1,0,0,''),
(36627,-1666017,'Icky sticky.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16991,1,0,0,''),
(36627,-1666018,'I think I made an angry poo-poo. It gonna blow! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16992,1,0,0,''),
(36627,-1666019,'Great news, everyone! The slime is flowing again!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17126,1,0,0,''),
(36627,-1666020,'Good news, everyone! I''ve fixed the poison slime pipes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17123,1,0,0,''),
(36678,-1666021,'Daddy make toys out of you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16988,1,0,0,''),
(36627,-1666022,'I brokes-ded it...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16987,1,0,0,''),
(36627,-1666023,'Sleepy Time!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16990,1,0,0,''),
(36627,-1666024,'Bad news daddy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16989,1,0,0,''),
(36627,-1666025,'Terrible news, everyone, Rotface is dead! But great news everyone, he left behind plenty of ooze for me to use! Whaa...? I''m a poet, and I didn''t know it? Astounding!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'');

-- 7
REPLACE INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36678,-1666026,'Good news, everyone! I think I perfected a plague that will destroy all life on Azeroth!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17144,1,0,0,''),
(36678,-1666027,'You can''t come in here all dirty like that! You need that nasty flesh scrubbed off first!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17125,1,0,0,''),
(36678,-1666028,'Two oozes, one room! So many delightful possibilities...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17122,1,0,0,''),
(36678,-1666029,'Hmm. I don''t feel a thing. Whaa...? Where''d those come from?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17120,1,0,0,''),
(36678,-1666030,'Tastes like... Cherry! Oh! Excuse me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17121,1,0,0,''),
(36678,-1666031,'Hmm... Interesting...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17115,1,0,0,''),
(36678,-1666032,'That was unexpected!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17116,1,0,0,''),
(36678,-1666033,'Great news, everyone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17118,1,0,0,''),
(36678,-1666034,'Bad news, everyone! I don''t think I''m going to make it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17117,1,0,0,'');

-- 8
REPLACE INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1666035,'Foolish mortals. You thought us defeated so easily? The San''layn are the Lich King''s immortal soldiers! Now you shall face their might combined!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16795,1,0,0,''),
(0,-1666036,'Rise up, brothers, and destroy our enemies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666037,'Such wondrous power! The Darkfallen Orb has made me INVINCIBLE!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666038,'Blood will flow!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666039,'Were you ever a threat?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666040,'Truth is found in death.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666041,'Prince Keleseth cackles maniacally!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666042,'My queen... they come...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666043,'Tremble before Taldaram, mortals, for the power of the orb flows through me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666044,'Delight in the pain!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666045,'Worm food.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666046,'Beg for mercy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,''),
(0,-1666047,'Prince Taldaram laughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666048,'Prince Taldaram gurgles and dies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,''),
(0,-1666049,'Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16685,1,0,0,''),
(0,-1666050,'Dinner... is served.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16681,1,0,0,''),
(0,-1666051,'Do you see NOW the power of the Darkfallen?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16682,1,0,0,''),
(0,-1666052,'BOW DOWN BEFORE THE SAN''LAYN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16684,1,0,0,''),
(0,-1666053,'...why...?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16683,1,0,0,'');

-- 9
REPLACE INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(37955,-1666054,'You have made an... unwise... decision.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16782,1,0,0,''),
(37955,-1666055,'Just a taste...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16783,1,0,0,''),
(37955,-1666056,'Know my hunger!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16784,1,0,0,''),
(37955,-1666057,'SUFFER!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16786,1,0,0,''),
(37955,-1666058,'Can you handle this?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16787,1,0,0,''),
(37955,-1666059,'Yes... feed my precious one! You''re mine now! ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16790,1,0,0,''),
(37955,-1666060,'Here it comes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16788,1,0,0,''),
(37955,-1666061,'THIS ENDS NOW!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16793,1,0,0,''),
(37955,-1666062,'But... we were getting along... so well...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16794,1,0,0,'');

-- 10
REPLACE INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36789,-1666063,'Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17064,1,0,0,''),
(36789,-1666064,'I have opened a portal into the Emerald Dream. Your salvation lies within, heroes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17068,1,0,0,''),
(36789,-1666065,'My strength is returning! Press on, heroes!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17070,1,0,0,''),
(36789,-1666066,'I will not last much longer!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17069,1,0,0,''),
(36789,-1666067,'Forgive me for what I do! I... cannot... stop... ONLY NIGHTMARES REMAIN!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17072,1,0,0,''),
(36789,-1666068,'A tragic loss...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17066,1,0,0,''),
(36789,-1666069,'FAILURES!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17067,1,0,0,''),
(36789,-1666070,'I am renewed! Ysera grants me the favor to lay these foul creatures to rest!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17071,1,0,0,'');

-- 11
REPLACE INTO `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36853,-1666071,'You are fools to have come to this place! The icy winds of Northrend will consume your souls!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17007,1,0,0,''),
(36853,-1666072,'Suffer, mortals, as your pathetic magic betrays you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17014,1,0,0,''),
(36853,-1666073,'Can you feel the cold hand of death upon your heart?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17013,1,0,0,''),
(36853,-1666074,'Aaah! It burns! What sorcery is this?!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17015,1,0,0,''),
(36853,-1666075,'Your incursion ends here! None shall survive!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17012,1,0,0,''),
(36853,-1666076,'Now feel my master''s limitless power and despair!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17016,1,0,0,''),
(36853,-1666077,'Perish!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17008,1,0,0,''),
(36853,-1666078,'A flaw of mortality...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17009,1,0,0,''),
(36853,-1666079,'Enough! I tire of these games!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17011,1,0,0,''),
(36853,-1666080,'Free...at last...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17010,1,0,0,'');

-- 12
REPLACE INTO script_texts (entry,content_default,content_loc1,content_loc2,content_loc3,content_loc4,content_loc5,content_loc6,content_loc7,content_loc8,sound,type,language,emote,comment)VALUES
(-1810001, 'So...the Light''s vaunted justice has finally arrived. Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',null,null,null,null,null,null,null,null,17349,1,0,0,''),
(-1810002, 'We will grant you a swift death, Arthas. More than can be said for the thousands you''ve tortured and slain.',null,null,null,null,null,null,null,null,17390,1,0,0,''),
(-1810003, 'You will learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power.',null,null,null,null,null,null,null,null,17350,1,0,0,''),
(-1810004, 'So be it. Champions, attack!',null,null,null,null,null,null,null,null,17391,1,0,0,''),
(-1810005, 'I''ll keep you alive to witness the end, Fordring. I would not want the Light''s greatest champion to miss seeing this wretched world remade in my image.',null,null,null,null,null,null,null,null,17351,1,0,0,''),
(-1810006, 'Come then champions, feed me your rage!',null,null,null,null,null,null,null,null,17352,1,0,0,''),
(-1810007, 'I will freeze you from within until all that remains is an icy husk!',null,null,null,null,null,null,null,null,17369,1,0,0,''),
(-1810008, 'Apocalypse!',null,null,null,null,null,null,null,null,17371,1,0,0,''),
(-1810009, 'Bow down before your lord and master!',null,null,null,null,null,null,null,null,17372,1,0,0,''),
(-1810010, 'Hope wanes!',null,null,null,null,null,null,null,null,17363,1,0,0,''),
(-1810011, 'The end has come!',null,null,null,null,null,null,null,null,17364,1,0,0,''),
(-1810012, 'Face now your tragic end!',null,null,null,null,null,null,null,null,17365,1,0,0,''),
(-1810013, 'No question remains unanswered. No doubts linger. You are Azeroth''s greatest champions! You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught, your unbridled fury... Is it truly righteousness that drives you? I wonder.',null,null,null,null,null,null,null,null,17353,1,0,0,''),
(-1810014, 'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands -- exactly as I intended. You shall be rewarded for your unwitting sacrifice.',null,null,null,null,null,null,null,null,17355,1,0,0,''),
(-1810015, 'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth''s fall will come at their hands -- and you will be the first to die.',null,null,null,null,null,null,null,null,17356,1,0,0,''),
(-1810016, 'I delight in the irony.',null,null,null,null,null,null,null,null,17357,1,0,0,''),
(-1810017, 'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',null,null,null,null,null,null,null,null,17392,1,0,0,''),
(-1810018, 'Impossible...',null,null,null,null,null,null,null,null,17358,1,0,0,''),
(-1810020, 'No more, Arthas! No more lives will be consumed by your hatred!',null,null,null,null,null,null,null,null,17393,1,0,0,''),
(-1810021, 'Free at last! It is over, my son. This is the moment of reckoning.',null,null,null,null,null,null,null,null,17397,1,0,0,''),
(-1810022, 'The Lich King must fall!',null,null,null,null,null,null,null,null,17389,1,0,0,''),
(-1810023, 'Rise up, champions of the Light!',null,null,null,null,null,null,null,null,17398,1,0,0,''),
(-1810024, 'Now I stand, the lion before the lambs... and they do not fear.',null,null,null,null,null,null,null,null,17361,1,0,0,''),
(-1810025, 'They cannot fear.',null,null,null,null,null,null,null,null,17362,1,0,0,''),
(-1810026, 'Argh... Frostmourne, obey me!',null,null,null,null,null,null,null,null,17367,1,0,0,''),
(-1810027, 'Frostmourne hungers...',null,null,null,null,null,null,null,null,17366,1,0,0,''),
(-1810028, 'Frostmourne feeds on the soul of your fallen ally!',null,null,null,null,null,null,null,null,17368,1,0,0,''),
(-1810029, 'Val''kyr, your master calls!',null,null,null,null,null,null,null,null,17373,1,0,0,''),
(-1810030, 'Watch as the world around you collapses!',null,null,null,null,null,null,null,null,17370,1,0,0,''),
(-1810031, 'You gnats actually hurt me! Perhaps I''ve toyed with you long enough, now taste the vengeance of the grave!',null,null,null,null,null,null,null,null,17359,1,0,0,'');

-- Spells
REPLACE INTO `spell_proc_event` VALUES 
(70107, 0x08, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000054, 0x00000000, 0, 20, 0),
(69762, 0x00, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00014000, 0x00000000, 0, 101, 0),
(72178, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00055510, 0x00000000, 0, 100, 0),
(72176, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00051154, 0x00000000, 0, 100, 0),
(70602, 0x20, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x000AAA20, 0x00000000, 0, 100, 0),
(71494, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 101, 0),
(72176, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00051154, 0x00000000, 0, 100, 0),
(72178, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00055510, 0x00000000, 0, 100, 0),
(71604, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(70001, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(71971, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(72256, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000004, 0x00000000, 0, 100, 0),
(72408, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0),
(72455, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000008, 0x00000000, 0, 100, 0);

-- 9453
-- Lord Marrowgar
UPDATE `creature_template` SET `ScriptName`='boss_lord_marrowgar' WHERE `entry`=36612;
UPDATE `creature_template` SET `ScriptName`='npc_coldflame' WHERE `entry`=36672;
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE `entry`=38711;
-- Scripts
DELETE FROM `spell_script_names` WHERE `spell_id`=69057 AND `ScriptName`='spell_marrowgar_bone_spike_graveyard';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (69140,72705) AND `ScriptName`='spell_marrowgar_coldflame';
DELETE FROM `spell_script_names` WHERE `spell_id`=69147 AND `ScriptName`='spell_marrowgar_coldflame_trigger';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (69075,70834,70835,70836) AND `ScriptName`='spell_marrowgar_bone_storm';
REPLACE INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69057,'spell_marrowgar_bone_spike_graveyard'),
(69140,'spell_marrowgar_coldflame'),
(72705,'spell_marrowgar_coldflame'),
(69147,'spell_marrowgar_coldflame_trigger'),
(69075,'spell_marrowgar_bone_storm'),
(70834,'spell_marrowgar_bone_storm'),
(70835,'spell_marrowgar_bone_storm'),
(70836,'spell_marrowgar_bone_storm');

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_bone_spike';
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE `entry`=36619;
UPDATE `creature_template` SET `ScriptName`='boss_lady_deathwhisper' WHERE `entry`=36855;
UPDATE `creature_template` SET `ScriptName`='npc_cult_fanatic' WHERE `entry` IN (37890,38009,38135);
UPDATE `creature_template` SET `ScriptName`='npc_cult_adherent' WHERE `entry` IN(37949,38010,38136);
UPDATE `creature_template` SET `ScriptName`='npc_vengeful_shade' WHERE `entry`=38222;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (70903,71236) AND `ScriptName`='spell_cultist_dark_martyrdom';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70903,'spell_cultist_dark_martyrdom'),
(71236,'spell_cultist_dark_martyrdom');

DELETE FROM `spell_script_names` WHERE `spell_id`=70842 AND `ScriptName`='spell_deathwhisper_mana_barrier';
DELETE FROM `spell_script_names` WHERE `spell_id`=72202 AND `ScriptName`='spell_deathbringer_blood_link';
DELETE FROM `spell_script_names` WHERE `spell_id`=72178 AND `ScriptName`='spell_deathbringer_blood_link_aura';
DELETE FROM `spell_script_names` WHERE `spell_id`=72371 AND `ScriptName`='spell_deathbringer_blood_power';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (72409,72447,72448,72449) AND `ScriptName`='spell_deathbringer_rune_of_blood';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (72380,72438,72439,72440) AND `ScriptName`='spell_deathbringer_blood_nova';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70842,'spell_deathwhisper_mana_barrier'),
(72202,'spell_deathbringer_blood_link'),
(72178,'spell_deathbringer_blood_link_aura'),
(72371,'spell_deathbringer_blood_power'),
(72409,'spell_deathbringer_rune_of_blood'),
(72447,'spell_deathbringer_rune_of_blood'),
(72448,'spell_deathbringer_rune_of_blood'),
(72449,'spell_deathbringer_rune_of_blood'),
(72380,'spell_deathbringer_blood_nova'),
(72438,'spell_deathbringer_blood_nova'),
(72439,'spell_deathbringer_blood_nova'),
(72440,'spell_deathbringer_blood_nova');

DELETE FROM `spell_script_names` WHERE `spell_id`=70842 AND `ScriptName`='spell_deathwhisper_mana_barrier';
DELETE FROM `spell_script_names` WHERE `spell_id`=72202 AND `ScriptName`='spell_deathbringer_blood_link';
DELETE FROM `spell_script_names` WHERE `spell_id`=72178 AND `ScriptName`='spell_deathbringer_blood_link_aura';
DELETE FROM `spell_script_names` WHERE `spell_id`=72371 AND `ScriptName`='spell_deathbringer_blood_power';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (72409,72447,72448,72449) AND `ScriptName`='spell_deathbringer_rune_of_blood';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (72380,72438,72439,72440) AND `ScriptName`='spell_deathbringer_blood_nova';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70842,'spell_deathwhisper_mana_barrier'),
(72202,'spell_deathbringer_blood_link'),
(72178,'spell_deathbringer_blood_link_aura'),
(72371,'spell_deathbringer_blood_power'),
(72409,'spell_deathbringer_rune_of_blood'),
(72447,'spell_deathbringer_rune_of_blood'),
(72448,'spell_deathbringer_rune_of_blood'),
(72449,'spell_deathbringer_rune_of_blood'),
(72380,'spell_deathbringer_blood_nova'),
(72438,'spell_deathbringer_blood_nova'),
(72439,'spell_deathbringer_blood_nova'),
(72440,'spell_deathbringer_blood_nova');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12778,13036,13035,13037) AND `type` IN (0,11);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12778,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13036,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13035,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13037,11,0,0, 'achievement_ive_gone_and_made_a_mess');

UPDATE `creature_template` SET `ScriptName`='boss_deathbringer_saurfang' WHERE `entry`=37813;
UPDATE `creature_template` SET `ScriptName`='npc_high_overlord_saurfang_icc' WHERE `entry`=37187;
UPDATE `creature_template` SET `ScriptName`='npc_muradin_bronzebeard_icc' WHERE `entry`=37200;
UPDATE `creature_template` SET `ScriptName`='npc_saurfang_event' WHERE `entry` IN (37920,37830);

REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(37200,-1631029, 'Let''s get a move on then! Move ou...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16974,1,0,0, 'SAY_INTRO_ALLIANCE_1'),
(37813,-1631030, 'For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King''s armies grew. Even now the val''kyr work to raise your fallen as Scourge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16701,1,0,0, 'SAY_INTRO_ALLIANCE_2'),
(37813,-1631031, 'Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16702,1,0,0, 'SAY_INTRO_ALLIANCE_3'),
(37200,-1631032, 'A lone orc against the might of the Alliance???',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16970,1,0,0, 'SAY_INTRO_ALLIANCE_4'),
(37200,-1631033, 'Charge!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16971,1,0,0, 'SAY_INTRO_ALLIANCE_5'),
(37813,-1631034, 'Dwarves...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16703,1,0,0, 'SAY_INTRO_ALLIANCE_6'),
(37813,-1631035, 'Deathbringer Saurfang immobilizes Muradin and his guards.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_INTRO_ALLIANCE_7'),
(37187,-1631036, 'Kor''kron, move out! Champions, watch your backs. The Scourge have been...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17103,1,0,22, 'SAY_INTRO_HORDE_1'),
(37813,-1631037, 'Join me, father. Join me and we will crush this world in the name of the Scourge -- for the glory of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16704,1,0,0, 'SAY_INTRO_HORDE_2'),
(37187,-1631038, 'My boy died at the Wrath Gate. I am here only to collect his body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17097,0,0,397, 'SAY_INTRO_HORDE_3'),
(37813,-1631039, 'Stubborn and old. What chance do you have? I am stronger, and more powerful than you ever were.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16705,1,0,5, 'SAY_INTRO_HORDE_4'),
(37187,-1631040, 'We named him Dranosh. It means "Heart of Draenor" in orcish. I would not let the warlocks take him. My boy would be safe, hidden away by the elders of Garadar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17098,0,0,1, 'SAY_INTRO_HORDE_5'),
(37187,-1631041, 'I made a promise to his mother before she died; that I would cross the Dark Portal alone - whether I lived or died, my son would be safe. Untainted...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17099,0,0,1, 'SAY_INTRO_HORDE_6'),
(37187,-1631042, 'Today, I fulfill that promise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17100,0,0,397, 'SAY_INTRO_HORDE_7'),
(37187,-1631043, 'High Overlord Saurfang charges!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17104,2,0,53, 'SAY_INTRO_HORDE_8'),
(37813,-1631044, 'Pathetic old orc. Come then heroes. Come and face the might of the Scourge!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16706,1,0,15, 'SAY_INTRO_HORDE_9'),
(37813,-1631045, 'BY THE MIGHT OF THE LICH KING!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16694,1,0,0, 'SAY_AGGRO'),
(37813,-1631046, 'The ground runs red with your blood!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16699,1,0,0, 'SAY_MARK_OF_THE_FALLEN_CHAMPION'),
(37813,-1631047, 'Feast, my minions!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16700,1,0,0, 'SAY_BLOOD_BEASTS'),
(37813,-1631048, 'You are nothing!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16695,1,0,0, 'SAY_KILL_1'),
(37813,-1631049, 'Your soul will find no redemption here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16696,1,0,0, 'SAY_KILL_2'),
(37813,-1631050, 'Deathbringer Saurfang goes into frenzy!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'SAY_FRENZY'),
(37813,-1631051, 'I have become...DEATH!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16698,1,0,0, 'SAY_BERSERK'),
(37813,-1631052, 'I... Am... Released.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16697,1,0,0, 'SAY_DEATH'),
(37200,-1631053, 'Muradin Bronzebeard gasps for air.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16975,2,0,0, 'SAY_OUTRO_ALLIANCE_1'),
(37200,-1631054, 'That was Saurfang''s boy - the Horde commander at the Wrath Gate. Such a tragic end...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16976,0,0,0, 'SAY_OUTRO_ALLIANCE_2'),
(37200,-1631055, 'What in the... There, in the distance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16977,0,0,0, 'SAY_OUTRO_ALLIANCE_3'),
(    0,-1631056, 'A Horde Zeppelin flies up to the rise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_4'),
(37200,-1631057, 'Soldiers, fall in! Looks like the Horde are comin'' to take another shot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16978,1,0,0, 'SAY_OUTRO_ALLIANCE_5'),
(    0,-1631058, 'The Zeppelin docks, and High Overlord Saurfang hops out, confronting the Alliance soldiers and Muradin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_6'),
(37200,-1631059, 'Don''t force me hand, orc. We can''t let ye pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16972,0,0,0, 'SAY_OUTRO_ALLIANCE_7'),
(37187,-1631060, 'Behind you lies the body of my only son. Nothing will keep me from him.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17094,0,0,0, 'SAY_OUTRO_ALLIANCE_8'),
(37200,-1631061, 'I... I can''t do it. Get back on yer ship and we''ll spare yer life.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16973,0,0,0, 'SAY_OUTRO_ALLIANCE_9'),
(    0,-1631062, 'A mage portal from Stormwind appears between the two and Varian Wrynn and Jaina Proudmoore emerge.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_10'),
(37879,-1631063, 'Stand down, Muradin. Let a grieving father pass.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16690,0,0,0, 'SAY_OUTRO_ALLIANCE_11'),
(37187,-1631064, 'High Overlord Saurfang walks over to his son and kneels before his son''s body.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_12'),
(37187,-1631065, '[Orcish] No''ku kil zil''nok ha tar.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17096,0,0,0, 'SAY_OUTRO_ALLIANCE_13'),
(37187,-1631066, 'Higher Overlord Saurfang picks up the body of his son and walks over towards Varian',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0, 'SAY_OUTRO_ALLIANCE_14'),
(37187,-1631067, 'I will not forget this... kindness. I thank you, Highness',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17095,0,0,0, 'SAY_OUTRO_ALLIANCE_15'),
(37879,-1631068, 'I... I was not at the Wrath Gate, but the soldiers who survived told me much of what happened. Your son fought with honor. He died a hero''s death. He deserves a hero''s burial.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16691,0,0,0, 'SAY_OUTRO_ALLIANCE_16'),
(37188,-1631069, 'Lady Jaina Proudmoore cries.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16651,2,0,18, 'SAY_OUTRO_ALLIANCE_17'),
(37879,-1631070, 'Jaina? Why are you crying?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16692,0,0,0, 'SAY_OUTRO_ALLIANCE_18'),
(37188,-1631071, 'It was nothing, your majesty. Just... I''m proud of my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16652,0,0,0, 'SAY_OUTRO_ALLIANCE_19'),
(37879,-1631072, 'Bah! Muradin, secure the deck and prepare our soldiers for an assault on the upper citadel. I''ll send out another regiment from Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16693,0,0,0, 'SAY_OUTRO_ALLIANCE_20'),
(37200,-1631073, 'Right away, yer majesty!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16979,0,0,0, 'SAY_OUTRO_ALLIANCE_21'),
(37187,-1631074, 'High Overlord Saurfang coughs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17105,2,0,0, 'SAY_OUTRO_HORDE_1'),
(37187,-1631075, 'High Overlord Saurfang weeps over the corpse of his son.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17106,2,0,15, 'SAY_OUTRO_HORDE_2'),
(37187,-1631076, 'You will have a proper ceremony in Nagrand next to the pyres of your mother and ancestors.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17101,0,0,0, 'SAY_OUTRO_HORDE_3'),
(37187,-1631077, 'Honor, young heroes... no matter how dire the battle... Never forsake it!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17102,0,0,0, 'SAY_OUTRO_HORDE_4');

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
REPLACE INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
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

UPDATE `creature_template` SET `vehicleId`=533 WHERE `entry`=36619;

-- OTHER
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128,minlevel=80,maxlevel=80 WHERE `entry`=36672;

-- Achievements
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12775,12775,13393,13393,12962,12962,13394,13394,12770,12771,12772,12773,12945,12946,12947,12948,13039,13040,13041,13042,13050,13051,13052,13053);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
(12775,12,0,0), -- Boned (10 player) mode requirement (10N)
(12775,18,0,0), -- Boned (10 player) script requirement
(13393,12,2,0), -- Boned (10 player) mode requirement (10H)
(13393,18,0,0), -- Boned (10 player) script requirement
(12962,12,1,0), -- Boned (25 player) mode requirement (25N)
(12962,18,0,0), -- Boned (25 player) script requirement
(13394,12,3,0), -- Boned (25 player) mode requirement (25H)
(13394,18,0,0), -- Boned (25 player) script requirement
(12770,12,0,0), -- Storming the Citadel (10 player), Lord Marrowgar, mode requirement (10N)
(12771,12,0,0), -- Storming the Citadel (10 player), Claim victory in the Gunship Battle, mode requirement (10N)
(12772,12,0,0), -- Storming the Citadel (10 player), The Deathbringer, mode requirement (10N)
(12773,12,0,0), -- Storming the Citadel (10 player), Lady Deathwhisper, mode requirement (10N)
(12945,12,1,0), -- Storming the Citadel (25 player), Lord Marrowgar, mode requirement (25N)
(12946,12,1,0), -- Storming the Citadel (25 player), The Deathbringer, mode requirement (25N)
(12947,12,1,0), -- Storming the Citadel (25 player), Claim victory in the Gunship Battle, mode requirement (25N)
(12948,12,1,0), -- Storming the Citadel (25 player), Lady Deathwhisper, mode requirement (25N)
(13039,12,2,0), -- Heroic: Storming the Citadel (10 player), Lord Marrowgar, mode requirement (10H)
(13040,12,2,0), -- Heroic: Storming the Citadel (10 player), Lady Deathwhisper, mode requirement (10H)
(13041,12,2,0), -- Heroic: Storming the Citadel (10 player), Claim victory in the Gunship Battle, mode requirement (10H)
(13042,12,2,0), -- Heroic: Storming the Citadel (10 player), The Deathbringer, mode requirement (10H)
(13050,12,3,0), -- Heroic: Storming the Citadel (25 player), Lord Marrowgar, mode requirement (25H)
(13051,12,3,0), -- Heroic: Storming the Citadel (25 player), Lady Deathwhisper, mode requirement (25H)
(13052,12,3,0), -- Heroic: Storming the Citadel (25 player), Claim victory in the Gunship Battle, mode requirement (25H)
(13053,12,3,0); -- Heroic: Storming the Citadel (25 player), The Deathbringer, mode requirement (25H)

-- Deathbringer Saurfang
SET @NPCSaurfang10N := 37813;
SET @NPCSaurfang25N := 3781301;
SET @NPCSaurfang10H := 3781302;
SET @NPCSaurfang25H := 3781302;

-- High Overlord Saurfang
SET @NPCOverlord10N := 37187;
SET @NPCOverlord25N := 38156;
SET @NPCOverlord10H := 38637;
SET @NPCOverlord25H := 38638;

-- Deathbringer's Cache
SET @DeathbringerCacheGUID := 151165; -- reserved
SET @DeathbringerCache10N := 202239;
SET @DeathbringerCache25N := 202240;
SET @DeathbringerCache10H := 202238;
SET @DeathbringerCache25H := 202241;

-- Make Deathbringer Saurfang bind players to instance and set vehicle id
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x1 WHERE `entry`=37813;

-- Add trigger flag to Martyr Stalkers (else they hit like truck)
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x80 WHERE `entry` IN (38569,39010);

-- Fix factions
UPDATE `creature_template` SET `faction_A`=974, `faction_H`=974 WHERE `entry` IN (@NPCSaurfang10N,@NPCSaurfang25N,@NPCSaurfang10H,@NPCSaurfang25H); -- Deathbringer Saurfang
UPDATE `creature_template` SET `faction_A`=1735, `faction_H`=1735 WHERE `entry` IN (@NPCOverlord10N,@NPCOverlord25N,@NPCOverlord10H,@NPCOverlord25H); -- High Overlord Saurfang
UPDATE `creature_template` SET `faction_A`=1735, `faction_H`=1735 WHERE `entry`=37920; -- Kor'kron Reaver
UPDATE `creature_template` SET `faction_A`=894, `faction_H`=894 WHERE `entry`=37188; -- Jaina Proudmoore
UPDATE `creature_template` SET `faction_A`=1732, `faction_H`=1732 WHERE `entry`=37830; -- Skybreaker Marine
UPDATE `creature_template` SET `faction_A`=1732, `faction_H`=1732 WHERE `entry`=37200; -- Muradin Bronzebeard

-- Fix vehicleIds
UPDATE `creature_template` SET `VehicleId`=591 WHERE `entry` IN (@NPCSaurfang10N,@NPCSaurfang25N,@NPCSaurfang10H,@NPCSaurfang25H); -- Deathbringer Saurfang
UPDATE `creature_template` SET `VehicleId`=599 WHERE `entry` IN (@NPCOverlord10N,@NPCOverlord25N,@NPCOverlord10H,@NPCOverlord25H); -- High Overlord Saurfang

-- Fix NPCFlags
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` IN (@NPCOverlord10N,@NPCOverlord25N,@NPCOverlord10H,@NPCOverlord25H); -- High Overlord Saurfang

-- Set difficulty ids
UPDATE `creature_template` SET `difficulty_entry_1`=@NPCOverlord25N, `difficulty_entry_2`=@NPCOverlord10H, `difficulty_entry_3`=@NPCOverlord25H WHERE `entry`=@NPCOverlord10N; -- High Overlord Saurfang

-- Unclickable flag for doors
UPDATE `gameobject_template` SET `flags`=`flags`|0x1 WHERE `entry`=201825; -- Saurfang's Door
UPDATE `gameobject_template` SET `flags`=0x28 WHERE `entry`=202220; -- Lady Deathwhisper Elevator

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (70572,72202);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(13,0,70572,0,18,1,37920,0,0, '', 'Deathbringer Saurfang - Grip of Agony'),
(13,0,70572,0,18,1,37200,0,0, '', 'Deathbringer Saurfang - Grip of Agony'),
(13,0,70572,0,18,1,37187,0,0, '', 'Deathbringer Saurfang - Grip of Agony'),
(13,0,70572,0,18,1,37830,0,0, '', 'Deathbringer Saurfang - Grip of Agony'),
(13,0,72202,0,18,1,37813,0,0, '', 'Deathbringer Saurfang - Blood Link');

-- Deathbringer's Cache
DELETE FROM `gameobject` WHERE `id` IN (@DeathbringerCache10N,@DeathbringerCache25N,@DeathbringerCache10H,@DeathbringerCache25H) OR `guid` IN (@DeathbringerCacheGUID,@DeathbringerCacheGUID+1,@DeathbringerCacheGUID+2,@DeathbringerCacheGUID+3);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@DeathbringerCacheGUID,@DeathbringerCache10N,631,1,1,-489.7205,2172.06763,539.289368,2.652894,0,0,0,0,-120,0,1),
(@DeathbringerCacheGUID+1,@DeathbringerCache25N,631,2,1,-489.7205,2172.06763,539.289368,2.652894,0,0,0,0,-120,0,1),
(@DeathbringerCacheGUID+2,@DeathbringerCache10H,631,4,1,-489.7205,2172.06763,539.289368,2.652894,0,0,0,0,-120,0,1),
(@DeathbringerCacheGUID+3,@DeathbringerCache25H,631,8,1,-489.7205,2172.06763,539.289368,2.652894,0,0,0,0,-120,0,1);

-- Achievements
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12776,12997,12995,12998,12778,13036,13035,13037) AND `type`!=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12776,12,0,0, ''), -- Full House (10 player) N
(12997,12,1,0, ''), -- Full House (25 player) N
(12995,12,2,0, ''), -- Full House (10 player) H
(12998,12,3,0, ''), -- Full House (25 player) H
(12778,12,0,0, ''), -- I've Gone and Made a Mess (10 player) N
(13036,12,1,0, ''), -- I've Gone and Made a Mess (25 player) N
(13035,12,2,0, ''), -- I've Gone and Made a Mess (10 player) H
(13037,12,3,0, ''); -- I've Gone and Made a Mess (25 player) H

-- Creature templates
DELETE FROM `creature_template` WHERE `entry` IN (3718701,3718702,3718703); -- delete invalid
DELETE FROM `creature_template` WHERE `entry` IN (@NPCOverlord25N,@NPCOverlord10H,@NPCOverlord25H); -- delete before insert
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`equipment_id`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`WDBVerified`) VALUES
(@NPCOverlord25N,0,0,0,0,0,30583,0,0,0, 'High Overlord Saurfang (1)', '', '',0,83,83,2,1735,1735,1,1,1.14286,1,3,509,683,0,805,35,0,0,1,33600,8,0,0,0,0,0,371,535,135,7,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,599,0,0, '',0,3,300,1,1,0,0,0,0,0,0,0,164,1,0,0,0, '',1),
(@NPCOverlord10H,0,0,0,0,0,30583,0,0,0, 'High Overlord Saurfang (2)', '', '',0,83,83,2,1735,1735,1,1,1.14286,1,3,509,683,0,805,35,0,0,1,33600,8,0,0,0,0,0,371,535,135,7,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,599,0,0, '',0,3,300,1,1,0,0,0,0,0,0,0,164,1,0,0,0, '',1),
(@NPCOverlord25H,0,0,0,0,0,30583,0,0,0, 'High Overlord Saurfang (3)', '', '',0,83,83,2,1735,1735,1,1,1.14286,1,3,509,683,0,805,35,0,0,1,33600,8,0,0,0,0,0,371,535,135,7,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,599,0,0, '',0,3,300,1,1,0,0,0,0,0,0,0,164,1,0,0,0, '',1);

-- Empowered Adherent
SET @eAdN := 38136;
SET @eAd1 := 38396;
SET @eAd2 := 38632;
SET @eAd3 := 38633;

-- Reanimated Adherent
SET @rAdN := 38010;
SET @rAd1 := 38397;
SET @rAd2 := 39000;
SET @rAd3 := 39001;

-- Reanimated Fanatic
SET @rFaN := 38009;
SET @rFa1 := 38398;
SET @rFa2 := 38630;
SET @rFa3 := 38631;

-- Deformed Fanatic
SET @dFaN := 38135;
SET @dFa1 := 38395;
SET @dFa2 := 38634;
SET @dFa3 := 38635;

-- Make Lord Marrowgar and Lady Deathwhisper bind players to instance
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x1 WHERE `entry` IN (36612,36855);

-- Add trigger flag
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x80 WHERE `entry`=37948;

-- Fix factions for Lady Deathwhisper adds
UPDATE `creature_template` SET `faction_A`=21, `faction_H`=21 WHERE `entry` IN (@rAdN,@eAdN); -- Adherents
UPDATE `creature_template` SET `faction_A`=21, `faction_H`=21 WHERE `entry` IN (@rFaN,@dFaN); -- Fanatics

-- Difficulty entries
UPDATE `creature_template` SET `difficulty_entry_1`=@rAd1, `difficulty_entry_2`=@rAd2, `difficulty_entry_3`=@rAd3 WHERE `entry`=@rAdN; -- Reanimated Adherent
UPDATE `creature_template` SET `difficulty_entry_1`=@eAd1, `difficulty_entry_2`=@eAd2, `difficulty_entry_3`=@eAd3 WHERE `entry`=@eAdN; -- Empowered Adherent
UPDATE `creature_template` SET `difficulty_entry_1`=@rFa1, `difficulty_entry_2`=@rFa2, `difficulty_entry_3`=@rFa3 WHERE `entry`=@rFaN; -- Reanimated Fanatic
UPDATE `creature_template` SET `difficulty_entry_1`=@dFa1, `difficulty_entry_2`=@dFa2, `difficulty_entry_3`=@dFa3 WHERE `entry`=@dFaN; -- Deformed Fanatic

-- Difficulty templates for Lady Deathwhisper adds
DELETE FROM `creature_template` WHERE `entry` IN (@rAd1,@rAd2,@rAd3,@eAd1,@eAd2,@eAd3,@rFa1,@rFa2,@rFa3,@dFa1,@dFa2,@dFa3);
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`equipment_id`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`WDBVerified`) VALUES
(@rAd1,0,0,0,0,0,30966,0,0,0, 'Reanimated Adherent (1)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@rAd2,0,0,0,0,0,30966,0,0,0, 'Reanimated Adherent (2)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@rAd3,0,0,0,0,0,30966,0,0,0, 'Reanimated Adherent (3)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@eAd1,0,0,0,0,0,30965,0,0,0, 'Empowered Adherent (1)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@eAd2,0,0,0,0,0,30965,0,0,0, 'Empowered Adherent (2)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@eAd3,0,0,0,0,0,30965,0,0,0, 'Empowered Adherent (3)', '', '',0,80,80,2,21,21,0,1,1.14286,1,1,417,582,0,608,7.5,0,0,2,0,8,0,0,0,0,0,341,506,80,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,10,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@rFa1,0,0,0,0,0,30968,0,0,0, 'Reanimated Fanatic (1)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@rFa2,0,0,0,0,0,30968,0,0,0, 'Reanimated Fanatic (2)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@rFa3,0,0,0,0,0,30968,0,0,0, 'Reanimated Fanatic (3)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,1032,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,0,1,0,0,0, '',1),
(@dFa1,0,0,0,0,0,22124,0,0,0, 'Deformed Fanatic (1)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,84,1,0,0,0, '',1),
(@dFa2,0,0,0,0,0,22124,0,0,0, 'Deformed Fanatic (2)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,84,1,0,0,0, '',1),
(@dFa3,0,0,0,0,0,22124,0,0,0, 'Deformed Fanatic (3)', 'Cult of the Damned', '',0,80,80,2,21,21,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,8,0,0,0,0,0,345,509,103,6,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, '',0,3,10,1,1,0,0,0,0,0,0,0,84,1,0,0,0, '',1);

-- Unclickable flag for doors
UPDATE `gameobject_template` SET `flags`=`flags`|0x1 WHERE `entry` IN (201910,201911,201857,201563);
-- Saurfang Extra Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72260;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,72260,0,18,1,37920,0,0, '', 'Deathbringer Saurfang - Mark of the Fallen Champion heal');

-- StartUP errors fix:
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
 ('36939','0','0','0','0','0','30416','0','0','0','High Overlord Saurfang','','','0','83','83','2','1801','1801','0','1.5','1.14286','1','1','351','527','0','132','62.9','1500','1500','1','32768','8','0','0','0','0','0','281','422','106','7','76','0','0','0','0','0','0','0','0','0','15284','70309','0','0','0','0','0','0','0','0','0','0','','0','3','175','1','1','0','0','0','0','0','0','0','164','1','2021','646922239','0','generic_creature','12340'),
 ('38156','0','0','0','0','0','30583','0','0','0','High Overlord Saurfang (1)','','','0','83','83','2','1735','1735','1','1','1.14286','1','3','509','683','0','805','35','0','0','1','33600','8','0','0','0','0','0','371','535','135','7','12','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','599','0','0','','0','3','300','1','1','0','0','0','0','0','0','0','164','1','0','0','0','','1'),
 ('38637','0','0','0','0','0','30583','0','0','0','High Overlord Saurfang (2)','','','0','83','83','2','1735','1735','1','1','1.14286','1','3','509','683','0','805','35','0','0','1','33600','8','0','0','0','0','0','371','535','135','7','12','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','599','0','0','','0','3','300','1','1','0','0','0','0','0','0','0','164','1','0','0','0','','1'),
 ('38638','0','0','0','0','0','30583','0','0','0','High Overlord Saurfang (3)','','','0','83','83','2','1735','1735','1','1','1.14286','1','3','509','683','0','805','35','0','0','1','33600','8','0','0','0','0','0','371','535','135','7','12','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','599','0','0','','0','3','300','1','1','0','0','0','0','0','0','0','164','1','0','0','0','','1');
 
 -- -------------------------------------------------------------------------
-- -------------------------- Halls of Reflection --------------------------
-- -------------------------------------------------------------------------
-- Creature Templates 
UPDATE `creature_template` SET `speed_walk`='1.5', `speed_run`='2.0' WHERE `entry` in (36954, 37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRintro' WHERE `entry` in (37221, 37223);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_falric' WHERE `entry`=38112;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_marwyn' WHERE `entry`=38113;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_lich_king_hr' WHERE `entry`=36954;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry`=37226;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRextro' WHERE `entry` in (36955, 37554);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_raging_gnoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_abon' WHERE `entry`=37069;
UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` in (37221, 36955);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` in (37223, 37554);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='1' WHERE `entry`=37223;
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` in (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags`='768', `type_flags`='268435564' WHERE `entry` in (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;
/*
UPDATE `creature_template` SET `equipment_id`='38112' WHERE `entry`=38112;
UPDATE `creature_template` SET `equipment_id`='38113' WHERE `entry`=38113;
*/
UPDATE `creature_template` set `scale`='1' where `entry` in (37223);
UPDATE `instance_template` SET `script` = 'instance_hall_of_reflection' WHERE map=668;
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` in (197341, 202302, 201385, 201596);
UPDATE `creature` SET `phaseMask` = 128 WHERE `id` = 36993; 
UPDATE `creature` SET `phaseMask` = 64 WHERE `id` = 36990; 
UPDATE `instance_template` SET `script` = 'instance_halls_of_reflection' WHERE map=668;

/*
DELETE FROM `creature` WHERE `map` = 668 AND `id` IN (38177,38176,38173,38172,38567,38175,36940,36941,37069);
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (135341, 38112, 668, 3, 1, 0, 0, 5276.81, 2037.45, 709.32, 5.58779, 604800, 0, 0, 377468, 0, 0, 0);
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (135342, 38113, 668, 3, 1, 0, 0, 5341.72, 1975.74, 709.32, 2.40694, 604800, 0, 0, 539240, 0, 0, 0);
*/

/*
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` IN (202236,202302);
UPDATE `gameobject_template` SET `faction` = '114' WHERE `entry` IN (197341, 201976);
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` IN (197341, 202302, 201385, 201596);
UPDATE `creature_template` SET `Scriptname`=' ' WHERE `entry` IN (38112,38113,37221,37223,38175,38172,38567,38177,38173,38176);
UPDATE `creature_template` SET `ScriptName`='generic_creature' WHERE `entry` IN (38177,38176,38173,38172,38567,38175);
UPDATE `creature_template` SET `speed_walk`='1.5', `speed_run`='2.0' WHERE `entry` IN (36954, 37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRintro' WHERE `entry` IN (37221, 37223);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_falric' WHERE `entry` IN (38112);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_marwyn' WHERE `entry` IN (38113);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_lich_king_hr' WHERE `entry` IN (36954);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry` IN (37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRextro' WHERE `entry` IN (36955, 37554);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='generic_creature' WHERE `entry` IN (36940,36941,37069);
UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` IN (37221, 36955);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` IN (37223, 37554);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='1' WHERE `entry` IN (37223);
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` IN (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags`='768', `type_flags`='268435564' WHERE `entry` IN (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` SET `equipment_id`='38113' WHERE `entry` IN (38113);
UPDATE `creature_template` SET `equipment_id`='38112' WHERE `entry` IN (38112);
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 11686, `modelid3` = 11686, `modelid4` = 11686 WHERE `entry` IN (37014,37704);
*/

/*
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (37014, 0, 0, 0, 0, 0, 169, 16925, 0, 0, 'Ice Wall Target', '', '', 0, 1, 1, 2, 35, 35, 0, 1, 1.14286, 1, 0, 1, 2, 0, 0, 1, 2000, 2000, 1, 0, 8, 0, 0, 0, 0, 0, 1, 2, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 12340);
*/

/*
-- Conditions
REPLACE INTO `conditions`  VALUES 
(13, 0, 69431, 0, 18, 1, 37496, 0, 0, NULL),
(13, 0, 69431, 0, 18, 1, 37497, 0, 0, NULL),
(13, 0, 69431, 0, 18, 1, 37584, 0, 0, NULL),
(13, 0, 69431, 0, 18, 1, 37587, 0, 0, NULL),
(13, 0, 69431, 0, 18, 1, 37588, 0, 0, NULL),
(13, 0, 69708, 0, 18, 1, 37226, 0, 0, NULL),
(13, 0, 69784, 0, 18, 1, 37014, 0, 0, NULL),
(13, 0, 70194, 0, 18, 1, 37226, 0, 0, NULL),
(13, 0, 70224, 0, 18, 1, 37014, 0, 0, NULL),
(13, 0, 70225, 0, 18, 1, 37014, 0, 0, NULL),
(13, 0, 70464, 0, 18, 1, 36881, 0, 0, NULL);
*/

/*
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES 
('13', '70464', '18', '1', '36881'),
('13', '69708', '18', '1', '37226'),
('13', '70194', '18', '1', '37226'),
('13', '69784', '18', '1', '37014'),
('13', '69784', '18', '1', '37014'),
('13', '70224', '18', '1', '37014'),
('13', '70225', '18', '1', '37014'),
('13', '69431', '18', '1', '37497'),
('13', '69431', '18', '1', '37496'),
('13', '69431', '18', '1', '37496'),
('13', '69431', '18', '1', '37588'),
('13', '69431', '18', '1', '37584'),
('13', '69431', '18', '1', '37587');

REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '70464', '18', '1', '36881');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '69708', '18', '1', '37226');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '70194', '18', '1', '37226');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '69784', '18', '1', '37014');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '69784', '18', '1', '37014');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '70224', '18', '1', '37014');
REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES ('13', '70225', '18', '1', '37014');
*/

/*
REPLACE INTO `creature_equip_template` VALUES ('38112', '50249', '49777', '0'); #Falric
REPLACE INTO `creature_equip_template` VALUES ('38113', '50248', '50248', '0'); #Marwyn

REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (14531739, 201596, 668, 1, 128, 5275.28, 1694.23, 786.147, 0.981225, 0, 0, 0.471166, 0.882044, 25, 0, 1);

DELETE from `creature` WHERE `id` IN (36955,37554,37226);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(36955, 668, 3, 128, 0, 0, 5547.27, 2256.95, 733.011, 0.835987, 7200, 0, 0, 252000, 881400, 0, 0),
(37554, 668, 3, 64, 0, 0, 5547.27, 2256.95, 733.011, 0.835987, 7200, 0, 0, 252000, 881400, 0, 0),
(37226, 668, 3, 1, 0, 0, 5551.29, 2261.33, 733.012, 4.0452, 604800, 0, 0, 27890000, 0, 0, 0);
*/

/*
UPDATE `gameobject_template` SET `flags` = 0 WHERE `gameobject_template`.`entry` IN (202212,201710,202337,202336);
UPDATE `gameobject_template` SET `faction` = '114',`data0` = '0' WHERE `gameobject_template`.`entry` IN (197341,197342,197343);

UPDATE `gameobject` SET `state` = '1' WHERE `id` IN (197341,197342,197343);

-- Captains chest (override)
DELETE FROM `gameobject` WHERE `id` IN (202212,201710,202337,202336);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(972561, 202212, 668, 1, 65535,  5241.047, 1663.4364, 784.295166, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(972562, 201710, 668, 1, 65535,  5241.047, 1663.4364, 784.295166, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(972563, 202337, 668, 2, 65535,  5241.047, 1663.4364, 784.295166, 0.54, 0, 0, 0, 0, -604800, 100, 1),
(972564, 202336, 668, 2, 65535,  5241.047, 1663.4364, 784.295166, 0.54, 0, 0, 0, 0, -604800, 100, 1);
-- Dalaran portal (override)
DELETE FROM `gameobject` WHERE `guid` IN (972565);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(972565, 202079, 668, 3, 65535, 5250.959961, 1639.359985, 784.302, 0, 0, 0, 0, 0, -604800, 100, 1);
DELETE FROM `gameobject` WHERE `id` IN (201385,201596,202079);
*/

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
# SCENE - Hall Of Reflection (Intro) - PreUther
(-1594433, 'The chill of this place freezes the marrow of my bones!', 'Как же тут холодно... Кровь стынет в жилах.', 16631,0,0,1, '67234'),
(-1594434, 'I... I don\'t believe it! Frostmourne stands before us, unguarded! Just as the Gnome claimed. Come, heroes!', 'Я... Я не верю своим глазам. Ледяная скорбь перед нами без всякой охраны! Как и говорил гном. Вперед герои!', 17049,0,0,1, '67234'),
(-1594435, 'What is that? Up ahead! Could it be ... ? Heroes at my side!', 'Что это там впереди? Неужели? Скорее герои!', 16632,1,0,1, '67234'),
(-1594436, 'Frostmourne ... The blade that destroyed our kingdom ...', 'Ледяная Скорбь, клинок, разрушивший наше королевство...', 16633,1,0,1, '67234'),
(-1594437, 'Standing this close to the blade that ended my life... The pain... It is renewed.', 'Боль снова захлестывает меня, когда я так близко вижу меч, отнявший у меня жизнь.', 17050,0,0,1, '67234'),
(-1594438, 'Stand back! Touch that blade and your soul will be scarred for all eternity! I must attempt to commune with the spirits locked away within Frostmourne. Give me space, back up please!', 'Отойдите. Тот кто коснется этого клинка обречет себя на вечные муки. Я попытаюсь заговорить с душами заключенными в Ледяной скорби. Расступитесь... Чуть назад! Прошу.', 16634,1,0,1, '67234'),
(-1594439, 'I dare not touch it. Stand back! Stand back! As I attempt to commune with the blade. Perhaps our salvation lies within.', 'Я не смею его коснуться. Назад! Отступите! Я попробую установить связь с мечом. Возможно, спасение находится внутри!', 17051,1,0,1, '67234'),
-- SCENE - Hall Of Reflection (Intro) - UtherDialog
(-1594440, 'Jaina! Could it truly be you?', 'Джайна? Неужели это ты?', 16666,0,0,1, '67234'),
(-1594441, 'Careful, girl. I\'ve heard talk of that cursed blade saving us before. Look around you and see what has been born of Frostmourne.', 'Осторожней девочка! Однажды мне уже говорили, что этот проклятый меч может нас спасти. Посмотри вокруг, и ты увидишь, что из этого вышло.', 16659,0,0,1, '67234'),
(-1594442, 'Uther! Dear Uther! I... I\'m so sorry.', 'Утер? Милый Утер! Мне... Мне так жаль.', 16635,0,0,1, '67234'),
(-1594443, 'Uther...Uther the Lightbringer. How...', 'Утер? Утер Светоносный? Как...', 17052,0,0,1, '67234'),
(-1594444, 'Jaina, you haven\'t much time. The Lich King sees what the sword sees. He will be here shortly.', 'Джайна, у вас мало времени. Король - Лич видит все что видит Ледяная Скорбь. Вскоре он будет здесь.', 16667,0,0,1, '67234'),
(-1594445, 'You haven\'t much time. The Lich King sees what the sword sees. He will be here shortly.', 'У вас мало времени. Король - Лич видит все что видит Ледяная Скорбь. Вскоре он будет здесь.', 16660,0,0,1, '67234'),
(-1594446, 'Arthas is here? Maybe I...', 'Артас здесь? Может я...', 16636,0,0,1, '67234'),
(-1594447, 'The Lich King is here? Then my destiny shall be fulfilled today!', 'Король - Лич здесь? Значит моя судьба решится сегодня!', 17053,1,0,1, '67234'),
(-1594448, 'No, girl. Arthas is not here. Arthas is merely a presence within the Lich King\'s mind. A dwindling presence...', 'Нет девочка. Артаса здесь нет. Артас лишь тень, мелькающая в сознании Короля - Лича. Смутная тень.', 16668,0,0,1, '67234'),
(-1594449, 'You cannot defeat the Lich King. Not here. You would be a fool to try. He will kill those who follow you and raise them as powerful servants of the Scourge. But for you, Sylvanas, his reward for you would be worse than the last.', 'Вам не победить Короля - Лича. Покрайней мере не здесь. Глупо и пытаться. Он убьет твоих соратников и воскресит их как воинов плети. Но что до тебя Сильвана, он готовит тебе участь еще страшнее, чем в прошлый раз.', 16661,0,0,1, '67234'),
(-1594450, 'But Uther, if there\'s any hope of reaching Arthas. I... I must try.', 'Но если есть малейшая надежда вернуть Артаса... Я должна попытаться!', 16637,0,0,1, '67234'),
(-1594451, 'There must be a way...', 'Должен быть способ!', 17054,0,0,1, '67234'),
(-1594452, 'Jaina, listen to me. You must destroy the Lich King. You cannot reason with him. He will kill you and your allies and raise you all as powerful soldiers of the Scourge.', 'Джайна послушай меня. Вам нужно уничтожить Короля - Лича. С ним нельзя договориться. Он убьет вас всех и превратит в могущественных воинов Плети.', 16669,0,0,1, '67234'),
(-1594453, 'Perhaps, but know this: there must always be a Lich King. Even if you were to strike down Arthas, another would have to take his place, for without the control of the Lich King, the Scourge would wash over this world like locusts, destroying all that they touched.', 'Возможно... Но знай! Король - Лич должен быть всегда. Даже если вы убьете Артаса кто то обязан будет занять его место. Лишившись правителя Плеть налетит на мир как стая саранчи и уничтожит все на своем пути.', 16662,0,0,1, '67234'),
(-1594454, 'Tell me how, Uther? How do I destroy my prince? My...', 'Но как Утер? Как мне убить моего принца, моего...', 16638,0,0,1, '67234'),
(-1594455, 'Who could bear such a burden?', 'Кому по силам такое бремя?', 17055,0,0,1, '67234'),
(-1594456, 'Snap out of it, girl. You must destroy the Lich King at the place where he merged with Ner\'zhul - atop the spire, at the Frozen Throne. It is the only way.', 'Забудь об этом девочка. Короля - Лича нужно уничтожить на том месте, где он слился с Нерзулом. На самой вершине, у Ледяного Трона!', 16670,0,0,1, '67234'),
(-1594457, 'I do not know, Banshee Queen. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 'Не знаю, Королева Баньши... Если бы не Артас, который все еще является частью Короля - Лича, Плеть давно бы уже уничтожила Азерот.', 16663,0,0,1, '67234'),
(-1594458, 'You\'re right, Uther. Forgive me. I... I don\'t know what got a hold of me. We will deliver this information to the King and the knights that battle the Scourge within Icecrown Citadel.', 'Ты прав Утер, прости меня... Я не знаю что на меня нашло. Мы передадим твои слова Королю и рыцарям, которые сражаются с Плетью в Цитадели Ледяной Короны.', 16639,0,0,1, '67234'),
(-1594459, 'There is... something else that you should know about the Lich King. Control over the Scourge must never be lost. Even if you were to strike down the Lich King, another would have to take his place. For without the control of its master, the Scourge would run rampant across the world - destroying all living things.', 'Тебе нужно знать еще кое что о Короле - Личе. Плеть не должна выйти из под контроля. Даже если вы убьете Короля - Лича, кто-то должен будет занять его место. Без Короля Плеть налетит на мир как стая саранчи и уничтожит все живое.', 16671,0,0,1, '67234'),
(-1594460, 'Alas, the only way to defeat the Lich King is to destroy him at the place he was created.', 'Увы единственый способ одолеть Короля - Лича - это убить его там где он был порожден.', 16664,0,0,1, '67234'),
(-1594461, 'Who could bear such a burden?', 'Кому по силам такое бремя?', 16640,0,0,1, '67234'),
(-1594462, 'The Frozen Throne...', 'Ледяной Трон!', 17056,0,0,1, '67234'),
(-1594463, 'A grand sacrifice by a noble soul...', 'Великая жертва, благородной души.', 16672,0,0,1, '67234'),
(-1594464, 'I do not know, Jaina. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 'Не знаю Джайна... мне кажется если бы не Артас, который все еще является частью Короля - Лича, Плеть давно бы уже уничтожила Азерот.', 16673,0,0,1, '67234'),
(-1594465, 'Then maybe there is still hope...', 'Но может еще есть надежда?', 16641,0,0,1, '67234'),
(-1594466, 'No, Jaina! ARRRRRRGHHHH... He... He is coming. You... You must...', 'Нет Джайна... Эээээ... Он... Он приближается... Вы... Вы должны...', 16674,1,0,1, '67234'),
(-1594467, 'Aye. ARRRRRRGHHHH... He... He is coming. You... You must...', 'Да... Эээээ... Он... Он приближается... Вы... Вы должны...', 16665,1,0,1, '67234'),
(-1594468, 'SILENCE, PALADIN!', 'Замолчи, паладин.', 17225,1,0,0, '67234'),
(-1594469, 'So you wish to commune with the dead? You shall have your wish.', 'Так ты хочешь поговорить с мертвыми? Нет ничего проще!', 17226,1,0,0, '67234'),
(-1594470, 'Falric. Marwyn. Bring their corpses to my chamber when you are through.', 'Фалрик, Марвин, когда закончите, принесите их тела в мои покои.', 17227,0,0,0, '67234'),
(-1594471, 'You won\'t deny me this, Arthas! I must know... I must find out...', 'Ты от меня не отмахнешься Артас. Я должна понять, я должна знать.', 16642,1,0,1, '67234'),
(-1594472, 'You will not escape me that easily, Arthas! I will have my vengeance!', 'Ты так просто от меня не уйдешь Артас. Я отомщу тебе!', 17057,1,0,1, '67234'),
(-1594473, '<need translate>', 'Глупая девчонка! Тот кого ты ищещь давно убит! Теперь он лишь призрак, слабый отзвук в моем сознании!', 17229,1,0,0, '67234'),
(-1594474, '<need translate>', 'Я не повторю прежней ошибки, Сильвана. На этот раз тебе не спастись. Ты не оправдала моего доверия и теперь тебя ждет только забвение!', 17228,1,0,0, '67234'),
(-1594475, 'As you wish, my lord.', 'Как пожелаете, мой господин!', 16717,1,0,0, '67234'),
(-1594476, 'As you wish, my lord.', 'Как пожелаете, мой господин!', 16741,1,0,0, '67234'),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.', 'Твои союзники прибыли, Джайна! Как ты и обещала... Ха-ха-ха-ха... Все вы станете могучими солдатами Плети...', 17212,1,0,0, '67234'),
(-1594478, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 'Я не повторю прежней ошибки, Сильвана! На этот раз тебе не спастись. Вы все будите служить мне после смерти...', 17213,1,0,0, '67234'),
(-1594479, 'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', 'Он слишком силен. Мы должны выбраться от сюда как можно скорее. Моя магия задержит его ненадолго, быстрее герои...', 16644,0,0,1, '67234'),
(-1594480, 'He\'s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.', 'Он слишком силен. Герои скорее, за мной. Мы должны выбраться отсюда немедленно. Я постараюсь его задержать, пока мы будем убегать.', 17058,0,0,1, '67234'),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481, 'Death\'s cold embrace awaits.', 'Смерть распростерла ледяные обьятия!', 17221,1,0,0, '67234'),
(-1594482, 'Rise minions, do not left them us!', 'Восстаньте прислужники, не дайте им сбежать!', 17216,1,0,0, '67234'),
(-1594483, 'Minions sees them. Bring their corpses back to me!', 'Схватите их! Принесите мне их тела!', 17222,1,0,0, '67234'),
(-1594484, 'No...', 'Надежды нет!', 17214,1,0,0, '67234'),
(-1594485, 'All is lost!', 'Смирись с судьбой.', 17215,1,0,0, '67234'),
(-1594486, 'There is no escape!', 'Бежать некуда!', 17217,1,0,0, '67234'),
(-1594487, 'I will destroy this barrier. You must hold the undead back!', 'Я разрушу эту преграду, а вы удерживайте нежить на расстоянии!', 16607,1,0,0, '67234'),
(-1594488, 'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!', 'Никакие стены не удержат Королеву Баньши. Держите нежить на расстоянии, я сокрушу эту преграду.', 17029,1,0,0, '67234'),
(-1594489, 'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!', 'Опять ледяная стена... Я разобью ее, только не дайте нежити прервать мои заклинания...', 16608,1,0,0, '67234'),
(-1594490, 'Another barrier? Stand strong, champions! I will bring the wall down!', 'Еще одна преграда. Держитесь герои! Я разрушу эту стену!', 17030,1,0,0, '67234'),
(-1594491, 'Succumb to the chill of the grave.', 'Покоритесь Леденящей смерти!', 17218,1,0,0, '67234'),
(-1594492, 'Another dead end.', 'Вы в ловушке!', 17219,1,0,0, '67234'),
(-1594493, 'How long can you fight it?', 'Как долго вы сможете сопротивляться?', 17220,1,0,0, '67234'),
(-1594494, '<need translate>', 'Он с нами играет. Я  покажу ему что бывает когда лед встречается со огнем!', 16609,0,0,0, '67234'),
(-1594495, 'Your barriers can\'t hold us back much longer, monster. I will shatter them all!', 'Твои преграды больше не задержат нас, чудовище. Я смету их с пути!', 16610,1,0,0, '67234'),
(-1594496, 'I grow tired of these games, Arthas! Your walls can\'t stop me!', 'Я устала от этих игр Артас. Твои стены не остановят меня!', 17031,1,0,0, '67234'),
(-1594497, 'You won\'t impede our escape, fiend. Keep the undead off me while I bring this barrier down!', 'Ты не помешаешь нам уйти, монстр. Сдерживайте нежить, а я уничтожу эту преграду.', 17032,1,0,0, '67234'),
(-1594498, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 16645,1,0,0, '67234'),
(-1594499, 'We\'re almost there... Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 16646,1,0,0, '67234'),
(-1594500, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 17059,1,0,0, '67234'),
(-1594501, 'We\'re almost there! Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 17060,1,0,0, '67234'),
(-1594502, 'It... It\'s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!', 'Больше некуда бежать. Теперь нам придется сражаться. Это наша последняя битва!', 16647,1,0,0, '67234'),
(-1594503, 'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', 'Проклятый тупик, значит все закончится здесь. Готовьтесь герои, это наша последняя битва.', 17061,1,0,0, '67234'),
(-1594504, 'Nowhere to run! You\'re mine now...', 'Ха-ха-ха... Бежать некуда. Теперь вы мои!', 17223,1,0,0, '67234'),
(-1594505, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 'Солдаты Лордерона, восстаньте по зову Господина!', 16714,1,0,0, '67234'),
(-1594506, 'The master surveyed his kingdom and found it... lacking. His judgement was swift and without mercy. Death to all!', 'Господин осмотрел свое королевство и признал его негодным! Его суд был быстрым и суровым - предать всех смерти!', 16738,1,0,0, '67234'),
-- Falric
(-1594507, 'Men, women and children... None were spared the master\'s wrath. Your death will be no different.', 'Мужчины, Женщины и дети... Никто не избежал гнева господина. Вы разделите их участь!', 16710,1,0,0, '67234'),
(-1594508, 'Marwyn, finish them...', 'Марвин... Добей их...', 16713,1,0,0, '67234'),
(-1594509, 'Sniveling maggot!', 'Сопливый червяк!', 16711,1,0,0, '67234'),
(-1594510, 'The children of Stratholme fought with more ferocity!', 'Стратхольмские детишки - и те сражались отчаяннее!', 16712,1,0,0, '67234'),
(-1594511, 'Despair... so delicious...', 'Как сладостно отчаянье!', 16715,1,0,0, '67234'),
(-1594512, 'Fear... so exhilarating...', 'Как приятен страх!', 16716,1,0,0, '67234'),
-- Marwyn
(-1594513, 'Death is all that you will find here!', 'Вы найдете здесь лишь смерть!', 16734,1,0,0, '67234'),
(-1594514, 'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.', 'Эээээ... Да... Бегите навстречу судьбе. Ее жестокие и холодные обьятия ждут вас...', 16737,1,0,0, '67234'),
(-1594515, 'I saw the same look in his eyes when he died. Terenas could hardly believe it. Hahahaha!', 'У Теренаса был такой же взгляд в миг смерти, он никак не мог поверить... Ха-ха-ха-ха-ха...', 16735,1,0,0, '67234'),
(-1594516, 'Choke on your suffering!', 'Захлебнись страданием!', 16736,1,0,0, '67234'),
(-1594517, 'Your flesh shall decay before your very eyes!', 'Вы увидите как разлагается ваша плоть!', 16739,1,0,0, '67234'),
(-1594518, 'Waste away into nothingness!', 'Сгиньте без следа!', 16740,1,0,0, '67234'),
-- FrostWorn General
(-1594519, 'You are not worthy to face the Lich King!', 'Вы недостойны предстать перед Королем - Личом!', 16921,1,0,0, '67234'),
(-1594520, 'Master, I have failed...', 'Господин... Я подвел вас...', 16922,1,0,0, '67234'),
-- Add
(-1594531, '<need translate>', 'Ну теперь-то точно пора сваливать.', 0,0,0,0, '67234'),
(-1594532, '<need translate>', 'Вот вам сундук за работу.', 0,0,0,0, '67234'),
(-1594533, '<need translate>', 'И, поскольку корабля с оффа не будет, вот вам портал в Даларан.', 0,0,0,0, '67234');

/*
# Gossips
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -3594540 AND -3594530;
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `content_loc8`, `comment`) VALUES
(-3594536, 'Lady Jaina, we are ready for next mission!', 'Джайна, мы готовы!',''),
(-3594537, 'Lady Jaina, Let\'s go!', 'Давай быстрее!', ''),
(-3594538, 'Lady Sylvanas, we are ready for next mission!', 'Сильвана, мы готовы!', ''),
(-3594539, 'Lady Sylvanas, Let\'s go!', 'Поехали!', ''),
(-3594540, 'Let\'s go!', 'Побежали!', '');
*/

-- Waypoints to escort event on Halls of reflection
DELETE FROM script_waypoint WHERE entry IN (36955,37226,37554);
INSERT INTO script_waypoint VALUES
-- Jaina

   (36955, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (36955, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (36955, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (36955, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (36955, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (36955, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (36955, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (36955, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (36955, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (36955, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (36955, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (36955, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (36955, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (36955, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (36955, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (36955, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (36955, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (36955, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (36955, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (36955, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (36955, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (36955, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Sylvana

   (37554, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (37554, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (37554, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (37554, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (37554, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (37554, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (37554, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (37554, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (37554, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (37554, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37554, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37554, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37554, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (37554, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37554, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37554, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37554, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (37554, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37554, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37554, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (37554, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (37554, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Lich King

   (37226, 0, 5577.187,2236.003,733.012, 0, 'WP1'),
   (37226, 1, 5587.682,2228.586,733.011, 0, 'WP2'),
   (37226, 2, 5600.715,2209.058,731.618, 0, 'WP3'),
   (37226, 3, 5606.417,2193.029,731.129, 0, 'WP4'),
   (37226, 4, 5598.562,2167.806,730.918, 0, 'WP5'), 
   (37226, 5, 5559.218,2106.802,731.229, 0, 'WP6'),
   (37226, 6, 5543.498,2071.234,731.702, 0, 'WP7'),
   (37226, 7, 5528.969,2036.121,731.407, 0, 'WP8'),
   (37226, 8, 5512.045,1996.702,735.122, 0, 'WP9'),
   (37226, 9, 5504.490,1988.789,735.886, 0, 'WP10'),
   (37226, 10, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37226, 11, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37226, 12, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37226, 13, 5445.157,1894.955,748.757, 0, 'WP13'),
   (37226, 14, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37226, 15, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37226, 16, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37226, 17, 5335.422,1766.951,767.635, 0, 'WP17'),
   (37226, 18, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37226, 19, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37226, 20, 5278.694,1697.912,785.692, 0, 'WP20'),
   (37226, 21, 5283.589,1703.755,784.176, 0, 'WP19');
   
/* Original Icewalls from YTDB
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(3485, 201385, 668, 3, 1, 5540.39, 2086.48, 731.066, 1.00057, 0, 0, 0.479677, 0.877445, 604800, 100, 1),
(3438, 201385, 668, 3, 1, 5494.3, 1978.27, 736.689, 1.0885, 0, 0, 0.517777, 0.855516, 604800, 100, 1),
(3386, 201385, 668, 3, 1, 5434.27, 1881.12, 751.303, 0.923328, 0, 0, 0.445439, 0.895312, 604800, 100, 1),
(3383, 201385, 668, 3, 1, 5323.61, 1755.85, 770.305, 0.784186, 0, 0, 0.382124, 0.924111, 604800, 100, 1);
*/

DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (37068,37107,37158);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
 ('3706801', '37068', '0', '0', '100', '3', '3600', '5400', '3700', '5400', '11', '69933', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Baleful Strike'),
 ('3706802', '37068', '0', '0', '100', '5', '3600', '5400', '3700', '5400', '11', '70400', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Baleful Strike'),
 ('3706803', '37068', '0', '0', '100', '3', '4200', '7300', '4300', '6100', '11', '69900', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Spirit Burst'),
 ('3706800', '37068', '0', '0', '100', '5', '4200', '7300', '4300', '6100', '11', '73046', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Spirit Burst'),
 ('3710700', '37107', '0', '0', '100', '3', '3600', '5400', '3700', '5400', '11', '69933', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Baleful Strike'),
 ('3710701', '37107', '0', '0', '100', '5', '3600', '5400', '3700', '5400', '11', '70400', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Baleful Strike'),
 ('3710702', '37107', '0', '0', '100', '3', '4200', '7300', '4300', '6100', '11', '69900', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Spirit Burst'),
 ('3710703', '37107', '0', '0', '100', '5', '4200', '7300', '4300', '6100', '11', '73046', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiritual Reflection - Cast Spirit Burst'),
 ('3715801', '37158', '0', '0', '100', '7', '6300', '9500', '12300', '15300', '11', '67541', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Quel\'Delar - Cast Bladestorm'),
 ('3715800', '37158', '0', '0', '100', '7', '2800', '4400', '3200', '6100', '11', '29426', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Quel\'Delar - Cast Heroic Strike'),
 ('3715803', '37158', '0', '0', '100', '7', '4400', '5100', '1600', '5200', '11', '16856', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Quel\'Delar - Cast Mortal Strike'),
 ('3715802', '37158', '0', '0', '100', '7', '6200', '9400', '5300', '9900', '11', '67716', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Quel\'Delar - Cast Whirlwind');
 
UPDATE creature_template SET  AIName='EventAI' WHERE entry IN   (37068,37107,37158);

-- ---------------------------------------------------
-- ----------------- Forge of Souls ------------------
-- ---------------------------------------------------
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (37107,37158,37774,37582,21925,37496,37587,37584,37588,37587,37498,37583,37779,36522,36499,36478,36666,36551,36564,36620,36516);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
 ('3777410', '37774', '0', '0', '100', '7', '11000', '11000', '20000', '45000', '11', '22746', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Cast Cone of Cold'),
 ('3777407', '37774', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Stop Movement on Aggro'),
 ('3777411', '37774', '4', '0', '100', '2', '0', '0', '0', '0', '11', '51779', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Cast Frostfire Bolt and Set Phase 1 on Aggro'),
 ('3777408', '37774', '3', '0', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3777409', '37774', '0', '6', '100', '3', '0', '0', '1500', '3000', '11', '51779', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Cast Frostfire Bolt above 15% Mana (Phase 1)'),
 ('3777414', '37774', '3', '5', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3777403', '37774', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Start Movement Beyond 30 Yards'),
 ('3777402', '37774', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - On Evade set Phase to 0'),
 ('3777400', '37774', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Stop Movement on Aggro'),
 ('3777404', '37774', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70616', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Cast Frostfire Bolt and Set Phase 1 on Aggro'),
 ('3777406', '37774', '3', '0', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3777413', '37774', '0', '6', '100', '5', '0', '0', '1500', '3000', '11', '70616', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Cast Frostfire Bolt above 15% Mana (Phase 1)'),
 ('3777401', '37774', '3', '5', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3777412', '37774', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - Start Movement Beyond 30 Yards'),
 ('3777405', '37774', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Elandra - On Evade set Phase to 0'),
 ('3758209', '37582', '0', '0', '100', '7', '11000', '11000', '20000', '45000', '11', '22746', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Cast Cone of Cold'),
 ('3758210', '37582', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Stop Movement on Aggro'),
 ('3758211', '37582', '4', '0', '100', '2', '0', '0', '0', '0', '11', '51779', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Cast Frostfire Bolt and Set Phase 1 on Aggro'),
 ('3758212', '37582', '3', '0', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3758215', '37582', '0', '6', '100', '3', '0', '0', '1500', '3000', '11', '51779', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Cast Frostfire Bolt above 15% Mana (Phase 1)'),
 ('3758202', '37582', '3', '5', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3758214', '37582', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Start Movement Beyond 30 Yards'),
 ('3758213', '37582', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - On Evade set Phase to 0'),
 ('3758207', '37582', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Stop Movement on Aggro'),
 ('3758206', '37582', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70616', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Cast Frostfire Bolt and Set Phase 1 on Aggro'),
 ('3758205', '37582', '3', '0', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3758200', '37582', '0', '6', '100', '5', '0', '0', '1500', '3000', '11', '70616', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Cast Frostfire Bolt above 15% Mana (Phase 1)'),
 ('3758201', '37582', '3', '5', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3758208', '37582', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Start Movement Beyond 30 Yards'),
 ('3758203', '37582', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - On Evade set Phase to 0'),
 ('3758204', '37582', '0', '0', '100', '7', '12000', '12000', '19000', '24000', '11', '22645', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Archmage Koreln - Casts Frost Nova'),
 ('2192507', '21925', '0', '0', '100', '7', '15000', '15500', '25500', '30000', '11', '34017', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Casts Rain of Chaos'),
 ('2192506', '21925', '0', '0', '100', '6', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Stop Movement on Aggro'),
 ('2192505', '21925', '4', '0', '100', '6', '0', '0', '0', '0', '11', '12471', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Cast Frostbolt and Set Phase 1 on Aggro'),
 ('2192504', '21925', '3', '0', '100', '6', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('2192503', '21925', '0', '6', '100', '7', '0', '0', '1500', '3000', '11', '12471', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Cast FrostBolt above 15% Mana (Phase 1)'),
 ('2192502', '21925', '3', '5', '100', '6', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('2192501', '21925', '9', '0', '100', '7', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - Start Movement Beyond 30 Yards'),
 ('2192500', '21925', '7', '0', '100', '6', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Avatar of Sathal - On Evade set Phase to 0'),
 ('3749601', '37496', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3749600', '37496', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3758703', '37587', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3758701', '37587', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3758400', '37584', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3758401', '37584', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3758800', '37588', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3758801', '37588', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3758700', '37587', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3758702', '37587', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3749802', '37498', '2', '0', '100', '7', '10', '0', '10300', '12900', '11', '69350', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Raise Dead When Below 10% HP'),
 ('3749803', '37498', '0', '0', '100', '7', '10000', '14000', '20500', '22900', '11', '69413', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Coliseum Champion  - Cast Strangulating'),
 ('3758316', '37583', '4', '0', '100', '2', '0', '0', '0', '0', '11', '31942', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Ranger Kalira - Cast Multi-Shot on Aggro'),
 ('3758317', '37583', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70513', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Ranger Kalira - Cast Multi-Shot on Aggro'),
 ('3777900', '37779', '4', '0', '100', '2', '0', '0', '0', '0', '11', '31942', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Ranger Loralen - Cast Multi-Shot on Aggro'),
 ('3777901', '37779', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70513', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Dark Ranger Loralen - Cast Multi-Shot on Aggro'),
 ('3652200', '36522', '0', '0', '100', '3', '8000', '10000', '16000', '22000', '11', '69088', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soul Horror - Casts Soul Strike'),
 ('3652201', '36522', '0', '0', '100', '5', '8000', '10000', '16000', '22000', '11', '70211', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soul Horror - Casts Soul Strike'),
 ('3649902', '36499', '0', '0', '100', '3', '12000', '15000', '19000', '24000', '11', '69060', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Reaper  - Casts Frost Nova'),
 ('3649901', '36499', '0', '0', '100', '5', '12000', '15000', '19000', '24000', '11', '70209', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Reaper  - Casts Frost Nova'),
 ('3649900', '36499', '0', '0', '100', '7', '10000', '14000', '22000', '29000', '11', '69058', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Reaper - Casts Shadow Lance'),
 ('3647800', '36478', '0', '0', '100', '7', '9000', '14000', '25000', '30000', '11', '69056', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Watchman  - Casts Shroud of Runes'),
 ('3647801', '36478', '1', '0', '100', '7', '1000', '1000', '1800000', '1800000', '11', '69053', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Watchman - Casts Unholy Rage on Spawn'),
 ('3666600', '36666', '0', '0', '100', '7', '10000', '14000', '27000', '30000', '11', '69633', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spectral Warden  - Casts Spectral Warden'),
 ('3666602', '36666', '0', '0', '100', '3', '15000', '17000', '29000', '35000', '11', '69148', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spectral Warden - Cast Wail of Souls'),
 ('3666601', '36666', '0', '0', '100', '5', '15000', '17000', '29000', '35000', '11', '70210', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spectral Warden - Cast Wail of Souls'),
 ('3655100', '36551', '0', '0', '100', '3', '15000', '17000', '29000', '35000', '11', '68895', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiteful Apparition - Cast Spite'),
 ('3655101', '36551', '0', '0', '100', '5', '15000', '17000', '29000', '35000', '11', '70212', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spiteful Apparition - Cast Spite'),
 ('3656401', '36564', '0', '0', '100', '3', '15000', '17000', '29000', '35000', '11', '69080', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Bone Volley'),
 ('3656404', '36564', '0', '0', '100', '5', '15000', '17000', '29000', '35000', '11', '70206', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Bone Volley'),
 ('3656402', '36564', '0', '0', '100', '3', '5000', '7000', '17000', '19000', '11', '69069', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Shield of Bones'),
 ('3656405', '36564', '0', '0', '100', '5', '5000', '7000', '17000', '19000', '11', '70207', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Shield of Bones'),
 ('3656403', '36564', '4', '0', '100', '2', '0', '0', '0', '0', '11', '31942', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Raise Dead'),
 ('3656400', '36564', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70513', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Bonecaster - Cast Raise Dead'),
 ('3662002', '36620', '2', '0', '100', '3', '55', '0', '10300', '12900', '11', '69066', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept  - Cast Drain Life When Below 25% HP'),
 ('3662004', '36620', '2', '0', '100', '5', '55', '0', '10300', '12900', '11', '70213', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept  - Cast Drain Life When Below 25% HP'),
 ('3662000', '36620', '0', '0', '100', '7', '5000', '7000', '29000', '35000', '11', '69562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adep - Cast Raise Dead'),
 ('3662001', '36620', '14', '0', '90', '2', '320', '40', '0', '0', '11', '69564', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adep - Casts Shadow Mend on Friendlies'),
 ('3662003', '36620', '14', '0', '90', '4', '320', '40', '0', '0', '11', '70205', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adep - Casts Shadow Mend on Friendlies'),
 ('3651609', '36516', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Stop Movement on Aggro'),
 ('3651611', '36516', '4', '0', '100', '2', '0', '0', '0', '0', '11', '69068', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3651612', '36516', '3', '0', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3651613', '36516', '0', '6', '100', '3', '0', '0', '1500', '3000', '11', '69068', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Shadow Bolt above 15% Mana (Phase 1)'),
 ('3651600', '36516', '3', '5', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3651610', '36516', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Start Movement Beyond 30 Yards'),
 ('3651608', '36516', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - On Evade set Phase to 0'),
 ('3651615', '36516', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Stop Movement on Aggro'),
 ('3651607', '36516', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70208', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3651606', '36516', '3', '0', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3651604', '36516', '0', '6', '100', '5', '0', '0', '1500', '3000', '11', '70208', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3651603', '36516', '3', '5', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3651602', '36516', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - Start Movement Beyond 30 Yards'),
 ('3651601', '36516', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adept - On Evade set Phase to 0'),
 ('3651616', '36516', '0', '0', '100', '7', '5000', '7000', '29000', '35000', '11', '69562', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Adep - Cast Raise Dead'),
 ('3651614', '36516', '0', '0', '100', '7', '12000', '15000', '19000', '24000', '11', '69128', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Animator  - Casts Soul Siphon'),
 ('3651605', '36516', '0', '0', '100', '7', '10000', '14000', '22000', '28000', '11', '69131', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Soulguard Animator  - Casts Soul Sickness');

UPDATE creature_template SET  AIName='EventAI' WHERE entry IN   (37107,37158,37774,37582,21925,37496,37587,37584,37588,37587,37498,37583,37779,36522,36499,36478,36666,36551,36564,36620,36516);

-- -------------------------------------------------
-- ----------------- Pit of Saron ------------------
-- -------------------------------------------------
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN  (36764,31260,36767,36766,37665,36788,37712,37711,37713,36874,36765,36841,38487,37575,37572,37576,37577,37578,37579,36886,37581,36770,36772,36773,36771,36891,37580,36879,36661,36896,36896,36842,36830,37728,36892,36840,36893);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
 ('3676400', '36764', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Demoralizing Shout'),
 ('3676401', '36764', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Heroic Strike'),
 ('3676700', '36767', '0', '0', '100', '7', '5000', '5000', '16000', '18000', '11', '70421', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Blizzard'),
 ('3676707', '36767', '0', '0', '100', '6', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Stop Movement on Aggro'),
 ('3676701', '36767', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69570', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Fireball and Set Phase 1 on Aggro'),
 ('3676703', '36767', '3', '13', '100', '6', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3676706', '36767', '0', '13', '100', '7', '0', '0', '1500', '3000', '11', '69570', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Fireball above 15% Mana (Phase 1)'),
 ('3676705', '36767', '3', '11', '100', '6', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3676702', '36767', '9', '0', '100', '7', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Start Movement Beyond 30 Yards'),
 ('3676704', '36767', '7', '0', '100', '6', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - On Evade set Phase to 0'),
 ('3676600', '36766', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Demoralizing Shout'),
 ('3676601', '36766', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Heroic Strike'),
 ('3676501', '36765', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69569', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Earth Shield on Aggro'),
 ('3676502', '36765', '0', '0', '100', '7', '9000', '11000', '15000', '21000', '11', '35199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Healing Stream Totem'),
 ('3676500', '36765', '14', '0', '100', '6', '25000', '40', '0', '0', '11', '70425', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Chain Heal on Friendlies'),
 ('3678810', '36788', '0', '0', '80', '3', '3000', '5000', '11000', '17000', '11', '70269', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Conversion Beam'),
 ('3678809', '36788', '0', '0', '80', '5', '3000', '5000', '11000', '17000', '11', '69578', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Conversion Beam'),
 ('3678811', '36788', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Stop Movement on Aggro'),
 ('3678812', '36788', '4', '0', '100', '2', '0', '0', '0', '0', '11', '69577', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3678813', '36788', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3678806', '36788', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '69577', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3678814', '36788', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3678815', '36788', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement Beyond 30 Yards'),
 ('3678808', '36788', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - On Evade set Phase to 0'),
 ('3678807', '36788', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Stop Movement on Aggro'),
 ('3678800', '36788', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70270', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3678801', '36788', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3678802', '36788', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '70270', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3678804', '36788', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3678805', '36788', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement Beyond 30 Yards'),
 ('3678803', '36788', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - On Evade set Phase to 0'),
 ('3771211', '37712', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Shadowcaster- Stop Movement on Aggro'),
 ('3771210', '37712', '4', '0', '100', '2', '0', '0', '0', '0', '11', '70386', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3771209', '37712', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3771208', '37712', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '70386', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3771207', '37712', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3771206', '37712', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement Beyond 30 Yards'),
 ('3771213', '37712', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - On Evade set Phase to 0'),
 ('3771205', '37712', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Stop Movement on Aggro'),
 ('3771212', '37712', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70387', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3771204', '37712', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3771202', '37712', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '70387', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3771201', '37712', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3771200', '37712', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - Start Movement Beyond 30 Yards'),
 ('3771203', '37712', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Necrolyte - On Evade set Phase to 0'),
 ('3771300', '37713', '0', '0', '100', '7', '5000', '5000', '13000', '19000', '11', '70392', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Torturer - Cast Black Brand'),
 ('3771301', '37713', '0', '0', '80', '7', '3000', '8000', '11000', '15000', '11', '70391', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Deathwhisper Torturer - Cast Curse of Agony'),
 ('3687400', '36874', '0', '0', '100', '7', '4000', '7000', '12000', '16000', '11', '55216', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Disturbed Glacial Revenant - Cast Avalanche'),
 ('3684102', '36841', '0', '0', '75', '7', '3000', '4000', '12000', '12000', '11', '69579', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Arcing Slice'),
 ('3684101', '36841', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '61044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Demoralizing Shout'),
 ('3684100', '36841', '0', '0', '75', '7', '5000', '5000', '21000', '22000', '11', '69580', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Shield Block'),
 ('3848702', '38487', '0', '0', '75', '7', '3000', '4000', '12000', '12000', '11', '69579', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Arcing Slice'),
 ('3848700', '38487', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '61044', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Demoralizing Shout'),
 ('3848701', '38487', '0', '0', '75', '7', '5000', '5000', '21000', '22000', '11', '69580', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Fallen Warrior - Cast Shield Block'),
 ('3757500', '37575', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69569', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Alliance Slave - Cast Earth Shield on Aggro'),
 ('3757501', '37575', '0', '0', '100', '7', '9000', '11000', '15000', '21000', '11', '35199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Allia nce Slave - Cast Healing Stream Totem'),
 ('3757502', '37575', '14', '0', '100', '6', '25000', '40', '0', '0', '11', '70425', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Alliance Slave - Cast Chain Heal on Friendlies'),
 ('3757200', '37572', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Alliance Slave - Cast Demoralizing Shout'),
 ('3757201', '37572', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Alliance Slave - Cast Heroic Strike'),
 ('3757202', '37572', '0', '0', '100', '7', '3000', '7000', '10000', '21000', '11', '59992', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Alliance Slave - Cast Cleave'),
 ('3757604', '37576', '0', '0', '100', '7', '5000', '5000', '16000', '18000', '11', '70421', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Blizzard'),
 ('3757605', '37576', '0', '0', '100', '6', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Stop Movement on Aggro'),
 ('3757606', '37576', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69570', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Fireball and Set Phase 1 on Aggro'),
 ('3757600', '37576', '3', '13', '100', '6', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3757608', '37576', '0', '13', '100', '7', '0', '0', '1500', '3000', '11', '69570', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Fireball above 15% Mana (Phase 1)'),
 ('3757602', '37576', '3', '11', '100', '6', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3757603', '37576', '9', '0', '100', '7', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Start Movement Beyond 30 Yards'),
 ('3757607', '37576', '7', '0', '100', '6', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - On Evade set Phase to 0'),
 ('3757601', '37576', '0', '0', '100', '7', '15000', '15000', '35000', '38000', '11', '46604', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Alliance Slave - Cast Ice Block'),
 ('3757702', '37577', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Demoralizing Shout'),
 ('3757700', '37577', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Heroic Strike'),
 ('3757701', '37577', '0', '0', '100', '7', '3000', '7000', '10000', '21000', '11', '59992', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Cleave'),
 ('3757801', '37578', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69569', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Earth Shield on Aggro'),
 ('3757800', '37578', '0', '0', '100', '7', '9000', '11000', '15000', '21000', '11', '35199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Healing Stream Totem'),
 ('3757802', '37578', '14', '0', '100', '6', '25000', '40', '0', '0', '11', '70425', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Freed Horde Slave - Cast Chain Heal on Friendlies'),
 ('3757907', '37579', '0', '0', '100', '7', '5000', '5000', '16000', '18000', '11', '70421', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Blizzard'),
 ('3757906', '37579', '0', '0', '100', '6', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Stop Movement on Aggro'),
 ('3757905', '37579', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69570', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Fireball and Set Phase 1 on Aggro'),
 ('3757904', '37579', '3', '13', '100', '6', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Horde Slave - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3757903', '37579', '0', '13', '100', '7', '0', '0', '1500', '3000', '11', '69570', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Fireball above 15% Mana (Phase 1)'),
 ('3757900', '37579', '3', '11', '100', '6', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Horde Slave - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3757901', '37579', '9', '0', '100', '7', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Start Movement Beyond 30 Yards'),
 ('3757902', '37579', '7', '0', '100', '6', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - On Evade set Phase to 0'),
 ('3757908', '37579', '0', '0', '100', '7', '15000', '15000', '35000', '38000', '11', '46604', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Ice Block'),
 ('3688600', '36886', '0', '0', '100', '2', '0', '0', '0', '0', '11', '69504', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Geist Ambusher - Cast Leaping Face Maul'),
 ('3688601', '36886', '0', '0', '100', '4', '0', '0', '0', '0', '11', '70271', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Geist Ambusher - Cast Leaping Face Maul'),
 ('3758105', '37581', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Gorkun Ironskull - Cast Demoralizing Shout'),
 ('3758104', '37581', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Gorkun Ironskull - Cast Heroic Strike'),
 ('3758103', '37581', '0', '0', '100', '7', '3000', '7000', '10000', '21000', '11', '59992', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Gorkun Ironskull - Cast Cleave'),
 ('3677008', '36770', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Demoralizing Shout'),
 ('3677009', '36770', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Heroic Strike'),
 ('3677201', '36772', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Demoralizing Shout'),
 ('3677200', '36772', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Heroic Strike'),
 ('3677307', '36773', '0', '0', '100', '7', '5000', '5000', '16000', '18000', '11', '70421', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Blizzard'),
 ('3677306', '36773', '0', '0', '100', '6', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Stop Movement on Aggro'),
 ('3677303', '36773', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69570', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Fireball and Set Phase 1 on Aggro'),
 ('3677302', '36773', '3', '13', '100', '6', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Horde Slave - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3677301', '36773', '0', '13', '100', '7', '0', '0', '1500', '3000', '11', '69570', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Fireball above 15% Mana (Phase 1)'),
 ('3677300', '36773', '3', '11', '100', '6', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Horde Slave - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3677304', '36773', '9', '0', '100', '7', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Start Movement Beyond 30 Yards'),
 ('3677305', '36773', '7', '0', '100', '6', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - On Evade set Phase to 0'),
 ('3677100', '36771', '4', '0', '100', '6', '0', '0', '0', '0', '11', '69569', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Earth Shield on Aggro'),
 ('3677102', '36771', '0', '0', '100', '7', '9000', '11000', '15000', '21000', '11', '35199', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Healing Stream Totem'),
 ('3677101', '36771', '14', '0', '100', '6', '25000', '40', '0', '0', '11', '70425', '6', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Horde Slave - Cast Chain Heal on Friendlies'),
 ('3771100', '37711', '2', '0', '100', '6', '45', '0', '0', '0', '11', '70393', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Hungering Ghoul - Devour Flesh at 45% HP'),
 ('3689101', '36891', '0', '0', '100', '3', '5000', '8000', '18000', '25000', '11', '69527', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Iceborn Proto-Drake - Cast Frost Breath'),
 ('3689100', '36891', '0', '0', '100', '5', '5000', '8000', '18000', '25000', '11', '70272', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Iceborn Proto-Drake - Cast Frost Breath'),
 ('3758002', '37580', '0', '0', '100', '7', '8000', '8000', '33000', '35000', '11', '69565', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Martin Victus - Cast Demoralizing Shout'),
 ('3758001', '37580', '0', '0', '100', '7', '5000', '5000', '13000', '15000', '11', '69566', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Martin Victus - Cast Heroic Strike'),
 ('3758000', '37580', '0', '0', '100', '7', '3000', '7000', '10000', '21000', '11', '59992', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Martin Victus - Cast Cleave'),
 ('3687900', '36879', '0', '0', '100', '3', '3000', '5000', '12000', '17000', '11', '69581', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Plagueborn Horror - Cast Pustulant Flesh'),
 ('3687901', '36879', '0', '0', '100', '5', '3000', '5000', '12000', '17000', '11', '70273', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Plagueborn Horror - Cast Pustulant Flesh'),
 ('3687903', '36879', '0', '0', '100', '7', '6000', '7000', '15000', '20000', '11', '70274', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Plagueborn Horror - Cast Toxic Waste'),
 ('3687902', '36879', '2', '0', '100', '6', '10', '0', '0', '0', '11', '69582', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Plagueborn Horror - Blight Bomb at 10% HP'),
 ('3666100', '36661', '0', '0', '100', '7', '5000', '5000', '15000', '18000', '11', '69246', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Rimefang - Cast Hoarfrost'),
 ('3689632', '36896', '0', '0', '100', '3', '3000', '5000', '14000', '17000', '11', '69520', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stonespine Gargoyle - Cast Gargoyle Strike'),
 ('3689633', '36896', '0', '0', '100', '5', '3000', '5000', '14000', '17000', '11', '70275', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stonespine Gargoyle - Cast Gargoyle Strike'),
 ('3689634', '36896', '0', '0', '100', '7', '8000', '8000', '25000', '25000', '11', '69575', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Stonespine Gargoyle - Cast Stoneform'),
 ('3684214', '36842', '0', '0', '100', '3', '3000', '5000', '14000', '17000', '11', '69574', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Freezing Circle'),
 ('3684213', '36842', '0', '0', '100', '5', '3000', '5000', '14000', '17000', '11', '70276', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Freezing Circle'),
 ('3684215', '36842', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Stop Movement on Aggro'),
 ('3684212', '36842', '4', '0', '100', '2', '0', '0', '0', '0', '11', '69573', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3684200', '36842', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3684201', '36842', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '69573', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3684202', '36842', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3684203', '36842', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement Beyond 30 Yards'),
 ('3684204', '36842', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3684205', '36842', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Stop Movement on Aggro'),
 ('3684206', '36842', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70277', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3684207', '36842', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3684208', '36842', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '70277', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3684209', '36842', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3684210', '36842', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Start Movement Beyond 30 Yards'),
 ('3684211', '36842', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3683001', '36830', '0', '0', '100', '3', '3000', '5000', '14000', '15000', '11', '70278', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Laborer - Cast Puncture Wound Strike'),
 ('3683000', '36830', '0', '0', '100', '5', '3000', '5000', '14000', '15000', '11', '70279', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Laborer - Cast Puncture Wound Strike'),
 ('3683002', '36830', '0', '0', '100', '3', '8000', '8000', '10000', '21000', '11', '69572', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Laborer - Cast Shovelled!'),
 ('3683003', '36830', '0', '0', '100', '3', '8000', '8000', '10000', '21000', '11', '70280', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Laborer - Cast Shovelled!'),
 ('3683004', '36830', '4', '0', '100', '6', '0', '0', '0', '0', '11', '70302', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Laborer - Cast Blinding Dirt'),
 ('3772810', '37728', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Stop Movement on Aggro'),
 ('3772811', '37728', '4', '0', '100', '2', '0', '0', '0', '0', '11', '75330', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3772812', '37728', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3772813', '37728', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '75330', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3772805', '37728', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3772806', '37728', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement Beyond 30 Yards'),
 ('3772800', '37728', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3772801', '37728', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Stop Movement on Aggro'),
 ('3772802', '37728', '4', '0', '100', '4', '0', '0', '0', '0', '11', '75331', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3772809', '37728', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3772803', '37728', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '75331', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3772804', '37728', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3772807', '37728', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Start Movement Beyond 30 Yards'),
 ('3772808', '37728', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3689205', '36892', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Stop Movement on Aggro'),
 ('3689206', '36892', '4', '0', '100', '2', '0', '0', '0', '0', '11', '69528', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3689207', '36892', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3689214', '36892', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '69528', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3689210', '36892', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3689212', '36892', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement Beyond 30 Yards'),
 ('3689211', '36892', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3689209', '36892', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Stop Movement on Aggro'),
 ('3689208', '36892', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70281', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Cast Shadow Bolt and Set Phase 1 on Aggro'),
 ('3689202', '36892', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3689204', '36892', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '70281', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Cast Shadow Bolt above 15% Mana (Phase 1)'),
 ('3689203', '36892', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3689200', '36892', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith- Start Movement Beyond 30 Yards'),
 ('3689201', '36892', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Wrathbone Coldwraith - On Evade set Phase to 0'),
 ('3689213', '36892', '0', '0', '100', '7', '6000', '6000', '25000', '27000', '11', '69516', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Deathbringer - Cast Summon Undead'),
 ('3684001', '36840', '0', '0', '100', '3', '5000', '5000', '14000', '18000', '11', '69603', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Wrathbringer - Cast Blight'),
 ('3684000', '36840', '0', '0', '100', '5', '5000', '5000', '14000', '18000', '11', '70285', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Wrathbringer - Cast Blight'),
 ('3126001', '31260', '0', '0', '100', '7', '5000', '6000', '12000', '15000', '11', '70291', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Skycaller - Cast Frostblade'),
 ('3126000', '31260', '0', '0', '100', '7', '8000', '9000', '16000', '21000', '11', '70292', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Skycaller - Cast Glacial Strike'),
 ('3689329', '36893', '0', '0', '100', '3', '8000', '8000', '25000', '25000', '11', '69586', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Hellfire'),
 ('3689316', '36893', '0', '0', '100', '5', '8000', '8000', '25000', '25000', '11', '70283', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Hellfire'),
 ('3689328', '36893', '0', '0', '100', '7', '10000', '10000', '21000', '21000', '11', '69584', '4', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Tactical Blink'),
 ('3689327', '36893', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer- Stop Movement on Aggro'),
 ('3689326', '36893', '4', '0', '100', '2', '0', '0', '0', '0', '11', '69583', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Fireball and Set Phase 1 on Aggro'),
 ('3689318', '36893', '3', '13', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3689319', '36893', '0', '13', '100', '3', '0', '0', '1500', '3000', '11', '69583', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Fireball above 15% Mana (Phase 1)'),
 ('3689315', '36893', '3', '11', '100', '2', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3689320', '36893', '9', '0', '100', '3', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Start Movement Beyond 30 Yards'),
 ('3689321', '36893', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - On Evade set Phase to 0'),
 ('3689330', '36893', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Stop Movement on Aggro'),
 ('3689322', '36893', '4', '0', '100', '4', '0', '0', '0', '0', '11', '70282', '1', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Cast Fireball and Set Phase 1 on Aggro'),
 ('3689323', '36893', '3', '13', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '2', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer- Start Movement and Set Phase 2 when Mana is at 15%'),
 ('3689331', '36893', '0', '13', '100', '5', '0', '0', '1500', '3000', '11', '70282', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer- Cast Fireball above 15% Mana (Phase 1)'),
 ('3689324', '36893', '3', '11', '100', '4', '100', '28', '0', '0', '21', '0', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - Set Ranged Movement and Set Phase 1 when Mana is above 28% (Phase 2)'),
 ('3689325', '36893', '9', '0', '100', '5', '30', '50', '0', '0', '22', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer- Start Movement Beyond 30 Yards'),
 ('3689317', '36893', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ymirjar Flamebearer - On Evade set Phase to 0');
 
UPDATE creature_template SET  AIName='EventAI' WHERE entry IN   (36764,31260,36767,36766,37665,36788,37712,37711,37713,36874,36765,36841,38487,37575,37572,37576,37577,37578,37579,36886,37581,36770,36772,36773,36771,36891,37580,36879,36661,36896,36896,36842,36830,37728,36892,36840,36893);

-- -----------------------------------------------------------------------------------------------
-- ------------------------------------ Crusader`s Coliseum --------------------------------------
-- -----------------------------------------------------------------------------------------------
-- THIS SQL CONTAIN ALL CRUSADER`S COLISEUM SQL NEEDED DATA FOR MYTH CORE.
-- -------------------------------------------------------------------------
-- ------------------------ Trial Of the Crusader --------------------------
-- -------------------------------------------------------------------------

/* Game Objects  */
DELETE FROM `gameobject` WHERE `map`=649;
INSERT INTO `gameobject` VALUES
(500000,195527,649,15,1,563.678,177.284,398.621,1.57047,0,0,0,0,0,100,0), /* Argent Coliseum Floor */
(500001,195647,649,15,1,563.678,199.329,394.766,1.58619,0,0,0,0,0,100,1), /* Main Gate */
(500002,195650,649,15,1,624.656,139.342,395.261,0.00202179,0,0,0,0,0,100,1), /* South Portcullis */
(500003,195648,649,15,1,563.671,78.459,395.261,4.69083,0,0,0,0,0,100,0), /* East Portcullis */
(500004,195649,649,15,1,502.674,139.302,395.26,3.14933,0,0,0,0,0,100,1), /* North Portcullis */
(500046,195594,649,1,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), /* Portal 10 normal */
(500048,195595,649,2,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), /* Portal 25 normal */
(500050,195596,649,8,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1), /* Portal 25 hc */
(500052,195593,649,4,1,563.72,77.1442,396.336,1.559,0,0,0.715397,-0.698718,300,0,1); /* Portal 10 hc */

/* Creatures */
DELETE FROM `creature` WHERE `map`=649;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(604905,34990,649,15,1,0,0,624.633,139.386,418.209,3.15008,300,0,0,8367000,0,0,0), /* King Varian Wrynn */
(604903,34996,649,15,1,0,547,563.697,78.3457, 418.21,1.55937,300,0,0,13945000,4258,0,0), /* Hight Lord Tirion Fordring */
(604907,34995,649,15,1,0,0,502.825,139.407,418.211,0.0163429,300,0,0,1394500,0,0,0), /* Garrosh Hellscream */
/*(604909,35458,649,15,1,0,2106,622.6,112.19,419.705,2.62386,300,0,0,100000,90000,0,0), /* Wilfred Fizzlebang */
(604911,34816,649,15,1,0,0,556.27,89.0785,395.241,1.05514,300,0,0,126000,0,0,0), /* Barrett Ramsey */
(504913,34564,649,15,1,0,0,783.237,133.477,142.576,3.06614,300,0,0,4183500,0,0,0); /* Anubarak */

/* Texts (yells) */
SET @id := -1760000;
DELETE FROM `script_texts` WHERE `entry` BETWEEN @id-76 AND @id;
INSERT INTO `script_texts` (npc_entry, entry, content_default, sound, type, language, emote, comment) VALUES
(34995, @id, "Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the crusaders coliseum that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its marsh to ice crown citadel.", 16036, 1, 0, 0, "Trial of the Crusader - welcome"),
(36095, @id-1, "Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!", 16038, 1, 0, 0, "Gormok the Impaler - intro"),
(36095, @id-2, "Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!", 16039, 1, 0, 0, "Acidmaw and Dreadscale - intro"),
(34799, @id-3, "At its companion perishes, %s becomes enraged!", 0, 3, 0, 0, "Acidmaws adn dreadscales enrage emote"),
(36095, @id-4, "The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!", 16040, 1, 0, 0, "Icehowl - intro"),
(34995, @id-5, "The monstrous menagerie has been vanquished!", 16041, 1, 0, 0, "Beasts of Northrend - victory"),
(36095, @id-6, "Tragic... They fought valiantly, but the beasts of Northrend triumphed. Let us observe a moment of silence for our fallen heroes.", 16042, 1, 0, 0, "Raid wipe"),
(36095, @id-7, "Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!", 16043, 1, 0, 0, "Lord Jaraxxus - intro"),
(35458, @id-8, "Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!", 16268, 1, 0, 0, "Lord Jaraxxus - intro2"),
(35458, @id-9, "Prepare for oblivion!", 16269, 1, 0, 0, "Wilfred Fizzlebang - summoning"),
(35458, @id-10, "Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!", 16270, 1, 0, 0, "Lord Jaraxxus - portal"),
(34780, @id-11, "Trifling gnome, your arrogance will be your undoing!", 16143, 1, 0, 0, "Lord Jaraxxus - intro3"),
(35458, @id-12, "But I'm in charge her-", 16271, 1, 0, 0, "Wilfred Fizzlebang - die"),
(36095, @id-13, "Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!", 16044, 1, 0, 0, "Lord Jaraxxus - intro4"),
(34780, @id-14, "You face Jaraxxus, eredar lord of the Burning Legion!", 16144, 1, 0, 0, "Lord Jaraxxus - aggro"),
(34780, @id-15, "FLESH FROM BONE!", 16149, 1, 0, 0, "Lord Jaraxxus - Incinerate Flesh"),
(34780, @id-16, "$n has |cFF00FFFFIncinerate flesh!|R Heal $ghim:her;!", 0, 3, 0, 0, "Lord Jaraxxus - incinerate flesh's emote for players"),
(34780, @id-17, "Come forth, sister! Your master calls!", 16150, 1, 0, 0, "Lord Jaraxxus - Summoning Mistress of Pain"),
(34780, @id-18, "INFERNO!", 16151, 1, 0, 0, "Lord Jaraxxus - Summoning Infernals"),
(34780, @id-19, "Insignificant gnat!", 16145, 1, 0, 0, "Lord Jaraxxus - killing a player1"),
(34780, @id-20, "Banished to the Nether!", 16146, 1, 0, 0, "Lord Jaraxxus - killing a player2"),
(34780, @id-21, "Another will take my place. Your world is doomed.", 16147, 1, 0, 0, "Lord Jaraxxus - death"),
(36095, @id-22, "The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.", 16045, 1, 0, 0, "Lord Jaraxxus - outro"),
(34995, @id-23, "Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!", 16021, 1, 0, 0, "Garrosh Hellscream - Jaraxxus outro"),
(34990, @id-24, "The Alliance doesn't need the help of a demon lord to deal with Horde filth. Come, pig!", 16064, 1, 0, 0, "Varian Wrynn - Jaraxxus outro"),
(36095, @id-25, "Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!", 16046, 1, 0, 0, "Lord Jaraxxus - intro"),
(36095, @id-26, "The next battle will be against the Argent Crusade's most powerful knights! Only by defeating them will you be deemed worthy...", 16047, 1, 0, 0, "Faction Champions - intro"),
(34995, @id-27, "The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!", 16023, 1, 0, 0, "Faction Champions - intro2, Ally"),
(34990, @id-28, "Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!", 16066, 1, 0, 0, "Faction Champions - intro2, Horda"),
(36095, @id-29, "Very well, I will allow it. Fight with honor!", 16048, 1, 0, 0, "Faction Champions - intro3"),
(34995, @id-30, "Show them no mercy, Horde champions! LOK'TAR OGAR!", 16022, 1, 0, 0, "Faction Champions - intro4, Ally"),
(34995, @id-31, "Fight for the glory of the Alliance, heroes! Honor your king and your people!", 16065, 1, 0, 0, "Faction Champions - intro4, Horda"),
(34995, @id-32, "Weakling!", 16017, 1, 0, 0, "Faction Champions - killing an alliance player1"),
(34995, @id-33, "Pathetic!", 16018, 1, 0, 0, "Faction Champions - killing an alliance player2"),
(34995, @id-34, "Overpowered.", 16019, 1, 0, 0, "Faction Champions - killing an alliance player3"),
(34995, @id-35, "Lok'tar!", 16020, 1, 0, 0, "Faction Champions - killing an alliance player4"),
(34990, @id-36, "HAH!", 16060, 1, 0, 0, "Faction Champions - killing an horde player1"),
(34990, @id-37, "Hardly a challenge!", 16061, 1, 0, 0, "Faction Champions - killing an horde player2"),
(34990, @id-38, "Worthless scrub.", 16062, 1, 0, 0, "Faction Champions - killing an horde player3"),
(34990, @id-39, "Is this the best the Horde has to offer?", 16063, 1, 0, 0, "Faction Champions - killing an horde player4"),
(34990, @id-40, "Glory to the Alliance!", 16067, 1, 0, 0, "Faction Champions - victory as ally"),
(34995, @id-41, "That was just a taste of what the future brings. FOR THE HORDE!", 16024, 1, 0, 0, "Faction Champions - victory as horde"),
(36095, @id-42, "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.", 16049, 1, 0, 0, "Faction Champions - outro"),
(36095, @id-43, "Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourge's most powerful lieutenants: fearsome val'kyr, winged harbingers of the Lich King!", 16050, 1, 0, 0, "Twin Valkyrs - intro"),
(36095, @id-44, "Let the games begin!", 16037, 1, 0, 0, "Twin Valkyrs - intro2"),
(34497, @id-45, "In the name of our dark master. For the Lich King. You. Will. Die.", 16272, 1, 0, 0, "Fjola - aggro"),
(34496, @id-46, "In the name of our dark master. For the Lich King. You. Will. Die.", 16272, 1, 0, 0, "Eydis - aggro"),
(34497, @id-47, "CHAOS!", 16274, 1, 0, 0, "Fjola - casting twins pact"),
(34496, @id-48, "CHAOS!", 16274, 1, 0, 0, "Eydis - casting twins pact"),
(34497, @id-49, "Let the dark consume you!", 16278, 1, 0, 0, "Fjola - casting dark vortex"),
(34496, @id-50, "Let the dark consume you!", 16278, 1, 0, 0, "Eydis - casting dark vortex"),
(34497, @id-51, "Let the light consume you!", 16279, 1, 0, 0, "Fjola - casting light vortex"),
(34496, @id-52, "Let the light consume you!", 16279, 1, 0, 0, "Eydis - casting light vortex"),
(34497, @id-53, "UNWORTHY!", 16277, 1, 0, 0, "Fjola - killing a player1"),
(34496, @id-54, "UNWORTHY!", 16277, 1, 0, 0, "Eydis - kiling a player1"),
(34497, @id-56, "You have been measured, and found wanting!", 16276, 1, 0, 0, "Fjola - killing a player2"),
(34496, @id-57, "You have been measured, and found wanting!", 16276, 1, 0, 0, "Eydis - kiling a player2"),
(34497, @id-58, "You are finished!", 16273, 1, 0, 0, "Fjola - berserk"),
(34496, @id-59, "You are finished!", 16273, 1, 0, 0, "Eydis - berserk"),
(34497, @id-60, "The Scourge cannot be stopped...", 16275, 1, 0, 0, "Fjola - death"),
(34496, @id-61, "The Scourge cannot be stopped...", 16275, 1, 0, 0, "Eydis - death"),
(34995, @id-62, "Do you still question the might of the Horde, paladin? We will take on all comers!", 16025, 1, 0, 0, "Twin Valkyrs - victory as horde"),
(34990, @id-63, "Not even the Lich King most powerful minions can stand against the Alliance! All hail our victors!", 16068, 1, 0, 0, "Twin Valkyrs - victory as alliance"),
(36095, @id-64, "A mighty blow has been dealt to the Lich King! You have proven yourselves as able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!", 16051, 1, 0, 0, "Anub'arak - intro1"),
(35877, @id-65, "You will have your challenge, Fordring.", 16321, 1, 0, 0, "Anub'arak - intro2"),
(36095, @id-66, "Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.", 16052, 1, 0, 0, "Anub'arak - intro3"),
(35877, @id-67, "The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.", 16322, 1, 0, 0, "Anub'arak - intro4"),
(35877, @id-68, "The souls of your fallen champions will be mine, Fordring.", 16323, 1, 0, 0, "Anub'arak - intro5"),
(34564, @id-69, "Ahhh... Our guests arrived, just as the master promised.", 16235, 1, 0, 0, "Anub'arak - intro6"),
(34564, @id-70, "This place will serve as your tomb!", 16234, 1, 0, 0, "Anub'arak - aggro"),
(34564, @id-71, "Auum na-l ak-k-k-k, isshhh. Rise, minions. Devour...", 16240, 1, 0, 0, "Anub'arak - submerge"),
(34564, @id-72, "The swarm shall overtake you!", 16241, 1, 0, 0, "Anub'arak - leeching swarm"),
(34564, @id-73, "F-lakkh shir!", 16236, 1, 0, 0, "Anub'arak - killing a player1"),
(34564, @id-74, "Another soul to sate the host.", 16237, 1, 0, 0, "Anub'arak - killing a player2"),
(34564, @id-75, "I have failed you, master....", 16238, 1, 0, 0, "Anub'arak - death"),
(36095, @id-76, "Champions, you're alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!", 0, 1, 0, 0, "Anub'arak - outro");

/* Creature/Instance Templates */
UPDATE creature_template SET ScriptName="boss_gormok_the_impaler" WHERE entry=34796; /* gormok the impaler */
UPDATE creature_template SET ScriptName="boss_acidmaw" WHERE entry=35144; /* acidmaw */
UPDATE creature_template SET ScriptName="boss_dreadscale" WHERE entry=34799; /* dreascale */
UPDATE creature_template SET scriptname="mob_slime_pool" WHERE entry = 35176; /* slime pool - acidmaw's and dreadscale's add */
UPDATE creature_template SET ScriptName="boss_icehowl" WHERE entry=34797; /* icehowl */
UPDATE creature_template SET ScriptName="mob_snobold" WHERE entry=34800; /* Snobold */
UPDATE creature_template SET ScriptName="boss_lord_jaraxxus" WHERE entry=34780; /* Lord Jaraxxus */
UPDATE creature_template SET scriptname="mob_misstress_of_pain" WHERE entry=34826; /* Misstress of pain (Jaraxxus' add) */
UPDATE creature_template SET scriptname="mob_felflame_infernal" WHERE entry=34815; /* Felflame Infernal (Jaraxxus' add) */
UPDATE creature_template SET scriptname="mob_jaraxxus_vulcan" WHERE entry=34813; /* Vulcan, summoned by Lord Jaraxxus, summoning Felflame Infernals */
UPDATE creature_template SET scriptname="mob_jaraxxus_portal" WHERE entry=34825; /* Nether Portal, summoned by Lord Jaraxxus, summonig Misstress of pain */
UPDATE creature_template SET scriptname="mob_legion_flame" WHERE entry = 34784; /* Jaraxxus' spell's effect - summon legion fire, deal damage every sec */

UPDATE creature_template SET scriptname="mob_toc_warrior" WHERE entry IN (34475,34453);
UPDATE creature_template SET scriptname="mob_toc_mage" WHERE entry IN (34468,34449);
UPDATE creature_template SET scriptname="mob_toc_shaman" WHERE entry IN (34470,34444);
UPDATE creature_template SET scriptname="mob_toc_enh_shaman" WHERE entry IN (34463,34455);
UPDATE creature_template SET scriptname="mob_toc_hunter" WHERE entry IN (34467,34448);
UPDATE creature_template SET scriptname="mob_toc_rogue" WHERE entry IN (34472,34454);
UPDATE creature_template SET scriptname="mob_toc_priest" WHERE entry IN (34466,34447);
UPDATE creature_template SET scriptname="mob_toc_shadow_priest" WHERE entry IN (34473,34441);
UPDATE creature_template SET scriptname="mob_toc_dk" WHERE entry IN (34461,34458);
UPDATE creature_template SET scriptname="mob_toc_paladin" WHERE entry IN (34465,34445);
UPDATE creature_template SET scriptname="mob_toc_retro_paladin" WHERE entry IN (34471,34456);
UPDATE creature_template SET scriptname="mob_toc_druid" WHERE entry IN (34469,34459);
UPDATE creature_template SET scriptname="mob_toc_boomkin" WHERE entry IN (34460,34451);
UPDATE creature_template SET scriptname="mob_toc_warlock" where entry IN (34474,34450);
UPDATE creature_template SET scriptname="mob_toc_pet_warlock" WHERE entry IN (35465);
UPDATE creature_template SET scriptname="mob_toc_pet_hunter" WHERE entry IN (35610);

UPDATE creature_template SET ScriptName="boss_light_twin" WHERE entry=34497; /* Fjola Lightbane */
UPDATE creature_template SET ScriptName="boss_dark_twin" WHERE entry=34496; /* Eydis Darkbane */
UPDATE creature_template SET ScriptName="light_essence" WHERE entry=34568; /* Light Essence (twins' fight) */
UPDATE creature_template SET ScriptName="dark_essence" WHERE entry=34567; /* Dark Essence (twins' fight) */
UPDATE creature_template SET ScriptName="mob_concetrated_light" WHERE entry=34630; /* Concentrated Light (twins' fight) */
UPDATE creature_template SET ScriptName="mob_concetrated_dark" WHERE entry=34628; /* Concentrated Dark (twins' fight) */
UPDATE creature_template SET ScriptName="boss_anubarak_trial" WHERE entry=34564; /* Anubarak */
UPDATE creature_template SET ScriptName="mob_swarm_scarab" WHERE entry=34605; /* Anub's adds */
UPDATE creature_template SET ScriptName="mob_nerubian_burrower" WHERE entry=34607; /* Anub's adds */
UPDATE creature_template SET scriptname="mob_anubarak_spike" WHERE entry=34660;
UPDATE creature_template SET ScriptName="mob_frost_sphere" WHERE entry = 34606;
UPDATE creature_template SET ScriptName="toc_tirion_fordring" WHERE entry=34996; /* Tirion Fordring */
UPDATE creature_template SET ScriptName="toc_barrett_ramsey" WHERE entry=34816; /* Barrett Ramsey (Arena Master) */
UPDATE instance_template SET script="instance_trial_of_the_crusader" WHERE map=649; /* Instance */

/* Additional */
UPDATE creature_template SET npcflag=1 WHERE entry IN(34816, 3481601, 3481602, 3481603, 34568, 3456801, 3456802, 3456803, 34567, 3456701, 3456702, 3456703); /* Make Barrett Ramsey, Dark and Light Essenes gossip creatures */
UPDATE creature_template SET IconName="Interact" WHERE entry IN(34568, 3456801, 3456802, 3456803, 34567, 3456701, 3456702, 3456703); /* Change white chat bubble on interaction wheel when mouse-overing Light and Dark Essences */
UPDATE creature_template SET unit_flags=4 WHERE entry IN(34813, 3481301, 3481302, 3481303, 34825, 3482501, 3482502, 3482503); /* Disable move for Jaraxxus' portals and vulcans */
UPDATE creature_template SET unit_flags=unit_flags|4 WHERE entry in (34784, 3478401, 3478402, 3478403); /* Disable move for Jaraxxus' spell's Legion Fire */
UPDATE creature_template SET modelid1=30039, modelid2=30039 where entry IN (348125, 3482501, 3482502, 3482503);  /* Set correct model for Jaraxxus' portal */
UPDATE creature_template SET faction_A=189, faction_H=189 WHERE entry IN (34605, 3460501, 3460502, 3460503); /* Make swarm scarab's neutral for players, faction switch implemented in anub's script */
UPDATE creature_template SET flags_extra=2 WHERE entry IN (34630, 3463001, 3463002, 3463003, 34628, 3462801, 3462802, 3462803); /* Makes Concentraded Energies ignore aggro */

/* Loot and Tribute Chests (from TC forum, thanks Gyullo) */
-- Chest Templates (this are for 10 Heroic)
DELETE FROM `gameobject_template` WHERE entry IN (195665,195666,195667,195668);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(195665, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27514, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195666, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27515, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195667, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27516, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195668, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27513, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723);

-- Chest Templates (this are for 25 Heroic)
DELETE FROM `gameobject_template` WHERE entry IN (195669,195670,195671,195672);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
(195669, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27512, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195670, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27517, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195671, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27518, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(195672, 3, 9069, 'Argent Crusade Tribute Chest', '', '', '', 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 1634, 27511, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723);

-- 10H mode (1-24 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27513;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27513,47242,100,1,0,2,2), -- 2 Trophys
(27513,47556,100,1,0,1,1); -- 1 Crusader Orb

-- 10H mode (25-44 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27514;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27514,47242,100,1,0,2,2), -- 2 Trophys
(27514,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27514,48713,0,1,1,1,1),
(27514,48711,0,1,1,1,1),
(27514,48712,0,1,1,1,1),
(27514,48714,0,1,1,1,1),
(27514,48709,0,1,1,1,1),
(27514,48710,0,1,1,1,1),
(27514,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27514,48695,0,1,2,1,1),
(27514,48697,0,1,2,1,1),
(27514,48703,0,1,2,1,1),
(27514,48699,0,1,2,1,1),
(27514,48693,0,1,2,1,1),
(27514,48705,0,1,2,1,1),
(27514,48701,0,1,2,1,1);

-- 10H mode (45-49 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27515;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27515,47242,100,1,0,4,4), -- 4 Trophys
(27515,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27515,48713,0,1,1,1,1),
(27515,48711,0,1,1,1,1),
(27515,48712,0,1,1,1,1),
(27515,48714,0,1,1,1,1),
(27515,48709,0,1,1,1,1),
(27515,48710,0,1,1,1,1),
(27515,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27515,48695,0,1,2,1,1),
(27515,48697,0,1,2,1,1),
(27515,48703,0,1,2,1,1),
(27515,48699,0,1,2,1,1),
(27515,48693,0,1,2,1,1),
(27515,48705,0,1,2,1,1),
(27515,48701,0,1,2,1,1);

-- 10H mode (50 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27516;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27516,47242,100,1,0,4,4), -- 4 Trophys
(27516,47556,100,1,0,1,1), -- 1 Crusader Orb
-- Alliance Loot (Handdle by conditions)
(27516,48713,0,1,1,1,1),
(27516,48711,0,1,1,1,1),
(27516,48712,0,1,1,1,1),
(27516,48714,0,1,1,1,1),
(27516,48709,0,1,1,1,1),
(27516,48710,0,1,1,1,1),
(27516,48708,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27516,48695,0,1,2,1,1),
(27516,48697,0,1,2,1,1),
(27516,48703,0,1,2,1,1),
(27516,48699,0,1,2,1,1),
(27516,48693,0,1,2,1,1),
(27516,48705,0,1,2,1,1),
(27516,48701,0,1,2,1,1),
-- Second Alliance Loot (Handdle by conditions)
(27516,49044,100,1,0,1,1),
(27516,48673,0,1,3,1,1),
(27516,48675,0,1,3,1,1),
(27516,48674,0,1,3,1,1),
(27516,48671,0,1,3,1,1),
(27516,48672,0,1,3,1,1),
-- Second Horde Loot (Handdle by conditions)
(27516,49046,100,1,0,1,1),
(27516,48668,0,1,4,1,1),
(27516,48670,0,1,4,1,1),
(27516,48669,0,1,4,1,1),
(27516,48666,0,1,4,1,1),
(27516,48667,0,1,4,1,1);

SET @RefTribute := 51000;

DELETE FROM `reference_loot_template` WHERE entry=@RefTribute;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@RefTribute,47557,0,1,1,1,1),
(@RefTribute,47558,0,1,1,1,1),
(@RefTribute,47559,0,1,1,1,1);

-- 25H mode (1-24 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27511;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27511,1,100,1,0,-@RefTribute,2); -- 2 Tokens

-- 25H mode (25-44 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27512;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27512,1,100,1,0,-@RefTribute,2), -- 2 Tokens

-- Alliance Loot (Handdle by conditions)
(27512,47521,0,1,1,1,1),
(27512,47526,0,1,1,1,1),
(27512,47519,0,1,1,1,1),
(27512,47524,0,1,1,1,1),
(27512,47517,0,1,1,1,1),
(27512,47506,0,1,1,1,1),
(27512,47515,0,1,1,1,1),

-- Horde Loot (Handdle by conditions)
(27512,47523,0,1,2,1,1),
(27512,47528,0,1,2,1,1),
(27512,47520,0,1,2,1,1),
(27512,47525,0,1,2,1,1),
(27512,47518,0,1,2,1,1),
(27512,47513,0,1,2,1,1),
(27512,47516,0,1,2,1,1);

-- 25H mode (45-49 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27517;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27517,1,100,1,0,-@RefTribute,2), -- 2 Tokens
(27517,2,100,1,0,-@RefTribute,2), -- 2 Tokens

-- Alliance Loot (Handdle by conditions)
(27517,47521,0,1,1,1,1),
(27517,47526,0,1,1,1,1),
(27517,47519,0,1,1,1,1),
(27517,47524,0,1,1,1,1),
(27517,47517,0,1,1,1,1),
(27517,47506,0,1,1,1,1),
(27517,47515,0,1,1,1,1),

-- Horde Loot (Handdle by conditions)
(27517,47523,0,1,2,1,1),
(27517,47528,0,1,2,1,1),
(27517,47520,0,1,2,1,1),
(27517,47525,0,1,2,1,1),
(27517,47518,0,1,2,1,1),
(27517,47513,0,1,2,1,1),
(27517,47516,0,1,2,1,1);

-- 25H mode (50 trys remaining)
DELETE FROM `gameobject_loot_template` WHERE entry=27518;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27518,1,100,1,0,-@RefTribute,2), -- 2 Tokens
(27518,2,100,1,0,-@RefTribute,2), -- 2 Tokens
-- Alliance Loot (Handdle by conditions)
(27518,47521,0,1,1,1,1),
(27518,47526,0,1,1,1,1),
(27518,47519,0,1,1,1,1),
(27518,47524,0,1,1,1,1),
(27518,47517,0,1,1,1,1),
(27518,47506,0,1,1,1,1),
(27518,47515,0,1,1,1,1),
-- Horde Loot (Handdle by conditions)
(27518,47523,0,1,2,1,1),
(27518,47528,0,1,2,1,1),
(27518,47520,0,1,2,1,1),
(27518,47525,0,1,2,1,1),
(27518,47518,0,1,2,1,1),
(27518,47513,0,1,2,1,1),
(27518,47516,0,1,2,1,1),
-- Second Alliance Loot (Handdle by conditions)
(27518,49096,100,1,0,1,1),
(27518,47553,0,1,3,1,1),
(27518,47552,0,1,3,1,1),
(27518,47549,0,1,3,1,1),
(27518,47547,0,1,3,1,1),
(27518,47545,0,1,3,1,1),
-- Second Horde Loot (Handdle by conditions)
(27518,49098,100,1,0,1,1),
(27518,47554,0,1,4,1,1),
(27518,47551,0,1,4,1,1),
(27518,47550,0,1,4,1,1),
(27518,47548,0,1,4,1,1),
(27518,47546,0,1,4,1,1);

/* Achievements criteria (thanks Gyullo) */
-- 10 Normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11684,11685,11686,11687,11688);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (10 player)
(11684,12,0,0),
(11685,12,0,0),
(11686,12,0,0),
(11687,12,0,0),
(11688,12,0,0);

-- 10 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11690,11689,11682,11693,11691);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (10 player)
(11690,12,2,0),
(11689,12,2,0),
(11682,12,2,0),
(11693,12,2,0),
(11691,12,2,0);

-- 25 normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11679,11683,11680,11682,11681);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Crusade (25 player)
(11679,12,1,0),
(11683,12,1,0),
(11680,12,1,0),
(11682,12,1,0),
(11681,12,1,0);

-- 25 Hero
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (11542,11546,11547,11549,11678,12350);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`) VALUES
-- Call of the Grand Crusade (25 player)
(11542,12,3,0),
(11546,12,3,0),
(11547,12,3,0),
(11549,12,3,0),
(11678,12,3,0),
-- Realm First! Grand Crusader
(12350,12,3,0);

/* Immunes:
 * charm, cofused, disarm, distract, fear, root, pacifi, silence, sleep, snare, stun, freeze, knockout, polymorph, banish, shackle, horror, daze, sapped (in order)
 * For:
 * Gormok, Acidmaw, Dreadscale, Icehowl, Jaraxxus, Fjola, Eydis and Anubarak
 */
UPDATE creature_template SET mechanic_immune_mask=1|2|4|8|16|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|8388608|67108864|536870912 WHERE entry IN
(34796, 3479601, 3479602, 3479603,
 35144, 3514401, 3514402, 3514403,
 34799, 3479901, 3479902, 3479903,
 34797, 3479701, 3479702, 3479703,
 34780, 3478001, 3478002, 3478003,
 34497, 3449701, 3449702, 3449703,
 34496, 3449601, 3449602, 3449603,
 34564, 3456401, 3456402, 3456403,
 34800, 3480001, 3480002, 3480003);

-- Last StartUP error fix. 
UPDATE creature_template SET ScriptName="mob_cat" WHERE entry=35610;

-- If you can`t Hit Anub. 
/* UPDATE `creature_template` SET `unit_flags` = '0' WHERE `creature_template`.`entry` =34564; */
-- REMOVE " /* */ " for use!

-- TOC original texts/sounds (thanks to griffonheart)
-- english translation by Cristy
-- reworked by rsa
-- reworked by JohnHoliver
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1649999 AND -1649000;
INSERT INTO `script_texts`
(`comment`,`sound`, `entry`,`type`,`language`,`emote`,`content_default`) VALUES
-- Northrend Beasts
-- Gormok
('34796','0','-1649000','3','0','0','My slaves! Destroy the enemy!'),
-- Acidmaw & Dreadscale
('34564','0','-1649010','3','0','0','%s buries itself in the earth!'),
('34564','0','-1649011','3','0','0','%s getting out of the ground!'),
('34799','0','-1649012','3','0','0','At its companion perishes, %s becomes enraged!'),
-- Icehowl
('34797','0','-1649020','3','0','0','%s looks at |3-3($n) and emits a guttural howl!'),
('34797','0','-1649021','3','0','0','%s crashes into a wall of the Colosseum and lose focus!'),
('34797','0','-1649022','3','0','0','|3-3(%s) covers boiling rage, and he tramples all in its path!'),
-- Jaraxxus
('34780','16143','-1649030','1','0','0','Trifling gnome, your arrogance will be your undoing!'),
('34780','16144','-1649031','1','0','0','You face Jaraxxus, eredar lord of the Burning Legion!'),
('34780','16147','-1649032','1','0','0','Another will take my place. Your world is doomed.'),
('34780','0','-1649033','3','0','0','$n has |cFF00FFFFIncinerate flesh!|R Heal $ghim:her;!'),
('34780','16149','-1649034','1','0','0','FLESH FROM BONE!'),
('34780','0','-1649035','3','0','0','|cFFFF0000Legion Flame|R on $n'),
('34780','0','-1649036','3','0','0','%s creates the gates of the Void!'),
('34780','16150','-1649037','1','0','0','Come forth, sister! Your master calls!'),
('34780','0','-1649038','3','0','0','%s creates an |cFF00FF00Infernal Volcano!|R'),
('34780','16151','-1649039','1','0','0','INFERNO!'),
-- Faction Champions
('34995','0','-1649115','1','0','0','Weakling!'),
('34995','0','-1649116','1','0','0','Pathetic!'),
('34995','0','-1649117','1','0','0','Overpowered.'),
('34995','0','-1649118','1','0','0','Lok\'tar!'),
('34990','0','-1649120','1','0','0','HAH!'),
('34990','0','-1649121','1','0','0','Hardly a challenge!'),
('34990','0','-1649122','1','0','0','Worthless scrub.'),
('34990','0','-1649123','1','0','0','Is this the best the Horde has to offer?'),
-- Twin Valkyrs
('34497','16272','-1649040','1','0','0','In the name of our dark master. For the Lich King. You. Will. Die.'),
('34496','16275','-1649041','1','0','0','The Scourge cannot be stopped...'),
('34497','16273','-1649042','1','0','0','YOU ARE FINISHED!'),
('34497','0','-1649043','3','0','0','%s begins to read the spell Treaty twins!'),
('34497','16274','-1649044','3','0','0','CHAOS!'),
('34496','16277','-1649045','1','0','0','UNWORTHY!'),
('34497','16276','-1649046','1','0','0','You appreciated and acknowledged nothing.'),
('34497','0','-1649047','3','0','0','%s begins to read a spell |cFFFFFFFFLight Vortex!|R switch to |cFFFFFFFFLight|r essence!'),
('34496','16279','-1649048','1','0','0','Let the light consume you!'),
('34496','0','-1649049','3','0','0','%s begins to read a spell |cFF9932CDBlack Vortex!|R switch to |cFF9932CDBlack|r essence!'),
('34496','16278','-1649050','1','0','0','Let the dark consume you!'),
-- Anub'arak
('34564','16235','-1649055','1','0','0','Ahhh... Our guests arrived, just as the master promised.'),
('34564','16234','-1649056','1','0','0','This place will serve as your tomb!'),
('34564','16236','-1649057','1','0','0','F-lakkh shir!'),
('34564','16237','-1649058','1','0','0','Another soul to sate the host.'),
('34564','16238','-1649059','1','0','0','I have failed you, master...'),
('34564','0','-1649060','3','0','0','%s spikes  pursuing $n!'),
('34564','16240','-1649061','1','0','0','Auum na-l ak-k-k-k, isshhh. Rise, minions. Devour...'),
('34564','0','-1649062','3','0','0','%s produces a swarm of beetles Peon to restore your health!'),
('34564','16241','-1649063','1','0','0','The swarm shall overtake you!'),
-- Event
-- Northrend Beasts
('34996','16036','-1649070','1','0','0','Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the crusaders coliseum that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its marsh to ice crown citadel.'),
('34996','16038','-1649071','1','0','0','Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!'),
('34990','16069','-1649072','1','0','0','Your beast will be no match for my champions Tirion!'),
('34995','16026','-1649073','1','0','0','I have seen  more  worthy  challenges in the ring of blood, you waste our time paladin.'),
('34996','16039','-1649074','1','0','0','Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!'),
('34996','16040','-1649075','1','0','0','The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!'),
('34996','16041','-1649076','1','0','0','The monstrous menagerie has been vanquished!'),
('34996','16042','-1649077','1','0','0','Tragic... They fought valiantly, but the beasts of Northrend triumphed. Let us observe a moment of silence for our fallen heroes.'),
-- Jaraxxus
('34996','16043','-1649080','1','0','0','Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!'),
('35458','16268','-1649081','1','0','0','Thank you, Highlord! Now challengers, I will begin the ritual of summoning! When I am done, a fearsome Doomguard will appear!'),
('35458','16269','-1649082','1','0','0','Prepare for oblivion!'),
('35458','16270','-1649083','1','0','0','Ah ha! Behold the absolute power of Wilfred Fizzlebang, master summoner! You are bound to ME, demon!'),
('35458','16271','-1649084','1','0','0','But I am in charge here-'),
('35458','0','-1649085','1','0','0','...'),
('34996','16044','-1649086','1','0','0','Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!'),
('34996','16045','-1649087','1','0','0','The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.'),
('34995','16021','-1649088','1','0','0','Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!'),
('34990','16064','-1649089','1','0','0','The Alliance doesnt need the help of a demon lord to deal with Horde filth. Come, pig!'),
('34996','16046','-1649090','1','0','0','Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!'),
-- Faction Champions
('34996','16047','-1649091','1','0','0','The next battle will be against the Argent Crusades most powerful knights! Only by defeating them will you be deemed worthy...'),
('34990','16066','-1649092','1','0','0','Our honor has been besmirched! They make wild claims and false accusations against us. I demand justice! Allow my champions to fight in place of your knights, Tirion. We challenge the Horde!'),
('34995','16023','-1649093','1','0','0','The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!'),
('34996','16048','-1649094','1','0','0','Very well, I will allow it. Fight with honor!'),
('34990','16065','-1649095','1','0','0','Fight for the glory of the Alliance, heroes! Honor your king and your people!'),
('34995','16022','-1649096','1','0','0','Show them no mercy, Horde champions! LOK-TAR OGAR!'),
('34990','16067','-1649097','1','0','0','GLORY OF THE ALLIANCE!'),
('34995','16024','-1649098','1','0','0','LOK-TAR OGAR!'),
('34996','16049','-1649099','1','0','0','A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.'),
-- Twin Valkyrs
('34996','16050','-1649100','1','0','0','Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourges most powerful lieutenants: fearsome valkyr, winged harbingers of the Lich King!'),
('34996','16037','-1649101','1','0','0','Let the games begin!'),
('34990','16068','-1649102','1','0','0','Not even the Lich King most powerful minions can stand against the Alliance! All hail our victors!'),
('34995','16025','-1649103','1','0','0','Do you still question the might of the horde paladin? We will take on all comers.'),
-- Anub'arak
('34996','16051','-1649104','1','0','0','A mighty blow has been dealt to the Lich King! You have proven yourselves able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!'),
('35877','16321','-1649105','1','0','0','You will have your challenge, Fordring.'),
('34996','16052','-1649106','1','0','0','Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.'),
('35877','16322','-1649107','1','0','0','The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.'),
('35877','16323','-1649108','1','0','0','The souls of your fallen champions will be mine, Fordring.'),
('36095','0','-1649109','1','0','0','Champions, you are alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!'),
('36095','0','-1649110','1','0','0','Let me hand you the chests as a reward, and let its contents will serve you faithfully in the campaign against Arthas in the heart of the Icecrown Citadel!');

-- Faction Champions
UPDATE `creature_template` SET `scriptname`='mob_toc_warrior', `AIName` ='' WHERE `entry` IN (34475,34453);
UPDATE `creature_template` SET `scriptname`='mob_toc_mage', `AIName` ='' WHERE `entry` IN (34468,34449);
UPDATE `creature_template` SET `scriptname`='mob_toc_shaman', `AIName` ='' WHERE `entry` IN (34470,34444);
UPDATE `creature_template` SET `scriptname`='mob_toc_enh_shaman', `AIName` ='' WHERE `entry` IN (34463,34455);
UPDATE `creature_template` SET `scriptname`='mob_toc_hunter', `AIName` ='' WHERE `entry` IN (34467,34448);
UPDATE `creature_template` SET `scriptname`='mob_toc_rogue', `AIName` ='' WHERE `entry` IN (34472,34454);
UPDATE `creature_template` SET `scriptname`='mob_toc_priest', `AIName` ='' WHERE `entry` IN (34466,34447);
UPDATE `creature_template` SET `scriptname`='mob_toc_shadow_priest', `AIName` ='' WHERE `entry` IN (34473,34441);
UPDATE `creature_template` SET `scriptname`='mob_toc_dk', `AIName` ='' WHERE `entry` IN (34461,34458);
UPDATE `creature_template` SET `scriptname`='mob_toc_paladin', `AIName` ='' WHERE `entry` IN (34465,34445);
UPDATE `creature_template` SET `scriptname`='mob_toc_retro_paladin', `AIName` ='' WHERE `entry` IN (34471,34456);
UPDATE `creature_template` SET `scriptname`='mob_toc_druid', `AIName` ='' WHERE `entry` IN (34469,34459);
UPDATE `creature_template` SET `scriptname`='mob_toc_boomkin', `AIName` ='' WHERE `entry` IN (34460,34451);
UPDATE `creature_template` SET `scriptname`='mob_toc_warlock' WHERE `entry` IN (34474,34450);
UPDATE `creature_template` SET `scriptname`='mob_toc_pet_warlock', `AIName` ='' WHERE `entry` IN (35465);
UPDATE `creature_template` SET `scriptname`='mob_toc_pet_hunter', `AIName` ='' WHERE `entry` IN (35610);

-- -----------------------------------------------------------------------------------------------
-- ---------------------------------------- Trial of the Champion --------------------------------
-- -----------------------------------------------------------------------------------------------
-- Georgios: I have been working since a long time ago in this information stepp by steem dat by day.
-- I have asign all guids to each npc and there is not anyy problem with satabase in the moment to insert the information.
-- All event is working perfect, just go close to the anouncer and wait, he will start the presentation.
-- Problemas: I add PhaseMask to mount then each faction see their mount, but in the moment you ride a mount then you can not see the anouncer.
-- Solutions:  If change the phaseMask to make horde and alliance see all mounts, then will see the announcer as well.
-- This information in not jet in CTDB, please, if there is something wrong just let me know.
-- NOTE: I have set phaseMask to 1 (provisional)

UPDATE `instance_template` SET `script`='instance_trial_of_the_champion' WHERE `map`=650;
UPDATE `creature_template` SET `ScriptName`='npc_announcer_toc5' WHERE `entry`IN (35004,35005);

-- Moturas
DELETE FROM `vehicle_accessory` WHERE `entry` in (35491,33299,33418,33409,33300,33408,33301,33414,33297,33416,33298);
INSERT INTO `vehicle_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`) VALUES
(35491,35451,0,0, 'Black Knight'),
(33299,35323,0,1, 'Darkspear Raptor'),
(33418,35326,0,1, 'Silvermoon Hawkstrider'),
(33409,35314,0,1, 'Orgrimmar Wolf'),
(33300,35325,0,1, 'Thunder Bluff Kodo'),
(33408,35329,0,1, 'Ironforge Ram'),
(33301,35331,0,1, 'Gnomeregan Mechanostrider'),
(33414,35327,0,1, 'Forsaken Warhorse'),
(33297,35328,0,1, 'Stormwind Steed'),
(33416,35330,0,1, 'Exodar Elekk'),
(33298,35332,0,1, 'Darnassian Nightsaber');

-- Arreglo de doble montura YTDB  y grнmpola de valeroso mбs otros spells http://es.wowhead.com/search?q=Gr%C3%ADmpola+de+Valeroso
-- Addons
-- Argent
DELETE FROM `creature_template_addon` WHERE `entry` IN (35309, 35310, 35305, 35306, 35307, 35308, 35119, 35518, 34928, 35517);
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES 
(35309, 1, '63501 0'),
(35310, 1, '63501 0'),
(35305, 1, '63501 0'),
(35306, 1, '63501 0'),
(35307, 1, '63501 0'),
(35308, 1, '63501 0'),
(35119, 1, '63501 0'),
(35518, 1, '63501 0'),
(34928, 1, '63501 0'),
(35517, 1, '63501 0');

-- Faction_champ
DELETE FROM `creature_template_addon` WHERE `entry` IN (34701, 34657, 34705, 35570, 35569, 35332,35330,33299,35328,35327,35331,35329,35325,35314,35326,35323, 35572, 35571, 34703, 34702, 35617);
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES 
(35323, 1, '63399 0 62852 0 64723 0'),
(35570, 1, '63399 0 62852 0 64723 0'),
(35326, 1, '63403 0 62852 0 64723 0'),
(35569, 1, '63403 0 62852 0 64723 0'),
(35314, 1, '63433 0 62852 0 64723 0'),
(35572, 1, '63433 0 62852 0 64723 0'),
(35325, 1, '63436 0 62852 0 64723 0'),
(35571, 1, '63436 0 62852 0 64723 0'),
(35329, 1, '63427 0 62852 0 64723 0'),
(34703, 1, '63427 0 62852 0 64723 0'),
(35331, 1, '63396 0 62852 0 64723 0'),
(34702, 1, '63396 0 62852 0 64723 0'),
(35327, 1, '63430 0 62852 0 64723 0'),
(35617, 1, '63430 0 62852 0 64723 0'),
(35328, 1, '62594 0 62852 0 64723 0'),
(34705, 1, '62594 0 62852 0 64723 0'),
(35330, 1, '63423 0 62852 0 64723 0'),
(34701, 1, '63423 0 62852 0 64723 0'),
(35332, 1, '63406 0 62852 0 64723 0'),
(34657, 1, '63406 0 62852 0 64723 0');

-- Textos originales.
DELETE FROM `script_texts` WHERE `entry` <= -1999926 and `entry` >= -1999956;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,-1999926, 'Coming out of the gate Grand Champions other faction.  ' ,0,0,0,1, 'SAY_START' ),
(0,-1999927, 'Good work! You can get your award from Crusader\'s Coliseum chest!.  ' ,0,1,0,1, 'Win' ),
(0,-1999928, 'You spoiled my grand entrance. Rat.' ,16256,1,0,5, 'SAY_AGGRO' ),
(0,-1999929, 'Did you honestly think an agent if the Kich King would be bested on the field of your pathetic little tournament?' ,16257,1,0,5, 'SAY_AGGRO_1' ),
(0,-1999930, 'I have come to finish my task ' ,16258,1,0,5, 'SAY_AGGRO_2' ),
(0,-1999931, 'This farce ends here!' ,16259,1,0,5, 'SAY_AGGRO_3' ),
(0,-1999932, '[Zombie]Brains.... .... ....' ,0,1,0,5, 'SAY_SLAY' ),
(0,-1999933, 'My roting flash was just getting in the way!' ,16262,1,0,5, 'SAY_DEATH_1' ),
(0,-1999934, 'I have no need for bones to best you!' ,16263,1,0,5, 'SAY_DEATH_2' ),
(0,-1999935, 'No! I must not fail...again...' ,16264,1,0,5, 'SAY_DEATH_3' ),
(0,-1999936, 'What\'s that. up near the rafters ?' ,0,1,0,5, 'detected' ),
(0,-1999937, 'Please change your weapon! Next battle will be start now!' ,0,3,0,5, 'nx' ),
(0,-1999939, 'Excellent work!' ,0,1,0,1, 'work' ),
(0,-1999940, 'Coming out of the gate Crusader\'s Coliseum Champion.' ,0,0,0,1, 'SAY_START3' ),
(0,-1999941, 'Excellent work! You are win Argent champion!' ,0,3,0,0, 'win' ),
(0,-1999942, 'The Sunreavers are proud to present their representatives in this trial by combat.' ,0,0,0,1, 'an1' ),
(0,-1999943, 'Welcome, champions. Today, before the eyes of your leeders and peers, you will prove youselves worthy combatants.' ,0,0,0,1, 'an2' ),
(0,-1999944, 'Fight well, Horde! Lok\'tar Ogar!' ,0,1,0,5, 'Thrall' ),
(0,-1999945, 'Finally, a fight worth watching.' ,0,1,0,5, 'Garrosh' ),
(0,-1999946, 'I did not come here to watch animals tear at each other senselessly, Tirion' ,0,1,0,5, 'King' ),
(0,-1999947, 'You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.' ,0,1,0,5, 'Hightlord' ),
(0,-1999948, 'Will tought! You next challenge comes from the Crusade\'s own ranks. You will be tested against their consederable prowess.' ,0,1,0,5, 'Hightlord2' ),
(0,-1999949, 'You may begin!' ,0,0,0,5, 'text' ),
(0,-1999950, 'Well, then. Let us begin.' ,0,1,0,5, 'pal agro' ),
(0,-1999951, 'Take this time to consider your past deeds.' ,16248,1,0,5, 'palsum' ),
(0,-1999952, 'What is the meaning of this?' ,0,1,0,5, 'dk_hightlord' ),
(0,-1999953, 'No...I\'m still too young' ,0,1,0,5, 'die' ),
(0,-1999954, 'Excellent work! You are win Argent champion!' ,0,3,0,0, 'win' );

-- actualizaciуn nueva de todos los npc relacionado a prueba del campeуn
-- Update mob's stats
-- Memory's Stats
-- Health, mana, vehicle id, etc...
-- Equipment
-- Faction for Vehicle
DELETE FROM `creature_template` WHERE `entry` IN 
(33297, 33298, 33299, 33300, 33301, 33408, 33409, 33414, 33416, 33418, 34657, 34658, 34701, 34702, 34703, 34705, 34928, 34942, 35028, 35029, 
35030, 35031, 35032, 35033, 35034, 35035, 35036, 35037, 35038, 35039, 35040, 35041, 35042, 35043, 35044, 35045, 35046, 35047, 35048, 35049, 
35050, 35051, 35052, 35119, 0000, 0000, 0000, 0000, 0000, 0000, 35314, 35323, 35325, 35326, 35327, 35328, 35329, 35330, 35331, 35332, 
35451, 35490, 35517, 35518, 35519, 35520, 35521, 35522, 35523, 35524, 35525, 35527, 35528, 35529, 35530, 35531, 35532, 35533, 35534, 35535, 
35536, 35537, 35538, 35539, 35541, 35542, 35543, 35544, 35545, 35564, 35568, 35569, 35570, 35571, 35572, 35590, 35617, 35633, 35634, 35635, 
35636, 35637, 35638, 35640, 35641, 35644, 35717, 35768, 36082, 36083, 36084, 36085, 36086, 36087, 36088, 36089, 36090, 36091, 36558);

INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES 
('33297','0','0','0','0','0','28912','0','0','0','Stormwind Steed','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33298','0','0','0','0','0','29256','0','0','0','Darnassian Nightsaber','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11723'),
('33299','0','0','0','0','0','29261','0','0','0','Darkspear Raptor','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33300','0','0','0','0','0','29259','0','0','0','Thunder Bluff Kodo','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33301','0','0','0','0','0','28571','0','0','0','Gnomeregan Mechanostrider','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33408','0','0','0','0','0','29258','0','0','0','Ironforge Ram','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('33409','0','0','0','0','0','29260','0','0','0','Orgrimmar Wolf','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33414','0','0','0','0','0','29257','0','0','0','Forsaken Warhorse','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11159'),
('33416','0','0','0','0','0','29255','0','0','0','Exodar Elekk','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','11403'),
('33418','0','0','0','0','0','29262','0','0','0','Silvermoon Hawkstrider','','','0','80','80','0','14','14','0','1','1.14286','1','0','20000','30000','0','24','1','2000','0','1','0','8','0','0','0','0','0','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','140','1','0','0','0','generic_vehicleAI_toc5','1'),
('34657','36086','0','0','0','0','28735','0','28735','0','Jaelyne Evensong','Grand Champion of Darnassus','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2095','617297499','0','boss_hunter_toc5','1'),
('34658','0','0','0','0','0','9991','0','0','0','Jaelyne Evensong\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('34701','36083','0','0','0','0','28736','0','28736','0','Colosos','Grand Champion of the Exodar','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67529','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2096','617297499','0','boss_shaman_toc5','1'),
('34702','36082','0','0','0','0','28586','0','28586','0','Ambrose Boltspark','Grand Champion of Gnomeregan','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','64','0','0','0','0','0','0','0','0','0','66044','66042','66045','66043','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','0','617297499','0','boss_mage_toc5','1'),
('34703','36087','0','0','0','0','28564','0','28564','0','Lana Stouthammer','Grand Champion of Ironforge','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','441','1','2093','617297499','0','boss_rouge_toc5','1'),
('34705','36088','0','0','0','0','28560','0','28560','0','Marshal Jacob Alerius','Grand Champion of Stormwind','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2092','617297499','0','boss_warrior_toc5','1'),
('34928','35517','0','0','0','0','29490','0','29490','0','Argent Confessor Paletress','','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','14.5','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66546','66536','66515','66537','0','0','0','0','0','0','0','0','','0','3','8','20','1','0','0','0','0','0','0','0','151','1','235','805257215','0','boss_paletress','1'),
('34942','35531','0','0','0','0','29525','0','29525','0','Memory of Hogger','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35028','35541','0','0','0','0','29536','0','29536','0','Memory of VanCleef','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35029','35538','0','0','0','0','29556','0','29556','0','Memory of Mutanus','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35030','35530','0','0','0','0','29537','0','29537','0','Memory of Herod','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35031','35536','0','0','0','0','29562','0','29562','0','Memory of Lucifron','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','66619','66552','0','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35032','0','0','0','0','0','14992','0','14992','0','Memory of Thunderaan','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35033','35521','0','0','0','0','14367','0','14367','0','Memory of Chromaggus','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35034','35528','0','0','0','0','29540','0','29540','0','Memory of Hakkar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35035','0','0','0','0','0','29888','0','0','0','Barrett Ramsey','Argent Coliseum Master','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','768','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','11723'),
('35036','35543','0','0','0','0','29541','0','29541','0','Memory of Vek\'nilash','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35037','35535','0','0','0','0','29542','0','29542','0','Memory of Kalithresh','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66552','66620','66619','0','0','0','0','0','0','0','0','0','','0','3','29.2313','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35038','35537','0','0','0','0','29543','0','29543','0','Memory of Malchezaar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35039','35527','0','0','0','0','18698','0','18698','0','Memory of Gruul','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35040','35542','0','0','0','0','29545','0','0','0','Memory of Vashj','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35041','35520','0','0','0','0','29546','0','29546','0','Memory of Archimonde','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35042','35533','0','0','0','0','29547','0','29547','0','Memory of Illidan','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35043','35523','0','0','0','0','18699','0','18699','0','Memory of Delrissa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35044','35525','0','0','0','0','23428','0','23428','0','Memory of Entropius','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35045','35534','0','0','0','0','29558','0','29558','0','Memory of Ingvar','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35046','35522','0','0','0','0','29549','0','29549','0','Memory of Cyanigosa','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35047','35524','0','0','0','0','26644','0','26644','0','Memory of Eck','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35048','35539','0','0','0','0','21401','0','21401','0','Memory of Onyxia','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35049','35529','0','0','0','0','29557','0','29557','0','Memory of Heigan','','','0','82','82','2','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35050','35532','0','0','0','0','29185','0','29185','0','Memory of Ignis','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','5','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35051','35544','0','0','0','0','28548','0','28548','0','Memory of Vezax','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35052','35519','0','0','0','0','29553','0','29553','0','Memory of Algalon','','','0','82','82','2','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','4','72','0','0','0','0','0','0','0','0','0','67679','67678','67677','0','0','0','0','0','0','0','0','0','','0','3','29','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','npc_memory','1'),
('35119','35518','0','0','0','0','29616','0','29616','0','Eadric the Pure','Grand Champion of the Argent Crusade','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','14.5','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66865','66863','66867','66935','0','0','0','0','0','0','0','0','','0','3','42.5','20','1','0','0','0','0','0','0','0','151','1','834','805257215','0','boss_eadric','1'),
-- ('35305','35306','0','0','0','0','29758','29759','29758','0','Argent Monk','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67251','67255','67233','67235','0','0','0','0','0','0','7661','7661','','0','3','8','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
-- ('35306','0','0','0','0','0','29758','29759','29758','0','Argent Monk','','','0','80','80','0','14','14','0','1','1','1','1','420','630','0','158','12','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67251','67255','67233','67235','0','0','0','0','0','0','7661','7661','','0','3','23.5867','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
-- ('35307','35308','0','0','0','0','29760','29761','29760','0','Argent Priestess','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','5.5','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','35307','0','0','0','0','0','0','0','0','67194','36176','67289','67229','0','0','0','0','0','0','7653','7653','','0','3','8','8','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
-- ('35308','0','0','0','0','0','29760','29761','29760','0','Argent Priestess','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8.5','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67194','36176','67289','67229','0','0','0','0','0','0','7653','7653','','0','3','10','8','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
-- ('35309','35310','0','0','0','0','29762','29763','29762','0','Argent Lightwielder','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','8.4','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','35309','0','0','0','0','0','0','0','0','67247','67290','15284','67237','0','0','0','0','0','0','7651','7651','','0','3','8','5','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_argent_soldier','1'),
-- ('35310','0','0','0','0','0','29762','29763','29762','0','Argent Lightwielder','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','12.6','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','8','0','0','0','0','0','0','0','0','0','67247','67290','15284','67237','0','0','0','0','0','0','7651','7651','','0','3','8','5','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35314','0','0','0','0','0','29090','0','0','0','Orgrimmar Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35323','0','0','0','0','0','28702','0','0','0','Sen\'jin Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35325','0','0','0','0','0','28864','0','0','0','Thunder Bluff Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','35325','0','0','0','0','0','0','0','0','63010','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','12340'),
('35326','0','0','0','0','0','28862','0','0','0','Silvermoon Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','35305','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35327','0','0','0','0','0','28865','0','0','0','Undercity Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35328','0','0','0','0','0','28863','0','0','0','Stormwind Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35329','0','0','0','0','0','28860','0','0','0','Ironforge Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35330','0','0','0','0','0','28858','0','0','0','Exodar Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35331','0','0','0','0','0','28859','0','0','0','Gnomeregan Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35332','0','0','0','0','0','28857','0','0','0','Darnassus Champion','','','0','80','80','2','35','35','0','1','1.14286','1','1','422','586','0','642','7.5','0','0','1','33554432','8','0','0','0','0','0','345','509','103','7','2048','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','PassiveAI','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','2049','0','0','','11723'),
('35451','35490','0','0','0','0','29837','0','29837','0','The Black Knight','','','0','80','80','2','14','14','0','1','1','1','1','420','630','0','158','11.8','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','35451','0','0','0','0','0','0','0','0','67724','67745','67718','67725','0','0','0','0','0','0','9530','9530','','0','3','5.95238','1','1','0','0','0','0','0','0','0','0','1','0','805257215','0','boss_black_knight','1'),
('35490','0','0','0','0','0','29837','0','29837','0','The Black Knight','','','0','80','80','0','14','14','0','1','1','1','1','420','630','0','158','17.6','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','35490','0','0','0','0','0','0','0','0','67884','68306','67881','67883','0','0','0','0','0','0','10700','10700','','0','3','37.7387','1','1','0','0','0','0','0','0','0','0','1','0','805257215','1','','1'),
('35517','0','0','0','0','0','29490','0','29490','0','Argent Confessor Paletress','','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','22.4','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66546','67674','66515','67675','0','0','0','0','0','0','0','0','','0','3','8','20','1','0','0','0','0','0','0','0','151','1','235','805257215','1','','1'),
('35518','0','0','0','0','0','29616','0','29616','0','Eadric the Pure','Grand Champion of the Argent Crusade','','0','82','82','2','14','14','0','1','1','1','1','452','678','0','170','22.4','2000','2000','2','0','0','0','0','0','0','0','362','542','136','7','104','0','0','0','0','0','0','0','0','0','66865','66863','66867','66935','0','0','0','0','0','0','0','0','','0','3','42.5','20','1','0','0','0','0','0','0','0','151','1','834','805257215','1','','1'),
('35519','0','0','0','0','0','29553','0','29553','0','Memory of Algalon','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','4','72','0','0','0','0','0','0','0','0','0','67679','67678','67677','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35520','0','0','0','0','0','29546','0','29546','0','Memory of Archimonde','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35521','0','0','0','0','0','14367','0','14367','0','Memory of Chromaggus','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35522','0','0','0','0','0','29549','0','29549','0','Memory of Cyanigosa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35523','0','0','0','0','0','18699','0','18699','0','Memory of Delrissa','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35524','0','0','0','0','0','26644','0','26644','0','Memory of Eck','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35525','0','0','0','0','0','23428','0','23428','0','Memory of Entropius','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35527','0','0','0','0','0','18698','0','18698','0','Memory of Gruul','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35528','0','0','0','0','0','29540','0','29540','0','Memory of Hakkar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35529','0','0','0','0','0','29557','0','29557','0','Memory of Heigan','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35530','0','0','0','0','0','29537','0','29537','0','Memory of Herod','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35531','0','0','0','0','0','29525','0','29525','0','Memory of Hogger','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35532','0','0','0','0','0','29185','0','29185','0','Memory of Ignis','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','5','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35533','0','0','0','0','0','29547','0','29547','0','Memory of Illidan','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35534','0','0','0','0','0','29558','0','29558','0','Memory of Ingvar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','6','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35535','0','0','0','0','0','29542','0','29542','0','Memory of Kalithresh','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66552','66620','66619','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35536','0','0','0','0','0','29562','0','29562','0','Memory of Lucifron','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','66619','66552','0','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35537','0','0','0','0','0','29543','0','29543','0','Memory of Malchezaar','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','3','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35538','0','0','0','0','0','29556','0','29556','0','Memory of Mutanus','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35539','0','0','0','0','0','21401','0','21401','0','Memory of Onyxia','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','2','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35541','0','0','0','0','0','29536','0','29536','0','Memory of VanCleef','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35542','0','0','0','0','0','29545','0','29545','0','Memory of Vashj','','','0','82','82','0','14','14','0','1','1','0.5','1','452','678','0','170','15','2000','2000','1','0','0','0','0','0','0','0','362','542','136','7','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35543','0','0','0','0','0','29541','0','29541','0','Memory of Vek\'nilash','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35544','0','0','0','0','0','28548','0','28548','0','Memory of Vezax','','','0','82','82','0','14','14','0','1','1','0.5','1','330','495','0','124','20.5','2000','2000','8','0','0','0','0','0','0','0','264','396','99','10','72','0','0','0','0','0','0','0','0','0','66620','67679','66619','67678','0','0','0','0','0','0','0','0','','0','3','122.031','25','1','0','0','0','0','0','0','0','150','1','0','617297499','0','','1'),
('35545','0','0','0','0','0','25528','0','25528','0','Risen Jaeren Sunsworn','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','2.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_risen_ghoul','1'),
('35564','35568','0','0','0','0','25528','0','25528','0','Risen Arelas Brightstar','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','2.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','npc_risen_ghoul','1'),
('35568','0','0','0','0','0','25528','0','25528','0','Risen Arelas Brightstar','Black Knight\'s Minion','','0','80','80','0','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67879','67886','67880','0','0','0','0','0','0','0','0','0','','0','3','9.43467','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35569','36085','0','0','0','0','28637','0','28637','0','Eressea Dawnsinger','Grand Champion of Silvermoon','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','66044','66042','66045','66043','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2021','617297499','0','boss_mage_toc5','1'),
('35570','36091','0','0','0','0','28588','0','28588','0','Zul\'tore','Grand Champion of Sen\'jin','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2019','617297499','0','boss_hunter_toc5','1'),
('35571','36090','0','0','0','0','28597','0','28597','0','Runok Wildmane','Grand Champion of the Thunder Bluff','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67529','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2025','617297499','0','boss_shaman_toc5','1'),
('35572','36089','0','0','0','0','28587','0','28587','0','Mokra the Skullcrusher','Grand Champion of Orgrimmar','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','441','1','2018','617297499','0','boss_warrior_toc5','1'),
('35590','35717','0','0','0','0','24996','24999','24997','0','Risen Champion','Black Knight\'s Minion','','0','80','80','2','14','14','0','1','1','1','0','420','630','0','158','1','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','1.5','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35617','36084','0','0','0','0','28589','0','28589','0','Deathstalker Visceri','Grand Champion of Undercity','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','10.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2020','617297499','0','boss_rouge_toc5','1'),
('35633','0','0','0','0','0','28571','0','0','0','Ambrose Boltspark\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35634','0','0','0','0','0','10718','0','0','0','Deathstalker Visceri\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35635','0','0','0','0','0','28607','0','0','0','Eressea Dawnsinger\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35636','0','0','0','0','0','2787','0','0','0','Lana Stouthammer\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35637','0','0','0','0','0','29284','0','0','0','Marshal Jacob Alerius\' Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35638','0','0','0','0','0','29879','0','0','0','Mokra the Skullcrusher\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35640','0','0','0','0','0','29880','0','0','0','Runok Wildmane\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35641','0','0','0','0','0','29261','0','0','0','Zul\'tore\'s Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('35644','0','0','0','0','0','28918','0','0','0','Argent Warhorse','','vehichleCursor','0','80','80','2','35','35','0','1','2','1','0','10000','20000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','10','0','0','0','0','0','0','0','0','0','0','62544','62575','63010','66482','0','0','0','0','0','486','0','0','','0','3','40','1','1','0','0','0','0','0','0','0','157','1','0','0','0','','11723'),
('35717','0','0','0','0','0','24996','24999','24997','0','Risen Champion','Black Knight\'s Minion','','0','80','80','0','14','14','0','1','1','1','0','420','630','0','158','1.4','2000','2000','1','0','0','0','0','0','0','0','336','504','126','6','72','0','0','0','0','0','0','0','0','0','67774','67879','67729','67886','0','0','0','0','0','0','0','0','','0','3','7.076','1','1','0','0','0','0','0','0','0','0','1','0','0','0','','1'),
('35768','0','0','0','0','0','29255','0','0','0','Colosos\' Mount','','','0','80','80','2','14','14','0','1','1.14286','1','0','20000','30000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','486','0','0','','0','3','10','1','1','0','0','0','0','0','0','0','0','1','0','0','0','generic_vehicleAI_toc5','11723'),
('36082','0','0','0','0','0','28586','0','28586','0','Ambrose Boltspark','Grand Champion of Gnomeregan','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','64','0','0','0','0','0','0','0','0','0','68312','68310','66045','68311','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','0','617297499','1','','1'),
('36083','0','0','0','0','0','28736','0','28736','0','Colosos','Grand Champion of the Exodar','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','17','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68319','67530','68318','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2096','617297499','1','','1'),
('36084','0','0','0','0','0','28589','0','28589','0','Deathstalker Visceri','Grand Champion of Undercity','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','67709','67706','67701','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2020','617297499','1','','1'),
('36085','0','0','0','0','0','28637','0','28637','0','Eressea Dawnsinger','Grand Champion of Silvermoon','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68312','68310','66045','68311','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2021','617297499','1','','1'),
('36086','0','0','0','0','0','28735','0','28735','0','Jaelyne Evensong','Grand Champion of Darnassus','','0','80','80','2','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2095','617297499','1','','1'),
('36087','0','0','0','0','0','28564','0','28564','0','Lana Stouthammer','Grand Champion of Ironforge','','0','80','80','0','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','441','1','2093','617297499','1','','1'),
('36088','0','0','0','0','0','28560','0','28560','0','Marshal Jacob Alerius','Grand Champion of Stormwind','','0','80','80','0','1802','1802','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2092','617297499','1','','1'),
('36089','0','0','0','0','0','28587','0','28587','0','Mokra the Skullcrusher','Grand Champion of Orgrimmar','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','441','1','2018','617297499','1','','1'),
('36090','0','0','0','0','0','28597','0','28597','0','Runok Wildmane','Grand Champion of the Thunder Bluff','','0','80','80','2','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','2','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68319','67530','67528','67534','0','0','0','0','0','0','0','0','','0','3','15','20','1','0','0','0','0','0','0','0','0','1','2025','617297499','1','','1'),
('36091','0','0','0','0','0','28588','0','28588','0','Zul\'tore','Grand Champion of Sen\'jin','','0','80','80','0','1801','1801','0','1','1','1','1','420','630','0','158','15.2','2000','2000','1','0','0','0','0','0','0','0','336','504','126','7','0','0','0','0','0','0','0','0','0','0','68340','66083','66081','66079','0','0','0','0','0','0','0','0','','0','3','35.38','20','1','0','0','0','0','0','0','0','0','1','2019','617297499','1','','1'),
('36558','0','0','0','0','0','29283','0','0','0','Argent Battleworg','','vehichleCursor','0','80','80','2','35','35','0','1','2','1','0','10000','20000','0','642','1','0','0','1','0','8','0','0','0','0','0','345','509','103','10','0','0','0','0','0','0','0','0','0','0','62544','62575','63010','66482','0','0','0','0','0','486','0','0','','0','3','40','1','1','0','0','0','0','0','0','0','157','1','0','0','0','','11723');

-- Equipment
UPDATE `creature_template` SET `equipment_id`=2049 WHERE `entry` in (35314,35326,35327,35325,35323,35331,35330,35329,35328,35332);
UPDATE `creature_template` SET `equipment_id`=2025 WHERE `entry` in (35571,36090);
UPDATE `creature_template` SET `equipment_id`=2021 WHERE `entry` in (35569,36085);
UPDATE `creature_template` SET `equipment_id`=2018 WHERE `entry` in (35572,36089);
UPDATE `creature_template` SET `equipment_id`=2020 WHERE `entry` in (35617,36084);
UPDATE `creature_template` SET `equipment_id`=2019 WHERE `entry` in (35570,36091);
UPDATE `creature_template` SET `equipment_id`=2096 WHERE `entry` in (34701,36803);
UPDATE `creature_template` SET `equipment_id`=2093 WHERE `entry` in (34703,36087);
UPDATE `creature_template` SET `equipment_id`=2095 WHERE `entry` in (34657,36086);
UPDATE `creature_template` SET `equipment_id`=2092 WHERE `entry` in (34705,36088);
UPDATE `creature_template` SET `equipment_id`=834 WHERE `entry` in (35119,35518);
UPDATE `creature_template` SET `equipment_id`=235 WHERE `entry` in (34928,35517);
UPDATE `creature_template` SET `equipment_id`=0 WHERE `entry` in (35451,35490);

-- Immunities
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1073741823 WHERE `entry` IN
(35309,35310, -- Argent Lightwielder
35305,35306, -- Argent Monk
35307,35308); -- Argent Priestess

-- Anuncios al comienzo del evento.
DELETE FROM `creature_template` WHERE `entry` in (35591,35592);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35591, 0, 0, 0, 0, 0, 29894, 0, 0, 0, 'Jaeren Sunsworn', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart'),
(35592, 0, 0, 0, 0, 0, 29893, 0, 0, 0, 'Arelas Brightstar', '', '', 0, 75, 75, 2, 14, 14, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_anstart');

-- Fountain of Light
DELETE FROM `creature_template` WHERE `entry`=35311;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35311, 0, 0, 0, 0, 0, 27769, 0, 0, 0, 'Fountain of Light', '', '', 0, 79, 80, 0, 14, 14, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '');

-- Grifo esquelйtico del Caballero Negro http://es.wowhead.com/npc=35491
DELETE FROM `creature_template` WHERE `entry`=35491;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35491, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 4, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_black_knight_skeletal_gryphon');
DELETE FROM `script_waypoint` WHERE `entry`=35491;
INSERT INTO `script_waypoint` VALUES
(35491,1,781.513062, 657.989624, 466.821472,0,''),
(35491,2,759.004639, 665.142029, 462.540771,0,''),
(35491,3,732.936646, 657.163879, 452.678284,0,''),
(35491,4,717.490967, 646.008545, 440.136902,0,''),
(35491,5,707.570129, 628.978455, 431.128632,0,''),
(35491,6,705.164063, 603.628418, 422.956635,0,''),
(35491,7,716.350891, 588.489746, 420.801666,0,''),
(35491,8,741.702881, 580.167725, 420.523010,0,''),
(35491,9,761.634033, 586.382690, 422.206207,0,''),
(35491,10,775.982666, 601.991943, 423.606079,0,''),
(35491,11,769.051025, 624.686157, 420.035126,0,''),
(35491,12,756.582214, 631.692322, 412.529785,0,''),
(35491,13,744.841,634.505,411.575,0,'');

-- Grifo esquelйtico del Caballero Negro antes de comenzar la batalla
DELETE FROM `creature_template` WHERE `entry` in (35492);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(35492, 0, 0, 0, 0, 0, 29842, 0, 0, 0, 'Black Knight\'s Skeletal Gryphon', '', '', 0, 80, 80, 2, 35, 35, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 33554432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 486, 0, 0, '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, 0, 'npc_gr');
DELETE FROM `script_waypoint` WHERE `entry`=35492;
INSERT INTO `script_waypoint` VALUES
(35492,1,741.067078, 634.471558, 411.569366,0,''),
(35492,2,735.726196, 639.247498, 414.725555,0,''),
(35492,3,730.187256, 653.250977, 418.913269,0,''),
(35492,4,734.517700, 666.071350, 426.259247,0,''),
(35492,5,739.638489, 675.339417, 438.226776,0,''),
(35492,6,741.833740, 698.797302, 456.986328,0,''),
(35492,7,734.647339, 711.084778, 467.165314,0,''),
(35492,8,715.388489, 723.820862, 470.333588,0,''),
(35492,9,687.178711, 730.140503, 470.569336,0,'');

-- Spawn Announcer in normal/heroic mode
DELETE FROM `creature` WHERE `id`=35004;
DELETE FROM `creature` WHERE `guid`=130961;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(130961, 35004, 650, 3, 1, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0, 0);

-- Daсo
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*1.40) WHERE `entry` IN (SELECT `id` FROM creature WHERE `map`=650);
-- El Caballero Negro 35451 11.8 - 35490 17.6p
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*2) WHERE `entry`= 35451;
UPDATE `creature_template` SET `dmg_multiplier`= (dmg_multiplier*2) WHERE `entry`= 35490;

-- CREATURES SPAWN TRIAL OF CHAMPION MAP 650
DELETE FROM `creature` WHERE `map`=650;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 

-- monturas
-- phaseMask 64
-- http://es.wowhead.com/npc=36558 Huargo de batalla Argenta
(130958, 36558, 650, 3, 1, 0, 0, 726.826, 661.201, 412.472, 4.66003, 86400, 0, 0, 1, 0, 0, 0),
(130960, 36558, 650, 3, 1, 0, 0, 716.665, 573.495, 412.475, 0.977384, 86400, 0, 0, 1, 0, 0, 0), 
(130962, 36558, 650, 3, 1, 0, 0, 705.497, 583.944, 412.476, 0.698132, 86400, 0, 0, 1, 0, 0, 0), 
(130964, 36558, 650, 3, 1, 0, 0, 770.486, 571.552, 412.475, 2.05949, 86400, 0, 0, 1, 0, 0, 0), 
(130966, 36558, 650, 3, 1, 0, 0, 717.443, 660.646, 412.467, 4.92183, 86400, 0, 0, 1, 0, 0, 0), 
(130968, 36558, 650, 3, 1, 0, 0, 700.531, 591.927, 412.475, 0.523599, 86400, 0, 0, 1, 0, 0, 0), 
(130970, 36558, 650, 3, 1, 0, 0, 790.177, 589.059, 412.475, 2.56563, 86400, 0, 0, 1, 0, 0, 0), 
(130972, 36558, 650, 3, 1, 0, 0, 702.165, 647.267, 412.475, 5.68977, 86400, 0, 0, 1, 0, 0, 0), 
(130974, 36558, 650, 3, 1, 0, 0, 773.097, 660.733, 412.467, 4.45059, 86400, 0, 0, 1, 0, 0, 0), 
(130976, 36558, 650, 3, 1, 0, 0, 793.052, 642.851, 412.474, 3.63029, 86400, 0, 0, 1, 0, 0, 0), 
(130978, 36558, 650, 3, 1, 0, 0, 778.741, 576.049, 412.476, 2.23402, 86400, 0, 0, 1, 0, 0, 0), 
(130980, 36558, 650, 3, 1, 0, 0, 788.016, 650.788, 412.475, 3.80482, 86400, 0, 0, 1, 0, 0, 0),
-- phaseMask 128
-- http://es.wowhead.com/npc=35644 Caballo de guerra Argenta
(130982, 35644, 650, 3, 1, 0, 0, 704.943, 651.33, 412.475, 5.60251, 86400, 0, 0, 1, 0, 0, 0),
(130984, 35644, 650, 3, 1, 0, 0, 774.898, 573.736, 412.475, 2.14675, 86400, 0, 0, 1, 0, 0, 0), 
(130986, 35644, 650, 3, 1, 0, 0, 699.943, 643.37, 412.474, 5.77704, 86400, 0, 0, 1, 0, 0, 0), 
(130988, 35644, 650, 3, 1, 0, 0, 712.594, 576.26, 412.476, 0.890118, 86400, 0, 0, 1, 0, 0, 0), 
(130990, 35644, 650, 3, 1, 0, 0, 793.009, 592.667, 412.475, 2.6529, 86400, 0, 0, 1, 0, 0, 0), 
(130992, 35644, 650, 3, 1, 0, 0, 702.967, 587.649, 412.475, 0.610865, 86400, 0, 0, 1, 0, 0, 0), 
(130994, 35644, 650, 3, 1, 0, 0, 768.255, 661.606, 412.47, 4.55531, 86400, 0, 0, 1, 0, 0, 0), 
(130996, 35644, 650, 3, 1, 0, 0, 720.569, 571.285, 412.475, 1.06465, 86400, 0, 0, 1, 0, 0, 0), 
(130998, 35644, 650, 3, 1, 0, 0, 787.439, 584.969, 412.476, 2.47837, 86400, 0, 0, 1, 0, 0, 0), 
(131000, 35644, 650, 3, 1, 0, 0, 722.363, 660.745, 412.468, 4.83456, 86400, 0, 0, 1, 0, 0, 0), 
(131002, 35644, 650, 3, 1, 0, 0, 790.49, 646.533, 412.474, 3.71755, 86400, 0, 0, 1, 0, 0, 0), 
(131004, 35644, 650, 3, 1, 0, 0, 777.564, 660.3, 412.467, 4.34587, 86400, 0, 0, 1, 0, 0, 0),

-- http://es.wowhead.com/npc=35004 anunciador del evento Jaeren Sunsworn
(130961, 35591, 650, 3, 1, 0, 0, 746.626, 618.54, 411.09, 4.63158, 86400, 0, 0, 10635, 0, 0, 0),

-- http://es.wowhead.com/npc=35016 [ph] Argent Raid Spectator - Generic Bunny
(115948, 35016, 650, 3, 1, 0, 0, 746.524, 615.868, 411.172, 0, 180, 0, 0, 1, 0, 0, 0),
(115949, 35016, 650, 3, 1, 0, 0, 795.549, 618.25, 412.477, 0, 180, 0, 0, 1, 0, 0, 0),
(115950, 35016, 650, 3, 1, 0, 0, 782.12, 583.21, 412.474, 0, 180, 0, 0, 1, 0, 0, 0),
(115951, 35016, 650, 3, 1, 0, 0, 791.972, 638.01, 412.47, 0, 180, 0, 0, 1, 0, 0, 0),
(115952, 35016, 650, 3, 1, 0, 0, 780.436, 654.406, 412.474, 0, 180, 0, 0, 1, 0, 0, 0),
(115953, 35016, 650, 3, 1, 0, 0, 697.285, 618.253, 412.476, 0, 180, 0, 0, 1, 0, 0, 0),
(115954, 35016, 650, 3, 1, 0, 0, 714.486, 581.722, 412.476, 0, 180, 0, 0, 1, 0, 0, 0),
(115955, 35016, 650, 3, 1, 0, 0, 703.884, 596.601, 412.474, 0, 180, 0, 0, 1, 0, 0, 0),
(115956, 35016, 650, 3, 1, 0, 0, 746.977, 618.793, 411.971, 0, 180, 0, 0, 1, 0, 0, 0),
(115957, 35016, 650, 3, 1, 0, 0, 748.884, 616.462, 411.174, 0, 180, 0, 0, 1, 0, 0, 0),
(115958, 35016, 650, 3, 1, 0, 0, 702.274, 638.76, 412.47, 0, 180, 0, 0, 1, 0, 0, 0),
(115959, 35016, 650, 3, 1, 0, 0, 792.259, 598.224, 412.47, 0, 180, 0, 0, 1, 0, 0, 0),
(115960, 35016, 650, 3, 1, 0, 0, 712.413, 653.931, 412.474, 0, 180, 0, 0, 1, 0, 0, 0),
(115961, 35016, 650, 3, 1, 0, 0, 747.375, 619.109, 411.971, 0, 180, 0, 0, 1, 0, 0, 0),

-- phaseMask was in 1 now is 65535
-- espectadores
-- http://es.wowhead.com/npc=34856 Espectador del coliseo enano
(131040, 34856, 650, 3, 65535, 0, 0, 810.378, 600.961, 438.781, 2.85266, 300, 0, 0, 1, 0, 0, 0), 
(131041, 34856, 650, 3, 65535, 0, 0, 803.7, 601.271, 435.419, 2.93905, 300, 0, 0, 1, 0, 0, 0),
(131042, 34856, 650, 3, 65535, 0, 0, 803.254, 599.097, 435.419, 2.93512, 300, 0, 0, 1, 0, 0, 0),
(131043, 34856, 650, 3, 65535, 0, 0, 801.833, 592.214, 435.419, 2.66809, 300, 0, 0, 1, 0, 0, 0),
(131044, 34856, 650, 3, 65535, 0, 0, 803.01, 588.849, 436.921, 2.53849, 300, 0, 0, 1, 0, 0, 0),
(131045, 34856, 650, 3, 65535, 0, 0, 808.849, 591.522, 438.762, 2.78589, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34857 Espectador del coliseo trol
(131080, 34857, 650, 3, 65535, 0, 0, 691.338, 593.985, 435.421, 0.463489, 300, 0, 0, 1, 0, 0, 0),
(131081, 34857, 650, 3, 65535, 0, 0, 686.892, 594.635, 436.913, 0.310337, 300, 0, 0, 1, 0, 0, 0),
(131082, 34857, 650, 3, 65535, 0, 0, 682.889, 596.325, 438.744, 0.212162, 300, 0, 0, 1, 0, 0, 0),
(131083, 34857, 650, 3, 65535, 0, 0, 689.73, 599.11, 435.42, 0.341752, 300, 0, 0, 1, 0, 0, 0),
(131084, 34857, 650, 3, 65535, 0, 0, 678.56, 600.035, 440.169, 0.141476, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34858 Espectador del coliseo tauren
(131075, 34858, 650, 3, 65535, 0, 0, 697.235, 584.177, 435.421, 0.58129, 300, 0, 0, 1, 0, 0, 0),
(131076, 34858, 650, 3, 65535, 0, 0, 697.667, 578.208, 436.925, 0.600927, 300, 0, 0, 1, 0, 0, 0),
(131077, 34858, 650, 3, 65535, 0, 0, 689.247, 585.204, 438.779, 0.467415, 300, 0, 0, 1, 0, 0, 0),
(131078, 34858, 650, 3, 65535, 0, 0, 690.431, 576.641, 440.185, 0.565586, 300, 0, 0, 1, 0, 0, 0),
(131079, 34858, 650, 3, 65535, 0, 0, 686.422, 588.876, 438.766, 0.479192, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34859 Espectador del coliseo orco
(131085, 34859, 650, 3, 65535, 0, 0, 689.458, 604.899, 435.417, 0.180746, 300, 0, 0, 1, 0, 0, 0),
(131086, 34859, 650, 3, 65535, 0, 0, 686.041, 601.491, 436.916, 0.255361, 300, 0, 0, 1, 0, 0, 0),
(131087, 34859, 650, 3, 65535, 0, 0, 681.72, 605.995, 438.765, 0.290703, 300, 0, 0, 1, 0, 0, 0),
(131088, 34859, 650, 3, 65535, 0, 0, 689.472, 629.279, 435.417, 6.20476, 300, 0, 0, 1, 0, 0, 0),
(131089, 34859, 650, 3, 65535, 0, 0, 686.241, 634.227, 436.924, 6.11444, 300, 0, 0, 1, 0, 0, 0),
(131090, 34859, 650, 3, 65535, 0, 0, 682.425, 633.087, 438.772, 6.01626, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34860 Espectador del coliseo Renegado
(131096, 34860, 650, 3, 65535, 0, 0, 699.635, 654.463, 435.421, 5.85133, 300, 0, 0, 1, 0, 0, 0),
(131097, 34860, 650, 3, 65535, 0, 0, 695.174, 654.18, 436.925, 5.61964, 300, 0, 0, 1, 0, 0, 0),
(131098, 34860, 650, 3, 65535, 0, 0, 689.259, 651.278, 438.771, 5.79242, 300, 0, 0, 1, 0, 0, 0),
(131099, 34860, 650, 3, 65535, 0, 0, 688.07, 655.691, 440.196, 5.7885, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34861 Espectador del coliseo elfo de sangre
(131091, 34861, 650, 3, 65535, 0, 0, 690.616, 639.017, 435.42, 6.08695, 300, 0, 0, 1, 0, 0, 0),
(131092, 34861, 650, 3, 65535, 0, 0, 692.094, 643.788, 435.42, 5.92201, 300, 0, 0, 1, 0, 0, 0),
(131093, 34861, 650, 3, 65535, 0, 0, 687.286, 642.438, 436.921, 5.97699, 300, 0, 0, 1, 0, 0, 0),
(131094, 34861, 650, 3, 65535, 0, 0, 686.736, 647.02, 438.783, 5.78849, 300, 0, 0, 1, 0, 0, 0),
(131095, 34861, 650, 3, 65535, 0, 0, 680.065, 642.334, 440.188, 6.08302, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34868 Espectador del coliseo draenei
(131046, 34868, 650, 3, 65535, 0, 0, 796.164, 584.956, 435.421, 2.44032, 300, 0, 0, 1, 0, 0, 0),
(131047, 34868, 650, 3, 65535, 0, 0, 798.57, 588.261, 435.421, 2.53064, 300, 0, 0, 1, 0, 0, 0),
(131048, 34868, 650, 3, 65535, 0, 0, 792.513, 579.865, 435.421, 2.43639, 300, 0, 0, 1, 0, 0, 0),
(131049, 34868, 650, 3, 65535, 0, 0, 796.131, 579.051, 436.927, 2.52671, 300, 0, 0, 1, 0, 0, 0),
(131050, 34868, 650, 3, 65535, 0, 0, 801.093, 579.5, 438.752, 2.511, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34869 Espectador del coliseo gnomo
(131029, 34869, 650, 3, 65535, 0, 0, 809.105, 643.482, 438.774, 3.50385, 300, 0, 0, 1, 0, 0, 0),
(131030, 34869, 650, 3, 65535, 0, 0, 802.657, 640.241, 435.419, 3.41353, 300, 0, 0, 1, 0, 0, 0),
(131031, 34869, 650, 3, 65535, 0, 0, 806.511, 638.859, 436.923, 3.33892, 300, 0, 0, 1, 0, 0, 0),
(131032, 34869, 650, 3, 65535, 0, 0, 803.337, 635.024, 435.419, 3.3507, 300, 0, 0, 1, 0, 0, 0),
(131033, 34869, 650, 3, 65535, 0, 0, 810.526, 635.597, 438.772, 3.37874, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34870 Espectador del coliseo humano
(131034, 34870, 650, 3, 65535, 0, 0, 804.269, 629.575, 435.418, 3.29627, 300, 0, 0, 1, 0, 0, 0),
(131035, 34870, 650, 3, 65535, 0, 0, 807.446, 632.568, 436.922, 3.41015, 300, 0, 0, 1, 0, 0, 0),
(131036, 34870, 650, 3, 65535, 0, 0, 811.982, 626.887, 438.773, 3.31983, 300, 0, 0, 1, 0, 0, 0),
(131037, 34870, 650, 3, 65535, 0, 0, 812.287, 608.857, 438.76, 2.92321, 300, 0, 0, 1, 0, 0, 0),
(131038, 34870, 650, 3, 65535, 0, 0, 804.13, 606.65, 435.418, 2.91143, 300, 0, 0, 1, 0, 0, 0),
(131039, 34870, 650, 3, 65535, 0, 0, 807.288, 603.803, 436.927, 2.8054, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34871 Espectador del coliseo elfo de la noche
(131024, 34871, 650, 3, 65535, 0, 0, 795.766, 651.07, 435.421, 3.73555, 300, 0, 0, 1, 0, 0, 0),
(131025, 34871, 650, 3, 65535, 0, 0, 797.19, 655.396, 436.93, 3.89263, 300, 0, 0, 1, 0, 0, 0),
(131026, 34871, 650, 3, 65535, 0, 0, 804.537, 650.886, 438.767, 3.7434, 300, 0, 0, 1, 0, 0, 0),
(131027, 34871, 650, 3, 65535, 0, 0, 802.272, 648.233, 436.923, 3.52898, 300, 0, 0, 1, 0, 0, 0),
(131028, 34871, 650, 3, 65535, 0, 0, 800.747, 644.155, 435.421, 3.6413, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34966 Espectador de la Cruzada Argenta
(131067, 34966, 650, 3, 65535, 0, 0, 726.498, 554.757, 438.775, 1.33527, 300, 0, 0, 1, 0, 0, 0),
(131068, 34966, 650, 3, 65535, 0, 0, 725.875, 561.87, 435.421, 1.29992, 300, 0, 0, 1, 0, 0, 0),
(131069, 34966, 650, 3, 65535, 0, 0, 720.481, 559.718, 436.92, 1.05252, 300, 0, 0, 1, 0, 0, 0),
(131070, 34966, 650, 3, 65535, 0, 0, 720.483, 564.132, 435.421, 1.08394, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34970 Espectador de la Cruzada Argenta
(131060, 34970, 650, 3, 65535, 0, 0, 757.896, 560.428, 435.417, 1.73189, 300, 0, 0, 1, 0, 0, 0),
(131061, 34970, 650, 3, 65535, 0, 0, 763.526, 558.026, 436.932, 1.73189, 300, 0, 0, 1, 0, 0, 0),
(131062, 34970, 650, 3, 65535, 0, 0, 761.724, 553.669, 438.767, 1.78686, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34974 Espectador de la Cruzada Argenta
(131051, 34974, 650, 3, 65535, 0, 0, 785.952, 572.827, 435.421, 2.13401, 300, 0, 0, 1, 0, 0, 0),
(131052, 34974, 650, 3, 65535, 0, 0, 781.002, 569.334, 435.421, 2.09474, 300, 0, 0, 1, 0, 0, 0),
(131053, 34974, 650, 3, 65535, 0, 0, 780.854, 565.183, 436.924, 2.08296, 300, 0, 0, 1, 0, 0, 0),
(131054, 34974, 650, 3, 65535, 0, 0, 786.776, 565.04, 438.765, 2.2204, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34975 Espectador de la Cruzada Argenta
(131055, 34975, 650, 3, 65535, 0, 0, 775.647, 565.757, 435.421, 2.03191, 300, 0, 0, 1, 0, 0, 0),
(131056, 34975, 650, 3, 65535, 0, 0, 766.964, 561.534, 435.421, 1.81828, 300, 0, 0, 1, 0, 0, 0),
(131057, 34975, 650, 3, 65535, 0, 0, 767.925, 557.983, 436.914, 1.72796, 300, 0, 0, 1, 0, 0, 0),
(131058, 34975, 650, 3, 65535, 0, 0, 772.597, 559.445, 436.919, 2.02249, 300, 0, 0, 1, 0, 0, 0),
(131059, 34975, 650, 3, 65535, 0, 0, 777.127, 559.035, 438.781, 2.10495, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34977 Espectador de la Cruzada Argenta
(131063, 34977, 650, 3, 65535, 0, 0, 735.978, 560.676, 435.417, 1.4727, 300, 0, 0, 1, 0, 0, 0),
(131064, 34977, 650, 3, 65535, 0, 0, 733.086, 557.001, 436.916, 1.32347, 300, 0, 0, 1, 0, 0, 0),
(131065, 34977, 650, 3, 65535, 0, 0, 733.016, 549.424, 440.174, 1.2253, 300, 0, 0, 1, 0, 0, 0),
(131066, 34977, 650, 3, 65535, 0, 0, 728.087, 558.086, 436.927, 1.39023, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34979 Espectador de la Cruzada Argenta
(131071, 34979, 650, 3, 65535, 0, 0, 716.195, 558.771, 438.769, 1.02897, 300, 0, 0, 1, 0, 0, 0),
(131072, 34979, 650, 3, 65535, 0, 0, 713.858, 563.841, 436.914, 0.938649, 300, 0, 0, 1, 0, 0, 0),
(131073, 34979, 650, 3, 65535, 0, 0, 711.956, 569.633, 435.421, 1.00148, 300, 0, 0, 1, 0, 0, 0),
(131074, 34979, 650, 3, 65535, 0, 0, 702.138, 563.997, 440.192, 0.962211, 300, 0, 0, 1, 0, 0, 0),

-- http://es.wowhead.com/npc=34883 [ph] Argent Raid Spectator - FX - Horde
(131106, 34883, 650, 3, 65535, 0, 0, 735.931, 560.084, 435.416, 1.3216, 300, 0, 0, 1, 0, 0, 0),
(131107, 34883, 650, 3, 65535, 0, 0, 726.508, 554.731, 438.774, 1.3805, 300, 0, 0, 1, 0, 0, 0),
(131108, 34883, 650, 3, 65535, 0, 0, 713.509, 563.346, 436.897, 1.11347, 300, 0, 0, 1, 0, 0, 0),
(131109, 34883, 650, 3, 65535, 0, 0, 701.499, 563.425, 440.137, 0.944606, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34901 [ph] Argent Raid Spectator - FX - Orc
(131116, 34901, 650, 3, 65535, 0, 0, 681.404, 606.01, 438.753, 0.186696, 300, 0, 0, 1, 0, 0, 0),
(131117, 34901, 650, 3, 65535, 0, 0, 682.044, 633.089, 438.758, 6.26568, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34902 [ph] Argent Raid Spectator - FX - Troll
(131114, 34902, 650, 3, 65535, 0, 0, 690.713, 593.896, 435.421, 0.504781, 300, 0, 0, 1, 0, 0, 0),
(131115, 34902, 650, 3, 65535, 0, 0, 678.504, 599.937, 440.17, 0.159205, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34903 [ph] Argent Raid Spectator - FX - Tauren
(131110, 34903, 650, 3, 65535, 0, 0, 697.341, 577.798, 436.911, 0.665789, 300, 0, 0, 1, 0, 0, 0),
(131111, 34903, 650, 3, 65535, 0, 0, 696.432, 583.914, 435.421, 0.563687, 300, 0, 0, 1, 0, 0, 0),
(131112, 34903, 650, 3, 65535, 0, 0, 689.846, 576.178, 440.141, 0.461585, 300, 0, 0, 1, 0, 0, 0),
(131113, 34903, 650, 3, 65535, 0, 0, 688.993, 584.588, 438.755, 0.669715, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34904 [ph] Argent Raid Spectator - FX - Blood Elf
(131118, 34904, 650, 3, 65535, 0, 0, 687.376, 642.417, 436.923, 6.03791, 300, 0, 0, 1, 0, 0, 0),
(131119, 34904, 650, 3, 65535, 0, 0, 691.9, 643.825, 435.421, 5.83764, 300, 0, 0, 1, 0, 0, 0),
(131120, 34904, 650, 3, 65535, 0, 0, 686.635, 646.976, 438.781, 5.81407, 300, 0, 0, 1, 0, 0, 0),
-- http://es.wowhead.com/npc=34905 [ph] Argent Raid Spectator - FX - Undead
(131121, 34905, 650, 3, 65535, 0, 0, 688.937, 651.509, 438.754, 5.74731, 300, 0, 0, 1, 0, 0, 0),
(131122, 34905, 650, 3, 65535, 0, 0, 699.036, 654.459, 435.421, 5.67271, 300, 0, 0, 1, 0, 0, 0),
(131123, 34905, 650, 3, 65535, 0, 0, 694.682, 654.335, 436.912, 5.7748, 300, 0, 0, 1, 0, 0, 0);

-- cajas que las spawnea el core
DELETE FROM `gameobject_template` WHERE `entry` IN (195709, 195374, 195323); -- modo normal
DELETE FROM `gameobject_template` WHERE `entry` IN (195710, 195375, 195324); -- modo heroico
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES 
('195323','3','9069','Confessor\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195323','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195324','3','9069','Confessor\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195324','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195374','3','9069','Eadric\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195374','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195375','3','9069','Eadric\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195375','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195709','3','9069','Champion\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195709','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723'),
('195710','3','9069','Champion\'s Cache','','','','0','0','2','0','0','0','0','0','0','1634','195710','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','11723');

-- GAMEOBJECTS SPAWN TRIAL OF CHAMPION MAP 650
DELETE FROM `gameobject` WHERE `map`=650;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
('150063','196398','650','3','1','801.663','624.806','412.344','-1.3439','0','0','0','0','0','0','0'),
('150064','196398','650','3','1','784.533','660.238','412.389','-0.715585','0','0','0','0','0','0','0'),
('150065','196398','650','3','1','710.325','660.708','412.387','0.698132','0','0','0','0','0','0','0'),
('150066','196398','650','3','1','692.127','610.575','412.347','1.85005','0','0','0','0','0','0','0'),
('150067','195477','650','3','1','813.13','617.632','413.039','0','0','0','0','0','0','0','0'),
('150068','195486','650','3','1','813.12','617.59','413.031','0','0','0','0','0','0','0','0'),
('150069','195481','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150070','195480','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150071','195479','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150072','195478','650','3','1','746.156','549.464','412.881','1.5708','0','0','0','0','0','0','0'),
('150075','195485','650','3','1','844.685','623.408','159.109','0','0','0','0','0','0','0','0'),
('150081','195647','650','3','1','746.698','677.469','412.339','1.5708','0','0','1','0','0','0','1'),
('150074','195649','650','3','65535','685.625','617.977','412.285','6.28137','0','0','0.000909718','-1','25','0','1'),
('150078','180723','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150079','180723','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150073','195648','650','3','65535','746.561','557.002','412.393','1.57292','0','0','0.707856','0.706357','25','0','1'),
('150076','195650','650','3','65535','807.66','618.091','412.394','3.12015','0','0','0.999943','0.0107224','25','0','0'),
('150082','180708','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0'),
('150083','180708','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150084','180708','650','3','1','704.302','636.326','425.136','-0.418879','0','0','0','0','0','0','0'),
('150085','180703','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0'),
('150086','180703','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150087','180703','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150088','180730','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150089','180730','650','3','1','704.793','600.736','429.519','0.436332','0','0','0','0','0','0','0'),
('150090','180736','650','3','1','792.309','598.457','424.636','2.70526','0','0','0','0','0','0','0'),
('150091','180736','650','3','1','794.441','638.306','425.7','-2.77507','0','0','0','0','0','0','0'),
('150092','180736','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150093','180736','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150094','180720','650','3','1','779.951','655.656','421.818','-2.35619','0','0','0','0','0','0','0'),
('150095','180720','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150096','180738','650','3','1','794.441','638.306','425.7','-2.77507','0','0','0','0','0','0','0'),
('150097','180738','650','3','1','782.309','582.892','421.546','2.25147','0','0','0','0','0','0','0'),
('150098','180728','650','3','1','704.302','636.326','425.136','-0.418879','0','0','0','0','0','0','0'),
('150099','180728','650','3','1','714.158','585.533','425.579','0.715585','0','0','0','0','0','0','0'),
('150100','180728','650','3','1','712.521','655.648','424.593','-0.767944','0','0','0','0','0','0','0');
DELETE FROM `gameobject` WHERE `id` IN (195709, 195374, 195323, 195710, 195375, 195324); -- objetos spawneados en ctdb, no deberian estar


-- DROPS (thanks misimouse from SiOm Project)
-- delete not used reference_loot_template
DELETE FROM `reference_loot_template` WHERE `entry` IN (47497, 47177);
-- drop and conditions
DELETE FROM `conditions` WHERE `SourceGroup` IN (35451, 35490, 195323, 195324, 195374, 195375, 195709, 195710); 
INSERT INTO `conditions` VALUES
(1, 35451, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(1, 35490, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195323, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195324, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195374, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195375, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195709, 43228, 0, 1, 57940, 0, 0, 0, '', NULL),
(4, 195710, 43228, 0, 1, 57940, 0, 0, 0, '', NULL);

-- The Black Knight
-- http://www.wowhead.com/npc=35451/el-caballero-negro#drops:mode=normal:0+1-15
-- Normal
-- Fix drops rates
DELETE FROM `creature_loot_template` WHERE (`entry`=35451);
INSERT INTO `creature_loot_template` VALUES 
(35451, 47216, 16.666, 1, 2, 1, 1),
(35451, 47215, 16.666, 1, 2, 1, 1),
(35451, 47226, 16.666, 1, 2, 1, 1),
(35451, 47227, 16.666, 1, 2, 1, 1),
(35451, 47229, 16.666, 1, 2, 1, 1),
(35451, 47232, 16.666, 1, 2, 1, 1),
(35451, 47222, 16.666, 1, 1, 1, 1),
(35451, 47221, 16.666, 1, 1, 1, 1),
(35451, 47228, 16.666, 1, 1, 1, 1),
(35451, 47220, 16.666, 1, 1, 1, 1),
(35451, 47230, 16.666, 1, 1, 1, 1),
(35451, 47231, 16.666, 1, 1, 1, 1),
(35451, 43228, 28, 1, 0, 3, 3);

-- http://www.wowhead.com/npc=35451/el-caballero-negro#drops:mode=heroic:0+1-15
-- Hero
-- Fix rates and drops and some missing
DELETE FROM `creature_loot_template` WHERE (`entry`=35490);
INSERT INTO `creature_loot_template` VALUES 
(35490, 47565, 14.285, 1, 2, 1, 1),
(35490, 47568, 14.285, 1, 2, 1, 1),
(35490, 47569, 14.285, 1, 2, 1, 1),
(35490, 47564, 14.285, 1, 2, 1, 1),
(35490, 47567, 14.285, 1, 2, 1, 1),
(35490, 47560, 14.285, 1, 2, 1, 1),
(35490, 49682, 14.285, 1, 2, 1, 1),
(35490, 47566, 16.666, 1, 1, 1, 1),
(35490, 47562, 16.666, 1, 1, 1, 1),
(35490, 47529, 16.666, 1, 1, 1, 1),
(35490, 47561, 16.666, 1, 1, 1, 1),
(35490, 47563, 16.666, 1, 1, 1, 1),
(35490, 47527, 16.666, 1, 1, 1, 1),
(35490, 43228, 2, 1, 0, 4, 4),
(35490, 43102, 100, 1, 0, 1, 1),
(35490, 48418, -100, 1, 0, 1, 1),
(35490, 47241, 100, 1, 0, 1, 1),
(35490, 44990, 47, 1, 0, 1, 1),
(35490, 34057, 1.3, 1, 0, 1, 2);

-- Confessor's Cache
-- http://www.wowhead.com/object=195323#contains:mode=normal:0+1-15
-- Normal (Entry: 195323)
-- fix drops rates and groups
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195323);
INSERT INTO `gameobject_loot_template` VALUES 
(195323, 43228, 100, 1, 0, 3, 3),
(195323, 47176, 8.333, 1, 1, 1, 1),
(195323, 47177, 8.333, 1, 1, 1, 1),
(195323, 47178, 8.333, 1, 1, 1, 1),
(195323, 47181, 8.333, 1, 1, 1, 1),
(195323, 47185, 8.333, 1, 1, 1, 1),
(195323, 47211, 8.333, 1, 1, 1, 1),
(195323, 47212, 8.333, 1, 1, 1, 1),
(195323, 47213, 8.333, 1, 1, 1, 1),
(195323, 47214, 8.333, 1, 1, 1, 1),
(195323, 47217, 8.333, 1, 1, 1, 1),
(195323, 47218, 8.333, 1, 1, 1, 1),
(195323, 47219, 8.333, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195323#contains:mode=heroic:0+1-15
-- Heroic (Entry: 195324)
-- Fix rates and groups
UPDATE `gameobject_template` SET `data1`='195324' WHERE entry='195324';
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195324);
INSERT INTO `gameobject_loot_template` VALUES 
(195324, 47514, 8.333, 1, 1, 1, 1),
(195324, 47512, 8.333, 1, 1, 1, 1),
(195324, 47511, 8.333, 1, 1, 1, 1),
(195324, 47510, 8.333, 1, 1, 1, 1),
(195324, 47500, 8.333, 1, 1, 1, 1),
(195324, 47245, 8.333, 1, 1, 1, 1),
(195324, 47522, 8.333, 1, 1, 1, 1),
(195324, 47498, 8.333, 1, 1, 1, 1),
(195324, 47497, 8.333, 1, 1, 1, 1),
(195324, 47496, 8.333, 1, 1, 1, 1),
(195324, 47495, 8.333, 1, 1, 1, 1),
(195324, 47494, 8.333, 1, 1, 1, 1),
(195324, 47241, 100, 1, 0, 1, 1),
(195324, 44990, 40, 1, 0, 1, 1),
(195324, 43228, 23, 1, 0, 4, 4),
(195324, 34057, 1.3, 1, 0, 1, 2);

-- Eadric's Cache
-- http://www.wowhead.com/object=195374#contains:mode=normal:0+1-15
-- Normal (entry: 195374)
-- Fix groups and drops
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195374);
INSERT INTO `gameobject_loot_template` VALUES 
(195374, 47176, 8.333, 1, 1, 1, 1),
(195374, 47200, 8.333, 1, 1, 1, 1),
(195374, 47178, 8.333, 1, 1, 1, 1),
(195374, 47201, 8.333, 1, 1, 1, 1),
(195374, 47213, 8.333, 1, 1, 1, 1),
(195374, 47181, 8.333, 1, 1, 1, 1),
(195374, 47197, 8.333, 1, 1, 1, 1),
(195374, 47177, 8.333, 1, 1, 1, 1),
(195374, 47202, 8.333, 1, 1, 1, 1),
(195374, 47199, 8.333, 1, 1, 1, 1),
(195374, 47185, 8.333, 1, 1, 1, 1),
(195374, 43228, 21, 1, 0, 3, 3),
(195374, 47210, 8.333, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195374#contains:mode=heroic:0+1-15
-- Hero (Entry: 195375)
-- Fix groups and rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195375);
INSERT INTO `gameobject_loot_template` VALUES 
(195375, 47509, 8.333, 1, 1, 1, 1),
(195375, 47508, 8.333, 1, 1, 1, 1),
(195375, 47504, 8.333, 1, 1, 1, 1),
(195375, 47503, 8.333, 1, 1, 1, 1),
(195375, 47502, 8.333, 1, 1, 1, 1),
(195375, 47501, 8.333, 1, 1, 1, 1),
(195375, 47500, 8.333, 1, 1, 1, 1),
(195375, 47498, 8.333, 1, 1, 1, 1),
(195375, 47497, 8.333, 1, 1, 1, 1),
(195375, 47496, 8.333, 1, 1, 1, 1),
(195375, 47495, 8.333, 1, 1, 1, 1),
(195375, 47494, 8.333, 1, 1, 1, 1),
(195375, 47241, 100, 1, 0, 1, 1),
(195375, 44990, 40, 1, 0, 1, 1),
(195375, 43228, 23, 1, 0, 4, 4),
(195375, 34057, 1.3, 1, 0, 1, 2);

-- Champion's Cache
-- http://www.wowhead.com/object=195709#contains:mode=normal:0+1-15
-- Normal (Entry: 195709)
-- Fix rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195709);
INSERT INTO `gameobject_loot_template` VALUES 
(195709, 43228, 24, 1, 0, 3, 3),
(195709, 47172, 16.666, 1, 1, 1, 1),
(195709, 47171, 16.666, 1, 1, 1, 1),
(195709, 47170, 16.666, 1, 1, 1, 1),
(195709, 47174, 16.666, 1, 1, 1, 1),
(195709, 47173, 16.666, 1, 1, 1, 1),
(195709, 47175, 16.666, 1, 1, 1, 1);

-- http://www.wowhead.com/object=195709#contains:mode=heroic:0+1-15
-- (Entry: 195710)
-- Fix rates
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195710);
INSERT INTO `gameobject_loot_template` VALUES 
(195710, 44990, 43, 1, 0, 1, 1),
(195710, 47241, 100, 1, 0, 1, 1),
(195710, 34057, 1.3, 1, 0, 1, 1),
(195710, 43228, 24, 1, 0, 4, 4),
(195710, 47243, 16.666, 1, 1, 1, 1),
(195710, 47244, 16.666, 1, 1, 1, 1),
(195710, 47493, 16.666, 1, 1, 1, 1),
(195710, 47248, 16.666, 1, 1, 1, 1),
(195710, 47249, 16.666, 1, 1, 1, 1),
(195710, 47250, 16.666, 1, 1, 1, 1);

-- Loot for creature Thunder Bluff Champion
-- http://www.wowhead.com/npc=35305#drops:mode=normal
DELETE FROM `creature_loot_template` WHERE (`entry`=35305);
INSERT INTO `creature_loot_template` VALUES 
(35305, 47172, 20, 1, 0, 1, 7),
(35305, 47170, 14, 1, 0, 1, 1);

-- Thunder Bluff Champion
-- Some one, a very nice person, delete this lines for give to us a double work :P
DELETE FROM `creature_loot_template` WHERE (`entry`=35325);
INSERT INTO `creature_loot_template` VALUES 
(35325, 47172, 33, 1, 0, 1, 2),
(35325, 47170, 25, 1, 0, 1, 1);

-- -----------------------------------------------------------------------------------------------
-- ------------------------------------------- Ulduar --------------------------------------------
-- -----------------------------------------------------------------------------------------------
-- THIS SQL CONTAIN ALL ULDUAR SQL NEEDED DATA FOR MYTH CORE.
-- -------------------------------------------------------------------------
-- -------------------------------- Ulduar ---------------------------------
-- -------------------------------------------------------------------------
REPLACE INTO `instance_template` (map, parent, script, allowMount) VALUES ('603', '571', 'instance_ulduar', '1');

UPDATE `gameobject_template` SET `ScriptName` = 'ulduar_teleporter' WHERE `entry` = 194569;

-- Algalon
UPDATE creature_template SET scriptname="mob_collapsing_star" WHERE entry=32955;
UPDATE creature_template SET ScriptName="boss_algalon_the_observer" WHERE entry=32871;
UPDATE creature_template SET ScriptName="mob_living_constellation" WHERE entry=33052;
UPDATE creature_template SET ScriptName="mob_black_hole" WHERE entry=32953;
UPDATE creature_template SET ScriptName="mob_cosmic_smash_target" WHERE entry=33104;
UPDATE creature_template SET ScriptName="mob_dark_mattery" WHERE entry=33089;

-- Assembly of Iron
UPDATE creature_template SET ScriptName = "boss_steelbreaker" WHERE entry = 32867;
UPDATE creature_template SET ScriptName = "boss_runemaster_molgeim" WHERE entry = 32927;
UPDATE creature_template SET ScriptName = "boss_stormcaller_brundir" WHERE entry = 32857;
UPDATE creature_template SET faction_A=16, faction_H=16, scriptname='mob_lightning_elemental', difficulty_entry_1 = 33689 WHERE entry = 32958;
UPDATE creature_template SET ScriptName = "mob_rune_of_summoning" WHERE entry = 33051;
UPDATE creature_template SET ScriptName = "mob_rune_of_power" WHERE entry = 33705;

-- Auriaya
UPDATE creature_template SET ScriptName = "boss_auriaya" WHERE entry = 33515;
UPDATE creature_template SET `faction_A` = 16, `faction_H` = 16, ScriptName = 'feral_defender_trigger' WHERE `entry` = 34096;
UPDATE creature_template SET ScriptName = "mob_sanctum_sentry" WHERE entry = 34014;
UPDATE creature_template SET ScriptName = "mob_feral_defender" WHERE entry = 34035;
UPDATE creature_template SET ScriptName = "seeping_trigger" WHERE entry = 34098;

-- Flame Leviathan
UPDATE creature_template SET ScriptName = "boss_flame_leviathan" WHERE entry = 33113;
UPDATE creature_template SET ScriptName = "boss_flame_leviathan_seat" WHERE entry = 33114;
UPDATE creature_template SET ScriptName = "boss_flame_leviathan_defense_turret" WHERE entry = 33139;
UPDATE creature_template SET ScriptName = "boss_flame_leviathan_overload_device" WHERE entry = 33189;
UPDATE creature_template SET ScriptName = "boss_flame_leviathan_safety_container" WHERE entry = 33218;
UPDATE creature_template SET ScriptName = "spell_pool_of_tar" WHERE entry = 33090;
UPDATE creature_template SET ScriptName = "keeper_norgannon" WHERE entry = 33686;
UPDATE creature_template SET ScriptName = "mob_colossus" WHERE entry = 33237;

-- Correct position
DELETE FROM `creature` WHERE `id`=33113;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(33113, 603, 3, 65535, 0, 0, 435.89, -8.417, 409.886, 3.12723, 480000, 0, 0, 23009250, 0, 0, 0);

-- Delete extra Colossus
DELETE FROM creature WHERE guid IN (128936,128937);

-- Lore Keeper of Norgannon must be gossip
UPDATE creature_template SET npcflag=npcflag |1 WHERE entry=33686;

-- System Shutdown Stun (thx Bloodycore)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62475;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('62475','9032','2','System Shutdown');

-- Fix Repair Station
UPDATE gameobject_template SET ScriptName='' WHERE entry=194261;
DELETE FROM areatrigger_scripts WHERE entry IN (5369, 5423);
INSERT INTO areatrigger_scripts VALUES
(5369,'AT_RX_214_repair_o_matic_station'),
(5423,'AT_RX_214_repair_o_matic_station');

-- This mob should be invisible
UPDATE creature_template SET flags_extra=flags_extra |128 WHERE entry=33377;

-- Freya
UPDATE creature_template SET ScriptName = "boss_freya" WHERE entry = 32906;
UPDATE creature_template SET ScriptName = "boss_elder_brightleaf" WHERE entry = 32915;
UPDATE creature_template SET `modelid1` = 11686, `modelid2` = 0, `unit_flags` = 33686022, ScriptName = 'creature_unstable_sun_beam' WHERE `entry` = 33050;
UPDATE creature_template SET `unit_flags` = 33685510, `modelid1` = 11686, `modelid2` = 0, ScriptName = 'creature_sun_beam' WHERE `entry` =33170;
UPDATE creature_template SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 393220, ScriptName = 'creature_iron_roots' WHERE `entry` = 33168;
UPDATE creature_template SET ScriptName = "boss_elder_ironbranch" WHERE entry = 32913;
UPDATE creature_template SET `unit_flags` = 393220, ScriptName = 'creature_eonars_gift' WHERE `entry` =33228;
UPDATE creature_template SET ScriptName = "boss_elder_stonebark" WHERE entry = 32914;
UPDATE creature_template SET `modelid1` = 11686, `modelid2` = 0, `unit_flags` = 33685508, ScriptName = 'creature_nature_bomb' WHERE `entry` =34129;
UPDATE creature_template SET ScriptName = 'creature_detonating_lasher' WHERE `entry` =32918;
UPDATE creature_template SET ScriptName = 'creature_ancient_conservator' WHERE `entry` =33203;
UPDATE creature_template SET `unit_flags` = 33686022, ScriptName = 'creature_healthy_spore' WHERE `entry` =33215;
UPDATE creature_template SET ScriptName = 'creature_storm_lasher' WHERE `entry` =32919;
UPDATE creature_template SET ScriptName = 'creature_snaplasher' WHERE `entry` =32916;
UPDATE creature_template SET ScriptName = 'creature_ancient_water_spirit' WHERE `entry` =33202;

-- General Vezax
UPDATE creature_template SET `mechanic_immune_mask` = 617299803, `flags_extra` = 257, ScriptName = 'boss_general_vezax' WHERE `entry` = 33271;
UPDATE creature_template SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, ScriptName = 'mob_saronite_vapors' WHERE `entry` = 33488;
UPDATE creature_template SET `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 650854235, ScriptName = 'mob_saronite_animus' WHERE `entry` = 33524;
UPDATE creature_template SET `modelid1` = 28470, `modelid2` = 0, ScriptName = 'mob_icicle' WHERE `entry` = 33169;
UPDATE creature_template SET `modelid1` = 28470, `modelid2` = 0, ScriptName = 'mob_icicle_snowdrift' WHERE `entry` = 33173;

-- Hodir
UPDATE creature_template SET ScriptName = "boss_hodir" WHERE entry=32845;
UPDATE creature_template SET ScriptName = 'mob_hodir_priest' WHERE `entry` IN (32897, 33326, 32948, 33330);
UPDATE creature_template SET ScriptName = 'mob_hodir_shaman' WHERE `entry` IN (33328, 32901, 33332, 32950);
UPDATE creature_template SET ScriptName = 'mob_hodir_druid' WHERE `entry` IN (33325, 32900, 32941, 33333);
UPDATE creature_template SET ScriptName = 'mob_hodir_mage' WHERE `entry` IN (32893, 33327, 33331, 32946);
UPDATE creature_template SET `modelid1` = 15880, `modelid2` = 0, ScriptName = 'toasty_fire' WHERE `entry` = 33342;

-- Ignis
UPDATE creature_template SET ScriptName = "boss_ignis" WHERE entry = 33118;
UPDATE creature_template SET ScriptName = "mob_iron_construct" WHERE entry = 33121;
UPDATE creature_template SET `modelid1` = 16925, `modelid2` = 0, ScriptName = 'mob_scorch_ground' WHERE `entry` = 33221;

-- Kologarn
UPDATE creature_template SET ScriptName = "boss_kologarn" WHERE entry = 32930;
UPDATE creature_template SET `faction_A` = 16, `faction_H` = 16, ScriptName = 'mob_focused_eyebeam' WHERE `entry` IN (33632, 33802);
UPDATE creature_template SET ScriptName = "mob_right_arm" WHERE entry = 32934;
UPDATE creature_template SET ScriptName = "mob_left_arm" WHERE entry = 32933;

-- Razorscale
UPDATE creature_template SET ScriptName = "boss_razorscale" WHERE entry = 33186;
UPDATE creature_template SET ScriptName = "npc_expedition_commander" WHERE entry = 33210;
UPDATE creature_template SET ScriptName = "mob_devouring_flame" WHERE entry = 34188;
UPDATE creature_template SET ScriptName = "mob_darkrune_watcher" WHERE entry = 33453;
UPDATE creature_template SET ScriptName = "mob_darkrune_guardian" WHERE entry = 33388;
UPDATE creature_template SET ScriptName = "mob_darkrune_sentinel" WHERE entry = 33846;
UPDATE creature_template SET ScriptName = "mole_machine_trigger" WHERE entry = 33245;

-- Thorim
UPDATE creature_template SET ScriptName = "boss_thorim" WHERE entry=32865;
UPDATE creature_template SET `faction_A` = 14, `faction_H` = 14, ScriptName = 'mob_pre_phase' WHERE `entry` IN (32882, 32908, 32885, 33110);
UPDATE creature_template SET `unit_flags` = 0, `faction_A` = 14, `faction_H` = 14, ScriptName = 'mob_arena_phase' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875);
UPDATE creature_template SET `unit_flags` = 0, ScriptName = 'mob_runic_colossus' WHERE `entry` = 32872;
UPDATE creature_template SET `unit_flags` = 0, ScriptName = 'mob_rune_giant' WHERE `entry` = 32873;
UPDATE creature_template SET `modelid1` = 16925, `modelid2` = 0, ScriptName = 'thorim_trap_bunny' WHERE `entry` = 33725;
UPDATE creature_template SET `flags_extra` = 0, ScriptName = 'thorim_energy_source' WHERE `entry` = 32892;
UPDATE creature_template SET `dmgschool` = 4, `dmg_multiplier` = 7.5, `unit_flags` = 33587202, ScriptName = 'npc_sif' WHERE `entry` = 33196;

-- XT-002
UPDATE creature_template SET ScriptName = "boss_xt002" WHERE entry = 33293;
UPDATE creature_template SET ScriptName = "mob_xt002_heart" WHERE entry=33329;
UPDATE creature_template SET ScriptName = "mob_scrapbot" WHERE entry = 33343;
UPDATE creature_template SET ScriptName = "mob_pummeller" WHERE entry=33344;
UPDATE creature_template SET ScriptName = "mob_boombot" WHERE entry = 33346;
UPDATE creature_template SET ScriptName = "mob_void_zone" WHERE entry = 34001;
UPDATE creature_template SET ScriptName = "mob_life_spark" WHERE entry = 34004;

-- Some instance data
SET @entry=60000;
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(@entry,'0','0','0','0','0','169','16925','0','0','Thorim Event Bunny','','','0','80','80','2','14','14','0','1','1.14286','1','1','422','586','0','642','7.5','2000','0','1','33554432','8','0','0','0','0','0','345','509','103','10','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','0','0','0','0','0','0','0','0','1','0','0','0','thorim_phase_trigger','11723');

-- Algalon
REPLACE INTO script_texts
(entry, content_default, sound, TYPE, LANGUAGE, emote, COMMENT) VALUES
(-1615172, "Trans-location complete. Commencing planetary analysis of Azeroth.", 15405, 0, 0, 0, "Algalon: Intro 1"),
(-1615173, "Stand back, mortals. I am not here to fight you.", 15406, 0, 0, 0, "Algalon: Intro 2"),
(-1615174, "It is in the universe's best interest to re-originate this planet should my analysis find systemic corruption. Do not interfere.", 15407, 0, 0, 0, "Algalon: Intro 3"),
(-1615175, "See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.", 15390, 1, 0, 0, "Algalon: Engaged for the first time"),
(-1615176, "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.", 15386, 1, 0, 0, "Algalon: Aggro"),
(-1615177, "The stars come to my aid.", 15392, 1, 0, 0, "Algalon: Summoning Collapsing Stars"),
(-1615178, "Witness the fury of cosmos!", 15396, 1, 0, 0, "Algalon: Big Bang 1"),
(-1615179, "Behold the tools of creation!", 15397, 1, 0, 0, "Algalon: Big Bang 2"),
(-1615180, "Beware!", 15391, 1, 0, 0, "Algalon: Phase 2"),
(-1615181, "Loss of life, unavoidable.", 15387, 1, 0, 0, "Algalon: Killing a player 1"),
(-1615182, "I do what I must.", 15388, 1, 0, 0, "Algalon: Killing a player 2"),
(-1615183, "You are... out of time.", 15394, 1, 0, 0, "Algalon: Berserk"),
(-1615184, "Analysis complete. There is partial corruption in the planet's life-support systems as well as complete corruption in most of the planet's defense mechanisms.", 15398, 0, 0, 0, "Algalon: Despawn 1"),
(-1615185, "Begin uplink: Reply Code: 'Omega'. Planetary re-origination requested.", 15399, 0, 0, 0, "Algalon: Despawn 2"),
(-1615186, "Farewell, mortals. Your bravery is admirable, for such flawed creatures.", 15400, 0, 0, 0, "Algalon: Despawn 3"),
(-1615187, "I have seen worlds bathed in the Makers' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?", 15393, 0, 0, 0, "Algalon: Defeated 1"),
(-1615188, "Perhaps it is your imperfection that which grants you free will. That allows you to persevere against cosmically calculated odds. You prevailed where the Titans' own perfect creations have failed.", 15401, 0, 0, 0, "Algalon: Defeated 2"),
(-1615189, "I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore.", 15402, 0, 0, 0, "Algalon: Defeated 3"),
(-1615190, "I lack the strength to transmit the signal. You must hurry. Find a place of power close to the skies.", 15403, 0, 0, 0, "Algalon: Defeated 4"),
(-1615191, "Do not worry about my fate $N. If the signal is not transmitted in time re-origination will proceed regardless. Save. Your. World.", 15403, 0, 0, 0, "Algalon: Defeated 5");

-- -------------------------------------------------------------------------
-- ----------------------------- Halls Of Stone ----------------------------
-- -------------------------------------------------------------------------
UPDATE `gameobject_template` SET `flags` = 4 WHERE `entry` IN (190586,193996);
UPDATE `gameobject` SET `spawnMask` = 1 WHERE `id` = 190586;
DELETE FROM `gameobject` WHERE `id` = '193996';
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
VALUES ('193996','599','2','1','880.406','345.164','203.706','0','0','0','0','1','86400','0','1');

UPDATE `gameobject` SET `spawntimesecs` = 86400 WHERE `id` IN (190586,193996);
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2 , `unit_flags` = `unit_flags`|2 WHERE `entry` = 28055;
UPDATE `creature_template` SET `flags_extra`= `flags_extra`|2|128 , `InhabitType`= 4 WHERE `entry` IN (28234,28235,28237,28265,30897,30898,30899,31874,31875,31878);
UPDATE `creature_template` SET `modelid1` = 17200, `modelid2` = 17200 WHERE `entry` IN (28235,31874);
UPDATE `creature` SET `spawnMask` = 0 WHERE `guid` = 126794;
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (27975,27977,27978,31384,31381,31386);
UPDATE `creature_template` SET `dmg_multiplier` = 16 WHERE `entry` = 31384;
UPDATE `creature_template` SET `dmg_multiplier` = 22 WHERE `entry` = 31381;
UPDATE `creature_template` SET `ScriptName` = 'mob_dark_matter' WHERE `entry` = 28235;
UPDATE `creature_template` SET `ScriptName` = 'mob_searing_gaze' WHERE `entry` = 28265;
UPDATE `creature_template` SET `AIName`= 'EventAI' WHERE `entry` IN (27979,27982,27983,27984,27985);

-- EventAI Scripts
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (27979,27982,27983,27984,27985);
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) 
VALUES
('2798401','27984','0','0','100','3','7000','10000','7000','10000','11','12167','4','1','0','0','0','0','0','0','0','0','Dark Rune Stormcaller (Normal) - Cast Lightning Bolt'),
('2798402','27984','0','0','100','5','7000','10000','7000','10000','11','59863','4','1','0','0','0','0','0','0','0','0','Dark Rune Stormcaller (Heroic) - Cast Lightning Bolt'),
('2798403','27984','0','0','100','3','4000','7000','12000','15000','11','15654','4','0','0','0','0','0','0','0','0','0','Dark Rune Stormcaller (Normal) - Cast Shadow Word: Pain'),
('2798404','27984','0','0','100','5','4000','7000','12000','15000','11','59864','4','0','0','0','0','0','0','0','0','0','Dark Rune Stormcaller (Heroic) - Cast Shadow Word: Pain'),
('2798301','27983','0','0','100','7','7000','10000','10000','15000','11','42724','1','0','0','0','0','0','0','0','0','0','Dark Rune Protector - Cast Cleave'),
('2798302','27983','0','0','100','7','7000','10000','15000','20000','11','22120','4','2','0','0','0','0','0','0','0','0','Dark Rune Protector - Cast Charge'),
('2798501','27985','0','0','100','7','4000','7000','10000','15000','11','33661','1','0','0','0','0','0','0','0','0','0','Iron Golem Custodian - Cast Crush Armor'),
('2798502','27985','0','0','100','3','7000','10000','15000','20000','11','12734','0','0','0','0','0','0','0','0','0','0','Iron Golem Custodian (Normal) - Cast Ground Smash'),
('2798503','27985','0','0','100','5','7000','10000','15000','20000','11','59865','0','0','0','0','0','0','0','0','0','0','Iron Golem Custodian (Heroic) - Cast Ground Smash'),
('2798201','27982','0','0','100','3','4000','7000','10000','15000','11','50895','4','0','0','0','0','0','0','0','0','0','Forged Iron Dwarf (Normal) - Cast Lightning Tether'),
('2798202','27982','0','0','100','5','4000','7000','10000','15000','11','59851','4','0','0','0','0','0','0','0','0','0','Forged Iron Dwarf (Heroic) - Cast Lightning Tether'),
('2797901','27979','0','0','100','3','4000','7000','7000','12000','11','50900','4','0','0','0','0','0','0','0','0','0','Forged Iron Trogg (Normal) - Cast Lightning Shock'),
('2797902','27979','0','0','100','5','4000','7000','7000','12000','11','59852','4','0','0','0','0','0','0','0','0','0','Forged Iron Trogg (Heroic) - Cast Lightning Shock');

-- -------------------------------------------------------------------------
-- ------------------------- Halls Of Lightning ----------------------------
-- -------------------------------------------------------------------------
## EventAI for Slag
-- Non-Heroic NPCs
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858501, 28585, 1, 0, 100, 1|2, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61509, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Melt Armor OOC');

REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858502, 28585, 0, 0, 100, 1|2, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61509, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Melt Armor');

REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858599, 28585, 6, 0, 100, 2, 
-- event: EVENT_T_DEATH
0, 0, 0, 0, 
-- action1: ACTION_T_CAST 
11, 23113, 0, 1, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Blast Wave on Death');

-- Heroic NPCs
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858503, 28585, 1, 0, 100, 1|4, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61510, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Melt Armor OOC');

REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858504, 28585, 0, 0, 100, 1|4, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61510, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Melt Armor');

REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858598, 28585, 6, 0, 100, 4, 
-- event: EVENT_T_DEATH
0, 0, 0, 0, 
-- action1: ACTION_T_CAST 
11, 22424, 0, 1, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Blast Wave on Death');

## Get a bit more damage from Bosses :)
SET @boss_bjarngrim = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28586);
SET @boss_volkhan   = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28587);
SET @boss_ionar     = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28546);
SET @boss_loken     = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28923);
UPDATE creature_template SET dmg_multiplier = 20 WHERE entry IN (@boss_bjarngrim, @boss_volkhan, @boss_ionar, @boss_loken);

## Add Some damage for whole Instance (heroic)
UPDATE creature_template SET dmg_multiplier = dmg_multiplier + 2 WHERE entry IN (31537, 30979, 30967, 30966, 30968, 30977, 30974, 30964, 30983, 30970, 31533, 31536, 30969, 30965, 30978, 30971, 30975, 30976, 30981, 30972, 31538, 31867, 30980, 30982, 30973);


## Trigger Static Overload Final Damage & Knockback
INSERT IGNORE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) 
VALUES
('-52658','53337','0','Static Overload'),
('-59795','59798','0','Static Overload');

DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (28923,28926,28961,28965,29240,28920,28838,28837,28836,28835,28826,28695,28587,28586,28585,28584,28583,28582,28581,28580,28579,28547,28578,28546);
INSERT INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
('2858300', '28583', '0', '0', '100', '3', '6000', '8000', '10000', '15000', '11', '52531', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Blistering Steamrager - Steam Blast'),
('2858301', '28583', '0', '0', '100', '5', '6000', '8000', '10000', '15000', '11', '59141', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Blistering Steamrager - Steam Blast'),
('2857901', '28579', '9', '0', '100', '3', '5', '20', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Stop Moving when in Throw Range'),
('2857910', '28579', '9', '0', '100', '3', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Start Moving when not in Throw Range I'),
('2857909', '28579', '9', '0', '100', '3', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Start Moving when not in Throw Range II'),
('2857908', '28579', '9', '0', '100', '3', '5', '20', '3500', '4100', '11', '52740', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Cast Throw'),
('2857907', '28579', '2', '0', '100', '2', '15', '0', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', '21', '1', '0', '0', 'Hardened Steel Berserker - Flee at 15% HP'),
('2857906', '28579', '9', '0', '100', '5', '5', '20', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Stop Moving when in Throw Range'),
('2857900', '28579', '9', '0', '100', '5', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Start Moving when not in Throw Range I'),
('2857905', '28579', '9', '0', '100', '5', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Start Moving when not in Throw Range II'),
('2857904', '28579', '9', '0', '100', '5', '5', '20', '3500', '4100', '11', '59259', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Cast Throw'),
('2857903', '28579', '2', '0', '100', '4', '15', '0', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', '21', '1', '0', '0', 'Hardened Steel Berserker - Flee at 15% HP'),
('2857902', '28579', '2', '0', '100', '6', '30', '0', '0', '0', '11', '61369', '0', '0', '1', '-106', '0', '0', '0', '0', '0', '0', 'Hardened Steel Berserker - Casts Enrage at 30% HP'),
('2857800', '28578', '0', '0', '100', '3', '6000', '8000', '10000', '12000', '11', '15655', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Reaver - Shield Slam'),
('2857802', '28578', '0', '0', '100', '5', '6000', '8000', '10000', '12000', '11', '59142', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Reaver - Shield Slam'),
('2857801', '28578', '0', '0', '100', '7', '8000', '10000', '14000', '16000', '11', '42724', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Reaver - Cleave'),
('2858003', '28580', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Stop Movement on Aggro'),
('2858002', '28580', '4', '0', '100', '2', '0', '0', '0', '0', '11', '16100', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Cast Shoot and Set Phase 1 on Aggro'),
('2858001', '28580', '0', '6', '100', '3', '2200', '4700', '2200', '4700', '11', '16100', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Cast Shoot (Phase 1)'),
('2858005', '28580', '9', '6', '100', '3', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Start Movement at 20 Yards (Phase 1)'),
('2858006', '28580', '9', '6', '100', '3', '6', '10', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Stop Movement at 10 Yards (Phase 1)'),
('2858007', '28580', '9', '6', '100', '3', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Start Movement at 5 Yards (Phase 1)'),
('2858004', '28580', '2', '0', '100', '2', '15', '0', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Set Phase 2 at 15% HP'),
('2858016', '28580', '2', '5', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Hardened Steel Skycaller - Start Movement and Flee at 15% HP (Phase 2)'),
('2858017', '28580', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - On Evade set Phase to 0'),
('2858018', '28580', '0', '0', '100', '3', '6000', '8000', '11000', '11000', '11', '52754', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Impact Shot'),
('2858020', '28580', '0', '0', '100', '3', '4000', '4000', '9000', '14000', '11', '52755', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Impact Multi-Shot'),
('2858019', '28580', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Stop Movement on Aggro'),
('2858021', '28580', '4', '0', '100', '4', '0', '0', '0', '0', '11', '61515', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Cast Shoot and Set Phase 1 on Aggro'),
('2858015', '28580', '0', '6', '100', '5', '2200', '4700', '2200', '4700', '11', '61515', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Cast Shoot (Phase 1)'),
('2858014', '28580', '9', '6', '100', '5', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Start Movement at 20 Yards (Phase 1)'),
('2858009', '28580', '9', '6', '100', '5', '6', '10', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Stop Movement at 10 Yards (Phase 1)'),
('2858022', '28580', '9', '6', '100', '5', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'RHardened Steel Skycaller - Start Movement at 5 Yards (Phase 1)'),
('2858008', '28580', '2', '0', '100', '4', '15', '0', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Set Phase 2 at 15% HP'),
('2858000', '28580', '2', '5', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Hardened Steel Skycaller - Start Movement and Flee at 15% HP (Phase 2)'),
('2858010', '28580', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - On Evade set Phase to 0'),
('2858011', '28580', '0', '0', '100', '5', '6000', '8000', '11000', '11000', '11', '59148', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Impact Shot'),
('2858012', '28580', '0', '0', '100', '5', '4000', '4000', '9000', '14000', '11', '59147', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Impact Multi-Shot'),
('2858013', '28580', '0', '0', '100', '7', '6000', '8000', '25000', '35000', '11', '61507', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Hardened Steel Skycaller - Disengage'),
('2869503', '28695', '0', '0', '100', '7', '6000', '8000', '15000', '15000', '11', '23113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Molten Golem - Blast Wave'),
('2869504', '28695', '0', '0', '100', '3', '4000', '4000', '20000', '24000', '11', '52433', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Molten Golem - Immolation Strike'),
('2869500', '28695', '0', '0', '100', '3', '10000', '10000', '12000', '18000', '11', '52429', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Molten Golem - Shatter'),
('2869501', '28695', '0', '0', '100', '5', '4000', '4000', '20000', '24000', '11', '59530', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Molten Golem - Immolation Strike'),
('2869502', '28695', '0', '0', '100', '5', '10000', '10000', '12000', '18000', '11', '59527', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Molten Golem - Shatter'),
('2858502', '28585', '0', '0', '100', '3', '6000', '8000', '10000', '14000', '11', '22424', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Slag - Blast Wave'),
('2858503', '28585', '0', '0', '100', '3', '4000', '6000', '5000', '7000', '11', '61509', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Slag - Melt Armor'),
('2858501', '28585', '0', '0', '100', '5', '6000', '8000', '10000', '14000', '11', '23113', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Slag- Blast Wave'),
('2858500', '28585', '0', '0', '100', '5', '3000', '6000', '5000', '7000', '11', '61510', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Slag - Melt Armor'),
('2892600', '28926', '0', '0', '100', '3', '6000', '8000', '10000', '12000', '11', '52671', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spark of Ionar - Arcing Burn'),
('2892601', '28926', '0', '0', '100', '5', '6000', '8000', '10000', '12000', '11', '59834', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Spark of Ionar - Arcing Burn'),
('2883505', '28835', '4', '0', '100', '2', '0', '0', '0', '0', '11', '61579', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Runic Focus'),
('2883502', '28835', '0', '0', '100', '3', '6000', '8000', '18000', '18000', '11', '53167', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Forked Lightning'),
('2883503', '28835', '0', '0', '100', '3', '4000', '4000', '14000', '15000', '11', '53068', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Rune Punch'),
('2883504', '28835', '4', '0', '100', '4', '0', '0', '0', '0', '11', '61596', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Runic Focus'),
('2883501', '28835', '0', '0', '100', '3', '6000', '8000', '18000', '18000', '11', '59152', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Forked Lightning'),
('2883500', '28835', '0', '0', '100', '3', '4000', '4000', '14000', '15000', '11', '59151', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Construct - Rune Punch'),
('2892000', '28920', '0', '0', '100', '7', '5000', '5000', '14000', '15000', '11', '32315', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Giant - Soul Strike'),
('2892004', '28920', '0', '0', '100', '3', '3000', '3000', '12000', '12000', '11', '53072', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Giant - Stormbolt'),
('2892001', '28920', '0', '0', '100', '3', '10000', '10000', '18000', '18000', '11', '53071', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Giant - Thunderstorm'),
('2892002', '28920', '0', '0', '100', '5', '3000', '3000', '12000', '12000', '11', '59155', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Giant - Stormbolt'),
('2892003', '28920', '0', '0', '100', '5', '10000', '10000', '18000', '18000', '11', '59154', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Giant - Thunderstorm'),
('2924003', '29240', '4', '0', '100', '6', '0', '0', '0', '0', '11', '59085', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Lieutenant - Renew Steel'),
('2924002', '29240', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Lieutenant - Arc Weld'),
('2924004', '29240', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Lieutenant - Arc Weld'),
('2924001', '29240', '0', '0', '100', '7', '5000', '5000', '15000', '15000', '11', '52773', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Hammer Blow'),
('2924000', '29240', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Renew Steel'),
('2924005', '29240', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Renew Steel'),
('2883600', '28836', '0', '0', '100', '7', '6000', '8000', '20000', '24000', '11', '53048', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Runeshaper - Startling Roar'),
('2883601', '28836', '0', '0', '100', '3', '5000', '5000', '15000', '15000', '11', '53049', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Runeshaper - ChargedFlurry'),
('2883602', '28836', '0', '0', '100', '5', '5000', '5000', '15000', '15000', '11', '61581', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Runeshaper - Charged Flurry'),
('2883700', '28837', '0', '0', '100', '7', '6000', '8000', '20000', '24000', '11', '53047', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Sentinel - Soul Strike'),
('2883701', '28837', '2', '0', '100', '3', '50', '0', '12300', '14900', '11', '34423', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Sentinel - Casts Renew at 50% HP'),
('2883704', '28837', '2', '0', '100', '5', '50', '0', '12300', '14900', '11', '37978', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Sentinel - Casts Renew at 50% HP'),
('2883703', '28837', '0', '0', '100', '3', '5000', '5000', '15000', '15000', '11', '53045', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Sentinel - Sleep'),
('2883702', '28837', '0', '0', '100', '5', '5000', '5000', '15000', '15000', '11', '59165', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Sentinel - Sleep'),
('2858102', '28581', '4', '0', '100', '6', '0', '0', '0', '0', '11', '59085', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Tactician - Arc Weld'),
('2858101', '28581', '0', '0', '100', '3', '5000', '5000', '15000', '15000', '11', '52778', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Tactician - Welding Beam'),
('2858100', '28581', '0', '0', '100', '5', '5000', '5000', '15000', '15000', '11', '59166', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Tactician - Welding Beam'),
('2882603', '28826', '0', '0', '100', '3', '3000', '3000', '11000', '12000', '11', '53043', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormfury Revenant - Electro Shock'),
('2882602', '28826', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52905', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormfury Revenant - Thunderbolt'),
('2882601', '28826', '0', '0', '100', '5', '3000', '3000', '11000', '12000', '11', '59168', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormfury Revenant - Electro Shock'),
('2882600', '28826', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59167', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormfury Revenant - Thunderbolt'),
('2854708', '28547', '0', '0', '100', '7', '6000', '8000', '14000', '15000', '11', '60236', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Cyclone'),
('2854709', '28547', '0', '0', '100', '2', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Stop Movement on Aggro'),
('2854710', '28547', '4', '0', '100', '2', '0', '0', '0', '0', '11', '53044', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Cast Fireball and Set Phase 1 on Aggro'),
('2854711', '28547', '0', '6', '100', '3', '3400', '4700', '3400', '4700', '0', '0', '0', '0', '11', '53044', '1', '0', '0', '0', '0', '0', 'Storming Vortex - Cast Fireball (Phase 1)'),
('2854714', '28547', '3', '6', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Start Movement and Set Phase 2 when Mana is at 15%'),
('2854713', '28547', '9', '6', '100', '3', '25', '80', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Start Movement Beyond 25 Yards'),
('2854700', '28547', '3', '5', '100', '3', '100', '30', '100', '100', '22', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Set Phase 1 when Mana is above 30% (Phase 2)'),
('2854717', '28547', '2', '0', '100', '2', '15', '0', '0', '0', '22', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Set Phase 3 at 15% HP'),
('2854716', '28547', '2', '3', '100', '2', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Storming Vortex - Start Movement and Flee at 15% HP (Phase 3)'),
('2854707', '28547', '7', '0', '100', '2', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - On Evade set Phase to 0'),
('2854715', '28547', '0', '0', '100', '4', '0', '0', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Stop Movement on Aggro'),
('2854718', '28547', '4', '0', '100', '4', '0', '0', '0', '0', '11', '59169', '1', '0', '22', '6', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Cast Fireball and Set Phase 1 on Aggro'),
('2854706', '28547', '0', '6', '100', '5', '3400', '4700', '3400', '4700', '0', '0', '0', '0', '11', '59169', '1', '0', '0', '0', '0', '0', 'Storming Vortex - Cast Fireball (Phase 1)'),
('2854704', '28547', '3', '6', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '22', '5', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Start Movement and Set Phase 2 when Mana is at 15%'),
('2854703', '28547', '9', '6', '100', '5', '25', '80', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Start Movement Beyond 25 Yards'),
('2854702', '28547', '3', '5', '100', '5', '100', '30', '100', '100', '22', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Set Phase 1 when Mana is above 30% (Phase 2)'),
('2854712', '28547', '2', '0', '100', '4', '15', '0', '0', '0', '22', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - Set Phase 3 at 15% HP'),
('2854705', '28547', '2', '3', '100', '4', '15', '0', '0', '0', '21', '1', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', 'Storming Vortex - Start Movement and Flee at 15% HP (Phase 3)'),
('2854701', '28547', '7', '0', '100', '4', '0', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Storming Vortex - On Evade set Phase to 0'),
('2896103', '28961', '0', '0', '100', '3', '3000', '3000', '14000', '14000', '11', '52891', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Siegebreaker - Blade Turning'),
('2896101', '28961', '0', '0', '100', '5', '3000', '3000', '14000', '14000', '11', '59173', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Siegebreaker - Blade Turning'),
('2896102', '28961', '0', '0', '100', '7', '6000', '8000', '20000', '24000', '11', '19134', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Siegebreaker - Frightening Shout'),
('2896100', '28961', '0', '0', '100', '7', '9000', '9000', '16000', '18000', '11', '52890', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Siegebreaker - Penetrating Strike'),
('2896104', '28961', '0', '0', '100', '7', '10000', '10000', '20000', '20000', '11', '23600', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Siegebreaker - Piercing Howl'),
('2883801', '28838', '4', '0', '100', '6', '0', '0', '0', '0', '11', '58619', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Vanguard - Charge'),
('2883800', '28838', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52890', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Vanguard - Poison Tipped Spear'),
('2896502', '28965', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52885', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Deadly Throw'),
('2896504', '28965', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52879', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Deflection'),
('2896513', '28965', '9', '0', '100', '3', '5', '20', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Stop Moving when in Throw Range'),
('2896512', '28965', '9', '0', '100', '3', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Start Moving when not in Throw Range I'),
('2896511', '28965', '9', '0', '100', '3', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Start Moving when not in Throw Range II'),
('2896510', '28965', '9', '0', '100', '3', '5', '20', '3500', '4100', '11', '52904', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Cast Throw'),
('2896500', '28965', '2', '0', '100', '2', '15', '0', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', '21', '1', '0', '0', 'Titanium Thunderer - Flee at 15% HP'),
('2896509', '28965', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59180', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Deadly Throw'),
('2896505', '28965', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59181', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Deflection'),
('2896506', '28965', '9', '0', '100', '5', '5', '20', '0', '0', '21', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Stop Moving when in Throw Range'),
('2896507', '28965', '9', '0', '100', '5', '0', '5', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Start Moving when not in Throw Range I'),
('2896503', '28965', '9', '0', '100', '5', '20', '100', '0', '0', '21', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Start Moving when not in Throw Range II'),
('2896508', '28965', '9', '0', '100', '5', '5', '20', '3500', '4100', '11', '59179', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Titanium Thunderer - Cast Throw'),
('2896501', '28965', '2', '0', '100', '4', '15', '0', '0', '0', '25', '0', '0', '0', '1', '-47', '0', '0', '21', '1', '0', '0', 'Titanium Thunderer - Flee at 15% HP'),
('2858403', '28584', '0', '0', '100', '3', '6000', '8000', '20000', '24000', '11', '52624', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Unbound Firestorm - Afterburn'),
('2858402', '28584', '0', '0', '100', '3', '3000', '3000', '12000', '12000', '11', '53788', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Unbound Firestorm - Lava Burst'),
('2858401', '28584', '0', '0', '100', '5', '6000', '8000', '20000', '24000', '11', '59183', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', 'Unbound Firestorm - Afterburn'),
('2858400', '28584', '0', '0', '100', '5', '3000', '3000', '12000', '12000', '11', '59182', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Unbound Firestorm - Lava Burst'),
('2858602', '28586', '2', '0', '100', '6', '90', '85', '0', '0', '11', '53790', '0', '0', '22', '6', '0', '0', '11', '41105', '0', '0', 'General Bjarngrim - Cast Defensive Stance and Set Phase 1'),
('2858618', '28586', '0', '6', '100', '7', '3000', '6000', '8000', '12000', '11', '36096', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Spell Reflection (Phase 1)'),
('2858617', '28586', '0', '6', '100', '7', '5000', '9000', '10000', '10000', '11', '12555', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Pummel (Phase 1)'),
('2858616', '28586', '2', '6', '100', '6', '60', '55', '0', '0', '11', '53791', '0', '0', '11', '41107', '0', '0', '22', '5', '0', '0', 'General Bjarngrim - Cast Berserker Stance and Set Phase 2 at 60% (Phase 1)'),
('2858623', '28586', '0', '5', '100', '7', '1000', '5000', '3000', '5000', '11', '15284', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Cleave (Phase 2)'),
('2858613', '28586', '0', '5', '100', '7', '3000', '8000', '5000', '9000', '11', '52029', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Knock Away (Phase 2)'),
('2858612', '28586', '0', '5', '100', '7', '7000', '12000', '12000', '17000', '11', '52026', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Slam (Phase 2)'),
('2858611', '28586', '0', '5', '100', '3', '7000', '12000', '10000', '18000', '11', '52027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Whirlwind (Phase 2)'),
('2858610', '28586', '0', '5', '100', '5', '7000', '12000', '10000', '18000', '11', '52028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Whirlwind (Phase 2)'),
('2858609', '28586', '2', '5', '100', '6', '30', '25', '0', '0', '11', '53792', '0', '0', '11', '41106', '0', '0', '22', '4', '0', '0', 'General Bjarngrim - Cast Battle Stance and Set Phase 3 at 30% (Phase 2)'),
('2858604', '28586', '0', '4', '100', '7', '3000', '8000', '10000', '15000', '11', '52098', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Charge Up (Phase 3)'),
('2858608', '28586', '0', '4', '100', '7', '4000', '7000', '10000', '20000', '11', '52022', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Ironform (Phase 3)'),
('2858624', '28586', '0', '4', '100', '7', '1000', '3000', '3000', '6000', '11', '16856', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Mortal Strike (Phase 3)'),
('2858614', '28586', '0', '4', '100', '3', '7000', '12000', '10000', '18000', '11', '52027', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Whirlwind (Phase 3)'),
('2858615', '28586', '0', '4', '100', '5', '7000', '12000', '10000', '18000', '11', '52028', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Whirlwind (Phase 3)'),
('2858619', '28586', '4', '0', '100', '6', '0', '0', '0', '0', '11', '58769', '1', '0', '1', '-1424', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Intercept and Say on Aggro'),
('2858620', '28586', '2', '4', '100', '6', '10', '0', '0', '0', '22', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Set Phase 0 at 10% (Phase 3)'),
('2858621', '28586', '0', '0', '100', '7', '3000', '8000', '10000', '15000', '11', '52098', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Charge Up'),
('2858622', '28586', '0', '0', '100', '7', '4000', '7000', '10000', '20000', '11', '52022', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Ironform'),
('2858607', '28586', '0', '0', '100', '7', '1000', '3000', '3000', '6000', '11', '16856', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Cast Mortal Strike'),
('2858606', '28586', '2', '0', '100', '6', '90', '85', '0', '0', '1', '-1426', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Yell on Defensive Stance'),
('2858605', '28586', '2', '5', '100', '6', '30', '25', '0', '0', '1', '-1425', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Yell on Battle Stance'),
('2858600', '28586', '2', '6', '100', '6', '60', '55', '0', '0', '1', '-1427', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Yell on Berserker Stance'),
('2858601', '28586', '5', '1', '100', '7', '3000', '5000', '0', '0', '1', '-1428', '-1429', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Yell on Kill'),
('2858603', '28586', '6', '0', '100', '6', '0', '0', '0', '0', '1', '-1430', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'General Bjarngrim - Yell on Death'),
('2858707', '28587', '0', '0', '100', '7', '10000', '10000', '50000', '50000', '11', '52238', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Cast Temper'),
('2858706', '28587', '0', '0', '100', '3', '7000', '10000', '15000', '20000', '11', '52237', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Cast Shattering Stomp'),
('2858700', '28587', '0', '0', '100', '5', '7000', '10000', '15000', '20000', '11', '59529', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Cast Shattering Stomp'),
('2858705', '28587', '0', '0', '100', '5', '15000', '15000', '30000', '30000', '11', '59528', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Cast Heat'),
('2858704', '28587', '0', '0', '100', '3', '15000', '15000', '30000', '30000', '11', '52387', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Cast Heat'),
('2858703', '28587', '0', '0', '100', '7', '15000', '15000', '30000', '30000', '1', '-1434', '-1435', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Say on Heat'),
('2858702', '28587', '0', '0', '100', '7', '7000', '10000', '15000', '20000', '1', '-1436', '-1437', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Say on Stomp'),
('2858701', '28587', '4', '0', '100', '6', '0', '0', '0', '0', '1', '-1392', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Say on Aggro'),
('2858708', '28587', '5', '0', '100', '7', '3000', '5000', '0', '0', '1', '-1438', '-1439', '-1440', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Say on Kill'),
('2858709', '28587', '6', '0', '100', '6', '0', '0', '0', '0', '1', '-1441', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Volkhan - Say on Death'),
('2854608', '28546', '0', '0', '100', '3', '2000', '6000', '5000', '9000', '11', '52780', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Cast Ball Lightning'),
('2854607', '28546', '0', '0', '100', '5', '2000', '6000', '5000', '9000', '11', '59800', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Cast Ball Lightning'),
('2854605', '28546', '0', '0', '100', '3', '6000', '10000', '8000', '12000', '11', '52658', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Cast Static Overload'),
('2854604', '28546', '0', '0', '100', '5', '6000', '10000', '8000', '12000', '11', '59795', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Cast Static Overload'),
('2854603', '28546', '0', '0', '100', '7', '10000', '15000', '10000', '20000', '11', '52770', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Cast Disperse'),
('2854602', '28546', '0', '0', '100', '7', '10000', '15000', '10000', '20000', '1', '-1446', '-1447', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Say on Disperse'),
('2854600', '28546', '4', '0', '100', '6', '0', '0', '0', '0', '1', '-1445', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Say on Aggro'),
('2854601', '28546', '5', '0', '100', '7', '3000', '5000', '0', '0', '1', '-1448', '-1450', '-1451', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Say on Kill'),
('2854606', '28546', '6', '0', '100', '6', '3000', '5000', '0', '0', '1', '-1449', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ionar - Say on Death'),
('2892303', '28923', '0', '0', '100', '7', '2000', '5000', '3000', '8000', '11', '52921', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Arc Lightning'),
('2892304', '28923', '0', '0', '100', '3', '10000', '10000', '20000', '20000', '11', '52960', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Lightning Nova'),
('2892305', '28923', '0', '0', '100', '5', '10000', '10000', '20000', '20000', '11', '59835', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Lightning Nova'),
('2892301', '28923', '4', '0', '100', '6', '0', '0', '0', '0', '1', '-1457', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say on Aggro'),
('2892306', '28923', '6', '0', '100', '6', '0', '0', '0', '0', '1', '-1467', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say on Death'),
('2892307', '28923', '0', '0', '100', '7', '10000', '10000', '20000', '20000', '1', '-1458', '-1459', '-1460', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say on Lightning Nova'),
('2892309', '28923', '5', '0', '100', '7', '3000', '5000', '0', '0', '1', '-1461', '-1462', '-1463', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say on Kill'),
('2892300', '28923', '2', '0', '100', '6', '75', '70', '0', '0', '1', '-1464', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say at 75%'),
('2892308', '28923', '2', '0', '100', '6', '50', '45', '0', '0', '1', '-1465', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say at 50%'),
('2892302', '28923', '2', '0', '100', '6', '25', '20', '0', '0', '1', '-1466', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Loken - Say at 25%'),
('2858202', '28582', '0', '0', '100', '7', '3000', '6000', '6000', '8000', '11', '52773', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Cast Hammer Blow'),
('2858201', '28582', '2', '0', '100', '3', '30', '0', '30000', '40000', '11', '52774', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Cast Renew Steel at 30%'),
('2858200', '28582', '2', '0', '100', '5', '30', '0', '30000', '40000', '11', '59160', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Stormforged Mender - Cast Renew Steel at 30%');

DELETE FROM `creature_ai_texts` WHERE `entry` IN(-1392,-1424,-1425,-1426,-1427,-1428,-1429,-1430,-1382,-1434,-1435,-1436,-1437,-1438,-1439,-1440,-1441,-1445,-1446,-1447,-1448,-1449,-1450,-1451,-1457,-1458,-1459,-1460,-1461,-1462,-1463,-1464,-1465,-1466,-1467);
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `sound`, `type`, `language`, `comment`) values
('-1392','Corpse go boom!','13184','1','0','Trollgore'),
('-1424','I\'m the greatest of my father\'s sons! Your end has come!','14149','1','0','General Bjarngrim'),
('-1425','Defend yourself, for all the good it will do!','14151','1','0','General Bjarngrim'),
('-1426','Give me your worst!','14150','1','0','General Bjarngrim'),
('-1427','GRAAAAAH! Behold the fury of iron and steel!','14152','1','0','General Bjarngrim'),
('-1428','So ends your curse!','14153','1','0','General Bjarngrim'),
('-1429','Flesh... is... weak!','14154','1','0','General Bjarngrim'),
('-1430','How can it be...? Flesh is not... stronger!','14156','1','0','General Bjarngrim'),
('-1382','It is you who have destroyed my children? You... shall... pay!','13960','1','0','Volkhan'),
('-1434','Life from the lifelessness... death for you.','13961','1','0','Volkhan'),
('-1435','Nothing is wasted in the process. You will see....','13962','1','0','Volkhan'),
('-1436','I will crush you beneath my boots!','13963','1','0','Volkhan'),
('-1437','All my work... undone!','13964','1','0','Volkhan'),
('-1438','The armies of iron will conquer all!','13965','1','0','Volkhan'),
('-1439','Ha, pathetic!','13966','1','0','Volkhan'),
('-1440','You have cost me too much work!','13967','1','0','Volkhan'),
('-1441','The master was right... to be concerned.','13968','1','0','Volkhan'),
('-1445','You wish to confront the master? You must weather the storm!','14453','1','0','Ionar'),
('-1446','The slightest spark shall be your undoing.','14453','1','0','Ionar'),
('-1447','No one is safe!','14453','1','0','Ionar'),
('-1448','Shocking, isn\'t it?','14453','1','0','Ionar'),
('-1449','Master... you have guests.','14453','1','0','Ionar'),
('-1450','You don\'t have a chance!','14453','1','0','Ionar'),
('-1451','Fire in you life is disappeared!','14453','1','0','Ionar'),
('-1457','What hope is there for you? None!','14162','1','0','Loken'),
('-1458','You cannot hide from fate!','14163','1','0','Loken'),
('-1459','Come closer. I will make it quick.','14164','1','0','Loken'),
('-1460','Your flesh cannot hold out for long.','14165','1','0','Loken'),
('-1461','Only mortal...','14166','1','0','Loken'),
('-1462','I... am... FOREVER!','14167','1','0','Loken'),
('-1463','What little time you had, you wasted!','14168','1','0','Loken'),
('-1464','You stare blindly into the abyss!','14169','1','0','Loken'),
('-1465','Your ignorance is profound. Can you not see where this path leads?','14170','1','0','Loken'),
('-1466','You cross the precipice of oblivion!','14171','1','0','Loken'),
('-1467','My death... heralds the end of this world.','14172','1','0','Loken');

UPDATE creature_template SET  AIName='EventAI' WHERE entry IN (28923,28926,28961,28965,29240,28920,28838,28837,28836,28835,28826,28695,28587,28586,28585,28584,28583,28582,28581,28580,28579,28547,28578,28546);

-- -------------------------------------------------------------------------
-- --------------------------- Isle Of Conquest ----------------------------
-- -------------------------------------------------------------------------
UPDATE gameobject_template SET size=2.151325 WHERE entry=195451;
UPDATE gameobject_template SET size=2.151325 WHERE entry=195452;
UPDATE gameobject_template SET size=3.163336 WHERE entry=195223;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36154;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36169;

-- Canon de la canonniиre de l'Alliance
-- http://fr.wowhead.com/npc=34929
UPDATE `creature_template` SET `spell1`=69495,`VehicleId`='452' WHERE `entry` =34929;

-- Canon de la canonniиre de la Horde
-- http://fr.wowhead.com/npc=34935
UPDATE `creature_template` SET `spell1`=68825,`VehicleId`='453' WHERE `entry` =34935;

-- Canon du donjon
-- http://fr.wowhead.com/npc=34944
UPDATE `creature_template` SET `VehicleId`=160,`spell1`=67452,`spell2`='68169' WHERE `entry` =34944;

-- Catapulte
-- http://fr.wowhead.com/npc=34793
UPDATE `creature_template` SET `VehicleId`=438,`spell1`=66218,`spell2`=66296 WHERE `entry`=34793;

-- Dйmolisseur
-- http://fr.wowhead.com/npc=34775
UPDATE `creature_template` SET `VehicleId`='509',`spell1`='67442',`spell2`='68068' WHERE `entry` =34775;

-- Engin de siиge
-- http://fr.wowhead.com/npc=34776
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=67816,`spell2`=69502 WHERE `entry`=34776;

-- Engin de siиge
-- http://fr.wowhead.com/npc=35069
UPDATE `creature_template` SET `VehicleId`=436,`spell1`=67816,`spell2`=69502 WHERE `entry`=35069;

-- Lanceur de glaive
-- http://fr.wowhead.com/npc=34802
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=34802;

-- Lanceur de glaive
-- http://fr.wowhead.com/npc=35273
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=35273;

-- Tourelle de flammes
-- http://fr.wowhead.com/npc=34778
UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =34778;
-- Tourelle de flammes
-- http://fr.wowhead.com/npc=36356
UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =36356;

-- Tourelle de siиge
-- http://fr.wowhead.com/npc=34777
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=34777;

-- Tourelle de siиge
-- http://fr.wowhead.com/npc=36355
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=36355;

-- Catapult speed
UPDATE creature_template SET `speed_run`=2.428571,`speed_walk`=2.8 WHERE `entry`=34793;

-- Overlord Agmar & script
UPDATE creature_template SET `ScriptName`='boss_isle_of_conquest' WHERE `entry` IN (34924,34922);
	
REPLACE INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(12039, 'le donjon de l''alliance', NULL, 'le donjon de l''alliance', NULL, NULL, NULL, NULL, NULL, NULL),
(12038, 'le donjon de la Horde', NULL, 'le donjon de la Horde', NULL, NULL, NULL, NULL, NULL, NULL),
(12037, 'L''Alliance a pris le donjon de la Horde !', NULL, 'L''Alliance a pris le donjon de la Horde !', NULL, NULL, NULL, NULL, NULL, NULL),
(12036, 'La Horde a pris le donjon de l''Alliance !', NULL, 'La Horde a pris le donjon de l''Alliance !', NULL, NULL, NULL, NULL, NULL, NULL),
(12035, '%s l''emporte !', NULL, '%s l''emporte !', NULL, NULL, NULL, NULL, NULL, NULL),
(12034, '%s a attaquй le donjon de la Horde !', NULL, '%s a attaquй le donjon de la Horde !', NULL, NULL, NULL, NULL, NULL, NULL),
(12033, '%s a attaquй le donjon de l''Alliance !', NULL, '%s a attaquй le donjon de l''Alliance !', NULL, NULL, NULL, NULL, NULL, NULL),
(12032, 'La porte ouest du donjon de la Horde est dйtruite !', NULL, 'La porte ouest du donjon de la Horde est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12031, 'La porte est du donjon de la Horde est dйtruite !', NULL, 'La porte est du donjon de la Horde est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12030, 'La porte sud du donjon de la Horde est dйtruite !', NULL, 'La porte sud du donjon de la Horde est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12029, 'La porte ouest du donjon de l''Alliance est dйtruite !', NULL, 'La porte ouest du donjon de l''Alliance est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12028, 'La porte est du donjon de l''Alliance est dйtruite !', NULL, 'La porte est du donjon de l''Alliance est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12027, 'La porte nord du donjon de l''Alliance est dйtruite !', NULL, 'La porte nord du donjon de l''Alliance est dйtruite !', NULL, NULL, NULL, NULL, NULL, NULL),
(12026, 'The battle will begin in 15 seconds!', NULL, 'La bataille commencera dans 15 secondes.', NULL, NULL, NULL, NULL, NULL, NULL),
(12025, '$n has assaulted the %s', '', '$n a attaquй %s !', '', '', '', '', '', ''),
(12024, '$n has defended the %s', '', '$n a dйfendu %s', '', '', '', '', '', ''),
(12023, '$n claims the %s! If left unchallenged, the %s will control it in 1 minute!', NULL, '$n а attaquй %s! Si rien n\'est fait, %s le contrфlera dans 1 minute!', NULL, NULL, NULL, NULL, NULL, NULL),
(12022, 'Alliance', NULL, 'L''Alliance', NULL, NULL, NULL, NULL, NULL, NULL),
(12021, 'Horde', NULL, 'La Horde', NULL, NULL, NULL, NULL, NULL, NULL),
(12020, 'The %s has taken the %s', NULL, '%s a pris %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12019, 'Workshop', NULL, 'l''atelier', NULL, NULL, NULL, NULL, NULL, NULL),
(12018, 'Docks', NULL, 'les docks', NULL, NULL, NULL, NULL, NULL, NULL),
(12017, 'Refinery', NULL, 'la raffinerie', NULL, NULL, NULL, NULL, NULL, NULL),
(12016, 'Quarry', NULL, 'la carriиre', NULL, NULL, NULL, NULL, NULL, NULL),
(12015, 'Hangar', NULL, 'le hangar', NULL, NULL, NULL, NULL, NULL, NULL),
(12014, 'The battle has begun!', NULL, 'Que la bataille commence !', NULL, NULL, NULL, NULL, NULL, NULL),
(12013, 'The battle will begin in 30 seconds!', NULL, 'La bataille commencera dans 30 secondes.', NULL, NULL, NULL, NULL, NULL, NULL),
(12012, 'The battle will begin in one minute!', NULL, 'La bataille commencera dans 1 minute.', NULL, NULL, NULL, NULL, NULL, NULL),
(12011, 'The battle will begin in two minutes!', NULL, 'La bataille commencera dans 2 minutes.', NULL, NULL, NULL, NULL, NULL, NULL);

REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(66548, 66550, 0, 'Isle of Conquest (OUT>IN)'),
(66549, 66550, 0, 'Isle of Conquest (IN>OUT)'),
(66550, -66549, 2, 'Isle of Conquest Teleport (OUT>IN) Debuff limit'),
(66550, -66548, 2, 'Isle of Conquest Teleport (IN>OUT) Debuff limit');

-- -------------------------------------------------------------------------
-- ----------------------------- Wintergrasp -------------------------------
-- -------------------------------------------------------------------------
-- Unused yet: 
-- Wintergrasp is under attack!
-- Wintergrasp Fortress is under attack!
-- Winter's Edge Tower is under attack!
-- Commander Dardosh yells: The first of the Alliance towers has fallen! Destro all three and we will hasten their retreat!
-- Commander Dardosh yells: Lok'tar! The second tower falls! Destroy the final tower and we will hasten their retreat!
-- Eastern Bridge is under attack!
-- Western Bridge is under attack!
-- Westspark Bridge is under attack!
-- Flamewatch Tower is under attack!

-- TODO: Remove french trad
REPLACE INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES
(12072, 'win keep text', NULL, 'TRAD', NULL, NULL, NULL, NULL, NULL, NULL),
(12071, 'The western tower', NULL, 'La tour ouest', NULL, NULL, NULL, NULL, NULL, NULL),
(12070, 'The eastern tower', NULL, 'La tour est', NULL, NULL, NULL, NULL, NULL, NULL),
(12069, 'The southern tower', NULL, 'La tour sud', NULL, NULL, NULL, NULL, NULL, NULL),
(12068, '%s has successfully defended the Wintergrasp fortress!', NULL, '%s a d?fendu la forteresse du Joug-d''hiver!', NULL, NULL, NULL, NULL, NULL, NULL),
(12067, 'The battle for Wintergrasp begin!', NULL, 'Que la bataille pour le Joug-d''hiver commence!', NULL, NULL, NULL, NULL, NULL, NULL),
(12066, '%s has been destroyed!', NULL, '%s a ?t? d?truite!', NULL, NULL, NULL, NULL, NULL, NULL),
(12065, '%s has been damaged !', NULL, '%s a ?t? endommag?e !', NULL, NULL, NULL, NULL, NULL, NULL),
(12064, 'The north-western keep tower', NULL, 'La tour du donjon nord-ouest', NULL, NULL, NULL, NULL, NULL, NULL),
(12063, 'The south-western keep tower', NULL, 'La tour du donjon sud-ouest', NULL, NULL, NULL, NULL, NULL, NULL),
(12062, 'The north-eastern keep tower', NULL, 'La tour du donjon nord-est', NULL, NULL, NULL, NULL, NULL, NULL),
(12061, 'The south-eastern keep tower', NULL, 'La tour du donjon sud-est', NULL, NULL, NULL, NULL, NULL, NULL),
(12060, 'You have reached Rank 2: First Lieutenant', NULL, 'Vous avez atteint le deuxi?me grade : premier lieutenant', NULL, NULL, NULL, NULL, NULL, NULL),
(12059, 'You have reached Rank 1: Corporal', NULL, 'Vous avez atteint le premier grade : caporal', NULL, NULL, NULL, NULL, NULL, NULL),
(12058, 'The battle for Wintergrasp is going to begin!', NULL, 'La bataille du lac Joug-d''hiver va commencer!', NULL, NULL, NULL, NULL, NULL, NULL),
(12057, 'Alliance', NULL, 'L''alliance', NULL, NULL, NULL, NULL, NULL, NULL),
(12056, 'Horde', NULL, 'la Horde', NULL, NULL, NULL, NULL, NULL, NULL),
(12055, 'The Sunken Ring siege workshop', NULL, 'L''atelier de si?ge de l''Ar?ne Engloutie', NULL, NULL, NULL, NULL, NULL, NULL),
(12054, 'Westspark siege workshop', NULL, 'L''atelier de si?ge de l''Ouestincelle', NULL, NULL, NULL, NULL, NULL, NULL),
(12053, 'Eastspark siege workshop', NULL, 'L''atelier de si?ge de l''Estincelle', NULL, NULL, NULL, NULL, NULL, NULL),
(12052, 'The Broken Temple siege workshop', NULL, 'L''atelier de si?ge du Temple Bris?', NULL, NULL, NULL, NULL, NULL, NULL),
(12051, '%s is under attack by %s', NULL, '%s est attaqu? par %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12050, '%s has been captured by %s ', NULL, '%s a ?t? pris par %s', NULL, NULL, NULL, NULL, NULL, NULL);

REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`)VALUES
(0, -1850500, 'Guide me to the Fortress Graveyard.', NULL, 'Montrez-moi o? est le cimeti?re de la forteresse..', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850501, 'Guide me to the Sunken Ring Graveyard.', NULL, 'Montrez-moi o? est le cimeti?re de l''ar?ne engloutie..', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850502, 'Guide me to the Broken Temple Graveyard.', NULL, 'Montrez-moi o? est le cimeti?re du temple Bris?.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850503, 'Guide me to the Westspark Graveyard.', NULL, 'Montrez-moi o? est le cimeti?re d''Ouestincelle.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850504, 'Guide me to the Eastspark Graveyard.', NULL, 'Montrez-moi o? est le cimeti?re d''Estincelle.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850505, 'Guide me back to the Horde landing camp.', NULL, 'Ramenez-moi au camp d''arriv?e de la Horde.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850506, 'Guide me back to the Alliance landing camp.', NULL, 'Ramenez-moi au camp d''arriv?e de l''Alliance.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850507, 'Se mettre dans la file pour le Joug-d''hiver.', NULL, 'Se mettre dans la file pour le Joug-d''hiver', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '');

UPDATE `creature_template` SET `ScriptName` = 'npc_wg_dalaran_queue' WHERE `entry` IN (32169,32170);
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (54640, 54643, 0, 'WG teleporter');

DELETE FROM `gameobject` where `id` in (190475,190487,194959,194962,192829,190219,190220,191795,191796,191799,191800,191801,191802,191803,191804,191806,191807,191808,191809,190369,190370,190371,190372,190374,190376,190221,190373,190377,190378,191797,191798,191805,190356,190357,190358,190375,191810,	192488,192501,192374,192416,192375,192336,192255,192269,192254,192349,192366,192367,192364,192370,192369,192368,192362,192363,192379,192378,192355,192354,192358,192359,192284,192285,192371,192372,192373,192360,192361,192356,192352,192353,192357,192350,192351,190763,192501,192488,192269,192278) AND `map`=571;
DELETE FROM `creature` where `id` in (30739,30740,31102,31841,31151,31153,32296,31051,31106,31108,31109,31053,30489,39172,31107,32294,31101,30499,31842,31036,31091,39173,31052) AND `map`=571;

UPDATE `creature_template` SET `ScriptName` = 'npc_wg_spiritguide' WHERE `entry` IN (31841,31842);
UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400,30499);

-- -------------------------------------------------------------------------
-- ------------------------ StartUP Errors Fixes ---------------------------
-- -------------------------------------------------------------------------
-- ONLY FOR MYTH DB !!!
-- OutdoorPVP Table (Trinity 9237 Commit)
REPLACE INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `Comment`) VALUES
(1, 'outdoorpvp_hp', 'Hellfire Peninsula'),
(2, 'outdoorpvp_na', 'Nagrand'),
(3, 'outdoorpvp_tf', 'Terokkar Forest'),
(4, 'outdoorpvp_zm', 'Zangarmarsh'),
(5, 'outdoorpvp_si', 'Silithus'),
(6, 'outdoorpvp_ep', 'Eastern Plaguelands');

-- AHTUNG! BackUP your world DB before use this queries! UNTESTED
-- For StarUP errors Fix. REMOVE " /* */ " for use!
DELETE FROM gameobject_loot_template WHERE entry IN (26094, 26097, 195665,195666,195667,195668,195669,195670,195671,195672);
DELETE FROM reference_loot_template WHERE entry IN (47557, 50008, 50009);

-- MythDB Version, for Proper Bug Reports
UPDATE version SET `cache_id`= '566';
UPDATE version SET `core_revision`= '10035';
UPDATE version SET `db_version`= 'MDB_v1.3_YTDB_v565_TC_rev10035';

DELETE FROM creature_addon WHERE guid =136107;

-- -------------------------------------------------------------------------
-- -------------------------- Myth Fixes ----------------------------
-- -------------------------------------------------------------------------
-- Icecrown Citadel Trinks 
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=65005;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=65013;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60442;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60493;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60487;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60529;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60436;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60537;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67670;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=33953;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=62115;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67672;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=33648;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=57352;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=57345;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60490;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=62114;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=59818;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=49622;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=33648;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60063;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=59787;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=60063;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=58901;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67667;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67653;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=33953;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64786;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64714;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64738;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71404;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64792;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=65025;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=65020;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64742;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=65002;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=64764;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71642;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71640;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71562;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71637;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71545;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71611;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71634;
UPDATE `spell_proc_event` SET Cooldown=105 WHERE entry=71519;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71606;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71585;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71406;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=41540;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67771;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71402;
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=67702;

-- Icecrown Citadel Bosses Spells
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71645; -- Unidentifiable Organ
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71602; -- Unidentifiable Organ (HC)
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71573; -- Muradin's Spyglass
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71571; -- Muradin's Spyglass (HC)
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71578; -- Dislodged Foreign Object
UPDATE `spell_proc_event` SET Cooldown=45 WHERE entry=71576; -- Dislodged Foreign Object (HC)
UPDATE `spell_proc_event` SET Cooldown=60 WHERE entry=72415; -- Ashen Band of Unmatched(Endless) Courage
UPDATE `spell_proc_event` SET Cooldown=60 WHERE entry=72417; -- Ashen Band of Unmatched(Endless) Destruction(Wisdom)
UPDATE `spell_proc_event` SET Cooldown=60 WHERE entry=72413; -- Ashen Band of Unmatched(Endless) Vengeance(Might)

-- 1136 Mount: Traveler's Tundra Mammuth Vendors
DELETE FROM `vehicle_accessory` WHERE `entry` IN (32640, 32633);
INSERT INTO `vehicle_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`) VALUES
(32640,32642,1,0, 'Traveler Mammoth (H) - Vendor'),
(32640,32641,2,0, 'Traveler Mammoth (H) - Vendor & Repairer'),
(32633,32638,1,0, 'Traveler Mammoth (A) - Vendor'),
(32633,32639,2,0, 'Traveler Mammoth (A) - Vendor & Repairer');
-- 987 Paladin: Righteous Vengeance should proc with Divine Storm, Judgements and Crusader Strike criticals.
UPDATE `spell_proc_event` SET `SpellFamilyMask1`=163840 WHERE `entry`=53380;
UPDATE `spell_proc_event` SET `SpellFamilyMask1`=163840 WHERE `entry`=53381;
UPDATE `spell_proc_event` SET `SpellFamilyMask1`=163840 WHERE `entry`=53382;
-- 1806 Item: Shadowmourne
DELETE FROM `spell_script_names` WHERE `spell_id`=71905 AND `ScriptName`='spell_item_shadowmourne';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(71905,'spell_item_shadowmourne'); -- Item - Shadowmourne Legendary
DELETE FROM `spell_proc_event` WHERE `entry`=71903;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(71903,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,20,0); -- Item - Shadowmourne Legendary
-- 1300 Paladin: Seal of Righteousness
REPLACE INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('25742','0','0','0','0','Paladin - Seal of Righteousness Dummy Proc'); 
-- 1350 Mage: Finders of Frost
REPLACE INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('199998','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','1','0','-1','0','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','0','0','Frostbite Helper (SERVERSIDE)');
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('12494','199998','0','Frostbite');
REPLACE INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('44543','0','3','1049120','4096','0','65536','0','0','0','0'),
('44545','0','3','1049120','4096','0','65536','0','0','0','0');
-- 2135 Improved Mana Gems 
REPLACE INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES 
(37447, 0, 3, 0, 0x00000100, 0, 0x04000, 0, 0, 0, 0), -- Serpent-Coil Braid
(61062, 0, 3, 0, 0x00000100, 0, 0x04000, 0, 0, 0, 0); -- 2/5 Frostfire Garb
-- 2136 Rogue: Deadly Poison
REPLACE INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('2818','0','0','0','0.03','Rogue - Deadly Poison Rank 1($AP*0.12 / number of ticks)');
REPLACE INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
('-2818','spell_rog_deadly_poison');
-- 2138 Priest: Mana Burn
REPLACE INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
('-8129','spell_pri_mana_burn');
-- 2178 Hunter: Hunting Party
REPLACE INTO spell_proc_event (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(53290,0,9,0x800,0x1,0x200,0,0x0000002,0,0,0),
(53291,0,9,0x800,0x1,0x200,0,0x0000002,0,0,0),
(53292,0,9,0x800,0x1,0x200,0,0x0000002,0,0,0); 
-- 2225 NPC: Squire Danny (http://www.wowhead.com/npc=33518)
UPDATE `creature_template` SET `ScriptName`='npc_squire_danny' WHERE `entry`=33518;
-- 2263 World: Commands
DELETE FROM trinity_string WHERE entry IN (819, 820);
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('819','OPvP are set to 1v1 for debugging. So, don\'t join as group.');
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES ('820','OPvP are set to normal playercount.');
DELETE FROM command WHERE name = 'debug opvp';
INSERT INTO command (`name`, `security`, `help`) VALUES ('debug opvp', 3, 'Syntax: .debug opvp\r\n\r\nToggle debug mode for outdoorPvPs. In debug mode a outdoorPvP can be started with single player.');
-- 2272 Mage: Living Bomb
DELETE FROM `spell_proc_event` WHERE `entry` IN ('44449','44469','44470','44471','44472','44445','44446','44448');
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('44449','0','3','551686903','233544','0','0','2','0','0','0'), -- Burnout (Rank 1)
('44469','0','3','551686903','233544','0','0','2','0','0','0'), -- Burnout (Rank 2)
('44470','0','3','551686903','233544','0','0','2','0','0','0'), -- Burnout (Rank 3)
('44471','0','3','551686903','233544','0','0','2','0','0','0'), -- Burnout (Rank 4)
('44472','0','3','551686903','233544','0','0','2','0','0','0'), -- Burnout (Rank 5)
('44445','0','3','19','69632','0','0','0','0','0','0'), -- Hot Streak (Rank 1)
('44446','0','3','19','69632','0','0','0','0','0','0'), -- Hot Streak (Rank 2)
('44448','0','3','19','69632','0','0','0','0','0','0'); -- Hot Streak (Rank 3)
DELETE FROM `spell_bonus_data` WHERE `entry` IN ('44457','44461');
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('44457','0','0.2','0','0','Mage - Living Bomb'),
('44461','0.4','0','0','0','Mage - Living Bomb');
-- 2275 Rogue: Vanish
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -1784;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-1784, -11327, 0, 'Vanish - Rank 1'),
(-1784, -11329, 0, 'Vanish - Rank 2'),
(-1784, -26888, 0, 'Vanish - Rank 3');
-- 2291 Dalaran: Portal
DELETE FROM gameobject_template WHERE `entry`=191164;
INSERT INTO gameobject_template VALUES ('191164', '22', '8111', 'Portal to Dalaran', '', '', '', '0', '0', '1', '0', '0', '0', '0', '0', '0', '53360', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '12340');
-- 2322 Warrior: Taste for Blood
UPDATE `spell_proc_event` SET `procEx` = 0x00040000 WHERE `entry` IN (56636, 56637, 56638);
-- 2346 Dungeron: Trial of the Champion
UPDATE `instance_template` SET `allowMount` = '1' WHERE `map` =650;
-- 2365 Shaman: Ancestral Healing & Riptide
REPLACE INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('16176','0','11','448','0','16','0','2','0','0','0'),  -- Ancestral Healing (Rank 1)
('16235','0','11','448','0','16','0','2','0','0','0'),  -- Ancestral Healing (Rank 2)
('16240','0','11','448','0','16','0','2','0','0','0');  -- Ancestral Healing (Rank 3)
-- 2373 Merge with Trinity 10029 Additional Data
-- Spell: Hunger For Blood
DELETE FROM spell_scripts WHERE `id`=51662 AND `effIndex`=0;
INSERT INTO spell_scripts (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(51662,0,0,15,63848,1,1,0,0,0,0);
-- Spell: Cheat Death
DELETE FROM spell_scripts WHERE `id`=31231 AND `effIndex`=0;
INSERT INTO spell_scripts (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(31231,0,0,15,45182,1,1,0,0,0,0);
-- 2400 Rogue: Master Poisoner
DELETE FROM `spell_dbc` WHERE `Id` IN ('45176');
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('45176','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','1','1','1','0','1','0','-1','0','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','8','0','0','0','0','0','0','0','0','0','0','1','Master Poisoner Trigger (SERVERSIDE)');
DELETE FROM `spell_proc_event` WHERE `entry` IN ('31226', '31227', '58410');
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('31226','0','8','0','524288','0','0','0','0','0','0'), -- Master Poisoner (Rank 1)
('31227','0','8','0','524288','0','0','0','0','0','0'), -- Master Poisoner (Rank 2)
('58410','0','8','0','524288','0','0','0','0','0','0'); -- Master Poisoner (Rank 3)
-- 2469 Spell: Ram for brewfest
DELETE FROM `spell_script_names` WHERE `spell_id` IN (42992,42993,42994,43310) AND `ScriptName` IN ('spell_ram_trot','spell_ram_neutral','spell_ram_canter','spell_ram_gallop');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(42992,'spell_ram_trot'),
(42993,'spell_ram_neutral'),
(42994,'spell_ram_canter'),
(43310,'spell_ram_gallop');
-- 2505 Quest: Start DK Quests Fixes
-- NPC 28481.
-- Bug: this trigger NPC shouldnt be visible for players
UPDATE `creature_template` SET `flags_extra`='128' WHERE (`entry`='28481');
-- NPC 28367.
-- Bug: this trigger NPC shouldnt be visible for players
UPDATE `creature_template` SET `flags_extra`='192' WHERE (`entry`='28367');
-- NPC 28511.
-- Bug. The eye sometimes spawns as a little brown eye instead of big blue one. Fixing diplayID.
UPDATE `creature_template` SET `modelid1`='26320', `modelid2`='26320' WHERE (`entry`='28511');
UPDATE `creature_model_info` SET `modelid_other_gender`='0' WHERE (`modelid`='26320');
-- 2684 Arena: Dalaran Sewers
UPDATE `gameobject_template` SET `flags` = '36' WHERE `gameobject_template`.`entry` =192642 LIMIT 1 ;
UPDATE `gameobject_template` SET `flags` = '36' WHERE `gameobject_template`.`entry` =192643 LIMIT 1 ;
UPDATE `battleground_template` SET `MinPlayersPerTeam` = '0', `MaxPlayersPerTeam` = '2' WHERE `battleground_template`.`id` =10 LIMIT 1 ;
DELETE FROM `disables` WHERE `entry` = 10 ;
-- 2687 LFG: Data
DELETE FROM lfg_dungeon_encounters WHERE achievementid IN (1233,1238,1512,1507,1232,1506,1241,1515,4026,4027,1234,1508,1236,1510,4726,4727,4720,4721,4715,4716,1231,1505,1239,1513,1235,1509,1237,1511,1242,1504,1240,1514);
INSERT INTO lfg_dungeon_encounters (achievementid,dungeonId) VALUES 
-- Ahn'kahet: The Old Kingdom
(1233,218),(1507,219),
-- Azjol-Nerub
(1232,204),(1506,241),
-- Culling of Stratholme
(1241,209),(1515,210),
-- Trial of the Champion
(4026,245),(4027,249),
-- Drak'Tharon Keep
(1234,214),(1508,215),
-- Gundrak
(1236,216),(1510,217),
-- Halls of Reflection
(4726,255),(4727,256),
-- Pit of Saron
(4720,253),(4721,254),
-- The Forge of Souls
(4715,251),(4716,252),
-- The Nexus
(1231,225),(1505,226),
-- The Oculus
(1239,206),(1513,211),
-- Violet Hold
(1235,220),(1509,221),
-- Halls of Lightning
(1238,207),(1512,212),
-- Halls of Stone
(1237,208),(1511,213),
-- Utgarde Keep
(1242,202),(1504,242),
-- Utgarde Pinnacle
(1240,203),(1514,205);
-- 2688 Quest: Opening Ahn Quiraj
-- Fix low chance for drop 21149 from NPC 15625
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=15625 AND `item`=21149;    
-- Fix low chance for drop 21149 from NPC 12478,12479,12477     
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-49 WHERE `entry`=12478 AND `item`=21146;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-45 WHERE `entry`=12479 AND `item`=21146;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-44 WHERE `entry`=12477 AND `item`=21146;
-- Remove bad loot item from NPC 14888,12496,5718
DELETE FROM `creature_loot_template` WHERE `entry` IN (14888,12496,5718) AND `item`=21146;
-- Remove bad loot item from NPC 14890
DELETE FROM `creature_loot_template` WHERE `entry`=14890  AND `item`=21149;
-- 2689 NPC: Havenshire Stalion 
-- Fixing vehicleID
UPDATE `creature_template` SET `VehicleId`='123' WHERE (`entry`='28605');
-- 2689 NPC: Acherus Deathcharger
-- Fixing vehicleID
UPDATE `creature_template` SET `VehicleId`='123' WHERE (`entry`='28782');
-- 2689 Quest: Massacre at Light's Hope
-- NPC: Mine Car.
-- Fixing displayID
UPDATE `creature_template` SET `modelid1`='25703', `modelid2`='25703' WHERE (`entry`='28817');
-- 2689 NPC: Scarlet Miner.
-- Fix run speed.
UPDATE `creature_template` SET `speed_run`='1.22' WHERE (`entry`='28841');
-- 2689 NPC: Scarlet Infantryman.
-- Fix factionID
UPDATE `creature_template` SET `faction_A`='35', `faction_H`='35' WHERE (`entry`='28896');
-- 2701 NPC: Warden Moi'bff Jill
UPDATE creature_template SET faction_A=1802, faction_H=1802 WHERE entry=18408;
-- 2706 Quest: An Improper Burial
-- Fixing quest objectives. Now it is 100% working.
UPDATE `quest_template` SET `ReqSpellCast1`='39189', `ReqSpellCast2`='39189' WHERE (`entry`='10913');
-- 2706 NPC: Unliving Initiate
-- Making the NPC unselectable and unattackable
UPDATE `creature_template` SET `unit_flags`='33554434' WHERE (`entry`='21870');
-- 2706 NPC: Slain Auchenai Warrior
-- Making the NPC unattackable
UPDATE `creature_template` SET `unit_flags`='256' WHERE (`entry`='21846');
-- 2743 Priest: Vampiric Touch
DELETE FROM `spell_bonus_data` WHERE `entry` IN ('34914', '64085');
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('34914','0','0.4','0','0','Priest - Vampiric Touch'),
('64085','1.2','0','0','0','Priest - Vampiric Touch');
-- 2808 Death Knight: Unholy Blight
DELETE FROM `spell_bonus_data` WHERE `entry` IN ('50536');
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('50536','0','0','0','0','Death Knight - Unholy Blight');
-- 2948 Mage: Brain Freeze
DELETE FROM `spell_proc_event` WHERE `entry` IN ('44546', '44548', '44549');
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('44546','0','3','544','0','0','0','0','0','0','0'), -- Brain Freeze (Rank 1)
('44548','0','3','544','0','0','0','0','0','0','0'), -- Brain Freeze (Rank 2)
('44549','0','3','544','0','0','0','0','0','0','0'); -- Brain Freeze (Rank 3)
-- 2949 Death Knight: Threat of Thassarian
DELETE FROM `spell_proc_event` WHERE `entry` IN (65661,66191,66192);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(65661,0,15,0x00400011,0x20020004,0x00000000,16,0,0,100,0), -- Threat of Thassarian - Rank1
(66191,0,15,0x00400011,0x20020004,0x00000000,16,0,0,100,0), -- Threat of Thassarian - Rank2
(66192,0,15,0x00400011,0x20020004,0x00000000,16,0,0,100,0); -- Threat of Thassarian - Rank3
-- 2962 Paladin: Divine Storm
DELETE FROM `spell_bonus_data` WHERE `entry` IN ('54172');
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
('54172','0','0','0','0','Paladin - Divine Storm');

DELETE FROM `spell_dbc` WHERE `Id` IN ('199997');
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('199997','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','1','0','-1','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','4','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','10','0','0','0','0','0','0','0','0','0','0','0','Divine Storm Helper (SERVERSIDE)');

DELETE FROM `spell_proc_event` WHERE `entry` IN ('199997');
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('199997','0','10','0','131072','0','16','0','0','100','0');

DELETE FROM `trinity_string` WHERE `entry` IN (1202,1203,1204);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(1202, 'Areatrigger debugging turned on.'),
(1203, 'Areatrigger debugging turned off.'),
(1204, 'You have reached areatrigger %u.');


DELETE FROM `command` WHERE `name` IN ('debug areatriggers');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug areatriggers',1,'Syntax: .debug areatriggers\nToggle debug mode for areatriggers. In debug mode GM will be notified if reaching an areatrigger');