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
(12072, 'win keep text', NULL, 'win keep text', NULL, NULL, NULL, NULL, NULL, NULL),
(12071, 'The western tower', NULL, 'The western tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12070, 'The eastern tower', NULL, 'The eastern tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12069, 'The southern tower', NULL, 'The southern tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12068, '%s has successfully defended the Wintergrasp fortress!', NULL, '%s has successfully defended the Wintergrasp fortress!', NULL, NULL, NULL, NULL, NULL, NULL),
(12067, 'The battle for Wintergrasp begin!', NULL, 'The battle for Wintergrasp begin!', NULL, NULL, NULL, NULL, NULL, NULL),
(12066, '%s has been destroyed!', NULL, '%s has been destroyed!', NULL, NULL, NULL, NULL, NULL, NULL),
(12065, '%s has been damaged !', NULL, '%s has been damaged !', NULL, NULL, NULL, NULL, NULL, NULL),
(12064, 'The north-western keep tower', NULL, 'The north-western keep tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12063, 'The south-western keep tower', NULL, 'The south-western keep tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12062, 'The north-eastern keep tower', NULL, 'The north-eastern keep tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12061, 'The south-eastern keep tower', NULL, 'The south-eastern keep tower', NULL, NULL, NULL, NULL, NULL, NULL),
(12060, 'You have reached Rank 2: First Lieutenant', NULL, 'You have reached Rank 2: First Lieutenant', NULL, NULL, NULL, NULL, NULL, NULL),
(12059, 'You have reached Rank 1: Corporal', NULL, 'You have reached Rank 1: Corporal', NULL, NULL, NULL, NULL, NULL, NULL),
(12058, 'The battle for Wintergrasp is going to begin!', NULL, 'The battle for Wintergrasp is going to begin!', NULL, NULL, NULL, NULL, NULL, NULL),
(12057, 'Alliance', NULL, 'Alliance', NULL, NULL, NULL, NULL, NULL, NULL),
(12056, 'Horde', NULL, 'Horde', NULL, NULL, NULL, NULL, NULL, NULL),
(12055, 'The Sunken Ring siege workshop', NULL, 'The Sunken Ring siege workshop', NULL, NULL, NULL, NULL, NULL, NULL),
(12054, 'Westspark siege workshop', NULL, 'Westspark siege workshop', NULL, NULL, NULL, NULL, NULL, NULL),
(12053, 'Eastspark siege workshop', NULL, 'Eastspark siege workshop', NULL, NULL, NULL, NULL, NULL, NULL),
(12052, 'The Broken Temple siege workshop', NULL, 'The Broken Temple siege workshop', NULL, NULL, NULL, NULL, NULL, NULL),
(12051, '%s is under attack by %s', NULL, '%s is under attack by %s', NULL, NULL, NULL, NULL, NULL, NULL),
(12050, '%s has been captured by %s ', NULL, '%s has been captured by %s', NULL, NULL, NULL, NULL, NULL, NULL);

REPLACE INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`)VALUES
(0, -1850500, 'Guide me to the Fortress Graveyard.', NULL, 'Guide me to the Fortress Graveyard.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850501, 'Guide me to the Sunken Ring Graveyard.', NULL, 'Guide me to the Sunken Ring Graveyard.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850502, 'Guide me to the Broken Temple Graveyard.', NULL, 'Guide me to the Broken Temple Graveyard.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850503, 'Guide me to the Westspark Graveyard.', NULL, 'Guide me to the Westspark Graveyard.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850504, 'Guide me to the Eastspark Graveyard.', NULL, 'Guide me to the Eastspark Graveyard.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850505, 'Guide me back to the Horde landing camp.', NULL, 'Guide me back to the Horde landing camp.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850506, 'Guide me back to the Alliance landing camp.', NULL, 'Guide me back to the Alliance landing camp.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, ''),
(0, -1850507, 'Get in the queue for Wintergrasp.', NULL, 'Get in the queue for Wintergrasp.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '');

UPDATE `creature_template` SET `ScriptName` = 'npc_wg_dalaran_queue' WHERE `entry` IN (32169,32170);
REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (54640, 54643, 0, 'WG teleporter');

DELETE FROM `gameobject` where `id` in (190475,190487,194959,194962,192829,190219,190220,191795,191796,191799,191800,191801,191802,191803,191804,191806,191807,191808,191809,190369,190370,190371,190372,190374,190376,190221,190373,190377,190378,191797,191798,191805,190356,190357,190358,190375,191810,	192488,192501,192374,192416,192375,192336,192255,192269,192254,192349,192366,192367,192364,192370,192369,192368,192362,192363,192379,192378,192355,192354,192358,192359,192284,192285,192371,192372,192373,192360,192361,192356,192352,192353,192357,192350,192351,190763,192501,192488,192269,192278) AND `map`=571;
DELETE FROM `creature` where `id` in (30739,30740,31102,31841,31151,31153,32296,31051,31106,31108,31109,31053,30489,39172,31107,32294,31101,30499,31842,31036,31091,39173,31052,30400) AND `map`=571;
UPDATE `creature_template` SET `InhabitType` = '7' WHERE `creature_template`.`entry` =27852 LIMIT 1;

UPDATE `creature_template` SET `ScriptName` = 'npc_wg_spiritguide' WHERE `entry` IN (31841,31842);
UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400,30499);

UPDATE `trinity_string` SET `content_default` = 'The Wintergrasp fortress has been captured by %s !', `content_loc2` = '%s a captur� la forteresse du Joug d''hiver !' WHERE `entry` =12072 LIMIT 1;
DELETE FROM `gameobject` where `id` in (192273, 192274, 192277, 192280, 192283, 192289, 192290, 192338, 192339, 192406, 192407, 192414, 192417, 192418, 192429, 192433, 192434, 192435, 192458, 192459, 192460, 192461) AND `map`=571;
DELETE FROM `creature` where `id`= 30400 AND `map`=571;
DELETE FROM `gameobject` where `id` = 192819  AND `map`=571;