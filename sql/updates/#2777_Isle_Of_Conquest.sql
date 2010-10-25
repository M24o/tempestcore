-- -------------------------------------------------------------------------
-- --------------------------- Isle Of Conquest ----------------------------
-- -------------------------------------------------------------------------
UPDATE gameobject_template SET size=2.151325 WHERE entry=195451;
UPDATE gameobject_template SET size=2.151325 WHERE entry=195452;
UPDATE gameobject_template SET size=3.163336 WHERE entry=195223;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36154;
UPDATE creature_template SET speed_run=1.142857 WHERE entry=36169;

-- Alliance Gunship Cannon
-- http://fr.wowhead.com/npc=34929
UPDATE `creature_template` SET `spell1`=69495,`VehicleId`='452' WHERE `entry` =34929;

-- Horde Gunship Cannon
-- http://fr.wowhead.com/npc=34935
UPDATE `creature_template` SET `spell1`=68825,`VehicleId`='453' WHERE `entry` =34935;

-- Keep Cannon
-- http://fr.wowhead.com/npc=34944
UPDATE `creature_template` SET `VehicleId`=160,`spell1`=67452,`spell2`='68169' WHERE `entry` =34944;

-- Catapult
-- http://fr.wowhead.com/npc=34793
UPDATE `creature_template` SET `VehicleId`=438,`spell1`=66218,`spell2`=66296 WHERE `entry`=34793;

-- Demolisher
-- http://fr.wowhead.com/npc=34775
UPDATE `creature_template` SET `VehicleId`='509',`spell1`='67442',`spell2`='68068' WHERE `entry` =34775;

-- Siege Engine
-- http://fr.wowhead.com/npc=34776
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=67816,`spell2`=69502 WHERE `entry`=34776;

-- Siege Engine
-- http://fr.wowhead.com/npc=35069
UPDATE `creature_template` SET `VehicleId`=436,`spell1`=67816,`spell2`=69502 WHERE `entry`=35069;

-- Glaive Thrower
-- http://fr.wowhead.com/npc=34802
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=34802;

-- Glaive Thrower
-- http://fr.wowhead.com/npc=35273
UPDATE `creature_template` SET `VehicleId`=447,`spell1`=68827,`spell2`=69515 WHERE `entry`=35273;

-- Fire Turret
-- http://fr.wowhead.com/npc=34778

UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =34778;
-- Fire Turret
-- http://fr.wowhead.com/npc=36356
UPDATE `creature_template` SET `spell1`='68832' WHERE `entry` =36356;

-- Siege Turret
-- http://fr.wowhead.com/npc=34777
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=34777;

-- Siege Turret
-- http://fr.wowhead.com/npc=36355
UPDATE `creature_template` SET `spell1`=67462,`spell2`=69505 WHERE `entry`=36355;

-- Catapult speed
UPDATE creature_template SET `speed_run`=2.428571,`speed_walk`=2.8 WHERE `entry`=34793;

-- Overlord Agmar & script
UPDATE creature_template SET `ScriptName`='boss_isle_of_conquest' WHERE `entry` IN (34924,34922);
	
REPLACE INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(12039, 'Alliance dungeon', NULL, 'Alliance dungeon', NULL, NULL, NULL, NULL, NULL, NULL),
(12038, 'Horde dungeon', NULL, 'Horde dungeon', NULL, NULL, NULL, NULL, NULL, NULL),
(12037, 'The Alliance taken the Horde dungeon !', NULL, 'The Alliance taken the Horde dungeon !', NULL, NULL, NULL, NULL, NULL, NULL),
(12036, 'The Horde taken the Alliance dungeon !', NULL, 'The Horde taken the Alliance dungeon !', NULL, NULL, NULL, NULL, NULL, NULL),
(12035, '%s win !', NULL, '%s win !', NULL, NULL, NULL, NULL, NULL, NULL),
(12034, '%s attack the Horde dungeon !', NULL, '%s attack the Horde dungeon !', NULL, NULL, NULL, NULL, NULL, NULL),
(12033, '%s attack the Alliance dungeon !', NULL, '%s attack the Alliance dungeon !', NULL, NULL, NULL, NULL, NULL, NULL),
(12032, 'The west door of the dungeon of the Horde was destroyed', NULL, 'The west door of the dungeon of the Horde was destroyed', NULL, NULL, NULL, NULL, NULL, NULL),
(12031, 'The east door of the dungeon of the Horde was destroyed', NULL, 'The east door of the dungeon of the Horde was destroyed', NULL, NULL, NULL, NULL, NULL, NULL),
(12030, 'The south gate of the keep is destroyed by the Horde!', NULL, 'The south gate of the keep is destroyed by the Horde!', NULL, NULL, NULL, NULL, NULL, NULL),
(12029, 'The west door of the dungeon of the Alliance was destroyed', NULL, 'The west door of the dungeon of the Alliance was destroyed', NULL, NULL, NULL, NULL, NULL, NULL),
(12028, 'The east door of the dungeon of the Alliance was destroyed', NULL, 'The east door of the dungeon of the Alliance was destroyed', NULL, NULL, NULL, NULL, NULL, NULL),
(12027, 'The north gate of door of the dungeon of the Alliance was destroyed', NULL, 'The north gate of door of the dungeon of the Alliance was destroyed', NULL, NULL, NULL, NULL, NULL, NULL),
(12026, 'The battle will begin in 15 seconds!', NULL, 'The battle will begin in 15 seconds!', NULL, NULL, NULL, NULL, NULL, NULL),
(12025, '$n has assaulted the %s', NULL, '$n has assaulted the %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12024, '$n has defended the %s', NULL, '$n has defended the %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12023, '$n claims the %s! If left unchallenged, the %s will control it in 1 minute!', NULL, '$n claims the %s! If left unchallenged, the %s will control it in 1 minute!', NULL, NULL, NULL, NULL, NULL, NULL),
(12022, 'Alliance', NULL, 'Alliance', NULL, NULL, NULL, NULL, NULL, NULL),
(12021, 'Horde', NULL, 'Horde', NULL, NULL, NULL, NULL, NULL, NULL),
(12020, 'The %s has taken the %s', NULL, 'The %s has taken the %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12019, 'Workshop', NULL, 'Workshop', NULL, NULL, NULL, NULL, NULL, NULL),
(12018, 'Docks', NULL, 'Docks', NULL, NULL, NULL, NULL, NULL, NULL),
(12017, 'Refinery', NULL, 'Refinery', NULL, NULL, NULL, NULL, NULL, NULL),
(12016, 'Quarry', NULL, 'Quarry', NULL, NULL, NULL, NULL, NULL, NULL),
(12015, 'Hangar', NULL, 'Hangar', NULL, NULL, NULL, NULL, NULL, NULL),
(12014, 'The battle has begun!', NULL, 'The battle has begun!', NULL, NULL, NULL, NULL, NULL, NULL),
(12013, 'The battle will begin in 30 seconds!', NULL, 'The battle will begin in 30 seconds!', NULL, NULL, NULL, NULL, NULL, NULL),
(12012, 'The battle will begin in one minute!', NULL, 'The battle will begin in one minute!', NULL, NULL, NULL, NULL, NULL, NULL),
(12011, 'The battle will begin in two minutes!', NULL, 'The battle will begin in two minutes!', NULL, NULL, NULL, NULL, NULL, NULL);

REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(66548, 66550, 0, 'Isle of Conquest (OUT>IN)'),
(66549, 66550, 0, 'Isle of Conquest (IN>OUT)'),
(66550, -66549, 2, 'Isle of Conquest Teleport (OUT>IN) Debuff limit'),
(66550, -66548, 2, 'Isle of Conquest Teleport (IN>OUT) Debuff limit');