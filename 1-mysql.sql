-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 13 2022 г., 00:37
-- Версия сервера: 5.7.33-log
-- Версия PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id_client` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id_client`, `first_name`, `last_name`, `second_name`, `phone`, `email`) VALUES
(1, 'Иван', 'Петров', 'Иванович', '+7 (901) 203-12-20', 'person.mail@gmail.con'),
(2, 'Семен', 'Тютиков', 'Степанович', '8999999999', 'test@mail.ru'),
(3, 'Николай', 'Тихонов', 'Олегович', '899999999', 'a@mail.com');

-- --------------------------------------------------------

--
-- Структура таблицы `pasport`
--

CREATE TABLE `pasport` (
  `id_pasport` int(11) UNSIGNED NOT NULL,
  `Series` int(4) DEFAULT NULL,
  `Number` int(6) DEFAULT NULL,
  `DateOfIssue` date DEFAULT NULL,
  `ConfirmationCode` int(11) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `issued_by` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place_of_birth` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_region_of_registration` int(11) UNSIGNED NOT NULL,
  `id_client` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `pasport`
--

INSERT INTO `pasport` (`id_pasport`, `Series`, `Number`, `DateOfIssue`, `ConfirmationCode`, `DateOfBirth`, `issued_by`, `place_of_birth`, `id_region_of_registration`, `id_client`) VALUES
(2, 1945, 300122, '2020-02-01', 123012, '1990-01-01', 'МВД', 'Новосибирск', 1, 1),
(3, 1234, 123456, '2018-08-08', 123123, '1989-05-02', 'ФМС', 'Москва', 2, 2),
(4, 1987, 300998, '2022-08-09', 789456, '2013-08-01', 'МФЦ', 'Санкт-Петербург', 2, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id_product` int(11) UNSIGNED NOT NULL,
  `Name_product` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id_product`, `Name_product`) VALUES
(1, 'Кредит наличными'),
(2, 'Ипотечный кредит'),
(3, 'Автокредит');

-- --------------------------------------------------------

--
-- Структура таблицы `region_of_registration`
--

CREATE TABLE `region_of_registration` (
  `id_region_of_registration` int(11) UNSIGNED NOT NULL,
  `Name_region_of_registration` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `region_of_registration`
--

INSERT INTO `region_of_registration` (`id_region_of_registration`, `Name_region_of_registration`) VALUES
(1, 'Новосибирская область'),
(2, 'Московская область');

-- --------------------------------------------------------

--
-- Структура таблицы `region_of_work`
--

CREATE TABLE `region_of_work` (
  `id_region_of_work` int(11) UNSIGNED NOT NULL,
  `name_region_of_work` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `region_of_work`
--

INSERT INTO `region_of_work` (`id_region_of_work`, `name_region_of_work`) VALUES
(1, 'Новосибирская область'),
(2, 'Ленинградская область');

-- --------------------------------------------------------

--
-- Структура таблицы `request`
--

CREATE TABLE `request` (
  `id_request` int(11) UNSIGNED NOT NULL,
  `Sum` float NOT NULL,
  `Bet_size` float NOT NULL,
  `id_target` int(11) UNSIGNED NOT NULL,
  `id_product` int(11) UNSIGNED NOT NULL,
  `Loan_amount_including_services` float DEFAULT NULL,
  `credit_term` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_client` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `request`
--

INSERT INTO `request` (`id_request`, `Sum`, `Bet_size`, `id_target`, `id_product`, `Loan_amount_including_services`, `credit_term`, `created_at`, `id_client`) VALUES
(2, 100000, 7.7, 1, 1, 140000, 36, '2022-08-11 20:15:53', 1),
(3, 150000, 7.7, 2, 1, 150000, 36, '2022-08-11 20:15:53', 2),
(4, 100000, 7.7, 2, 2, 140000, 36, '2022-08-11 20:15:53', 3),
(5, 100000, 7.7, 2, 1, 140000, 36, '2022-08-11 20:15:53', 2),
(6, 150000, 7.7, 2, 3, 150000, 36, '2021-08-11 20:15:53', 1),
(7, 100000, 7.7, 1, 3, 140000, 36, '2022-08-11 20:15:53', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `request_services`
--

CREATE TABLE `request_services` (
  `id_request` int(11) UNSIGNED NOT NULL,
  `id_services` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `request_services`
--

INSERT INTO `request_services` (`id_request`, `id_services`) VALUES
(1, 1),
(1, 2),
(3, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `services`
--

CREATE TABLE `services` (
  `id_services` int(11) UNSIGNED NOT NULL,
  `Name_services` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `services`
--

INSERT INTO `services` (`id_services`, `Name_services`, `Price`) VALUES
(1, 'Страхование жизни', 25000),
(2, 'Юридическая помощь', 15000);

-- --------------------------------------------------------

--
-- Структура таблицы `target`
--

CREATE TABLE `target` (
  `id_target` int(11) UNSIGNED NOT NULL,
  `Name_target` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `target`
--

INSERT INTO `target` (`id_target`, `Name_target`) VALUES
(1, 'Покупка товаров / услуг'),
(2, 'Оплата лечения');

-- --------------------------------------------------------

--
-- Структура таблицы `work`
--

CREATE TABLE `work` (
  `id_work` int(11) UNSIGNED NOT NULL,
  `INN` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Salary` float NOT NULL,
  `Start_date` date NOT NULL,
  `name_job_title` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_organization` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_region_of_work` int(11) UNSIGNED NOT NULL,
  `id_client` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `work`
--

INSERT INTO `work` (`id_work`, `INN`, `Salary`, `Start_date`, `name_job_title`, `name_organization`, `id_region_of_work`, `id_client`) VALUES
(1, '7149913174', 35000, '2019-01-01', 'Специалист', 'ООО \"Рога и копыта\"', 1, 1),
(2, '7149916598', 60000, '2020-08-21', 'Слесарь', 'АО \"Ромашка\"', 2, 2),
(3, '7149913165', 50000.3, '2013-08-15', 'Специалист', 'АО \"Ромашка\"', 2, 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`);

--
-- Индексы таблицы `pasport`
--
ALTER TABLE `pasport`
  ADD PRIMARY KEY (`id_pasport`),
  ADD KEY `id_region_of_registration` (`id_region_of_registration`),
  ADD KEY `id_client` (`id_client`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_product`);

--
-- Индексы таблицы `region_of_registration`
--
ALTER TABLE `region_of_registration`
  ADD PRIMARY KEY (`id_region_of_registration`);

--
-- Индексы таблицы `region_of_work`
--
ALTER TABLE `region_of_work`
  ADD PRIMARY KEY (`id_region_of_work`);

--
-- Индексы таблицы `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id_request`),
  ADD KEY `id_product` (`id_product`),
  ADD KEY `id_target` (`id_target`),
  ADD KEY `id_client` (`id_client`);

--
-- Индексы таблицы `request_services`
--
ALTER TABLE `request_services`
  ADD KEY `id_request` (`id_request`),
  ADD KEY `id_services` (`id_services`);

--
-- Индексы таблицы `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id_services`);

--
-- Индексы таблицы `target`
--
ALTER TABLE `target`
  ADD PRIMARY KEY (`id_target`);

--
-- Индексы таблицы `work`
--
ALTER TABLE `work`
  ADD PRIMARY KEY (`id_work`),
  ADD KEY `id_region_of_work` (`id_region_of_work`),
  ADD KEY `id_client` (`id_client`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `pasport`
--
ALTER TABLE `pasport`
  MODIFY `id_pasport` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id_product` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `region_of_registration`
--
ALTER TABLE `region_of_registration`
  MODIFY `id_region_of_registration` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `region_of_work`
--
ALTER TABLE `region_of_work`
  MODIFY `id_region_of_work` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `request`
--
ALTER TABLE `request`
  MODIFY `id_request` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `services`
--
ALTER TABLE `services`
  MODIFY `id_services` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `target`
--
ALTER TABLE `target`
  MODIFY `id_target` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `work`
--
ALTER TABLE `work`
  MODIFY `id_work` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `pasport`
--
ALTER TABLE `pasport`
  ADD CONSTRAINT `pasport_ibfk_2` FOREIGN KEY (`id_region_of_registration`) REFERENCES `region_of_registration` (`id_region_of_registration`),
  ADD CONSTRAINT `pasport_ibfk_4` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`);

--
-- Ограничения внешнего ключа таблицы `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`id_target`) REFERENCES `target` (`id_target`),
  ADD CONSTRAINT `request_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`);

--
-- Ограничения внешнего ключа таблицы `request_services`
--
ALTER TABLE `request_services`
  ADD CONSTRAINT `request_services_ibfk_1` FOREIGN KEY (`id_request`) REFERENCES `request` (`id_request`),
  ADD CONSTRAINT `request_services_ibfk_2` FOREIGN KEY (`id_services`) REFERENCES `services` (`id_services`);

--
-- Ограничения внешнего ключа таблицы `work`
--
ALTER TABLE `work`
  ADD CONSTRAINT `work_ibfk_2` FOREIGN KEY (`id_region_of_work`) REFERENCES `region_of_work` (`id_region_of_work`),
  ADD CONSTRAINT `work_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
