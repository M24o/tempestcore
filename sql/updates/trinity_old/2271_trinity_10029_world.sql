-- 10000
DELETE FROM `command` WHERE `name` IN ('ban character','ban playeraccount');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('ban character',3,'Syntax: .ban character $Name $bantime $reason\nBan character and kick player.\n$bantime: negative value leads to permban, otherwise use a timestring like "4d20h3s".'),
('ban playeraccount',3,'Syntax: .ban playeraccount $Name $bantime $reason\nBan account and kick player.\n$bantime: negative value leads to permban, otherwise use a timestring like "4d20h3s".');
DELETE FROM `trinity_string` WHERE `entry` IN (1131,1132,1133);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(1131, 'The following characters match your query:'),
(1132, 'Currently Banned Characters:'),
(1133, '|   Character   |   BanDate    |   UnbanDate  |  Banned By    |   Ban Reason  |');
-- 10023
DELETE FROM `command` WHERE `name` IN ('achievement add', 'achievement');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('achievement add',4,'Syntax: .achievement add $achievement\nAdd an achievement to the targeted player.\n$achievement: can be either achievement id or achievement link'),
('achievement',4,'Syntax: .achievement $subcommand\nType .achievement to see the list of possible subcommands or .help achievement $subcommand to see info on subcommands');
-- 10029
DELETE FROM `spell_script_names` WHERE `spell_id`=41337 AND `ScriptName`='spell_gen_aura_of_anger';
DELETE FROM `spell_script_names` WHERE `spell_id`=46394 AND `ScriptName`='spell_gen_burn_brutallus';
DELETE FROM `spell_script_names` WHERE `spell_id`=-53302 AND `ScriptName`='spell_hun_sniper_training';
DELETE FROM `spell_script_names` WHERE `spell_id`=45472 AND `ScriptName`='spell_gen_parachute';
DELETE FROM `spell_script_names` WHERE `spell_id`=-51685 AND `ScriptName`='spell_rog_prey_on_the_weak';
DELETE FROM `spell_script_names` WHERE `spell_id`=66118 AND `ScriptName`='spell_gen_leeching_swarm';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (20911,25899) AND `ScriptName`='spell_pal_blessing_of_sanctuary';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(41337,'spell_gen_aura_of_anger'),
(46394,'spell_gen_burn_brutallus'),
(-53302,'spell_hun_sniper_training'),
(45472,'spell_gen_parachute'),
(-51685,'spell_rog_prey_on_the_weak'),
(66118,'spell_gen_leeching_swarm'),
(20911,'spell_pal_blessing_of_sanctuary'),
(25899,'spell_pal_blessing_of_sanctuary');
DELETE FROM `spell_script_names` WHERE `spell_id`=51662 AND `ScriptName`='spell_rog_hunger_for_blood';
DELETE FROM `spell_script_names` WHERE `spell_id`=31231 AND `ScriptName`='spell_rog_cheat_death';
