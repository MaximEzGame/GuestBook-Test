-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 07 2025 г., 17:23
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `guestbook`
--

-- --------------------------------------------------------

--
-- Структура таблицы `guests`
--

CREATE TABLE `guests` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `message` varchar(1024) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `author` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `guests`
--

INSERT INTO `guests` (`id`, `name`, `email`, `message`, `time`, `author`) VALUES
(165, 'Michael Walker', 'michael.walker@hotmail.com', 'Had a great time exploring the guestbook.', '2025-05-04 00:20:06', ''),
(166, 'Laura Davis', 'laura.davis@example.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-03 20:43:06', ''),
(167, 'Sophie Brown', 'sophie.brown@yahoo.com', 'Cool project, excited to see where it goes.', '2025-05-07 06:37:06', ''),
(168, 'David Wilson', 'david.wilson@gmail.com', 'Amazing experience, will definitely come back!', '2025-05-01 22:45:06', ''),
(169, 'John Wilson', 'john.wilson@yahoo.com', 'This is a fantastic way to connect with others.', '2025-05-01 18:12:06', ''),
(170, 'Laura Brown', 'laura.brown@test.com', 'Loving the design and functionality of this site!', '2025-05-05 07:41:06', ''),
(171, 'Michael Johnson', 'michael.johnson@test.com', 'Wonderful idea, happy to contribute a message!', '2025-04-30 22:31:06', ''),
(172, 'Emma Taylor', 'emma.taylor@test.com', 'Amazing experience, will definitely come back!', '2025-05-01 23:38:06', ''),
(173, 'Laura Brown', 'laura.brown@gmail.com', 'Thanks for the awesome platform, keep it up!', '2025-05-03 15:28:06', ''),
(174, 'Alex Harris', 'alex.harris@test.com', 'Loving the design and functionality of this site!', '2025-05-04 21:05:06', ''),
(175, 'Chris Walker', 'chris.walker@yahoo.com', 'Loving the design and functionality of this site!', '2025-05-05 15:37:06', ''),
(176, 'Julia Clark', 'julia.clark@gmail.com', 'Had a great time exploring the guestbook.', '2025-05-04 02:18:06', ''),
(177, 'David Smith', 'david.smith@gmail.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-02 11:00:06', ''),
(178, 'Alex Johnson', 'alex.johnson@example.com', 'Had a great time exploring the guestbook.', '2025-04-29 21:29:06', ''),
(179, 'Michael Harris', 'michael.harris@example.com', 'Had a great time exploring the guestbook.', '2025-05-01 12:36:06', ''),
(180, 'Chris Clark', 'chris.clark@test.com', 'Had a great time exploring the guestbook.', '2025-05-06 02:43:06', ''),
(181, 'Laura Walker', 'laura.walker@gmail.com', 'This is a fantastic way to connect with others.', '2025-05-07 06:43:06', ''),
(182, 'Alex Lewis', 'alex.lewis@gmail.com', 'Amazing experience, will definitely come back!', '2025-05-05 01:55:06', ''),
(183, 'Sophie Wilson', 'sophie.wilson@test.com', 'Had a great time exploring the guestbook.', '2025-05-04 06:57:06', ''),
(184, 'David Taylor', 'david.taylor@gmail.com', 'Amazing experience, will definitely come back!', '2025-04-30 22:47:06', ''),
(185, 'Emma Walker', 'emma.walker@gmail.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-06 02:19:06', ''),
(186, 'Emma Brown', 'emma.brown@yahoo.com', 'Just wanted to say hi and leave a note.', '2025-05-04 19:57:06', ''),
(187, 'Julia Smith', 'julia.smith@hotmail.com', 'Loving the design and functionality of this site!', '2025-05-02 10:15:06', ''),
(188, 'Chris Davis', 'chris.davis@yahoo.com', 'Just wanted to say hi and leave a note.', '2025-05-04 09:43:06', ''),
(189, 'Emma Harris', 'emma.harris@gmail.com', 'This is a fantastic way to connect with others.', '2025-04-30 05:28:06', ''),
(190, 'Julia Brown', 'julia.brown@example.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-04 16:04:06', ''),
(191, 'John Walker', 'john.walker@example.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-01 22:53:06', ''),
(192, 'Laura Davis', 'laura.davis@hotmail.com', 'Just wanted to say hi and leave a note.', '2025-05-03 06:24:06', ''),
(193, 'Julia Lewis', 'julia.lewis@gmail.com', 'Thanks for the awesome platform, keep it up!', '2025-05-06 16:35:06', ''),
(194, 'John Lewis', 'john.lewis@gmail.com', 'Loving the design and functionality of this site!', '2025-05-02 07:11:06', ''),
(195, 'Emma Wilson', 'emma.wilson@hotmail.com', 'Amazing experience, will definitely come back!', '2025-05-04 18:19:06', ''),
(196, 'Laura Johnson', 'laura.johnson@hotmail.com', 'Loving the design and functionality of this site!', '2025-05-02 07:06:06', ''),
(197, 'Sophie Harris', 'sophie.harris@hotmail.com', 'Loving the design and functionality of this site!', '2025-05-04 06:53:06', ''),
(198, 'Sophie Harris', 'sophie.harris@example.com', 'Had a great time exploring the guestbook.', '2025-05-02 16:25:06', ''),
(199, 'Laura Walker', 'laura.walker@hotmail.com', 'This is a fantastic way to connect with others.', '2025-05-07 00:47:06', ''),
(200, 'Chris Clark', 'chris.clark@test.com', 'Cool project, excited to see where it goes.', '2025-04-30 08:03:06', ''),
(201, 'Sophie Johnson', 'sophie.johnson@gmail.com', 'Thanks for the awesome platform, keep it up!', '2025-05-02 19:06:06', ''),
(202, 'Anna Johnson', 'anna.johnson@yahoo.com', 'Had a great time exploring the guestbook.', '2025-05-02 16:05:06', ''),
(204, 'David Clark', 'david.clark@test.com', 'Cool project, excited to see where it goes.', '2025-05-03 18:05:06', ''),
(205, 'Sophie Clark', 'sophie.clark@example.com', 'Thanks for the awesome platform, keep it up!', '2025-05-05 10:38:06', ''),
(206, 'Alex Wilson', 'alex.wilson@test.com', 'Wonderful idea, happy to contribute a message!', '2025-04-30 11:10:06', ''),
(207, 'Laura Harris', 'laura.harris@yahoo.com', 'Cool project, excited to see where it goes.', '2025-05-05 12:12:06', ''),
(208, 'Laura Brown', 'laura.brown@test.com', 'Had a great time exploring the guestbook.', '2025-05-02 09:23:06', ''),
(209, 'Chris Brown', 'chris.brown@test.com', 'Amazing experience, will definitely come back!', '2025-05-05 19:21:06', ''),
(210, 'Anna Lewis', 'anna.lewis@gmail.com', 'Loving the design and functionality of this site!', '2025-05-02 03:44:06', ''),
(211, 'John Johnson', 'john.johnson@example.com', 'Wonderful idea, happy to contribute a message!', '2025-05-03 09:51:06', ''),
(212, 'Michael Brown', 'michael.brown@gmail.com', 'Wonderful idea, happy to contribute a message!', '2025-05-06 07:30:06', ''),
(213, 'Sophie Johnson', 'sophie.johnson@test.com', 'Amazing experience, will definitely come back!', '2025-05-01 00:00:06', ''),
(214, 'Sophie Johnson', 'sophie.johnson@test.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-05 07:46:06', ''),
(215, 'Chris Davis', 'chris.davis@yahoo.com', 'This is a fantastic way to connect with others.', '2025-05-05 04:43:06', ''),
(216, 'David Clark', 'david.clark@gmail.com', 'Wonderful idea, happy to contribute a message!', '2025-04-30 16:03:06', ''),
(217, 'John Davis', 'john.davis@hotmail.com', 'Loving the design and functionality of this site!', '2025-05-04 11:28:06', ''),
(218, 'David Walker', 'david.walker@test.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-04 06:50:06', ''),
(219, 'Chris Wilson', 'chris.wilson@example.com', 'Wonderful idea, happy to contribute a message!', '2025-05-04 14:39:06', ''),
(220, 'Chris Walker', 'chris.walker@gmail.com', 'Cool project, excited to see where it goes.', '2025-04-30 09:46:06', ''),
(221, 'Anna Harris', 'anna.harris@test.com', 'Amazing experience, will definitely come back!', '2025-05-02 14:32:06', ''),
(222, 'David Davis', 'david.davis@hotmail.com', 'Wonderful idea, happy to contribute a message!', '2025-05-05 13:28:06', ''),
(223, 'Michael Wilson', 'michael.wilson@hotmail.com', 'Wonderful idea, happy to contribute a message!', '2025-05-01 08:06:06', ''),
(224, 'Emma Harris', 'emma.harris@example.com', 'Thanks for the awesome platform, keep it up!', '2025-05-01 13:03:06', ''),
(225, 'Anna Wilson', 'anna.wilson@yahoo.com', 'Thanks for making this, it\'s super user-friendly.', '2025-05-06 05:06:06', ''),
(226, 'Laura Walker', 'laura.walker@hotmail.com', 'Just wanted to say hi and leave a note.', '2025-05-06 15:27:06', ''),
(227, 'John Davis', 'john.davis@gmail.com', 'Amazing experience, will definitely come back!', '2025-05-06 02:43:06', ''),
(228, 'Anna Smith', 'anna.smith@example.com', 'This is a fantastic way to connect with others.', '2025-05-01 04:57:06', ''),
(229, 'Laura Johnson', 'laura.johnson@hotmail.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-05 13:14:06', ''),
(230, 'Anna Brown', 'anna.brown@gmail.com', 'Wonderful idea, happy to contribute a message!', '2025-05-05 04:24:06', ''),
(231, 'Julia Clark', 'julia.clark@hotmail.com', 'Amazing experience, will definitely come back!', '2025-05-07 02:09:06', ''),
(232, 'Alex Wilson', 'alex.wilson@test.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-04 22:07:06', ''),
(233, 'Chris Clark', 'chris.clark@example.com', 'Had a great time exploring the guestbook.', '2025-05-04 18:54:06', ''),
(235, 'Chris Johnson', 'chris.johnson@example.com', 'Wonderful idea, happy to contribute a message!', '2025-05-02 19:02:06', ''),
(236, 'Emma Lewis', 'emma.lewis@example.com', 'Amazing experience, will definitely come back!', '2025-05-03 06:13:06', ''),
(237, 'Laura Brown', 'laura.brown@gmail.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-06 21:07:06', ''),
(238, 'John Smith', 'john.smith@hotmail.com', 'Just wanted to say hi and leave a note.', '2025-04-30 22:27:06', ''),
(239, 'Michael Harris', 'michael.harris@gmail.com', 'This is a fantastic way to connect with others.', '2025-05-02 21:03:06', ''),
(240, 'Emma Wilson', 'emma.wilson@gmail.com', 'This is a fantastic way to connect with others.', '2025-05-01 07:26:06', ''),
(241, 'Anna Davis', 'anna.davis@test.com', 'Wonderful idea, happy to contribute a message!', '2025-05-05 22:33:06', ''),
(242, 'Chris Lewis', 'chris.lewis@hotmail.com', 'Had a great time exploring the guestbook.', '2025-05-06 22:14:06', ''),
(244, 'Emma Wilson', 'emma.wilson@gmail.com', 'This is a fantastic way to connect with others.', '2025-05-04 19:22:06', ''),
(245, 'Anna Walker', 'anna.walker@gmail.com', 'This is a fantastic way to connect with others.', '2025-05-06 08:43:06', ''),
(246, 'Sophie Wilson', 'sophie.wilson@test.com', 'Loving the design and functionality of this site!', '2025-05-03 01:32:06', ''),
(247, 'David Walker', 'david.walker@yahoo.com', 'This is a fantastic way to connect with others.', '2025-05-05 05:23:06', ''),
(248, 'Alex Smith', 'alex.smith@hotmail.com', 'Thanks for the awesome platform, keep it up!', '2025-05-04 16:56:06', ''),
(249, 'Michael Taylor', 'michael.taylor@hotmail.com', 'Just wanted to say hi and leave a note.', '2025-05-06 08:32:06', ''),
(250, 'Michael Brown', 'michael.brown@gmail.com', 'Wonderful idea, happy to contribute a message!', '2025-05-05 03:57:06', ''),
(251, 'Chris Johnson', 'chris.johnson@gmail.com', 'Amazing experience, will definitely come back!', '2025-05-02 14:11:06', ''),
(252, 'Chris Davis', 'chris.davis@test.com', 'Loving the design and functionality of this site!', '2025-04-30 08:38:06', ''),
(253, 'Julia Clark', 'julia.clark@gmail.com', 'Thanks for the awesome platform, keep it up!', '2025-05-04 03:04:06', ''),
(254, 'David Wilson', 'david.wilson@yahoo.com', 'Had a great time exploring the guestbook.', '2025-05-03 22:41:06', ''),
(255, 'Julia Walker', 'julia.walker@test.com', 'Thanks for making this, it\'s super user-friendly.', '2025-04-29 18:39:06', ''),
(256, 'Julia Johnson', 'julia.johnson@example.com', 'Wonderful idea, happy to contribute a message!', '2025-05-06 10:17:06', ''),
(257, 'Michael Clark', 'michael.clark@test.com', 'Cool project, excited to see where it goes.', '2025-05-04 04:59:06', ''),
(258, 'David Lewis', 'david.lewis@hotmail.com', 'Cool project, excited to see where it goes.', '2025-05-02 21:55:06', ''),
(259, 'Sophie Wilson', 'sophie.wilson@example.com', 'Cool project, excited to see where it goes.', '2025-05-06 23:13:06', ''),
(260, 'John Walker', 'john.walker@test.com', 'Amazing experience, will definitely come back!', '2025-05-02 08:56:06', ''),
(261, 'Michael Johnson', 'michael.johnson@hotmail.com', 'Great guestbook! Really enjoyed leaving a message here.', '2025-05-05 13:20:06', ''),
(262, 'Alex Smith', 'alex.smith@hotmail.com', 'This is a fantastic way to connect with others.', '2025-04-30 06:34:06', ''),
(263, 'Chris Davis', 'chris.davis@gmail.com', 'Thanks for making this, it\'s super user-friendly.', '2025-04-30 05:09:06', ''),
(264, 'Michael Harris', 'michael.harris@example.com', 'Amazing experience, will definitely come back!', '2025-05-05 18:45:06', ''),
(265, 'Maxim', 'ezgame092@icloud.com', 'Hello there', '2025-05-07 15:22:43', '');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `guests`
--
ALTER TABLE `guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=266;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
