-- -------------------------------------------------------------------------
-- ------------------------- Myth Project UPDATE ---------------------------
-- -------------------------------------------------------------------------
-- THIS IS UPDATE FOR "AUTHORIZATION" Database.
-- NOTE: This Update pack is optimized for TRINITY AUTH DB.
-- Contain all trinity updates for authorization database since 8787 rev.
-- HOW TO USE:
--  IF YOU HAVE AUTHORIZATION DB, WITH LAST TRINITY UPDATES BEFORE 8787 REV. SKIP 1),2) STEPS.
-- 1) Create database for authorization database 
-- 2) Install clear authorization database from sql\base
-- 3) If you have StartUP errors, Please do that:
--    3.1) Host them in to text hosts. (for example http://paste2.org/new-paste)
--    3.2) Please post them in our forum, don`t forget link of your error logs. 
--    3.3) DON`T CREATE DUBLICATE ISSUES!!!
-- 4) If you have some fixes, please post it in issue tracker too.
-- 5) Thanks you for visit MythProject.
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- ------------------------- TrinityCore UPDATE ----------------------------
-- -------------------------------------------------------------------------
-- 8877 12340 Gamebuild
UPDATE `realmlist` SET `gamebuild`=12340 WHERE `id`=1;
ALTER TABLE `realmlist` CHANGE COLUMN `gamebuild` `gamebuild` int(11) unsigned NOT NULL default '12340';
-- 9453
ALTER TABLE `account` ADD COLUMN `recruiter` int(11) NOT NULL default '0' AFTER `locale`;