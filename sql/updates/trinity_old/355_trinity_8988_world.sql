-- 8795
-- Add serverside spells place holders for future development
DELETE FROM `spell_dbc` WHERE `Id` IN (38406);
INSERT INTO `spell_dbc` (`Id`,`Comment`) VALUES
(38406, 'Quest 10721 RewSpellCast serverside spell');

-- 8987
ALTER TABLE `playercreateinfo`
  ADD COLUMN `orientation` float NOT NULL DEFAULT 0 AFTER `position_z`;

-- 8988
UPDATE `playercreateinfo` SET `orientation`=5.696318 WHERE `race`=4 AND `class`<>6;
UPDATE `playercreateinfo` SET `orientation`=6.177156 WHERE `race`=3 AND `class`<>6;
UPDATE `playercreateinfo` SET `orientation`=2.70526 WHERE `race`=5 AND `class`<>6;
UPDATE `playercreateinfo` SET `orientation`=5.316046 WHERE `race`=10 AND `class`<>6;
UPDATE `playercreateinfo` SET `orientation`=2.083644 WHERE `race`=11 AND `class`<>6;
UPDATE `playercreateinfo` SET `orientation`=3.659973 WHERE `class`=6;
