-- -------------------------------------------------------------------------
-- -------------------------- Myth Custom Fixes ----------------------------
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