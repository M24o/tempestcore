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