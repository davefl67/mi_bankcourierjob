/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table overextended.ox_groups
CREATE TABLE IF NOT EXISTS `ox_groups` (
  `name` varchar(20) NOT NULL,
  `label` varchar(50) NOT NULL,
  `grades` longtext NOT NULL,
  `hasAccount` bit(1) NOT NULL DEFAULT b'0',
  `adminGrade` tinyint(3) unsigned NOT NULL DEFAULT json_length(`grades`),
  `colour` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table overextended.ox_groups: ~3 rows (approximately)
INSERT INTO `ox_groups` (`name`, `label`, `grades`, `hasAccount`, `adminGrade`, `colour`) VALUES
    ('bankcourier',     'G6 Bank Security',             '["Security Guard", "Boss"]', b'0', 2, NULL),
    ('electrician',     'L.S. Dept. of Water & Power',  '["Technician", "Boss"]', b'0', 2, NULL),
    ('packagecourier',  'GoPostal Courier Servies',     '["Courier", "Boss"]', b'0', 2, NULL),
    ('pestcontrol',     'Bugstars Pest Control',        '["Technician", "Boss"]', b'0', 2, NULL),
    ('security',        'Bobcat Security Services',     '["Security Guard", "Boss"]', b'0', 2, NULL)
    ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
