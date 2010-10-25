-- 9792
ALTER TABLE `instance_reset` ADD INDEX ( `difficulty` );
ALTER TABLE `groups` ADD INDEX ( `leaderGuid` );
ALTER TABLE `instance` ADD INDEX ( `difficulty` );
