-- 9668
DROP TABLE IF EXISTS `gm_subsurveys`;
CREATE TABLE `gm_subsurveys` (
  `surveyid` int(10) NOT NULL auto_increment,
  `subsurveyid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `rank` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `comment` longtext NOT NULL,
  PRIMARY KEY (`surveyid`,`subsurveyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
 
DROP TABLE IF EXISTS `gm_surveys`;
CREATE TABLE `gm_surveys` (
  `surveyid` int(10) NOT NULL auto_increment,
  `player` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `mainSurvey` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `overall_comment` longtext NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`surveyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
 
ALTER TABLE `gm_tickets` ADD COLUMN `completed` int(11) NOT NULL DEFAULT '0' AFTER `comment`;
ALTER TABLE `gm_tickets` ADD COLUMN `escalated` int(11) NOT NULL DEFAULT '0' AFTER `completed`;
ALTER TABLE `gm_tickets` ADD COLUMN `viewed` int(11) NOT NULL DEFAULT '0' AFTER `escalated`;
 
DROP TABLE IF EXISTS `lag_reports`;
CREATE TABLE `lag_reports` (
  `report_id` int(10) NOT NULL auto_increment,
  `player` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `lag_type` int(10) NOT NULL DEFAULT '0',
  `map` int(11) NOT NULL DEFAULT '0',
  `posX` float NOT NULL default '0',
  `posY` float NOT NULL default '0',
  `posZ` float NOT NULL default '0',
  PRIMARY KEY  (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';
