-- 9587
DELETE FROM `spell_bonus_data` WHERE `entry` IN (54158, 20187, 31804);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(54158, 0.25, 0, 0.16, 0, 'Paladin - Judgement (Seal of Light, Seal of Wisdom, Seal of Justice)'),
(20187, 0.32, 0, 0.2, 0, 'Paladin - Judgement of Righteousness'),
(31804, 0.22, 0, 0.14, 0, 'Paladin - Judgement of Vengeance');

-- 9591
DELETE FROM script_texts WHERE entry BETWEEN -1000506 AND -1000500;
INSERT INTO script_texts (npc_entry,entry,content_default,sound,type,language,emote,comment) VALUES
(5391, -1000500,'Help! Please, You must help me!',0,0,0,0,'Galen - periodic say'),
(5391, -1000501,'Let us leave this place.',0,0,0,0,'Galen - quest accepted'),
(5391, -1000502,'Look out! The $c attacks!',0,0,0,0,'Galen - aggro 1'),
(5391, -1000503,'Help! I\'m under attack!',0,0,0,0,'Galen - aggro 2'),
(5391, -1000504,'Thank you $N. I will remember you always. You can find my strongbox in my camp, north of Stonard.',0,0,0,0,'Galen - quest complete'),
(5391, -1000505,'%s whispers to $N the secret to opening his strongbox.',0,2,0,0,'Galen - emote whisper'),
(5391, -1000506,'%s disappears into the swamp.',0,2,0,0,'Galen - emote disapper');

DELETE FROM script_waypoint WHERE entry=5391;
INSERT INTO script_waypoint VALUES
(5391, 0, -9901.12, -3727.29, 22.11, 3000, ''),
(5391, 1, -9909.27, -3727.81, 23.25, 0, ''),
(5391, 2, -9935.25, -3729.02, 22.11, 0, ''),
(5391, 3, -9945.83, -3719.34, 21.68, 0, ''),
(5391, 4, -9963.41, -3710.18, 21.71, 0, ''),
(5391, 5, -9972.75, -3690.13, 21.68, 0, ''),
(5391, 6, -9989.70, -3669.67, 21.67, 0, ''),
(5391, 7, -9989.21, -3647.76, 23.00, 0, ''),
(5391, 8, -9992.27, -3633.74, 21.67, 0, ''),
(5391, 9,-10002.32, -3611.67, 22.26, 0, ''),
(5391,10, -9999.25, -3586.33, 21.85, 0, ''),
(5391,11,-10006.53, -3571.99, 21.67, 0, ''),
(5391,12,-10014.30, -3545.24, 21.67, 0, ''),
(5391,13,-10018.91, -3525.03, 21.68, 0, ''),
(5391,14,-10030.22, -3514.77, 21.67, 0, ''),
(5391,15,-10045.11, -3501.49, 21.67, 0, ''),
(5391,16,-10052.91, -3479.13, 21.67, 0, ''),
(5391,17,-10060.68, -3460.31, 21.67, 0, ''),
(5391,18,-10074.68, -3436.85, 20.97, 0, ''),
(5391,19,-10074.68, -3436.85, 20.97, 0, ''),
(5391,20,-10072.86, -3408.92, 20.43, 15000, ''),
(5391,21,-10108.01, -3406.05, 22.06, 0, '');

UPDATE creature_template SET ScriptName='npc_galen_goodward' WHERE entry=5391;

-- 9595
DELETE FROM `spell_proc_event` WHERE entry = 71404;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(71404, 0, 0, 0, 0, 0, 0, 2, 0, 0, 45);

-- 9599
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_flame_leviathan_defense_cannon' WHERE `entry` = 33139;

DELETE FROM `vehicle_accessory` WHERE `entry`=33114;

-- 9600
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1000578 AND -1000575;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(19589,-1000575, 'All systems on-line. Prepare yourself, we leave shortly.',0,0,0,0, 'max_a_million SAY_START'),
(19589,-1000576, 'Be careful in there and come back in one piece!',0,0,0,0, 'bot-specialist_alley SAY_ALLEY_FAREWELL'),
(19589,-1000577, 'Proceed.',0,0,0,0, 'max_a_million SAY_CONTINUE'),
(19589,-1000578, 'You are back! Were you able to get all of the machines?',0,0,0,0, 'bot-specialist_alley SAY_ALLEY_FINISH');

DELETE FROM script_waypoint WHERE entry = 19589;
INSERT INTO script_waypoint VALUES
(19589, 1, 3358.22, 3728.25, 141.204, 0, ''),
(19589, 2, 3368.05, 3715.51, 142.057, 0, ''),
(19589, 3, 3389.04, 3701.21, 144.648, 0, ''),
(19589, 4, 3419.51, 3691.41, 146.598, 0, ''),
(19589, 5, 3437.83, 3699.2,   147.235, 0, ''),
(19589, 6, 3444.85, 3700.89, 147.088, 0, ''),
(19589, 7, 3449.89, 3700.14, 148.118, 0, ''),
(19589, 8, 3443.55, 3682.09, 149.219, 0, ''),
(19589, 9, 3452.6,  3674.65,  150.226, 0, ''),
(19589, 10, 3462.6,  3659.01, 152.436, 0, ''),
(19589, 11, 3469.18, 3649.47, 153.178, 0, ''),
(19589, 12, 3475.11, 3639.41, 157.213, 0, ''),
(19589, 13, 3482.26, 3617.69, 159.126, 0, ''),
(19589, 14, 3492.7,  3606.27,  156.419, 0, ''),
(19589, 15, 3493.52, 3595.06,  156.581, 0, ''),
(19589, 16, 3490.4,  3588.45,  157.764, 0, ''),
(19589, 17, 3485.21, 3585.69, 159.979, 0, ''),
(19589, 18, 3504.68, 3594.44, 152.862, 0, ''),
(19589, 19, 3523.6,  3594.48, 145.393, 0, ''),
(19589, 20, 3537.01, 3576.71, 135.748, 0, ''),
(19589, 21, 3551.73, 3573.12, 128.013, 0, ''),
(19589, 22, 3552.12, 3614.08, 127.847, 0, ''),
(19589, 23, 3536.14, 3639.78, 126.031, 0, ''),
(19589, 24, 3522.94, 3646.47, 131.989, 0, ''),
(19589, 25, 3507.21, 3645.69, 138.1527, 0, ''),
(19589, 26, 3485.15, 3645.64, 137.755, 0, ''),
(19589, 27, 3472.18, 3633.88, 140.352, 0, ''),
(19589, 28, 3435.34, 3613.69, 140.725, 0, ''),
(19589, 29, 3417.4,  3612.4,   141.143, 0, ''),
(19589, 30, 3411.04, 3621.14, 142.454, 0, ''),
(19589, 31, 3404.47, 3636.89, 144.434, 0, ''),
(19589, 32, 3380.55, 3657.06, 144.332, 0, ''),
(19589, 33, 3375,     3676.86, 145.298, 0, ''),
(19589, 34, 3388.87, 3685.48, 146.818, 0, ''),
(19589, 35, 3393.99, 3699.4,   144.858, 0, ''),
(19589, 36, 3354.95, 3726.02, 141.428, 0, '');

UPDATE creature_template SET ScriptName='npc_maxx_a_million_escort', MovementType=2 WHERE entry=19589;

-- 9604
DELETE FROM script_texts WHERE entry BETWEEN -1000516 AND -1000507;
INSERT INTO script_texts (npc_entry,entry,content_default,sound,type,language,emote,comment) VALUES
(4880, -1000507,'Ok, let''s get started.',0,0,0,0,'stinky - quest accepted'),
(4880, -1000508,'Now let''s look for the herb.',0,0,0,0,'stinky - say1'),
(4880, -1000509,'Nope, not here...',0,0,0,0,'stinky - say2'),
(4880, -1000510,'There must be one around here somewhere...',0,0,0,0,'stinky - say3'),
(4880, -1000511,'Ah, there''s one! ',0,0,0,0,'stinky - say4'),
(4880, -1000512,'Come, $N!  Let''s go over there and collect it!',0,0,0,0,'stinky - say5'),
(4880, -1000513,'Ok, now let''s get out of here! ',0,0,0,0,'stinky - say6'),
(4880, -1000514,'I can make it from here.  Thanks, $N!  And talk to my employer about a reward!',0,0,0,0,'stinky - quest complete'),
(4880, -1000515,'Help! The beast is on me!',0,0,0,0,'stinky - aggro'),
(4880, -1000516,'%s disappears back into the swamp.',0,2,0,0,'stinky - emote disapper');

DELETE FROM script_waypoint WHERE entry=4880;
INSERT INTO `script_waypoint` VALUES
(4880,0,-2646.429932,-3436.070068,35.373199,0, ''),
(4880,1,-2650.82617,-3440.15332,35.138092,0, ''),
(4880,2,-2662.3147,-3447.67285,35.10891,0, ''),
(4880,3,-2680.4834,-3454.59766,34.6538124,0, ''),
(4880,4,-2701.01855,-3457.43628,34.26906,0, ''),
(4880,5,-2724.063,-3458.63623,33.6734657,0, ''),
(4880,6,-2745.0127,-3459.28125,32.53458,0, ''),
(4880,7,-2759.419,-3464.78174,32.714283,3000, ''),
(4880,8,-2763.63,-3471.50732,33.53883,0, ''),
(4880,9,-2771.789,-3480.88721,33.2553253,0, ''),
(4880,10,-2780.66455,-3488.76343,31.8750439,0, ''),
(4880,11,-2796.144775,-3489.013184,30.858467,3000, ''),
(4880,12,-2792.117920,-3495.966797,30.732433,0, ''),
(4880,13,-2789.059814,-3502.372559,30.670414,0, ''),
(4880,14,-2787.715576,-3515.013428,31.117569,0, ''),
(4880,15,-2790.841309,-3523.311768,30.573286,0, ''),
(4880,16,-2796.58545,-3520.61963,29.9187489,0, ''),
(4880,17,-2798.563,-3518.91064,30.3887444,0, ''),
(4880,18,-2801.46875,-3516.745,30.1914845,0, ''),
(4880,19,-2804.356201,-3513.899170,29.550812,0, ''),
(4880,20,-2807.97559,-3517.99634,29.94883,0, ''),
(4880,21,-2815.680664,-3521.739014,29.772268,0, ''),
(4880,22,-2823.386230,-3526.234131,31.71944,0, ''),
(4880,23,-2836.109619,-3544.695557,32.493855,0, ''),
(4880,24,-2830.392578,-3568.862305,30.410404,0, ''),
(4880,25,-2824.842285,-3569.516846,31.281128,0, ''),
(4880,26,-2818.663818,-3567.801025,30.920368,6000, ''),
(4880,27,-2817.663818,-3568.935059,30.431194,6000, ''),
(4880,28,-2820.394043,-3592.223389,30.716301,6000, ''),
(4880,29,-2820.765625,-3592.497803,30.886147,0, ''),
(4880,30,-2829.909424,-3588.730713,30.683064,0, ''),
(4880,31,-2842.322021,-3577.498291,36.848869,0, ''),
(4880,32,-2851.180420,-3567.579346,38.515850,0, ''),
(4880,33,-2865.554932,-3551.582275,41.438988,0, ''),
(4880,34,-2871.234863,-3548.145020,40.761391,0, ''),
(4880,35,-2877.840332,-3544.147461,38.670235,0, ''),
(4880,36,-2890.394775,-3542.388672,34.314426,0, ''),
(4880,37,-2898.729980,-3543.635742,34.319958,6000, ''),
(4880,38,-2910.064453,-3568.957275,34.250011,0, ''),
(4880,39,-2932.509766,-3584.618652,37.238464,0, '');

UPDATE creature_template SET ScriptName='npc_stinky' WHERE entry=4880;

-- 9607
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12778,13036,13035,13037) AND `type` IN (0,11);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12778,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13036,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13035,11,0,0, 'achievement_ive_gone_and_made_a_mess'),
(13037,11,0,0, 'achievement_ive_gone_and_made_a_mess');

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1631077 AND -1631029;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
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

UPDATE `creature_template` SET `ScriptName`='boss_deathbringer_saurfang' WHERE `entry`=37813;
UPDATE `creature_template` SET `ScriptName`='npc_high_overlord_saurfang_icc' WHERE `entry`=37187;
UPDATE `creature_template` SET `ScriptName`='npc_muradin_bronzebeard_icc' WHERE `entry`=37200;
UPDATE `creature_template` SET `ScriptName`='npc_saurfang_event' WHERE `entry` IN (37920,37830);

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