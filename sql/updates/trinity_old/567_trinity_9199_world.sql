-- 9195
ALTER TABLE `game_weather` ADD `ScriptName` char(64) NOT NULL DEFAULT '' AFTER `winter_storm_chance`;

-- 9196
ALTER TABLE `conditions` ADD `ScriptName` char(64) NOT NULL DEFAULT '' AFTER `ErrorTextId`;

-- 9198
DROP TABLE IF EXISTS `outdoorpvp_template`;
CREATE TABLE `outdoorpvp_template` (
  `TypeId` tinyint(2) unsigned NOT NULL,
  `ScriptName` char(64) NOT NULL DEFAULT '',
  `comment` text,
  PRIMARY KEY (`TypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='OutdoorPvP Templates';

-- 9199
DELETE FROM `spell_script_names` WHERE `spell_id`=47948 AND `ScriptName`='spell_pri_pain_and_suffering_proc';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (47948, 'spell_pri_pain_and_suffering_proc');