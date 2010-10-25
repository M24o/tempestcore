-- -------------------------------------------------------------------------
-- ------------------------ StartUP Errors Fixes ---------------------------
-- -------------------------------------------------------------------------
-- ONLY FOR MYTH DB !!!
-- OutdoorPVP Table (Trinity 9237 Commit)
REPLACE INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `Comment`) VALUES
(1, 'outdoorpvp_hp', 'Hellfire Peninsula'),
(2, 'outdoorpvp_na', 'Nagrand'),
(3, 'outdoorpvp_tf', 'Terokkar Forest'),
(4, 'outdoorpvp_zm', 'Zangarmarsh'),
(5, 'outdoorpvp_si', 'Silithus');

-- AHTUNG! BackUP your world DB before use this queries! UNTESTED
-- For StarUP errors Fix. REMOVE " /* */ " for use!
DELETE FROM gameobject_loot_template WHERE entry IN (26094, 26097, 195665,195666,195667,195668,195669,195670,195671,195672);
DELETE FROM reference_loot_template WHERE entry IN (47557, 50008, 50009);

-- MythDB Version, for Proper Bug Reports
UPDATE version SET `cache_id`= '566';
UPDATE version SET `core_revision`= '10035';
UPDATE version SET `db_version`= 'MDB_v1.3_YTDB_v565_TC_rev10035';

DELETE FROM creature_addon WHERE guid =136107;