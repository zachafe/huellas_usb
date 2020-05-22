-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-05-2020 a las 11:19:02
-- Versión del servidor: 5.7.30-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `USB_TEST`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ALUMNOS`
--

CREATE TABLE `ALUMNOS` (
  `ID` int(10) NOT NULL,
  `NOMBRES` varchar(200) NOT NULL,
  `APELLIDOS` varchar(100) NOT NULL,
  `SEXO` enum('M','F') NOT NULL,
  `FECHA_NACIMIENTO` date NOT NULL,
  `PROGRAMA` varchar(300) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ALUMNOS`
--

INSERT INTO `ALUMNOS` (`ID`, `NOMBRES`, `APELLIDOS`, `SEXO`, `FECHA_NACIMIENTO`, `PROGRAMA`) VALUES
(1, 'ANDRÉS FELIPE', 'QUINTERO TORIJANO', 'M', '1989-01-18', 'MAESTRÍA EN INGENIERÍA DE SOFTWARE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `FELIPE`
--

CREATE TABLE `FELIPE` (
  `ID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PROFESORES`
--

CREATE TABLE `PROFESORES` (
  `ID` int(10) NOT NULL,
  `NOMBRE` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PRUEBA2`
--

CREATE TABLE `PRUEBA2` (
  `ID` int(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PRUEBA3`
--

CREATE TABLE `PRUEBA3` (
  `ID` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PRUEBA_`
--

CREATE TABLE `PRUEBA_` (
  `ID` int(10) NOT NULL,
  `PRUEBA` varchar(300) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ALUMNOS`
--
ALTER TABLE `ALUMNOS`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ALUMNOS`
--
ALTER TABLE `ALUMNOS`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
