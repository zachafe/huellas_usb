-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-05-2020 a las 11:18:07
-- Versión del servidor: 5.7.30-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `USB_APP`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `COMMANDS`
--

CREATE TABLE `COMMANDS` (
  `ID` int(11) NOT NULL,
  `METHOD` varchar(100) NOT NULL,
  `OBJET` varchar(100) NOT NULL,
  `LOG` int(1) NOT NULL DEFAULT '0',
  `ROOT` varchar(100) NOT NULL,
  `OPERATOR` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `COMMANDS`
--

INSERT INTO `COMMANDS` (`ID`, `METHOD`, `OBJET`, `LOG`, `ROOT`, `OPERATOR`) VALUES
(1, 'registerDba', 'menu', 0, '1', '0'),
(2, 'createDba', 'dbaUser', 1, '1', '0'),
(3, 'listDba', 'menu', 0, '1', '1'),
(4, 'listDba', 'dbaUser', 0, '1', '1'),
(5, 'viewDba', 'dbaUser', 0, '1', '1'),
(6, 'editDba', 'dbaUser', 0, '1', '0'),
(7, 'editDbaSet', 'dbaUser', 1, '1', '0'),
(8, 'createFootprint', 'menu', 0, '1', '1'),
(9, 'generarHuella', 'footPrint', 1, '1', '1'),
(10, 'listFootPrint', 'menu', 0, '1', '1'),
(11, 'listFootPrint', 'footPrint', 0, '1', '1'),
(12, 'viewFootprint', 'footPrint', 0, '1', '1'),
(13, 'compareFootprint', 'footPrint', 0, '1', '1'),
(14, 'compareFootprintSystem', 'footPrint', 0, '1', '1'),
(15, 'compareFootprintOther', 'footPrint', 0, '1', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DBA`
--

CREATE TABLE `DBA` (
  `ID_DBA` int(10) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `IP` varchar(100) NOT NULL,
  `USER` varchar(100) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `TYPE` enum('MYSQL','ORACLE','POSTGRE') NOT NULL,
  `CREATION_DATE` datetime NOT NULL,
  `CREATED_BY` int(10) NOT NULL,
  `MODIFIED_DATE` datetime DEFAULT NULL,
  `MODIFIED_BY` int(10) DEFAULT NULL,
  `OBSERVATION` varchar(300) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `DBA`
--

INSERT INTO `DBA` (`ID_DBA`, `NAME`, `IP`, `USER`, `PASSWORD`, `TYPE`, `CREATION_DATE`, `CREATED_BY`, `MODIFIED_DATE`, `MODIFIED_BY`, `OBSERVATION`) VALUES
(1, 'USB_APP', '127.0.0.1', 'root', 'felipe', 'MYSQL', '2020-05-18 00:00:00', 1, '2020-05-18 18:01:18', 1, 'Prueba de modificacion'),
(4, 'sakila', '127.0.0.1', 'root', 'felipe', 'MYSQL', '2020-05-18 18:05:52', 1, '2020-05-19 19:33:59', 2, 'sakila dba example modify'),
(5, 'USB_TEST', '127.0.0.1', 'root', 'felipe', 'MYSQL', '2020-05-18 19:33:54', 1, '2020-05-19 12:25:58', 2, 'DBA DE PRUEBAS PARA PINTAR'),
(6, 'medicalgroup', '127.0.0.1', 'root', 'felipe', 'MYSQL', '2020-05-19 19:44:03', 2, '2020-05-19 19:44:21', 2, 'dba medicalgroup');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `FOOTPRINT`
--

CREATE TABLE `FOOTPRINT` (
  `ID_FOOTPRINT` int(10) NOT NULL,
  `FK_DBA` int(10) NOT NULL,
  `FOOTPRINT` text NOT NULL,
  `CREATION_DATE` datetime NOT NULL,
  `CREATED_BY` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `FOOTPRINT`
--

INSERT INTO `FOOTPRINT` (`ID_FOOTPRINT`, `FK_DBA`, `FOOTPRINT`, `CREATION_DATE`, `CREATED_BY`) VALUES
(1, 4, '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[{\"TRIGGER_NAME\":\"customer_create_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"4c3df3d9338e3a1385a0b01f646ba06e59516765dffbd67c70c3315c64bf16e4\"},{\"TRIGGER_NAME\":\"ins_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"bb30d5b2eb2dca7cd5c4648de45efc67c40050f1292c3e5061a21ab24b36e0f9\"},{\"TRIGGER_NAME\":\"upd_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"cc76c81e37c38b5b850f85dbf6020c44f30330c7999604b75f026bc9acea7dc8\"},{\"TRIGGER_NAME\":\"del_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"6ca599ec1590f87594a3a141589779bd78aff568bea6391d114624edd61e1d33\"},{\"TRIGGER_NAME\":\"payment_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"88f2157f558e0f046afbe9b039e62a52987091acb5b3d340d1d2f25fea2561a4\"},{\"TRIGGER_NAME\":\"rental_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"2c2ddccbcf1abba04da4e413fabb8aa8154a41ef17af30a42f612f96fc707140\"}],\"vistas\":[{\"TABLE_NAME\":\"actor_info\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"e7e3be6dd6002a306af81d575d55cb74520c3838600f01dba1a4d9145cd66fe0\"},{\"TABLE_NAME\":\"customer_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"8849ae7eeee34f679bc5b49a89ca993bc840c41f2040556593c61050d9a001cd\"},{\"TABLE_NAME\":\"film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"d2d0fd45fb66a1ccbea92ae6f4aa13be4fb4c09ef447624862136b6cb79a13f9\"},{\"TABLE_NAME\":\"nicer_but_slower_film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"7f5ed6f4020cf6bb56ecb615d0b20b177a67b05d4fa4e999b09ab812590a928c\"},{\"TABLE_NAME\":\"sales_by_film_category\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"54e28e68a0f5aad5162c7a58281271fb981f8290d8c918bfdb8ac6d2b5a0162d\"},{\"TABLE_NAME\":\"sales_by_store\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"5fcfe25642607a17eaed01052155175b85194867c8214fbbf435b636790ad9d7\"},{\"TABLE_NAME\":\"staff_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4c026812a0c246a222af9bb81ce1151ed90299ccb2bbabf5675fb1868949d2bb\"}],\"rutinas\":[{\"ROUTINE_NAME\":\"film_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"758ace6e48851ac7e8fa197dafc91b01fc19ca90c916e460e285283be01be2f0\"},{\"ROUTINE_NAME\":\"film_not_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"5bffa595786d200b1e17c5d6b2fa54c629b7aef49320aaba64d4021819ddecc3\"},{\"ROUTINE_NAME\":\"get_customer_balance\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"fb04357e3da67a646374e344faff48964263a08c4cfae30d7bf1953fa2f5831b\"},{\"ROUTINE_NAME\":\"inventory_held_by_customer\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"2d52a630a6dcb704eaa0143b07c7e59b8cbd0abfd8cd4857bc5247a0a1d69ffb\"},{\"ROUTINE_NAME\":\"inventory_in_stock\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"0a69d2b6f90867b972211c35df2de5fd70b30aaf6c9125695872ab0d43856d41\"},{\"ROUTINE_NAME\":\"rewards_report\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"e3f2e939c1c200d1a1ca6e7b966bb1b26aa79de9a00edc8e1a81ed425608bd59\"}],\"tablas\":[{\"TABLA\":\"actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"64e30f8f4b4767b8c874eb59aa327ee5b7d0298e8ed4d5ff5097dcaca078e549\"},{\"TABLA\":\"address\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55d70d8d8e4abdc9a32fb07e4c2d915380b7ff0a447d9a233efd77ecd4c664a3\"},{\"TABLA\":\"category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7b4c051a97367cde16b9805eceea9efecd076548311e2478f1e7d669eaf10423\"},{\"TABLA\":\"city\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7a1564fe4776e46601d1b999254c8e833ca00b42c5c7970240f99bf7ebb94af4\"},{\"TABLA\":\"country\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"f671691d766b7b2e1850bd277d46b27eafd6580591367cffcfb6acd587508fe3\"},{\"TABLA\":\"customer\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"abd8bf20cbc525ca6eb5c7fcb5625cfa65ed78da2f1fac0ba66faa8a3321376a\"},{\"TABLA\":\"film\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"18e19a0440d1f26a3d9fb986f2564bc41a075aa4a0a48b9bc7413f95176d7557\"},{\"TABLA\":\"film_actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4dd791e74094b745da1f715764a4c72fb6b4ee51c366f9a7e8ce5415bd63338a\"},{\"TABLA\":\"film_category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5cc66864dea047c52d33fb82bf174ac02f355d080b810839ad0278412a0ba727\"},{\"TABLA\":\"film_text\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ffa1651ee9492b5101e2f547c0a261c82538f2c0e1cbc059d293e7442671e9d4\"},{\"TABLA\":\"inventory\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"d2d8dc9a66c3f43e28bf188f26ee8a82f6ed1bf93f6824b058a13706134b47c1\"},{\"TABLA\":\"language\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86aef5617792760fe91cad508ce815e0768fbf97aa7e692bd5ac048d3da63754\"},{\"TABLA\":\"payment\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"28f7d097848034b5dc8f1bcb95c01250f49b6bfe6dcc2def96dc37d7087ddf40\"},{\"TABLA\":\"rental\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a6870cf51509c29561546e5568b7bd1517729be0722eb35becff344580983509\"},{\"TABLA\":\"staff\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"449dee08c772b52403c28b40bc6ce634abcd7026ccfb973ad39372a9e4a06697\"},{\"TABLA\":\"store\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4670f8a49421c3eeaf17dd72181c3f7cf995c39f24b0d8b1b3d66d9c1f670da8\"}]}}', '2020-05-20 11:34:40', 1),
(2, 5, '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"ALUMNOS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55b2efa18323d059450dfad225081ee98f084de81307f34270a9a0074aa3cb7b\"},{\"TABLA\":\"PROFESORES\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"910548e378257e3995a6c9871122d6803a1ba8056a049fe895d30c985358d033\"},{\"TABLA\":\"PRUEBA\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4c56085ca7560e8595a5dc7572711ac4c9d062526c914692ba708db2e964afb2\"}]}}', '2020-05-20 11:35:22', 1),
(3, 6, '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"COMMANDS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"c284de460a97c5b3895e6f65a0b9ab08b13801e24ec7132550fec85eafef69b1\"},{\"TABLA\":\"atributos_estados\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86e39ff89e2e8eb6cccc2c1f40d98f0a7f1e614777ff55ed1bc83f8739a2f33c\"},{\"TABLA\":\"convenio\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a24ac38448bb3b14a9e588bbbec1d06540a3e4222e21e554abf7f26ab0d30f85\"},{\"TABLA\":\"diagnostico_cie10\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"e9ba361992aa227eac9ee9ef082e7ad3f8a79d8a240055753e4033cd0b4fa594\"},{\"TABLA\":\"empleados\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"6213b2677afeaf223e1c1d58b87cca41ce2f7bb8e8a8ffd5c36ffe5d9ebd7bda\"},{\"TABLA\":\"empleados_historicos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"94deb5c857ddf930947bd61d39a34e3d62fc542862cbdcada2f6e2501aebb33e\"},{\"TABLA\":\"encuesta\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ba20c26cb8b4cd0a513c51a7c449ce0aa657a5c03237286f880fddd6b32f70a7\"},{\"TABLA\":\"insumos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"11755575b3636e4f18d2792e2f40006bc14091bc490af3a1cefed8d579b0df97\"},{\"TABLA\":\"ot\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"fc7890f11b445e16b2e9bc32edf04f2eff55aed00a8466d1c711d81cc0ff8d8c\"},{\"TABLA\":\"ot_trayectos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"588cbbe8c28f17f9ec4241bc13d6d87498e25c4c00f56ceadbb926a030a1a1c5\"},{\"TABLA\":\"ot_trayectos_finish\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ef4a8598833fac2dc857a7fd05919e6abfee4efca1018140b2444b7cdfd90cd0\"},{\"TABLA\":\"ot_trayectos_historico\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"bbf3b1db9156d6abd0f4d7788cceeb116c3d002cee12ccd5bbce3636d428c145\"},{\"TABLA\":\"ot_trayectos_insumo\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"fd93e85c19e1d668e782f74a8cca2cd266436d075ab1857cbab37b942429e0b0\"},{\"TABLA\":\"pacientes\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ad65160fc636a248e5372e0597aed54041d0fb762fc933fb2d59b67812af7853\"},{\"TABLA\":\"pacientes_historicos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"34c5e580323d7950e3888902ed9f5a4ec293bf03fce3aa9ba14341e5f058d01c\"},{\"TABLA\":\"perfil\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5c6905fff35ba13c5e7d01c0d1c84801d4c8ab83c5e97122f7b4a65598dedbec\"},{\"TABLA\":\"select_ciudad\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"38f313883446aea81092f373a71724428761980af63796e60aa33906b8aab930\"},{\"TABLA\":\"select_departamento\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"bfb1398773bd198318e56448a2b84c6a3900cedf9f84c199f2923a9b3d734d66\"},{\"TABLA\":\"tipo_traslado\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"69c0d46b97cd7a5e3ee36bd59b8f7fda8234abd301a501f9f77ef0d7bc0c6395\"},{\"TABLA\":\"tipo_traslado_2\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4c3da0608ee985542f88880f05819cf3628e4af44b7f8437aefdd9238be7472f\"},{\"TABLA\":\"usuarios\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"011d33e4cf7835036179bd3d166497fc504e82b4dca82c3c8560a0baa5e50724\"},{\"TABLA\":\"vehiculo\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"411ed584976dec438f10bc2014616d810e15c19534c2ec9f7e4041e28644ad55\"}]}}', '2020-05-20 11:35:46', 1),
(4, 5, '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[{\"TABLE_NAME\":\"ALUMONOS_FELIPE\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"cd856eabb28d7c36a120920fa0bc30dbcbd4b5fa44d846265bd1e9975a198ca2\"}],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"ALUMNOS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"1376ac621a9b77f6c18317dc92b4fc0e80ca3521651ff51f55c29bab45197792\"},{\"TABLA\":\"FELIPE\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"78f7a569f8ac8d42a945d4fb5a09497851014fb9e63b2017dc8dd9cb71519125\"},{\"TABLA\":\"PROFESORES\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"10556ee34ca9450f58121d0dedd61970deb5a0145400b93409df750cb20c959e\"},{\"TABLA\":\"PRUEBA2\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"e8c17b5862892708ea910c21c09c1ec3d20587a8019a5f9252835a2338af1bbe\"},{\"TABLA\":\"PRUEBA3\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"2dc385eec8a0c3c7618ff2e2eaa71b16d3178a14cf517a0085e7f1a7b880e43c\"},{\"TABLA\":\"PRUEBA_\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a1d894e982ee9c14308b1fa4c4550b2b6c4c23638616b614d9090d06ad13fb92\"}]}}', '2020-05-20 17:14:25', 2),
(5, 4, '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[{\"TRIGGER_NAME\":\"customer_create_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"4c3df3d9338e3a1385a0b01f646ba06e59516765dffbd67c70c3315c64bf16e4\"},{\"TRIGGER_NAME\":\"ins_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"bb30d5b2eb2dca7cd5c4648de45efc67c40050f1292c3e5061a21ab24b36e0f9\"},{\"TRIGGER_NAME\":\"upd_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"cc76c81e37c38b5b850f85dbf6020c44f30330c7999604b75f026bc9acea7dc8\"},{\"TRIGGER_NAME\":\"del_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"6ca599ec1590f87594a3a141589779bd78aff568bea6391d114624edd61e1d33\"},{\"TRIGGER_NAME\":\"payment_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"88f2157f558e0f046afbe9b039e62a52987091acb5b3d340d1d2f25fea2561a4\"},{\"TRIGGER_NAME\":\"rental_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"2c2ddccbcf1abba04da4e413fabb8aa8154a41ef17af30a42f612f96fc707140\"}],\"vistas\":[{\"TABLE_NAME\":\"actor_info\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"e7e3be6dd6002a306af81d575d55cb74520c3838600f01dba1a4d9145cd66fe0\"},{\"TABLE_NAME\":\"customer_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"8849ae7eeee34f679bc5b49a89ca993bc840c41f2040556593c61050d9a001cd\"},{\"TABLE_NAME\":\"felipe\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4f2aeb5f5050be5c7a22bb275ebd6d0b71ead4013c45e10700412267b246014a\"},{\"TABLE_NAME\":\"film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"d2d0fd45fb66a1ccbea92ae6f4aa13be4fb4c09ef447624862136b6cb79a13f9\"},{\"TABLE_NAME\":\"nicer_but_slower_film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"7f5ed6f4020cf6bb56ecb615d0b20b177a67b05d4fa4e999b09ab812590a928c\"},{\"TABLE_NAME\":\"sales_by_film_category\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"54e28e68a0f5aad5162c7a58281271fb981f8290d8c918bfdb8ac6d2b5a0162d\"},{\"TABLE_NAME\":\"sales_by_store\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"5fcfe25642607a17eaed01052155175b85194867c8214fbbf435b636790ad9d7\"},{\"TABLE_NAME\":\"staff_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4c026812a0c246a222af9bb81ce1151ed90299ccb2bbabf5675fb1868949d2bb\"}],\"rutinas\":[{\"ROUTINE_NAME\":\"film_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"758ace6e48851ac7e8fa197dafc91b01fc19ca90c916e460e285283be01be2f0\"},{\"ROUTINE_NAME\":\"film_not_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"5bffa595786d200b1e17c5d6b2fa54c629b7aef49320aaba64d4021819ddecc3\"},{\"ROUTINE_NAME\":\"get_customer_balance\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"fb04357e3da67a646374e344faff48964263a08c4cfae30d7bf1953fa2f5831b\"},{\"ROUTINE_NAME\":\"inventory_held_by_customer\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"2d52a630a6dcb704eaa0143b07c7e59b8cbd0abfd8cd4857bc5247a0a1d69ffb\"},{\"ROUTINE_NAME\":\"inventory_in_stock\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"0a69d2b6f90867b972211c35df2de5fd70b30aaf6c9125695872ab0d43856d41\"},{\"ROUTINE_NAME\":\"rewards_report\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"e3f2e939c1c200d1a1ca6e7b966bb1b26aa79de9a00edc8e1a81ed425608bd59\"}],\"tablas\":[{\"TABLA\":\"actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"64e30f8f4b4767b8c874eb59aa327ee5b7d0298e8ed4d5ff5097dcaca078e549\"},{\"TABLA\":\"address\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55d70d8d8e4abdc9a32fb07e4c2d915380b7ff0a447d9a233efd77ecd4c664a3\"},{\"TABLA\":\"category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7b4c051a97367cde16b9805eceea9efecd076548311e2478f1e7d669eaf10423\"},{\"TABLA\":\"city\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7a1564fe4776e46601d1b999254c8e833ca00b42c5c7970240f99bf7ebb94af4\"},{\"TABLA\":\"country\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"f671691d766b7b2e1850bd277d46b27eafd6580591367cffcfb6acd587508fe3\"},{\"TABLA\":\"customer\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"abd8bf20cbc525ca6eb5c7fcb5625cfa65ed78da2f1fac0ba66faa8a3321376a\"},{\"TABLA\":\"film\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"18e19a0440d1f26a3d9fb986f2564bc41a075aa4a0a48b9bc7413f95176d7557\"},{\"TABLA\":\"film_actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4dd791e74094b745da1f715764a4c72fb6b4ee51c366f9a7e8ce5415bd63338a\"},{\"TABLA\":\"film_category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5cc66864dea047c52d33fb82bf174ac02f355d080b810839ad0278412a0ba727\"},{\"TABLA\":\"film_text\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ffa1651ee9492b5101e2f547c0a261c82538f2c0e1cbc059d293e7442671e9d4\"},{\"TABLA\":\"inventory\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"d2d8dc9a66c3f43e28bf188f26ee8a82f6ed1bf93f6824b058a13706134b47c1\"},{\"TABLA\":\"language\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86aef5617792760fe91cad508ce815e0768fbf97aa7e692bd5ac048d3da63754\"},{\"TABLA\":\"payment\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"28f7d097848034b5dc8f1bcb95c01250f49b6bfe6dcc2def96dc37d7087ddf40\"},{\"TABLA\":\"rental\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a6870cf51509c29561546e5568b7bd1517729be0722eb35becff344580983509\"},{\"TABLA\":\"staff\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"449dee08c772b52403c28b40bc6ce634abcd7026ccfb973ad39372a9e4a06697\"},{\"TABLA\":\"store\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4670f8a49421c3eeaf17dd72181c3f7cf995c39f24b0d8b1b3d66d9c1f670da8\"}]}}', '2020-05-21 10:14:58', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PROFILE`
--

CREATE TABLE `PROFILE` (
  `ID` int(10) NOT NULL,
  `NAME` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `PROFILE`
--

INSERT INTO `PROFILE` (`ID`, `NAME`) VALUES
(1, 'ROOT'),
(2, 'OPERATOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TRANSACTIONS`
--

CREATE TABLE `TRANSACTIONS` (
  `ID` int(10) NOT NULL,
  `LOGIN` varchar(100) NOT NULL,
  `PROFILE` varchar(100) NOT NULL,
  `OBJET` varchar(100) NOT NULL,
  `METHOD` varchar(100) NOT NULL,
  `PARAMETERS` text,
  `RESPONSE` text,
  `CREATION_DATE` datetime NOT NULL,
  `CREATED_BY` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `TRANSACTIONS`
--

INSERT INTO `TRANSACTIONS` (`ID`, `LOGIN`, `PROFILE`, `OBJET`, `METHOD`, `PARAMETERS`, `RESPONSE`, `CREATION_DATE`, `CREATED_BY`) VALUES
(1, 'afquintero', 'ROOT', 'footPrint', 'generarHuella', '{\"ID_DBA\":\"4\",\"USER\":\"root\",\"PASSWORD\":\"felipe\",\"IP\":\"127.0.0.1\",\"DB_NAME\":\"sakila\"}', '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[{\"TRIGGER_NAME\":\"customer_create_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"4c3df3d9338e3a1385a0b01f646ba06e59516765dffbd67c70c3315c64bf16e4\"},{\"TRIGGER_NAME\":\"ins_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"bb30d5b2eb2dca7cd5c4648de45efc67c40050f1292c3e5061a21ab24b36e0f9\"},{\"TRIGGER_NAME\":\"upd_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"cc76c81e37c38b5b850f85dbf6020c44f30330c7999604b75f026bc9acea7dc8\"},{\"TRIGGER_NAME\":\"del_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"6ca599ec1590f87594a3a141589779bd78aff568bea6391d114624edd61e1d33\"},{\"TRIGGER_NAME\":\"payment_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"88f2157f558e0f046afbe9b039e62a52987091acb5b3d340d1d2f25fea2561a4\"},{\"TRIGGER_NAME\":\"rental_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"2c2ddccbcf1abba04da4e413fabb8aa8154a41ef17af30a42f612f96fc707140\"}],\"vistas\":[{\"TABLE_NAME\":\"actor_info\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"e7e3be6dd6002a306af81d575d55cb74520c3838600f01dba1a4d9145cd66fe0\"},{\"TABLE_NAME\":\"customer_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"8849ae7eeee34f679bc5b49a89ca993bc840c41f2040556593c61050d9a001cd\"},{\"TABLE_NAME\":\"film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"d2d0fd45fb66a1ccbea92ae6f4aa13be4fb4c09ef447624862136b6cb79a13f9\"},{\"TABLE_NAME\":\"nicer_but_slower_film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"7f5ed6f4020cf6bb56ecb615d0b20b177a67b05d4fa4e999b09ab812590a928c\"},{\"TABLE_NAME\":\"sales_by_film_category\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"54e28e68a0f5aad5162c7a58281271fb981f8290d8c918bfdb8ac6d2b5a0162d\"},{\"TABLE_NAME\":\"sales_by_store\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"5fcfe25642607a17eaed01052155175b85194867c8214fbbf435b636790ad9d7\"},{\"TABLE_NAME\":\"staff_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4c026812a0c246a222af9bb81ce1151ed90299ccb2bbabf5675fb1868949d2bb\"}],\"rutinas\":[{\"ROUTINE_NAME\":\"film_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"758ace6e48851ac7e8fa197dafc91b01fc19ca90c916e460e285283be01be2f0\"},{\"ROUTINE_NAME\":\"film_not_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"5bffa595786d200b1e17c5d6b2fa54c629b7aef49320aaba64d4021819ddecc3\"},{\"ROUTINE_NAME\":\"get_customer_balance\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"fb04357e3da67a646374e344faff48964263a08c4cfae30d7bf1953fa2f5831b\"},{\"ROUTINE_NAME\":\"inventory_held_by_customer\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"2d52a630a6dcb704eaa0143b07c7e59b8cbd0abfd8cd4857bc5247a0a1d69ffb\"},{\"ROUTINE_NAME\":\"inventory_in_stock\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"0a69d2b6f90867b972211c35df2de5fd70b30aaf6c9125695872ab0d43856d41\"},{\"ROUTINE_NAME\":\"rewards_report\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"e3f2e939c1c200d1a1ca6e7b966bb1b26aa79de9a00edc8e1a81ed425608bd59\"}],\"tablas\":[{\"TABLA\":\"actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"64e30f8f4b4767b8c874eb59aa327ee5b7d0298e8ed4d5ff5097dcaca078e549\"},{\"TABLA\":\"address\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55d70d8d8e4abdc9a32fb07e4c2d915380b7ff0a447d9a233efd77ecd4c664a3\"},{\"TABLA\":\"category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7b4c051a97367cde16b9805eceea9efecd076548311e2478f1e7d669eaf10423\"},{\"TABLA\":\"city\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7a1564fe4776e46601d1b999254c8e833ca00b42c5c7970240f99bf7ebb94af4\"},{\"TABLA\":\"country\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"f671691d766b7b2e1850bd277d46b27eafd6580591367cffcfb6acd587508fe3\"},{\"TABLA\":\"customer\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"abd8bf20cbc525ca6eb5c7fcb5625cfa65ed78da2f1fac0ba66faa8a3321376a\"},{\"TABLA\":\"film\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"18e19a0440d1f26a3d9fb986f2564bc41a075aa4a0a48b9bc7413f95176d7557\"},{\"TABLA\":\"film_actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4dd791e74094b745da1f715764a4c72fb6b4ee51c366f9a7e8ce5415bd63338a\"},{\"TABLA\":\"film_category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5cc66864dea047c52d33fb82bf174ac02f355d080b810839ad0278412a0ba727\"},{\"TABLA\":\"film_text\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ffa1651ee9492b5101e2f547c0a261c82538f2c0e1cbc059d293e7442671e9d4\"},{\"TABLA\":\"inventory\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"d2d8dc9a66c3f43e28bf188f26ee8a82f6ed1bf93f6824b058a13706134b47c1\"},{\"TABLA\":\"language\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86aef5617792760fe91cad508ce815e0768fbf97aa7e692bd5ac048d3da63754\"},{\"TABLA\":\"payment\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"28f7d097848034b5dc8f1bcb95c01250f49b6bfe6dcc2def96dc37d7087ddf40\"},{\"TABLA\":\"rental\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a6870cf51509c29561546e5568b7bd1517729be0722eb35becff344580983509\"},{\"TABLA\":\"staff\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"449dee08c772b52403c28b40bc6ce634abcd7026ccfb973ad39372a9e4a06697\"},{\"TABLA\":\"store\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4670f8a49421c3eeaf17dd72181c3f7cf995c39f24b0d8b1b3d66d9c1f670da8\"}]},\"type\":\"success\",\"msg\":\"se registro la huella correctamentese ejecuto correctamente SQL\"}', '2020-05-20 11:34:40', 1),
(2, 'afquintero', 'ROOT', 'footPrint', 'generarHuella', '{\"ID_DBA\":\"5\",\"USER\":\"root\",\"PASSWORD\":\"felipe\",\"IP\":\"127.0.0.1\",\"DB_NAME\":\"USB_TEST\"}', '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"ALUMNOS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55b2efa18323d059450dfad225081ee98f084de81307f34270a9a0074aa3cb7b\"},{\"TABLA\":\"PROFESORES\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"910548e378257e3995a6c9871122d6803a1ba8056a049fe895d30c985358d033\"},{\"TABLA\":\"PRUEBA\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4c56085ca7560e8595a5dc7572711ac4c9d062526c914692ba708db2e964afb2\"}]},\"type\":\"success\",\"msg\":\"se registro la huella correctamentese ejecuto correctamente SQL\"}', '2020-05-20 11:35:22', 1),
(3, 'afquintero', 'ROOT', 'footPrint', 'generarHuella', '{\"ID_DBA\":\"6\",\"USER\":\"root\",\"PASSWORD\":\"felipe\",\"IP\":\"127.0.0.1\",\"DB_NAME\":\"medicalgroup\"}', '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"COMMANDS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"c284de460a97c5b3895e6f65a0b9ab08b13801e24ec7132550fec85eafef69b1\"},{\"TABLA\":\"atributos_estados\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86e39ff89e2e8eb6cccc2c1f40d98f0a7f1e614777ff55ed1bc83f8739a2f33c\"},{\"TABLA\":\"convenio\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a24ac38448bb3b14a9e588bbbec1d06540a3e4222e21e554abf7f26ab0d30f85\"},{\"TABLA\":\"diagnostico_cie10\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"e9ba361992aa227eac9ee9ef082e7ad3f8a79d8a240055753e4033cd0b4fa594\"},{\"TABLA\":\"empleados\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"6213b2677afeaf223e1c1d58b87cca41ce2f7bb8e8a8ffd5c36ffe5d9ebd7bda\"},{\"TABLA\":\"empleados_historicos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"94deb5c857ddf930947bd61d39a34e3d62fc542862cbdcada2f6e2501aebb33e\"},{\"TABLA\":\"encuesta\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ba20c26cb8b4cd0a513c51a7c449ce0aa657a5c03237286f880fddd6b32f70a7\"},{\"TABLA\":\"insumos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"11755575b3636e4f18d2792e2f40006bc14091bc490af3a1cefed8d579b0df97\"},{\"TABLA\":\"ot\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"fc7890f11b445e16b2e9bc32edf04f2eff55aed00a8466d1c711d81cc0ff8d8c\"},{\"TABLA\":\"ot_trayectos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"588cbbe8c28f17f9ec4241bc13d6d87498e25c4c00f56ceadbb926a030a1a1c5\"},{\"TABLA\":\"ot_trayectos_finish\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ef4a8598833fac2dc857a7fd05919e6abfee4efca1018140b2444b7cdfd90cd0\"},{\"TABLA\":\"ot_trayectos_historico\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"bbf3b1db9156d6abd0f4d7788cceeb116c3d002cee12ccd5bbce3636d428c145\"},{\"TABLA\":\"ot_trayectos_insumo\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"fd93e85c19e1d668e782f74a8cca2cd266436d075ab1857cbab37b942429e0b0\"},{\"TABLA\":\"pacientes\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ad65160fc636a248e5372e0597aed54041d0fb762fc933fb2d59b67812af7853\"},{\"TABLA\":\"pacientes_historicos\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"34c5e580323d7950e3888902ed9f5a4ec293bf03fce3aa9ba14341e5f058d01c\"},{\"TABLA\":\"perfil\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5c6905fff35ba13c5e7d01c0d1c84801d4c8ab83c5e97122f7b4a65598dedbec\"},{\"TABLA\":\"select_ciudad\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"38f313883446aea81092f373a71724428761980af63796e60aa33906b8aab930\"},{\"TABLA\":\"select_departamento\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"bfb1398773bd198318e56448a2b84c6a3900cedf9f84c199f2923a9b3d734d66\"},{\"TABLA\":\"tipo_traslado\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"69c0d46b97cd7a5e3ee36bd59b8f7fda8234abd301a501f9f77ef0d7bc0c6395\"},{\"TABLA\":\"tipo_traslado_2\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4c3da0608ee985542f88880f05819cf3628e4af44b7f8437aefdd9238be7472f\"},{\"TABLA\":\"usuarios\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"011d33e4cf7835036179bd3d166497fc504e82b4dca82c3c8560a0baa5e50724\"},{\"TABLA\":\"vehiculo\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"411ed584976dec438f10bc2014616d810e15c19534c2ec9f7e4041e28644ad55\"}]},\"type\":\"success\",\"msg\":\"se registro la huella correctamentese ejecuto correctamente SQL\"}', '2020-05-20 11:35:46', 1),
(4, 'root', 'ROOT', 'footPrint', 'generarHuella', '{\"ID_DBA\":\"5\",\"USER\":\"root\",\"PASSWORD\":\"felipe\",\"IP\":\"127.0.0.1\",\"DB_NAME\":\"USB_TEST\"}', '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[],\"vistas\":[{\"TABLE_NAME\":\"ALUMONOS_FELIPE\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"cd856eabb28d7c36a120920fa0bc30dbcbd4b5fa44d846265bd1e9975a198ca2\"}],\"rutinas\":[],\"tablas\":[{\"TABLA\":\"ALUMNOS\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"1376ac621a9b77f6c18317dc92b4fc0e80ca3521651ff51f55c29bab45197792\"},{\"TABLA\":\"FELIPE\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"78f7a569f8ac8d42a945d4fb5a09497851014fb9e63b2017dc8dd9cb71519125\"},{\"TABLA\":\"PROFESORES\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"10556ee34ca9450f58121d0dedd61970deb5a0145400b93409df750cb20c959e\"},{\"TABLA\":\"PRUEBA2\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"e8c17b5862892708ea910c21c09c1ec3d20587a8019a5f9252835a2338af1bbe\"},{\"TABLA\":\"PRUEBA3\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"2dc385eec8a0c3c7618ff2e2eaa71b16d3178a14cf517a0085e7f1a7b880e43c\"},{\"TABLA\":\"PRUEBA_\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a1d894e982ee9c14308b1fa4c4550b2b6c4c23638616b614d9090d06ad13fb92\"}]},\"type\":\"success\",\"msg\":\"se registro la huella correctamentese ejecuto correctamente SQL\"}', '2020-05-20 17:14:25', 2),
(5, 'root', 'ROOT', 'footPrint', 'generarHuella', '{\"ID_DBA\":\"4\",\"USER\":\"root\",\"PASSWORD\":\"felipe\",\"IP\":\"127.0.0.1\",\"DB_NAME\":\"sakila\"}', '{\"data\":{\"versiones\":[{\"Variable_name\":\"innodb_version\",\"sha256\":\"5e0151ff243ff56e1fc82327b5635bbd285657f5470dfff71ae820e87c2778b2\"},{\"Variable_name\":\"protocol_version\",\"sha256\":\"4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5\"},{\"Variable_name\":\"slave_type_conversions\",\"sha256\":\"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\"},{\"Variable_name\":\"tls_version\",\"sha256\":\"f4976289a935085daac06d4dcbd877ca93d444678094dd4b98161bb0001141a7\"},{\"Variable_name\":\"version\",\"sha256\":\"d407187f72a25d24927d4bcf768057c5a6d67132539f54ef509d810dc53ff627\"},{\"Variable_name\":\"version_comment\",\"sha256\":\"84eb581e761c186109aea5c8bae64de6f0ccf677eb0c74b4baee67e6f5c1218d\"},{\"Variable_name\":\"version_compile_machine\",\"sha256\":\"7520b5a1b312efde4fd7e2793ef4bc0cf8f1c235f778d203ab7216a0e31b3880\"},{\"Variable_name\":\"version_compile_os\",\"sha256\":\"4828e60247c1636f57b7446a314e7f599c12b53d40061cc851a1442004354fed\"}],\"triggers\":[{\"TRIGGER_NAME\":\"customer_create_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"4c3df3d9338e3a1385a0b01f646ba06e59516765dffbd67c70c3315c64bf16e4\"},{\"TRIGGER_NAME\":\"ins_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"bb30d5b2eb2dca7cd5c4648de45efc67c40050f1292c3e5061a21ab24b36e0f9\"},{\"TRIGGER_NAME\":\"upd_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"cc76c81e37c38b5b850f85dbf6020c44f30330c7999604b75f026bc9acea7dc8\"},{\"TRIGGER_NAME\":\"del_film\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"6ca599ec1590f87594a3a141589779bd78aff568bea6391d114624edd61e1d33\"},{\"TRIGGER_NAME\":\"payment_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"88f2157f558e0f046afbe9b039e62a52987091acb5b3d340d1d2f25fea2561a4\"},{\"TRIGGER_NAME\":\"rental_date\",\"ROUTINE_TYPE\":\"TRIGGER\",\"sha256\":\"2c2ddccbcf1abba04da4e413fabb8aa8154a41ef17af30a42f612f96fc707140\"}],\"vistas\":[{\"TABLE_NAME\":\"actor_info\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"e7e3be6dd6002a306af81d575d55cb74520c3838600f01dba1a4d9145cd66fe0\"},{\"TABLE_NAME\":\"customer_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"8849ae7eeee34f679bc5b49a89ca993bc840c41f2040556593c61050d9a001cd\"},{\"TABLE_NAME\":\"felipe\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4f2aeb5f5050be5c7a22bb275ebd6d0b71ead4013c45e10700412267b246014a\"},{\"TABLE_NAME\":\"film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"d2d0fd45fb66a1ccbea92ae6f4aa13be4fb4c09ef447624862136b6cb79a13f9\"},{\"TABLE_NAME\":\"nicer_but_slower_film_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"7f5ed6f4020cf6bb56ecb615d0b20b177a67b05d4fa4e999b09ab812590a928c\"},{\"TABLE_NAME\":\"sales_by_film_category\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"54e28e68a0f5aad5162c7a58281271fb981f8290d8c918bfdb8ac6d2b5a0162d\"},{\"TABLE_NAME\":\"sales_by_store\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"5fcfe25642607a17eaed01052155175b85194867c8214fbbf435b636790ad9d7\"},{\"TABLE_NAME\":\"staff_list\",\"ROUTINE_TYPE\":\"VIEW\",\"sha256\":\"4c026812a0c246a222af9bb81ce1151ed90299ccb2bbabf5675fb1868949d2bb\"}],\"rutinas\":[{\"ROUTINE_NAME\":\"film_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"758ace6e48851ac7e8fa197dafc91b01fc19ca90c916e460e285283be01be2f0\"},{\"ROUTINE_NAME\":\"film_not_in_stock\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"5bffa595786d200b1e17c5d6b2fa54c629b7aef49320aaba64d4021819ddecc3\"},{\"ROUTINE_NAME\":\"get_customer_balance\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"fb04357e3da67a646374e344faff48964263a08c4cfae30d7bf1953fa2f5831b\"},{\"ROUTINE_NAME\":\"inventory_held_by_customer\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"2d52a630a6dcb704eaa0143b07c7e59b8cbd0abfd8cd4857bc5247a0a1d69ffb\"},{\"ROUTINE_NAME\":\"inventory_in_stock\",\"ROUTINE_TYPE\":\"FUNCTION\",\"sha256\":\"0a69d2b6f90867b972211c35df2de5fd70b30aaf6c9125695872ab0d43856d41\"},{\"ROUTINE_NAME\":\"rewards_report\",\"ROUTINE_TYPE\":\"PROCEDURE\",\"sha256\":\"e3f2e939c1c200d1a1ca6e7b966bb1b26aa79de9a00edc8e1a81ed425608bd59\"}],\"tablas\":[{\"TABLA\":\"actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"64e30f8f4b4767b8c874eb59aa327ee5b7d0298e8ed4d5ff5097dcaca078e549\"},{\"TABLA\":\"address\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"55d70d8d8e4abdc9a32fb07e4c2d915380b7ff0a447d9a233efd77ecd4c664a3\"},{\"TABLA\":\"category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7b4c051a97367cde16b9805eceea9efecd076548311e2478f1e7d669eaf10423\"},{\"TABLA\":\"city\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"7a1564fe4776e46601d1b999254c8e833ca00b42c5c7970240f99bf7ebb94af4\"},{\"TABLA\":\"country\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"f671691d766b7b2e1850bd277d46b27eafd6580591367cffcfb6acd587508fe3\"},{\"TABLA\":\"customer\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"abd8bf20cbc525ca6eb5c7fcb5625cfa65ed78da2f1fac0ba66faa8a3321376a\"},{\"TABLA\":\"film\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"18e19a0440d1f26a3d9fb986f2564bc41a075aa4a0a48b9bc7413f95176d7557\"},{\"TABLA\":\"film_actor\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4dd791e74094b745da1f715764a4c72fb6b4ee51c366f9a7e8ce5415bd63338a\"},{\"TABLA\":\"film_category\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"5cc66864dea047c52d33fb82bf174ac02f355d080b810839ad0278412a0ba727\"},{\"TABLA\":\"film_text\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"ffa1651ee9492b5101e2f547c0a261c82538f2c0e1cbc059d293e7442671e9d4\"},{\"TABLA\":\"inventory\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"d2d8dc9a66c3f43e28bf188f26ee8a82f6ed1bf93f6824b058a13706134b47c1\"},{\"TABLA\":\"language\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"86aef5617792760fe91cad508ce815e0768fbf97aa7e692bd5ac048d3da63754\"},{\"TABLA\":\"payment\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"28f7d097848034b5dc8f1bcb95c01250f49b6bfe6dcc2def96dc37d7087ddf40\"},{\"TABLA\":\"rental\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"a6870cf51509c29561546e5568b7bd1517729be0722eb35becff344580983509\"},{\"TABLA\":\"staff\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"449dee08c772b52403c28b40bc6ce634abcd7026ccfb973ad39372a9e4a06697\"},{\"TABLA\":\"store\",\"ROUTINE_TYPE\":\"TABLAS\",\"sha256\":\"4670f8a49421c3eeaf17dd72181c3f7cf995c39f24b0d8b1b3d66d9c1f670da8\"}]},\"type\":\"success\",\"msg\":\"se registro la huella correctamentese ejecuto correctamente SQL\"}', '2020-05-21 10:14:58', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USERS`
--

CREATE TABLE `USERS` (
  `ID_USERS` int(10) NOT NULL,
  `LOGIN` varchar(300) NOT NULL,
  `PASSWORD` varchar(300) NOT NULL,
  `MAIL` varchar(300) NOT NULL DEFAULT '@',
  `FK_PROFILE` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `USERS`
--

INSERT INTO `USERS` (`ID_USERS`, `LOGIN`, `PASSWORD`, `MAIL`, `FK_PROFILE`) VALUES
(1, 'afquintero', '7e04da88cbb8cc933c7b89fbfe121cca', 'afquinterot@correo.usbcali.edu.co', 1),
(2, 'root', '63a9f0ea7bb98050796b649e85481845', 'root@correo.usbcali.edu.co', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `COMMANDS`
--
ALTER TABLE `COMMANDS`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `DBA`
--
ALTER TABLE `DBA`
  ADD PRIMARY KEY (`ID_DBA`),
  ADD UNIQUE KEY `NAME` (`NAME`,`IP`);

--
-- Indices de la tabla `FOOTPRINT`
--
ALTER TABLE `FOOTPRINT`
  ADD PRIMARY KEY (`ID_FOOTPRINT`);

--
-- Indices de la tabla `PROFILE`
--
ALTER TABLE `PROFILE`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `TRANSACTIONS`
--
ALTER TABLE `TRANSACTIONS`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `USERS`
--
ALTER TABLE `USERS`
  ADD PRIMARY KEY (`ID_USERS`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `COMMANDS`
--
ALTER TABLE `COMMANDS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `DBA`
--
ALTER TABLE `DBA`
  MODIFY `ID_DBA` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `FOOTPRINT`
--
ALTER TABLE `FOOTPRINT`
  MODIFY `ID_FOOTPRINT` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `PROFILE`
--
ALTER TABLE `PROFILE`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `TRANSACTIONS`
--
ALTER TABLE `TRANSACTIONS`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `USERS`
--
ALTER TABLE `USERS`
  MODIFY `ID_USERS` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
