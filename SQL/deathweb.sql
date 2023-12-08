-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 06, 2023 at 10:22 AM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deathweb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `ckey` varchar(255) NOT NULL,
  `rank` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `adminsfarweb`
--

CREATE TABLE `adminsfarweb` (
  `ckey` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `ckey` varchar(255) NOT NULL,
  `computerid` text NOT NULL,
  `ips` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `bannedby` varchar(255) NOT NULL,
  `temp` int(1) NOT NULL COMMENT '0 = perma ban / minutes banned',
  `minute` int(255) NOT NULL DEFAULT '0',
  `timebanned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bansfarweb`
--

CREATE TABLE `bansfarweb` (
  `ckey` varchar(30) NOT NULL,
  `reason` text NOT NULL,
  `adminckey` varchar(30) NOT NULL,
  `isbanned` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `booklog`
--

CREATE TABLE `booklog` (
  `ckey` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'INSERT',
  `title` text NOT NULL,
  `author` varchar(256) NOT NULL,
  `text` longtext NOT NULL,
  `cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `text` longtext NOT NULL,
  `cat` int(2) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `changelog`
--

CREATE TABLE `changelog` (
  `id` int(11) NOT NULL,
  `bywho` varchar(255) NOT NULL,
  `changes` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comradelist`
--

CREATE TABLE `comradelist` (
  `ckey` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE `config` (
  `motd` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_30cm`
--

CREATE TABLE `donation_30cm` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_baliset`
--

CREATE TABLE `donation_baliset` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_crusader`
--

CREATE TABLE `donation_crusader` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_customooccolorlist`
--

CREATE TABLE `donation_customooccolorlist` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_futa`
--

CREATE TABLE `donation_futa` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `donation_futa`
--

INSERT INTO `donation_futa` (`ckey`) VALUES
('lyoll');

-- --------------------------------------------------------

--
-- Table structure for table `donation_lord`
--

CREATE TABLE `donation_lord` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_luxurydonation`
--

CREATE TABLE `donation_luxurydonation` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_mercenary_donor`
--

CREATE TABLE `donation_mercenary_donor` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_mobilephone`
--

CREATE TABLE `donation_mobilephone` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_monk`
--

CREATE TABLE `donation_monk` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_outlaw`
--

CREATE TABLE `donation_outlaw` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_pjack`
--

CREATE TABLE `donation_pjack` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_reddawn_merc`
--

CREATE TABLE `donation_reddawn_merc` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_remigrator`
--

CREATE TABLE `donation_remigrator` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_seaspotter_merc`
--

CREATE TABLE `donation_seaspotter_merc` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_squire_donor`
--

CREATE TABLE `donation_squire_donor` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_tophat`
--

CREATE TABLE `donation_tophat` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_trapapoc`
--

CREATE TABLE `donation_trapapoc` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_tribvet_donor`
--

CREATE TABLE `donation_tribvet_donor` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_urchin_donor`
--

CREATE TABLE `donation_urchin_donor` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_waterbottledonation`
--

CREATE TABLE `donation_waterbottledonation` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `donation_weedonator`
--

CREATE TABLE `donation_weedonator` (
  `ckey` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `erro_admin`
--

CREATE TABLE `erro_admin` (
  `id` int(11) NOT NULL,
  `ckey` varchar(32) NOT NULL,
  `rank` varchar(32) NOT NULL DEFAULT 'Administrator',
  `flags` int(16) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `erro_admin`
--

INSERT INTO `erro_admin` (`id`, `ckey`, `rank`, `flags`) VALUES
(1, 'lyoll', 'Enoch', 0);

-- --------------------------------------------------------

--
-- Table structure for table `erro_admin_log`
--

CREATE TABLE `erro_admin_log` (
  `id` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `adminckey` varchar(32) NOT NULL,
  `adminip` varchar(18) NOT NULL,
  `log` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `erro_admin_ranks`
--

CREATE TABLE `erro_admin_ranks` (
  `id` int(11) NOT NULL,
  `rank` varchar(40) NOT NULL,
  `flags` int(16) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `erro_ban`
--

CREATE TABLE `erro_ban` (
  `id` int(11) NOT NULL,
  `bantime` datetime NOT NULL,
  `serverip` varchar(32) NOT NULL,
  `bantype` varchar(32) NOT NULL,
  `reason` text NOT NULL,
  `job` varchar(32) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `rounds` int(11) DEFAULT NULL,
  `expiration_time` datetime NOT NULL,
  `ckey` varchar(32) NOT NULL,
  `computerid` varchar(32) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `a_ckey` varchar(32) NOT NULL,
  `a_computerid` varchar(32) NOT NULL,
  `a_ip` varchar(32) NOT NULL,
  `who` text NOT NULL,
  `adminwho` text NOT NULL,
  `edits` text,
  `unbanned` tinyint(1) DEFAULT NULL,
  `unbanned_datetime` datetime DEFAULT NULL,
  `unbanned_ckey` varchar(32) DEFAULT NULL,
  `unbanned_computerid` varchar(32) DEFAULT NULL,
  `unbanned_ip` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `erro_feedback`
--

CREATE TABLE `erro_feedback` (
  `id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `round_id` int(8) NOT NULL,
  `var_name` varchar(32) NOT NULL,
  `var_value` int(16) DEFAULT NULL,
  `details` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `erro_library`
--

CREATE TABLE `erro_library` (
  `id` int(11) NOT NULL,
  `author` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `category` varchar(45) NOT NULL,
  `ckey` varchar(45) DEFAULT 'LEGACY',
  `datetime` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `erro_player`
--

CREATE TABLE `erro_player` (
  `id` int(11) NOT NULL,
  `ckey` varchar(32) NOT NULL,
  `firstseen` datetime NOT NULL,
  `lastseen` datetime NOT NULL,
  `ip` varchar(18) NOT NULL,
  `computerid` varchar(32) NOT NULL,
  `lastadminrank` varchar(32) NOT NULL DEFAULT 'Player'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `erro_player`
--

INSERT INTO `erro_player` (`id`, `ckey`, `firstseen`, `lastseen`, `ip`, `computerid`, `lastadminrank`) VALUES
(1, 'lyoll', '2023-10-12 09:22:17', '2023-12-06 11:56:07', '127.0.0.1', '1173822351', 'Enoch'),
(2, 'lyolltest', '2023-10-14 09:53:42', '2023-12-06 11:55:14', '127.0.0.1', '1173822351', 'Player'),
(3, 'lyolldev', '2023-10-16 10:26:05', '2023-10-16 10:41:35', '127.0.0.1', '1173822351', 'Player');

-- --------------------------------------------------------

--
-- Table structure for table `jobban`
--

CREATE TABLE `jobban` (
  `ckey` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jobbanlog`
--

CREATE TABLE `jobbanlog` (
  `ckey` varchar(255) NOT NULL COMMENT 'By who',
  `targetckey` varchar(255) NOT NULL COMMENT 'Target',
  `rank` varchar(255) NOT NULL COMMENT 'rank',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'when',
  `why` varchar(355) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `medals`
--

CREATE TABLE `medals` (
  `ckey` varchar(255) NOT NULL,
  `medal` text NOT NULL,
  `medaldesc` text NOT NULL,
  `medaldiff` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pigpluslist`
--

CREATE TABLE `pigpluslist` (
  `ckey` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `ckey` varchar(255) NOT NULL,
  `slot` int(2) NOT NULL DEFAULT '1',
  `slotname` varchar(255) NOT NULL DEFAULT 'Default',
  `real_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `occupation1` varchar(255) NOT NULL,
  `occupation2` varchar(255) NOT NULL,
  `occupation3` varchar(255) NOT NULL,
  `hair_red` int(3) NOT NULL,
  `hair_green` int(3) NOT NULL,
  `hair_blue` int(3) NOT NULL,
  `ages` int(3) NOT NULL,
  `facial_red` int(3) NOT NULL,
  `facial_green` int(3) NOT NULL,
  `facial_blue` int(3) NOT NULL,
  `skin_tone` int(3) NOT NULL,
  `hair_style_name` varchar(255) NOT NULL,
  `facial_style_name` varchar(255) NOT NULL,
  `eyes_red` int(3) NOT NULL,
  `eyes_green` int(3) NOT NULL,
  `eyes_blue` int(3) NOT NULL,
  `blood_type` varchar(3) NOT NULL,
  `be_syndicate` int(3) NOT NULL,
  `underwear` int(3) NOT NULL,
  `name_is_always_random` int(3) NOT NULL,
  `bios` longtext NOT NULL,
  `show` int(1) NOT NULL DEFAULT '1',
  `be_nuke_agent` tinyint(1) NOT NULL,
  `be_takeover_agent` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `playersfarweb`
--

CREATE TABLE `playersfarweb` (
  `ckey` char(30) NOT NULL,
  `firstseen` datetime DEFAULT NULL,
  `lastseen` datetime DEFAULT NULL,
  `invitedby` char(30) DEFAULT NULL,
  `invitecount` smallint(6) NOT NULL DEFAULT '0',
  `reason` longtext,
  `chromosomes` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reputation`
--

CREATE TABLE `reputation` (
  `ckey` varchar(30) DEFAULT NULL,
  `giver_ckey` varchar(30) DEFAULT NULL,
  `value` tinyint(1) DEFAULT NULL,
  `reason` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE `stories` (
  `storyid` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`storyid`) VALUES
(65);

-- --------------------------------------------------------

--
-- Table structure for table `traitorlogs`
--

CREATE TABLE `traitorlogs` (
  `CKey` varchar(128) NOT NULL,
  `Objective` text NOT NULL,
  `Succeeded` tinyint(4) NOT NULL,
  `Spawned` text NOT NULL,
  `Occupation` varchar(128) NOT NULL,
  `PlayerCount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `unbans`
--

CREATE TABLE `unbans` (
  `ckey` varchar(255) NOT NULL,
  `computerid` text NOT NULL,
  `ips` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `bannedby` varchar(255) NOT NULL,
  `temp` int(255) NOT NULL COMMENT '0 = perma ban / minutes banned',
  `minutes` int(255) NOT NULL,
  `timebanned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `villainlist`
--

CREATE TABLE `villainlist` (
  `ckey` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`ckey`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`ckey`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `changelog`
--
ALTER TABLE `changelog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_admin`
--
ALTER TABLE `erro_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_admin_log`
--
ALTER TABLE `erro_admin_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_admin_ranks`
--
ALTER TABLE `erro_admin_ranks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_ban`
--
ALTER TABLE `erro_ban`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_feedback`
--
ALTER TABLE `erro_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_library`
--
ALTER TABLE `erro_library`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erro_player`
--
ALTER TABLE `erro_player`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ckey` (`ckey`);

--
-- Indexes for table `jobban`
--
ALTER TABLE `jobban`
  ADD UNIQUE KEY `NODUPES` (`ckey`(100),`rank`(100));

--
-- Indexes for table `jobbanlog`
--
ALTER TABLE `jobbanlog`
  ADD UNIQUE KEY `targetckey` (`targetckey`(100),`rank`(100));

--
-- Indexes for table `medals`
--
ALTER TABLE `medals`
  ADD UNIQUE KEY `NODUPES` (`ckey`,`medal`(8));

--
-- Indexes for table `playersfarweb`
--
ALTER TABLE `playersfarweb`
  ADD PRIMARY KEY (`ckey`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `changelog`
--
ALTER TABLE `changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_admin`
--
ALTER TABLE `erro_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `erro_admin_log`
--
ALTER TABLE `erro_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_admin_ranks`
--
ALTER TABLE `erro_admin_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_ban`
--
ALTER TABLE `erro_ban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_feedback`
--
ALTER TABLE `erro_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_library`
--
ALTER TABLE `erro_library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `erro_player`
--
ALTER TABLE `erro_player`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
