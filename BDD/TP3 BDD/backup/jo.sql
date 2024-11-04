-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : lun. 04 nov. 2024 à 11:13
-- Version du serveur : 8.0.40
-- Version de PHP : 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jo`
--

-- --------------------------------------------------------

--
-- Structure de la table `APPARTENIR_EQUIPE`
--

CREATE TABLE `APPARTENIR_EQUIPE` (
  `NUM_LICENCE` int NOT NULL,
  `NUM_EQUIPE` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `APPARTENIR_EQUIPE`
--

INSERT INTO `APPARTENIR_EQUIPE` (`NUM_LICENCE`, `NUM_EQUIPE`) VALUES
(201, 299),
(202, 299),
(523, 577),
(524, 577),
(525, 577),
(526, 577),
(527, 577),
(528, 577),
(529, 577),
(530, 577),
(531, 577),
(532, 577),
(533, 577),
(534, 577),
(834, 865),
(835, 865),
(836, 865),
(1423, 1498),
(1424, 1498),
(1425, 1498),
(1426, 1498),
(1427, 1498),
(1428, 1498),
(1429, 1498),
(1430, 1498),
(1431, 1498),
(1432, 1498),
(1433, 1498),
(1434, 1498),
(1435, 1498),
(1436, 1498),
(1437, 1498),
(1818, 1896),
(1820, 1896),
(1821, 1896),
(1822, 1896),
(1823, 1896),
(1824, 1896),
(1890, 1897),
(1892, 1897),
(1893, 1897),
(1895, 1897),
(1896, 1897),
(1890, 1899),
(1891, 1899),
(1892, 1899),
(1893, 1899),
(1894, 1899),
(1895, 1899),
(2210, 2204),
(2211, 2204),
(2212, 2205),
(2213, 2205);

-- --------------------------------------------------------

--
-- Structure de la table `DISCIPLINE`
--

CREATE TABLE `DISCIPLINE` (
  `CODE_DISCIPLINE` int NOT NULL,
  `INTITULE` varchar(60) NOT NULL,
  `CODE_SPORT` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `DISCIPLINE`
--

INSERT INTO `DISCIPLINE` (`CODE_DISCIPLINE`, `INTITULE`, `CODE_SPORT`) VALUES
(101, 'Saut à la perche - messieurs', 1),
(109, '3000 m steeple - hommes', 1),
(201, 'Deux sans barreur - messieurs', 2),
(203, 'Quatre sans barreur', 2),
(501, 'Basket - messieurs', 5),
(502, 'Basket - dames', 5),
(601, 'Poids mouche', 6),
(603, '48kg', 6),
(702, 'Canoe slalom', 7),
(705, 'Kayak slalom - dames', 7),
(707, 'K1 (slalom) dames', 7),
(710, 'Deux de couple', 7),
(801, 'Vtt', 8),
(802, 'Piste vitesse - dames', 8),
(803, '500 m - dames', 8),
(805, 'Piste - dames', 8),
(810, 'Piste vitesse - messieurs', 8),
(815, 'Contre la montre - dames', 8),
(819, 'Omnium hommes ', 8),
(820, 'Keirin', 8),
(821, 'Vitesse par EQUIPE - messieurs', 8),
(827, 'Cross-country VTT Femmes', 8),
(1001, 'Epee individuel - messieurs', 10),
(1002, 'Epee individuel - dames', 10),
(1003, 'Fleuret individuel - messieurs', 10),
(1004, 'Fleuret individuel - dames', 10),
(1005, 'Sabre individuel - messieurs', 10),
(1006, 'Sabre individuel - dames', 10),
(1007, 'Epee par EQUIPE - messieurs', 10),
(1008, 'Epee par EQUIPE - dames', 10),
(1009, 'Fleuret par EQUIPE - messieurs', 10),
(1010, 'Fleuret par EQUIPE - dames', 10),
(1011, 'Sabre par EQUIPE - messieurs', 10),
(1012, 'Sabre par EQUIPE - dames', 10),
(1203, 'Barres parallèles', 12),
(1204, 'Barre fixe', 12),
(1205, 'Cheval d\'arcons', 12),
(1401, 'Tournoi Hanball masculin', 14),
(1601, ' + 100 kg - messieurs', 16),
(1603, ' - 60 kg - messieurs', 16),
(1604, ' - 66 kg - messieurs', 16),
(1605, ' - 73 kg - messieurs', 16),
(1616, ' - 81 kg - messieurs', 16),
(1621, ' - 90 kg - messieurs', 16),
(1622, ' - 100 kg - messieurs', 16),
(1626, ' - 48 kg - dames', 16),
(1627, ' - 52 kg - dames', 16),
(1628, ' - 57 kg - dames', 16),
(1629, ' - 63 kg - dames', 16),
(1630, ' - 70 kg - dames', 16),
(1631, ' - 78 kg - dames', 16),
(1632, ' + 78 kg - dames', 16),
(1710, ' - 66 kg - messieurs', 17),
(1801, '400 m nage libre - dames', 18),
(1802, '200 m dos - dames', 18),
(1803, 'Synchronise - duo', 18),
(1804, 'relai 4x100 m nage libre - messieurs', 18),
(1809, '50 m nage libre - messieurs', 18),
(1810, '200 m nage libre - dames', 18),
(1811, 'Relais 4 × 200 m nage libre - hommes', 18),
(1812, 'Relais 4 × 200 m nage libre - dames', 18),
(1813, '200 m nage libre - messieurs', 18),
(2101, '  + 67 kg - dames', 21),
(2102, '  - 57 kg - dames', 21),
(2201, 'Double - messieurs', 22),
(2202, 'Simple - messieurs', 22),
(2401, 'Pistolet 10m - messieurs', 24),
(2403, 'Tir aux plateaux - dames', 24),
(2404, 'Pistolet à 10 m air comprimé - dames', 24),
(2405, 'Trap - dames', 24),
(2705, 'Finn', 27);

-- --------------------------------------------------------

--
-- Structure de la table `EQUIPE`
--

CREATE TABLE `EQUIPE` (
  `NUM_EQUIPE` int NOT NULL,
  `DENOMINATION` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `EQUIPE`
--

INSERT INTO `EQUIPE` (`NUM_EQUIPE`, `DENOMINATION`) VALUES
(299, 'Deux sans barreur hommes'),
(577, 'Basket - dames'),
(865, 'Vitesse par équipes hommes'),
(1498, 'Handball - messieurs'),
(1896, 'Relais 4 × 200 m nage libre - dames'),
(1897, 'Relais 4×200 m nage libre - hommes'),
(1899, 'Relai 4x100 nage libre - messieurs'),
(2204, 'Tennis double - messieurs - équipe1'),
(2205, 'Tennis double - messieurs - équipe2');

-- --------------------------------------------------------

--
-- Structure de la table `GAGNER_COLLECTIF`
--

CREATE TABLE `GAGNER_COLLECTIF` (
  `CODE_DISCIPLINE` int NOT NULL,
  `NUM_EQUIPE` int NOT NULL,
  `MEDAILLE` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `GAGNER_COLLECTIF`
--

INSERT INTO `GAGNER_COLLECTIF` (`CODE_DISCIPLINE`, `NUM_EQUIPE`, `MEDAILLE`) VALUES
(201, 299, 'Argent'),
(502, 577, 'Argent'),
(821, 865, 'Argent'),
(1401, 1498, 'Or'),
(1804, 1899, 'Or'),
(1811, 1897, 'Argent'),
(1812, 1896, 'Bronze'),
(2201, 2204, 'Argent'),
(2201, 2205, 'Bronze');

-- --------------------------------------------------------

--
-- Structure de la table `GAGNER_INDIVIDUEL`
--

CREATE TABLE `GAGNER_INDIVIDUEL` (
  `CODE_DISCIPLINE` int NOT NULL,
  `NUM_LICENCE` int NOT NULL,
  `MEDAILLE` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `GAGNER_INDIVIDUEL`
--

INSERT INTO `GAGNER_INDIVIDUEL` (`CODE_DISCIPLINE`, `NUM_LICENCE`, `MEDAILLE`) VALUES
(101, 101, 'Or'),
(109, 165, 'Argent'),
(702, 712, 'Or'),
(707, 723, 'Or'),
(810, 834, 'Argent'),
(819, 837, 'Argent'),
(827, 856, 'Or'),
(1203, 1201, 'Bronze'),
(1605, 1623, 'Bronze'),
(1622, 1699, 'Or'),
(1627, 1621, 'Bronze'),
(1628, 1622, 'Bronze'),
(1629, 1624, 'Bronze'),
(1630, 1607, 'Or'),
(1631, 1625, 'Bronze'),
(1710, 1701, 'Bronze'),
(1801, 1818, 'Or'),
(1809, 1899, 'Or'),
(1810, 1818, 'Argent'),
(1813, 1893, 'Or'),
(2101, 2101, 'Argent'),
(2102, 2112, 'Bronze'),
(2404, 2412, 'Argent'),
(2405, 2413, 'Bronze'),
(2705, 2701, 'Bronze');

-- --------------------------------------------------------

--
-- Structure de la table `SPORT`
--

CREATE TABLE `SPORT` (
  `CODE_SPORT` int NOT NULL,
  `INTITULE` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `SPORT`
--

INSERT INTO `SPORT` (`CODE_SPORT`, `INTITULE`) VALUES
(1, 'Athletisme'),
(2, 'Aviron'),
(3, 'Badminton'),
(5, 'Basket-ball'),
(6, 'Boxe'),
(7, 'Canoe-Kayak'),
(8, 'Cyclisme'),
(9, 'Equitation'),
(10, 'Escrime'),
(11, 'Football'),
(12, 'Gymnastique'),
(13, 'Halterophilie'),
(14, 'Handball'),
(15, 'Hockey'),
(16, 'Judo'),
(17, 'Lutte'),
(18, 'Natation'),
(19, 'Pentathlon moderne'),
(21, 'Taekwando'),
(22, 'Tennis'),
(23, 'Tennis de table'),
(24, 'Tir'),
(25, 'Tir a l\'arc'),
(26, 'Triathlon'),
(27, 'Voile'),
(28, 'Volleyball'),
(29, 'petanque');

-- --------------------------------------------------------

--
-- Structure de la table `SPORTIF`
--

CREATE TABLE `SPORTIF` (
  `NUM_LICENCE` int NOT NULL,
  `NOM` varchar(20) NOT NULL,
  `PRENOM` varchar(20) DEFAULT NULL,
  `PAYS` varchar(20) DEFAULT NULL,
  `CODE_SPORT` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `SPORTIF`
--

INSERT INTO `SPORTIF` (`NUM_LICENCE`, `NOM`, `PRENOM`, `PAYS`, `CODE_SPORT`) VALUES
(101, 'Lavillennie', 'Renaud', 'France', 1),
(165, 'Mekhissi-Benabbad', 'Mahiedine', 'France', 1),
(201, 'Chardin', 'Germain', 'France', 2),
(202, 'Mortelette', 'Dorian', 'France', 2),
(523, 'Beikes', 'Clémence', 'France', 5),
(524, 'Digbeu', 'Jennifer', 'France', 5),
(525, 'Dumerc', 'Céline', 'France', 5),
(526, 'Godin', 'Élodie', 'France', 5),
(527, 'Gomis', 'Émilie', 'France', 5),
(528, 'Gruda', 'Sandrine', 'France', 5),
(529, 'Laborde', 'Marion', 'France', 5),
(530, 'Lawson-Wade', 'Edwige', 'France', 5),
(531, 'Lepron', 'Florence', 'France', 5),
(532, 'Miyem', 'Nwal-Endéné', 'France', 5),
(533, 'Ndongue', 'Emmeline', 'France', 5),
(534, 'Yacoubou-Dehoui', 'Isabelle', 'France', 5),
(712, 'Estanguet', 'Tony', 'France', 7),
(723, 'Fer', 'Emilie', 'France', 7),
(834, 'Baugé', 'Grégory', 'France', 8),
(835, 'D\'Almeida', 'Michaël', 'France', 8),
(836, 'Sireau', 'Kévin', 'France', 8),
(837, 'Coquard', 'Bryan', 'France', 8),
(856, 'Bresset', 'Julie', 'France', 8),
(1201, 'Sabot', 'Hamilton', 'France', 12),
(1423, 'Abalo', 'Luc', 'France', 14),
(1424, 'Accambray', 'William', 'France', 14),
(1425, 'Barachet', 'Xavier', 'France', 14),
(1426, 'Dinart', 'Didier', 'France', 14),
(1427, 'Fernandez', 'Jérôme', 'France', 14),
(1428, 'Gille', 'Bertrand', 'France', 14),
(1429, 'Gille', 'Guillaume', 'France', 14),
(1430, 'Guigou', 'Michaël', 'France', 14),
(1431, 'Honrubia', 'Samuel', 'France', 14),
(1432, 'Joli', 'Guillaume', 'France', 14),
(1433, 'Karabatic', 'Nikola', 'France', 14),
(1434, 'Karaboué', 'Daouda', 'France', 14),
(1435, 'Narcisse', 'Daniel', 'France', 14),
(1436, 'Omeyer', 'Thierry', 'France', 14),
(1437, 'Sorhaindo', 'Cédric', 'France', 14),
(1607, 'Décosse', 'Lucie', 'France', 16),
(1621, 'Gneto', 'Priscilla', 'France', 16),
(1622, 'Pavia', 'Automne', 'France', 16),
(1623, 'Legrand', 'Ugo', 'France', 16),
(1624, 'Émane', 'Gévrise', 'France', 16),
(1625, 'Tcheuméo', 'Audrey', 'France', 16),
(1699, 'Riner', 'Teddy', 'France', 16),
(1701, 'Guénot', 'Steeve', 'France', 17),
(1818, 'Muffat', 'Camille', 'France', 18),
(1820, 'Bonnet', 'Charlotte', 'France', 18),
(1821, 'Étienne', 'Ophélie-Cyrielle', 'France', 18),
(1822, 'Balmy', 'Coralie', 'France', 18),
(1823, 'Farrell', 'Margaux', 'France', 18),
(1824, 'Lazare', 'Mylène', 'France', 18),
(1890, 'Leveaux', 'Armaury', 'France', 18),
(1891, 'Gilot', 'Fabien', 'France', 18),
(1892, 'Lefert', 'Clément', 'France', 18),
(1893, 'Agnel', 'Yannick', 'France', 18),
(1894, 'Bernard', 'Alain', 'France', 18),
(1895, 'Stravius', 'Jérémy', 'France', 18),
(1896, 'Mallet', 'Grégory', 'France', 18),
(1899, 'Manaudou', 'Florent', 'France', 18),
(2101, 'Graffe', 'Anne-Caroline', 'France', 21),
(2112, 'Harnois', 'Marlène', 'France', 21),
(2210, 'Tsonga', 'Jo-Wilfried', 'France', 22),
(2211, 'Llodra', 'Michaël', 'France', 22),
(2212, 'Benneteau', 'Julien', 'France', 22),
(2213, 'Gasquet', 'Richard', 'France', 22),
(2412, 'Goberville', 'Céline', 'France', 24),
(2413, 'Réau-Racinet', 'Delphine', 'France', 24),
(2701, 'Lobert', 'Jonathan', 'France', 27);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `APPARTENIR_EQUIPE`
--
ALTER TABLE `APPARTENIR_EQUIPE`
  ADD PRIMARY KEY (`NUM_LICENCE`,`NUM_EQUIPE`),
  ADD KEY `FK_APPARTENIR_EQUIPE` (`NUM_EQUIPE`);

--
-- Index pour la table `DISCIPLINE`
--
ALTER TABLE `DISCIPLINE`
  ADD PRIMARY KEY (`CODE_DISCIPLINE`),
  ADD KEY `FK_DISCIPLINE_SPORT` (`CODE_SPORT`);

--
-- Index pour la table `EQUIPE`
--
ALTER TABLE `EQUIPE`
  ADD PRIMARY KEY (`NUM_EQUIPE`);

--
-- Index pour la table `GAGNER_COLLECTIF`
--
ALTER TABLE `GAGNER_COLLECTIF`
  ADD PRIMARY KEY (`CODE_DISCIPLINE`,`NUM_EQUIPE`),
  ADD KEY `FK_GAGNER_COLLECTIF` (`NUM_EQUIPE`);

--
-- Index pour la table `GAGNER_INDIVIDUEL`
--
ALTER TABLE `GAGNER_INDIVIDUEL`
  ADD PRIMARY KEY (`CODE_DISCIPLINE`,`NUM_LICENCE`),
  ADD KEY `FK_GAGNER_INDIVIDUEL_SPORTIF` (`NUM_LICENCE`);

--
-- Index pour la table `SPORT`
--
ALTER TABLE `SPORT`
  ADD PRIMARY KEY (`CODE_SPORT`);

--
-- Index pour la table `SPORTIF`
--
ALTER TABLE `SPORTIF`
  ADD PRIMARY KEY (`NUM_LICENCE`),
  ADD KEY `FK_SPORTIF_SPORT` (`CODE_SPORT`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `SPORT`
--
ALTER TABLE `SPORT`
  MODIFY `CODE_SPORT` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `APPARTENIR_EQUIPE`
--
ALTER TABLE `APPARTENIR_EQUIPE`
  ADD CONSTRAINT `FK_APPARTENIR_EQUIPE` FOREIGN KEY (`NUM_EQUIPE`) REFERENCES `EQUIPE` (`NUM_EQUIPE`),
  ADD CONSTRAINT `FK_APPARTENIR_SPORTIF` FOREIGN KEY (`NUM_LICENCE`) REFERENCES `SPORTIF` (`NUM_LICENCE`);

--
-- Contraintes pour la table `DISCIPLINE`
--
ALTER TABLE `DISCIPLINE`
  ADD CONSTRAINT `FK_DISCIPLINE_SPORT` FOREIGN KEY (`CODE_SPORT`) REFERENCES `SPORT` (`CODE_SPORT`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `GAGNER_COLLECTIF`
--
ALTER TABLE `GAGNER_COLLECTIF`
  ADD CONSTRAINT `FK_GAGNER_COLLECTIF` FOREIGN KEY (`NUM_EQUIPE`) REFERENCES `EQUIPE` (`NUM_EQUIPE`),
  ADD CONSTRAINT `FK_GAGNER_COLLECTIF_DISCIPLIN` FOREIGN KEY (`CODE_DISCIPLINE`) REFERENCES `DISCIPLINE` (`CODE_DISCIPLINE`);

--
-- Contraintes pour la table `GAGNER_INDIVIDUEL`
--
ALTER TABLE `GAGNER_INDIVIDUEL`
  ADD CONSTRAINT `FK_GAGNER_INDIVIDUEL_DISCIPLIN` FOREIGN KEY (`CODE_DISCIPLINE`) REFERENCES `DISCIPLINE` (`CODE_DISCIPLINE`),
  ADD CONSTRAINT `FK_GAGNER_INDIVIDUEL_SPORTIF` FOREIGN KEY (`NUM_LICENCE`) REFERENCES `SPORTIF` (`NUM_LICENCE`);

--
-- Contraintes pour la table `SPORTIF`
--
ALTER TABLE `SPORTIF`
  ADD CONSTRAINT `FK_SPORTIF_SPORT` FOREIGN KEY (`CODE_SPORT`) REFERENCES `SPORT` (`CODE_SPORT`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
