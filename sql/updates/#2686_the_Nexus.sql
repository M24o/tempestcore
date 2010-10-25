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
(26094, 40752, 	100,1,0, 		2,	2), -- Emblem of Heroism x2
(26094, 1, 		100,1,0, -50008, 	2), -- 2 items ilevel 213
(26094, 44650, 	100,1,0, 		1,	1), -- Quest item, Judgement at the Eye of Eternity
(26094, 43953, 	1, 	1,0, 		1,	1), -- Reins of the Blue Drake 	
-- End of 10m Malygos loot

(26097, 40753, 100, 1, 0, 2, 		2), -- Emblem of Valor x2
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
DELETE FROM creature_template WHERE entry = 50000;
INSERT INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, 
modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction_A, faction_H, npcflag, speed_walk, speed_run, scale, 
rank, mindmg, maxdmg, dmgschool, attackpower, dmg_multiplier, baseattacktime, rangeattacktime, unit_class, unit_flags, dynamicflags, family, 
trainer_type, trainer_spell, trainer_class, trainer_race, minrangedmg, maxrangedmg, rangedattackpower, type, type_flags, lootid, pickpocketloot, 
skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, 
spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, Health_mod, Mana_mod, Armor_mod, RacialLeader, questItem1, 
questItem2, questItem3, questItem4, questItem5, questItem6, movementId, RegenHealth, equipment_id, mechanic_immune_mask, flags_extra, ScriptName, WDBVerified) VALUES 
(50000, 0, 0, 0, 0, 0, 26752, 0, 0, 0, 'Malygos', '', '', 0, 83, 83, 2, 16, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 64, 8, 0, 0, 0, 0, 0, 365, 529, 98, 2, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 500, 50, 1, 0, 44650, 0, 0, 0, 0, 0, 227, 1, 0, 0, 1, 'boss_malygos', 1);

UPDATE creature_template SET Health_mod = 1400, questItem1 = 44651, mechanic_immune_mask = 617299803, ScriptName = '', WDBVerified = 1 WHERE entry = 50000;
UPDATE creature_template SET mindmg = 4602, maxdmg = 5502, dmg_multiplier = 7.5, difficulty_entry_1 = 50000, mechanic_immune_mask = 617299803 WHERE entry = 28859;
UPDATE creature_template SET mindmg = 4602, maxdmg = 5502, dmg_multiplier = 13 WHERE entry = 50000;
UPDATE creature_template SET flags_extra = flags_extra | 1 WHERE entry IN (28859, 50000);

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

-- Fix Surge of Power targeting
DELETE FROM `conditions` WHERE `SourceEntry`=56505;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,56505,18,1,22517);

-- Fix loot for Malygos (Alexstrasza's Gift)
-- End of 25m Malygos loot
-- Fix Malygos and his adds' damage
UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 7.5, mechanic_immune_mask = 1072918979 WHERE entry = 30245; -- Nexus Lord
UPDATE creature_template SET mindmg = 3684, maxdmg = 4329, dmg_multiplier = 13,  mechanic_immune_mask = 1072918979 WHERE entry = 31750; -- Nexus Lord (1)
UPDATE creature_template SET mechanic_immune_mask = 1072918979 WHERE entry IN (30249, 31751);
UPDATE creature_template SET faction_A = 14, faction_H = 14 WHERE entry IN (31750, 31751);

-- Create entry for Heroic Malygos
UPDATE creature_template SET flags_extra = flags_extra | 1 WHERE entry IN (28859);-- Añadir 50000

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
## Set Emblem of Heroism Badges
SET @lootid_anomalus     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26763));
SET @lootid_telestra     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26731));
SET @lootid_keristrasza  = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26723));
SET @lootid_ormorok      = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26794));

UPDATE creature_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (@lootid_anomalus,@lootid_telestra,@lootid_keristrasza,@lootid_ormorok);
UPDATE reference_loot_template SET item = 40752 WHERE item = 47241 AND entry = 35034;

## Set Damage for Commander Kolurg to Commander Stoutbeards Values
SET @mindmg = (SELECT mindmg      FROM creature_template WHERE entry = 26796);
SET @maxdmg = (SELECT maxdmg      FROM creature_template WHERE entry = 26796);
SET @attack = (SELECT attackpower FROM creature_template WHERE entry = 26796);
UPDATE creature_template SET mindmg = @mindmg, maxdmg = @maxdmg, attackpower = @attack WHERE entry = 26798;

SET @mindmg = (SELECT mindmg      FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26796));
SET @maxdmg = (SELECT maxdmg      FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26796));
SET @attack = (SELECT attackpower FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26796));
SET @kolurg_diff1 = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 26798);
UPDATE creature_template SET mindmg = @mindmg, maxdmg = @maxdmg, attackpower = @attack WHERE entry = @kolurg_diff1;

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

## Change Position of Trashmobs near Ormorok
UPDATE creature SET position_x = '323.541779', position_y = '-240.492249', position_z = '-14.088820', orientation = '2.964224' WHERE guid = '126444';
UPDATE creature SET position_x = '323.179108', position_y = '-242.347137', position_z = '-14.088820', orientation = '2.948516' WHERE guid = '126606';
UPDATE creature SET position_x = '324.616272', position_y = '-234.996307', position_z = '-14.088820', orientation = '3.152720' WHERE guid = '126605';
UPDATE creature SET position_x = '317.004852', position_y = '-237.360901', position_z = '-14.088820', orientation = '3.231260' WHERE guid = '126445';

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