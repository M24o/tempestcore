-- 9421
DELETE FROM `command` WHERE `name` IN ('namego','goname','groupgo','summon','appear','groupsummon');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('appear',1,'Syntax: .appear [$charactername]\r\n\r\nTeleport to the given character. Either specify the character name or click on the character''s portrait, e.g. when you are in a group. Character can be offline.'),
('groupsummon',1,'Syntax: .groupsummon [$charactername]\r\n\r\nTeleport the given character and his group to you. Teleported only online characters but original selected group member can be offline.'),
('summon',1,'Syntax: .summon [$charactername]\r\n\r\nTeleport the given character to you. Character can be offline.');

-- 9427
DELETE FROM `command` WHERE `name` IN ('reload gossip_menu','reload gossip_menu_option','reload gossip_scripts');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('reload gossip_menu',3, 'Syntax: .reload gossip_menu\nReload gossip_menu table.'),
('reload gossip_menu_option',3, 'Syntax: .reload gossip_menu_option\nReload gossip_menu_option table.'),
('reload gossip_scripts',3, 'Syntax: .reload gossip_scripts\nReload gossip_scripts table.');

-- 9436
-- QUEST SPELLS
-- 45449 Arcane Prisoner Rescue
DELETE FROM `spell_script_names` WHERE `spell_id`=45449 AND `ScriptName`='spell_q11587_arcane_prisoner_rescue';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (45449,'spell_q11587_arcane_prisoner_rescue');

-- 46023 The Ultrasonic Screwdriver
DELETE FROM `spell_script_names` WHERE `spell_id`=46023 AND `ScriptName`='spell_q11730_ultrasonic_screwdriver';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (46023,'spell_q11730_ultrasonic_screwdriver');

-- SHAMAN SPELLS
-- 1535 Fire Nova (and ranks)
DELETE FROM `spell_script_names` WHERE `spell_id`=-1535 AND `ScriptName`='spell_sha_fire_nova';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-1535,'spell_sha_fire_nova');

-- 39610 Mana Tide Totem
DELETE FROM `spell_script_names` WHERE `spell_id`=39610 AND `ScriptName`='spell_sha_mana_tide_totem';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (39610,'spell_sha_mana_tide_totem');

-- DEATH KNIGHT SPELLS
-- 49158 Corpse Explosion (and ranks)
DELETE FROM `spell_script_names` WHERE `spell_id`=-49158 AND `ScriptName`='spell_dk_corpse_explosion';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-49158,'spell_dk_corpse_explosion');

-- 50524 Runic Power Feed
DELETE FROM `spell_script_names` WHERE `spell_id`=50524 AND `ScriptName`='spell_dk_runic_power_feed';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (50524,'spell_dk_runic_power_feed');

-- 55090 Scourge Strike (and ranks)
DELETE FROM `spell_script_names` WHERE `spell_id`=-55090 AND `ScriptName`='spell_dk_scourge_strike';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-55090,'spell_dk_scourge_strike');

-- DRUID SPELLS
-- 54846 Glyph of Starfire
DELETE FROM `spell_script_names` WHERE `spell_id`=54846 AND `ScriptName`='spell_dru_glyph_of_starfire';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (54846,'spell_dru_glyph_of_starfire');

-- WARLOCK SPELLS
-- 6201 Create Healthstone (and ranks)
DELETE FROM `spell_script_names` WHERE `spell_id`=-6201 AND `ScriptName`='spell_warl_create_healthstone';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-6201,'spell_warl_create_healthstone');

-- 47193 Demonic Empowerment
DELETE FROM `spell_script_names` WHERE `spell_id`=47193 AND `ScriptName`='spell_warl_demonic_empowerment';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (47193,'spell_warl_demonic_empowerment');

-- 47422 Everlasting Affliction
DELETE FROM `spell_script_names` WHERE `spell_id`=47422 AND `ScriptName`='spell_warl_everlasting_affliction';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (47422,'spell_warl_everlasting_affliction');

-- 63521 Guarded by The Light
DELETE FROM `spell_script_names` WHERE `spell_id`=63521 AND `ScriptName`='spell_warl_guarded_by_the_light';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (63521,'spell_warl_guarded_by_the_light');

-- HUNTER SPELLS
-- 53209 Chimera Shot
DELETE FROM `spell_script_names` WHERE `spell_id`=53209 AND `ScriptName`='spell_hun_chimera_shot';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (53209,'spell_hun_chimera_shot');

-- 53412 Invigoration
DELETE FROM `spell_script_names` WHERE `spell_id`=53412 AND `ScriptName`='spell_hun_invigoration';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (53412,'spell_hun_invigoration');

-- 37506 Scatter Shot
DELETE FROM `spell_script_names` WHERE `spell_id`=37506 AND `ScriptName`='spell_hun_scatter_shot';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (37506,'spell_hun_scatter_shot');

-- 9447
DELETE FROM `spell_script_names` WHERE `spell_id`=63521 AND `ScriptName`='spell_warl_guarded_by_the_light';
DELETE FROM `spell_script_names` WHERE `spell_id`=63521 AND `ScriptName`='spell_pal_guarded_by_the_light';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (63521, 'spell_pal_guarded_by_the_light');

-- 9453
-- Lord Marrowgar
UPDATE `creature_template` SET `ScriptName`='boss_lord_marrowgar' WHERE `entry`=36612;
UPDATE `creature_template` SET `ScriptName`='npc_coldflame' WHERE `entry`=36672;
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE `entry`=38711;
-- Instance
UPDATE `instance_template` SET `script`='instance_icecrown_citadel' WHERE `map`=631;
-- Scripts
DELETE FROM `spell_script_names` WHERE `spell_id`=69057 AND `ScriptName`='spell_marrowgar_bone_spike_graveyard';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (69140,72705) AND `ScriptName`='spell_marrowgar_coldflame';
DELETE FROM `spell_script_names` WHERE `spell_id`=69147 AND `ScriptName`='spell_marrowgar_coldflame_trigger';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (69075,70834,70835,70836) AND `ScriptName`='spell_marrowgar_bone_storm';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69057,'spell_marrowgar_bone_spike_graveyard'),
(69140,'spell_marrowgar_coldflame'),
(72705,'spell_marrowgar_coldflame'),
(69147,'spell_marrowgar_coldflame_trigger'),
(69075,'spell_marrowgar_bone_storm'),
(70834,'spell_marrowgar_bone_storm'),
(70835,'spell_marrowgar_bone_storm'),
(70836,'spell_marrowgar_bone_storm');
-- Texts
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631999 AND -1631000;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36612,-1631000,'This is the beginning AND the end, mortals. None may enter the master''s sanctum!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16950,1,0,0,'SAY_ENTER_ZONE'),
(36612,-1631001,'The Scourge will wash over this world as a swarm of death and destruction!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16941,1,0,0,'SAY_AGGRO'),
(36612,-1631002,'BONE STORM!',NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,16946,1,0,0,'SAY_BONE_STORM'),
(36612,-1631003,'Bound by bone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16947,1,0,0, 'SAY_BONESPIKE_1'),
(36612,-1631004,'Stick Around!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16948,1,0,0,'SAY_BONESPIKE_2'),
(36612,-1631005,'The only escape is death!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16949,1,0,0,'SAY_BONESPIKE_3'),
(36612,-1631006,'More bones for the offering!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16942,1,0,0,'SAY_KILL_1'),
(36612,-1631007,'Languish in damnation!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16943,1,0,0,'SAY_KILL_2'),
(36612,-1631008,'I see... only darkness...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16944,1,0,0,'SAY_DEATH'),
(36612,-1631009,'THE MASTER''S RAGE COURSES THROUGH ME!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16945,1,0,0,'SAY_BERSERK');

-- 9472
DELETE FROM `script_texts` WHERE `entry`=-1631010;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36612,-1631010,'Lord Marrowgar creates a whirling storm of bone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0,'SAY_BONE_STORM_EMOTE');

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_bone_spike';
UPDATE `creature_template` SET `ScriptName`='npc_bone_spike' WHERE `entry`=36619;

-- 9508
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631028 AND -1631011;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(36855,-1631011, 'You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17272,1,0,0, 'SAY_INTRO_1'),
(36855,-1631012, 'You can see through the fog that hangs over this world like a shroud, and grasp where true power lies.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17273,1,0,0, 'SAY_INTRO_2'),
(36855,-1631013, 'Fix your eyes upon your crude hands: the sinew, the soft meat, the dark blood coursing within.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16878,1,0,0, 'SAY_INTRO_3'),
(36855,-1631014, 'It is a weakness; a crippling flaw.... A joke played by the Creators upon their own creations.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17268,1,0,0, 'SAY_INTRO_4'),
(36855,-1631015, 'The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17269,1,0,0, 'SAY_INTRO_5'),
(36855,-1631016, 'Through our Master, all things are possible. His power is without limit, and his will unbending.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17270,1,0,0, 'SAY_INTRO_6'),
(36855,-1631017, 'Those who oppose him will be destroyed utterly, and those who serve -- who serve wholly, unquestioningly, with utter devotion of mind and soul -- elevated to heights beyond your ken.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,17271,1,0,0, 'SAY_INTRO_7'),
(36855,-1631018, 'What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16868,1,0,0, 'SAY_AGGRO'),
(36855,-1631019, 'Enough! I see I must take matters into my own hands!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16877,1,0,0, 'SAY_PHASE_2'),
(36855,-1631020, 'Lady Deathwhisper''s Mana Barrier shimmers and fades away!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,3,0,0, 'SAY_PHASE_2_EMOTE'),
(36855,-1631021, 'You are weak, powerless to resist my will!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16876,1,0,0, 'SAY_DOMINATE_MIND'),
(36855,-1631022, 'Take this blessing and show these intruders a taste of our master''s power.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16873,1,0,0, 'SAY_DARK_EMPOWERMENT'),
(36855,-1631023, 'I release you from the curse of flesh!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16874,1,0,0, 'SAY_DARK_TRANSFORMATION'),
(36855,-1631024, 'Arise and exult in your pure form!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16875,1,0,0, 'SAY_ANIMATE_DEAD'),
(36855,-1631025, 'Do you yet grasp of the futility of your actions?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16869,1,0,0, 'SAY_KILL_1'),
(36855,-1631026, 'Embrace the darkness... Darkness eternal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16870,1,0,0, 'SAY_KILL_2'),
(36855,-1631027, 'This charade has gone on long enough.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16872,1,0,0, 'SAY_BERSERK'),
(36855,-1631028, 'All part of the masters plan! Your end is... inevitable!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16871,1,0,0, 'SAY_DEATH');

UPDATE `creature_template` SET `ScriptName`='boss_lady_deathwhisper' WHERE `entry`=36855;
UPDATE `creature_template` SET `ScriptName`='npc_cult_fanatic' WHERE `entry` IN (37890,38009,38135);
UPDATE `creature_template` SET `ScriptName`='npc_cult_adherent' WHERE `entry` IN(37949,38010,38136);
UPDATE `creature_template` SET `ScriptName`='npc_vengeful_shade' WHERE `entry`=38222;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (70903,71236) AND `ScriptName`='spell_cultist_dark_martyrdom';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70903,'spell_cultist_dark_martyrdom'),
(71236,'spell_cultist_dark_martyrdom');

-- 9521
-- spell_linked_spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (66870,67621,67622,67623,-66683,-67661);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(66870,-66823,1, 'Remove Paralytic Toxin when hit by Burning Bite'),
(67621,-67618,1, 'Remove Paralytic Toxin when hit by Burning Bite'),
(67622,-67619,1, 'Remove Paralytic Toxin when hit by Burning Bite'),
(67623,-67620,1, 'Remove Paralytic Toxin when hit by Burning Bite'),
(-66683,68667,0, 'Icehowl - Surge of Adrenaline'),
(-67661,68667,0, 'Icehowl - Surge of Adrenaline');

-- 9529
DELETE FROM `spell_script_names` WHERE `spell_id`=6962 AND `ScriptName`='spell_gen_pet_summoned';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (6962, 'spell_gen_pet_summoned');

-- 9537
DELETE FROM `spell_proc_event` WHERE `entry` IN (70748);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(70748,0x00,3,0x00000000,0x00200000,0x00000000,0x00000400,0x00000000,0,0,0); -- Item - Mage T10 4P Bonus

-- 9544
DELETE FROM `spell_script_names` WHERE `spell_id` = 66244 AND `ScriptName` = "spell_ex_66244";
DELETE FROM `spell_script_names` WHERE `spell_id` = 5581 AND `ScriptName` = "spell_ex_5581";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (66244, "spell_ex_66244"), (5581, "spell_ex_5581");

-- 9551
-- Item - Shaman T10 Enhancement 2P Bonus
DELETE FROM `spell_proc_event` WHERE `entry` = 70830;
INSERT INTO `spell_proc_event` VALUES (70830, 0x00, 11, 0x00000000, 0x00020000, 0x00000000, 0x00000000, 0x00000000, 0, 0, 0);
REPLACE INTO `spell_bonus_data` VALUES (70809, 0, 0, 0, 0, 'Item - Shaman T10 Restoration 4P Bonus');

-- 9554
DELETE FROM `spell_proc_event` WHERE `entry` IN (70727,70730,70803,70805,70841);
INSERT INTO `spell_proc_event` VALUES 
( 70727, 0x00,   9, 0x00000000, 0x00000000, 0x00000000, 0x00000040, 0x00000000,   0,   0,   0), -- Item - Hunter T10 2P Bonus
( 70730, 0x00,   9, 0x00004000, 0x00001000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Hunter T10 4P Bonus
( 70803, 0x00,   8, 0x003E0000, 0x00000008, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Rogue T10 4P Bonus
( 70805, 0x00,   8, 0x00000000, 0x00020000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   0), -- Item - Rogue T10 2P Bonus
( 70841, 0x00,   5, 0x00000004, 0x00000100, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0); -- Item - Warlock T10 4P Bonus

-- 9555
-- Idols
-- Librams
-- Totems
-- Sigils
DELETE FROM `spell_proc_event` WHERE `entry` IN (71214, 71217, 67389, 67386, 67392, 71178, 67361, 71176, 71191, 71194, 71186, 67379, 67365, 67363, 64955, 71228, 71226, 67381, 67384);
INSERT INTO `spell_proc_event` VALUES 
( 64955, 0x00,  10, 0x00000000, 0x00000040, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T8 Protection Relic
( 67361, 0x00,   7, 0x00000002, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T9 Balance Relic (Moonfire)
( 67363, 0x00,  10, 0x00000000, 0x80000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Item - Paladin T9 Holy Relic (Judgement)
( 67365, 0x00,  10, 0x00000000, 0x00000800, 0x00000000, 0x00040000, 0x00000000,   0,   0,   6), -- Item - Paladin T9 Retribution Relic (Seal of Vengeance)
( 67379, 0x00,  10, 0x00000000, 0x00040000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T9 Protection Relic (Hammer of The Righteous)
( 67381, 0x00,  15, 0x00000000, 0x20000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,  10), -- Item - Death Knight T9 Tank Relic (Rune Strike)
( 67384, 0x00,  15, 0x00000010, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,  80,  10), -- Item - Death Knight T9 Melee Relic (Rune Strike)
( 67386, 0x00,  11, 0x00000001, 0x00000000, 0x00000000, 0x00010000, 0x00000000,   0,   0,   6), -- Item - Shaman T9 Elemental Relic (Lightning Bolt)
( 67389, 0x00,  11, 0x00000100, 0x00000000, 0x00000000, 0x00004000, 0x00000000,   0,   0,   8), -- Item - Shaman T9 Restoration Relic (Chain Heal)
( 67392, 0x00,  11, 0x00000000, 0x00000000, 0x00000004, 0x00000010, 0x00000000,   0,   0,   0), -- Item - Shaman T9 Enhancement Relic (Lava Lash)
( 71176, 0x00,   7, 0x00200002, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T10 Balance Relic (Moonfire and Insect Swarm)
( 71178, 0x00,   7, 0x00000010, 0x00000000, 0x00000000, 0x00040000, 0x00000000,   0,   0,   0), -- Item - Druid T10 Restoration Relic (Rejuvenation)
( 71186, 0x00,  10, 0x00000000, 0x00008000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Retribution Relic (Crusader Strike)
( 71191, 0x00,  10, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Holy Relic (Holy Shock)
( 71194, 0x00,  10, 0x00000000, 0x00100000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Paladin T10 Protection Relic (Shield of Righteousness)
( 71214, 0x00,  11, 0x00001400, 0x00000010, 0x00000000, 0x00000010, 0x00000000,   0,   0,   6), -- Item - Shaman T10 Enhancement Relic (Stormstrike)
( 71217, 0x00,  11, 0x00000000, 0x00000000, 0x00000010, 0x00004000, 0x00000000,   0,   0,   0), -- Item - Shaman T10 Restoration Relic (Riptide)
( 71226, 0x00,  15, 0x00000010, 0x08020000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0), -- Item - Death Knight T10 DPS Relic (Obliterate, Scourge Strike, Death Strike)
( 71228, 0x00,  15, 0x00000000, 0x20000000, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0); -- Item - Death Knight T10 Tank Relic (Runestrike)

-- 9556
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=58875 AND `spell_effect`=58876 AND `type`=0;
INSERT INTO `spell_linked_spell` VALUES (58875, 58876, 0, 'Spirit Walk');

-- 9560
DELETE FROM `spell_proc_event` WHERE `entry`=70854;
INSERT INTO `spell_proc_event` VALUES 
( 70854, 0x00,   4, 0x00000000, 0x00000010, 0x00000000, 0x00000000, 0x00000000,   0,   0,   0); -- 	Item - Warrior T10 Melee 2P Bonus

-- 9570
DELETE FROM `spell_group_stack_rules` WHERE `group_id` IN (1108, 1109, 1110);
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1108, 1), -- Mark/Gift of the Wild
(1109, 1), -- Power Word/Prayer of Fortitude
(1110, 1); -- Prayer of/Shadow protection

-- 9570
DELETE FROM `spell_group` WHERE `id` IN (1108, 1109, 1110);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1108, 1126), -- Mark of the Wild
(1108, 21849), -- Gift of the Wild
(1109, 1243), -- Power Word: Fortitude
(1109, 21562), -- Prayer of Fortitude
(1110, 976), -- Shadow Protection
(1110, 27683); -- Prayer of Shadow Protection

-- 9577
DELETE FROM `spell_group` WHERE `spell_id` IN (72586, 72588, 72590);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1006, 72586), -- Blessing of Forgotten Kings (Drums)
(1108, 72588), -- Gift of the Wild (Drums)
(1109, 72590); -- Fortitude (Scroll)

-- 9578
DROP TABLE IF EXISTS `vehicle_scaling_info`;
CREATE TABLE `vehicle_scaling_info` (
  `entry` mediumint(8) unsigned NOT NULL default '0',
  `baseItemLevel` float NOT NULL default '0',
  `scalingFactor` float NOT NULL default '0',
  PRIMARY KEY  (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- vehicle scaling data for Ulduar vehicles
DELETE FROM `vehicle_scaling_info` WHERE `entry` IN (336, 335, 338);
INSERT INTO `vehicle_scaling_info` (`entry`,`baseItemLevel`,`scalingFactor`) VALUES 
(336,170.0,0.01),
(335,170.0,0.01),
(338,170.0,0.01);

