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
UPDATE `gameobject_loot_template` SET `item` = 40752 WHERE `entry` = 26260 AND `item` = 47241;
UPDATE `creature_loot_template` SET `item` = 40752 WHERE `entry` IN (31384,31381,31386) AND `item` = 47241;
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
## Set Emblem of Heroism Badges
SET @lootid_bjarngrim = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28586));
SET @lootid_volkhan   = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28587));
SET @lootid_ionar     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28546));
SET @lootid_loken     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28923));

UPDATE creature_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (@lootid_bjarngrim,@lootid_volkhan,@lootid_ionar,@lootid_loken);

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

## Correct Faction fur Heroic Sparks and Molten Golems
SET @28695_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28695);
CALL sp_set_npc_faction(@28695_h,16,16);
SET @28926_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28926);
CALL sp_set_npc_faction(@28926_h,14,14);

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