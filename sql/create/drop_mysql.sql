REVOKE ALL PRIVILEGES ON * . * FROM 'myth'@'localhost';

REVOKE ALL PRIVILEGES ON `world` . * FROM 'myth'@'localhost';

REVOKE GRANT OPTION ON `world` . * FROM 'myth'@'localhost';

REVOKE ALL PRIVILEGES ON `characters` . * FROM 'myth'@'localhost';

REVOKE GRANT OPTION ON `characters` . * FROM 'myth'@'localhost';

REVOKE ALL PRIVILEGES ON `auth` . * FROM 'myth'@'localhost';

REVOKE GRANT OPTION ON `auth` . * FROM 'myth'@'localhost';

DROP USER 'myth'@'localhost';

DROP DATABASE IF EXISTS `world`;

DROP DATABASE IF EXISTS `characters`;

DROP DATABASE IF EXISTS `auth`;
