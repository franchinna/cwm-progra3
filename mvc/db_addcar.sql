-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 01-03-2023 a las 16:58:05
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_addcar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amigos`
--

CREATE TABLE `amigos` (
  `id_usuario` int(11) NOT NULL,
  `id_amigo` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `amigos`
--

INSERT INTO `amigos` (`id_usuario`, `id_amigo`, `status`) VALUES
(1, 2, 1),
(1, 3, 1),
(1, 53, 1),
(2, 1, 1),
(3, 1, 1),
(52, 53, 0),
(53, 1, 1),
(54, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `cuerpo` text NOT NULL,
  `fecha` date NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `cuerpo`, `fecha`, `id_usuario`) VALUES
(1, 'Guau! que buen posteo!!! Sigue así!! ', '2020-11-18', 1),
(2, 'Si desmontas la parte baja del volante puedes meter la mano a la sirga y ayudarla a salir hacia el cuadro, puedes soltarla metiendo el destornillador para apalancar pero claro, luego para ponerla estarás en las mismas. Hace poco escuché a un compi que el siempre lo quita de un tirón y pone apretando pero pff mejor desmontar un par de plásticos más y así acceder al resto de la sirga', '2020-12-18', 2),
(3, 'claro ese es el problema que no quiero tirar por si la lio, digo a ver si hay algun truquillo. O que el cable si tiro de el cede un poco, sin que se desconecte del otro extremo que entonces la liamos mas....', '2020-12-18', 3),
(4, 'Excelente Post!', '2020-12-18', 22),
(5, 'No estoy de acuero!! ', '2020-12-18', 24),
(26, 'testeto por muchisimo tiempo, basta! ', '2020-11-19', 24),
(27, 'vamooo carajo, graba!', '2020-11-19', 24),
(40, 'ahora si, funciona y me voy a dormir. ', '2020-11-19', 24),
(41, 'dale bolas, sacá los echo pre si no.. no ejecuta ', '2020-11-19', 24),
(42, 'me doy por vencido? ', '2020-11-19', 24),
(43, 'asdasd12esdasd', '2020-11-19', 24),
(44, 'asdasdasdasdasd', '2020-11-19', 24),
(45, 'sdasdqwdesazdasdaszdasd', '2020-11-19', 24),
(46, 'ultimo comentario, tengo sueño ', '2020-11-19', 24),
(47, 'Probando un comentario! ', '2020-11-19', 1),
(48, 'Hola! Estoy probando comentarios ramdoms', '2023-01-21', 1),
(49, 'Hola. Quiero ver como funciona esto', '2023-01-21', 1),
(50, 'Hola, me interesa el tema! Que bueno, seguí así  ', '2023-02-04', 24),
(51, 'sadasdasdas', '2023-02-21', 1),
(52, 'Hola quiero comentar este posteo', '2023-02-25', 1),
(53, 'Escribo un comentario para probar si funciona', '2023-02-25', 1),
(54, 'Quiero ver si esto funciona bien.', '2023-02-27', 1),
(55, 'Holla!! Muy interesante posteo! :)', '2023-03-01', 53);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `cuerpo` text NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `localizacion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`id_evento`, `titulo`, `fecha`, `cuerpo`, `id_usuario`, `imagen`, `localizacion`) VALUES
(1, 'Exhibición de autos: Mendoza Motor Show', '2023-04-23', 'El \"Mendoza Motor Show\" es un evento anual que reúne a los amantes de los autos y la velocidad en la hermosa ciudad de Mendoza. Durante el evento, los asistentes podrán disfrutar de una gran exhibición de autos deportivos y clásicos de todo el mundo, así como de las últimas tendencias en tecnología automotriz y accesorios para vehículos. \\n Además de la exhibición de autos, el evento contará con entretenimiento en vivo, actividades para toda la familia y exhibiciones de carreras de autos. Los asistentes tendrán la oportunidad de conocer a expertos de la industria automotriz, hacer preguntas y aprender sobre las últimas tendencias en tecnología y diseño de autos.  \\n Ya sea que seas un entusiasta de los autos o simplemente estés interesado en ver los últimos modelos y tendencias en la industria, el \"Mendoza Motor Show\" es un evento que no te puedes perder. Ven y disfruta de un día lleno de emoción, velocidad y diversión.', 1, 'mendoza.jpg', 'San Rafael - Mendoza'),
(2, 'Ruteada a Cordoba', '2023-04-23', 'La \"Ruteada a Córdoba\" es un evento imperdible para los amantes de los deportes de motor. Córdoba es conocida como la cuna del rally, y este recorrido te permitirá descubrir los mejores paisajes de la provincia mientras exploras los mismos caminos que los pilotos del Campeonato Mundial de Rally (WRC) han recorrido. Desde las espectaculares sierras de Córdoba hasta sus pintorescos pueblos y ciudades, este evento te ofrecerá la oportunidad de experimentar la adrenalina de conducir en estos caminos de rally. Además, contarás con la asistencia de guías especializados y expertos en rally para llevar tu experiencia a otro nivel. ¡No te pierdas esta oportunidad única de experimentar la emoción de la ruta en una de las provincias más emblemáticas de Argentina!', 22, 'cordoba.jpg', 'Uritorco - Cordoba'),
(3, 'Ruteada a Tierra del fuego', '2023-04-23', 'La \"Ruteada por Tierra del Fuego\" es un evento para aquellos amantes de la aventura y la naturaleza que desean explorar una de las regiones más hermosas y remotas de Argentina. Este recorrido en motocicleta o vehículo 4x4 cubrirá una ruta a través de los impresionantes paisajes de Tierra del Fuego, donde los participantes podrán admirar los glaciares, montañas, lagos y ríos más hermosos del sur de Argentina. El evento contará con guías especializados, quienes guiarán a los participantes por las mejores rutas y senderos de la región, así como también se incluirán actividades de camping y excursiones en grupo para experimentar al máximo la aventura de este viaje inolvidable. ¡No te pierdas esta oportunidad única de explorar la belleza natural de Tierra del Fuego!', 2, 'Tierra_del_fuego.jpg', 'Valle del nose - Tierra del fuego'),
(4, 'Desafío sobre ruedas en Buenos Aires', '2023-04-23', 'El \"Rally Challenge: Desafío sobre ruedas en Buenos Aires\" es un evento de carreras de rally que reunirá a los mejores pilotos de Argentina y del mundo. Este desafío se llevará a cabo en los caminos y carreteras de la ciudad de Buenos Aires, donde los pilotos demostrarán su habilidad y destreza en terrenos difíciles y desafiantes. Los asistentes tendrán la oportunidad de disfrutar de la velocidad, la emoción y la adrenalina que ofrece este deporte, así como también de conocer de cerca a los pilotos y sus equipos. ¡No te pierdas este desafío sobre ruedas que te mantendrá al borde de tu asiento!', 3, 'Baires.jpg', 'Autodromo - Baires'),
(5, 'Ruteada a Santiago del Estero', '2023-04-23', 'La \"Ruteada a Santiago del Estero\" es un evento para los entusiastas del automovilismo que desean experimentar la cultura y la historia de una de las provincias más antiguas de Argentina. La ruta comienza en la ciudad de Córdoba y continúa a través de paisajes sorprendentes, campos y montañas hasta llegar a Santiago del Estero. Allí, los participantes tendrán la oportunidad de disfrutar de la gastronomía local, conocer las tradiciones regionales y visitar lugares históricos y culturales. Este evento incluye guías especializados que acompañarán a los participantes a lo largo del recorrido, además de actividades de camping y reuniones de grupo para que los participantes puedan conectarse y disfrutar de una experiencia inolvidable. ¡No te pierdas la oportunidad de explorar una de las provincias más hermosas y con más historia de Argentina en esta Ruteada a Santiago del Estero!', 1, 'santiago_estero.jpg', 'La banda - Sgo del estero'),
(6, 'Ruta del Color', '2023-09-02', 'Recorre la Quebrada de Humahuaca y sus pintorescos pueblos andinos', 1, 'jujuy.jpg', 'Jujuy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos_has_usuarios`
--

CREATE TABLE `eventos_has_usuarios` (
  `id_evento` int(11) NOT NULL,
  `id_usaurio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `eventos_has_usuarios`
--

INSERT INTO `eventos_has_usuarios` (`id_evento`, `id_usaurio`) VALUES
(5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_posteo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`id`, `id_usuario`, `id_posteo`) VALUES
(1, 1, 5),
(2, 1, 6),
(3, 1, 7),
(4, 1, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participantes`
--

CREATE TABLE `participantes` (
  `id` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `asistencia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `participantes`
--

INSERT INTO `participantes` (`id`, `id_evento`, `id_usuario`, `asistencia`) VALUES
(27, 3, 38, NULL),
(32, 2, 39, NULL),
(34, 4, 39, NULL),
(37, 1, 40, NULL),
(39, 3, 40, NULL),
(43, 1, 41, NULL),
(47, 5, 41, NULL),
(51, 3, 42, NULL),
(55, 1, 43, NULL),
(59, 5, 43, NULL),
(63, 3, 44, NULL),
(67, 1, 45, NULL),
(71, 5, 45, NULL),
(76, 4, 46, NULL),
(82, 4, 47, NULL),
(88, 4, 48, NULL),
(94, 4, 49, NULL),
(105, 6, 37, NULL),
(107, 4, 3, NULL),
(108, 5, 53, NULL),
(109, 5, 50, NULL),
(146, 5, 1, NULL),
(148, 3, 1, NULL),
(164, 6, 24, NULL),
(166, 6, 55, NULL),
(169, 6, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posteos`
--

CREATE TABLE `posteos` (
  `id_posteo` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `cuerpo` text NOT NULL,
  `fecha` date NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `posteos`
--

INSERT INTO `posteos` (`id_posteo`, `titulo`, `cuerpo`, `fecha`, `id_usuario`) VALUES
(5, 'Carburador doble cuerpo talbot', 'Buenas noches amigos doscingueros!Me venden dos carburadores doble cuerpo weber para mi 205 1.3 Talbot, uno de ellos proviene de un 205 GTX y el otro no se a ciencia cierta pero también es un Weber 36... la pregunta es si podría ponérselos a mi pequeño y en caso afirmativo si sería quitar y poner o si debería llevar a cabo más modificaciones. ', '2020-03-11', 24),
(6, 'Linea de escape 205 GTI', 'Buenas, alguno me puede mandar fotos o un despiece del la linea de escape desde el colector. De un 205 GTI. Gracias', '2010-05-21', 24),
(7, '¿Qué frenos para 205 GTI?', 'Frenos para 205 GTI, ¿Que equipo de frenos tenéis montados?  Tengo los discos muy gastados y no sé si mejorar ya todo su conjunto de alguna manera.', '2014-12-11', 2),
(8, 'Mangueta Y Buje Palier Compatible', 'tengo un buje doblado, al frenar se me desmonta el coche ,despues de cambiar los discos 2 veces y tornear ,comprobe el buje sin disco y esta alaveado ,en el 1.8d ,  me gustaria saber que bujes/manguetas me valen ,estaba pensando a parte del mismo modelo en la c15d ,por el tema de palieres ,pero creo que tambien valen de TU3  Y ya ir al desguce y sacar la mangueta entera y y no complicarme ,la economia esta jodia Gracias por las respuestas', '2018-01-11', 24),
(9, 'Temperatura Motor Tu3s', 'Buenas a todos, alguien sabe a que temperatura tiene que trabajareste motor ? No encuentro nada x ningun lado. Si alguien sabe se lo agradeceria . Aaaah es block de aluminio.', '2015-10-11', 22),
(10, 'Culata 1.3 G1 Talbot', 'Buenos dias!! Pues como os comenté ya he abierto el motor de mi 205 para ver que es lo que producía ese humo blanco y que se pase gasolina al carter de aceite. Me he encontrado muchos conductos de refrigerante completamente obstruidos y algunos casi tapados... Y lo más grave es que he encontrado en el cilindro 1 unas cuantas rayas no pequeñas precisamente... los demás cilindros a simple vista están bien. Entonces ahora mismo estoy planteándome que hacer. Me daría pena llegar hasta ahí y solo hacerle planificado y junta sabiendo que va a seguir yendo mal. No se, escucharé vuestras opiniones... Os dejo unas fotos para que veáis lo que he encontrado. ', '2017-06-15', 1),
(13, ' Separador bomba de gasolina motor talbot', 'El dueño anterior cambió la bomba de gasolina por una de otra marca (lada) y cambio la pieza entre la bomba y el motor. Ahora pongo una bomba original para motor Peugeot gasolina y resulta que se ahoga el carburador porque tiene demasiada presión y la solución parcial fue aumentar la distancia del separador pero lo hice con juntas más gruesas. La pregunta al final. Que ancho debe tener esta pieza entre la bomba y el motor? En cuba me es difícil buscar la original para evitarme esta pregunta.\nDe antemano mil gracias.\nAtentamente Fran', '2020-11-17', 37),
(14, 'Vibraciones en movimiento', 'Buenas gente. A ver si alguien me puede ayudar. Tengo un problema en mi mito diesel. Cuando me pongo a 120 con el vibra que da gusto. He mirado los silentblock y nada, le acabo de cambiar los neumáticos con equilibrado y nada, timonería del cambio bien y las bieletas de la dirección están bien. Hay gente que me ha dicho que puede ser los palieres. Que sí es falta de engrase o simplemente holguras. ¿Alguien me podría arrojar algo claro? Gracias.', '2020-11-18', 38),
(15, 'Medida Original Falso Amortiguador 205 Gti', 'Buenas Gente,\nAlguien tiene la medida que hay que poner al falso amortigüador trasero para dejar la altura original del 205 gti.\n\nGracias de antemano', '2020-11-18', 40),
(16, 'Sacar Cuadro Para Cambiar Bombillas (No Salpicadero, El Cuadro)', 'Buenas chicos.\nHe leido por varios sitios del foro como desmontar el salpicadero para llegar hasta el cuadro ( donde esta el velocimetro, km, gasoil y reloj) es un mito del 96 y lo he hecho bien, pero no me caben las manos detrás para cambiar las bombillas, intento sacar el cuadro por completo pero me queda enganchado en el cable que creo marca la velocidad y kilometros recorridos. Estiro pero me da miedo que tenga algun truco que desconozco y parta algo por que en este salpicadero todo lo que no toques con un super super cariño, se parte uffff y anda que no da rabia.\nMuchas gracias de antemano.\nUn saludo.', '2020-11-18', 24),
(17, 'Mangueta Y Buje Palier Compatible', 'tengo un buje doblado, al frenar se me desmonta el coche ,despues de cambiar los discos 2 veces y tornear ,comprobe el buje sin disco y esta alaveado ,en el 1.8d ,\n\nme gustaria saber que bujes/manguetas me valen ,estaba pensando a parte del mismo modelo en la c15d ,por el tema de palieres ,pero creo que tambien valen de TU3\n\nY ya ir al desguce y sacar la mangueta entera y y no complicarme ,la economia esta jodia\n\nGracias por las respuestas\nArriba\n', '2020-11-19', 44),
(18, 'Las nuevas Ford Ranger Raptor llegaron a Pinamar', 'Ford presentará el 25 de enero en Pinamar la Ranger Raptor (2023). Se trata de la nueva generación de la pick-up deportiva del Óvalo, que reemplazará a la Ranger Raptor que se comercializó desde septiembre de 2019.\n\nLa nueva Ranger Raptor llegará importada de Tailandia y será un anticipo de la nueva generación de la Ranger nacional, cuyas todas otras versiones se fabricarán en la planta argentina de Pacheco (leer más).\n\nLas fotos que se publican acá fueron enviadas a novedades@motor1.compor Ariel C., paparazzo de Motor1 Argentina en Pinamar. Y muestran la llegada a ese baalneario de dos unidades en color Blue Ford Performance.', '2020-11-19', 43),
(19, 'De punta en blanco: la colección de autos de Agustín Drubi', 'Desde Miami (Estados Unidos) - Agustín Drubi tiene 36 años, nació en Córdoba y es un inversionista argentino que vive en Miami. Por supuesto, como haría cualquiera de nosotros, Agustín disfruta de los autos. Por eso, de a poco, fue armando una colección que se hizo famosa en las redes sociales por una característica singular: todos son de color blanco.\n\n\"Siempre quise tener una Ferrari, un Lamborghini y un Rolls Royce\", dice Agustín mientras presenta los Aventador, Cullinan y 458 Spider que tiene en su garage. El diálogo completo con Motor1 Argentina se reproduce a continuación.\n\n-¿Cómo surgió tu pasión por los autos y cuál es el primer recuerdo que tenés de este hobby?\n-Siempre me gustaron los autos. Mis primeros recuerdos son sentándome con mis amigos en la esquina y jugábamos un juego en el cual nos tomábamos turnos y decíamos: \"El próximo auto que pase lo voy a tener cuando sea grande\". La idea era ver a quién le tocaba el mejor del día.\n\n-¿Dónde estudiaste y cómo fueron tus primeros pasos profesionales?\n-Estudié en la Universidad de la Florida, en Estados Unidos. Empecé cuando era chico haciendo websites y marketing para compañías. Después estudié y me recibí de ortodoncista, pero sólo trabaje un tiempo: no me gustó mucho y me empecé a dedicar a los negocios e inversiones.\n\n-¿Con qué auto aprendiste a manejar y cuál fue tu primer auto?\n-Aprendí con la Renoleta de mi abuela, era muy chico. Una vez, cuando tenía como 10 años, se la sacamos con mis primos más chicos y la metimos al río sin querer. Mi primer auto fue un Toyota Corolla.\n\n-¿Hace cuánto que vivís en Estados Unidos y a qué te dedicás?\n-Hace 23 años. Tengo negocios e inversiones.\n\n-¿Qué autos tenés en tu colección actual y por qué los elegiste?\n-Tengo una Ferrari 458 Spider, un Lamborghini Aventador y un Rolls-Royce Cullinan. Siempre quise tener una Ferrari, un Lamborghini y un Rolls Royce.\n\n-¿Todos tus autos son blancos o sólo la mayoría? ¿Por qué?\n-Todos son blancos, pero es por casualidad. El Rolls Royce lo iba a comprar negro y justo vendieron el que fui a ver el día anterior: terminé comprando uno blanco. La Ferrari siempre me gustó blanca. El Lamborghini solo había uno blanco. Fueron todas compras medio compulsivas del momento. Me llevo lo que tengan y me guste.\n\n-En tus redes sociales hay un video con el Roll-Royce Cullinan donde hacés referencia a Ricardo Fort. ¿Te sentís identificado con su gusto por los autos?\n-Jaja no, fue un vídeo gracioso que salió en el momento nomás con el Rolls Royce\n\n-¿Cuál es el próximo auto que estás planeando comprar?\n-El único que me gustaría que todavía no compre es un Pagani Huayra (leer más).\n\n-Si pudieras armar tu garage soñado, ¿qué autos tendrías?\n\n-Sería muy parecido al que tengo. Para mí el Rolls Royce Cullinan es el mejor auto del mundo, ningún auto se maneja mejor. Y todo el mundo debería tener una Ferrari. Creo que agregaría un Pagani y capaz una Bugatti. Después ya sería cuestión de ir cambiando para mantenerte entretenido. Cada vez los manejo menos, porque paso mucho tiempo viajando, pero también se disfrutan más así.', '2023-01-17', 45),
(20, 'Nueva normativa en Argentina: las motos 2T quedarán prohibidas en 2026', 'A través de la resolución 14/2023 del Ministerio de Ambiente y Desarrollo Sostenible, el Gobierno argentino volvió a pronunciarse acerca de la normativa vigente en nuestro país para motovehículos, un tema largamente dilatado en una sucesión de resoluciones que pretenden acercar al país al contexto internacional en lo que hace a emisiones (y también seguridad, dado que algunas normas Euro incluyen requisitos en este apartado, fundamentalmente de motos para el uso en el ámbito urbano).\n\nPara ponernos en contexto, Argentina es hasta el momento el único país de la región -y uno de los pocos en el mundo- en el que no regía formalmente ninguna norma en vigencia (o lo hacían versiones muy tempranas de las mismas las que ya han quedado obsoletas, leer opinión).\n\nEuropa terminará de entrar en 2024 con la norma Euro V para motos (que suma requisitos como el control de venteo de los tanques de combustible, no solo emisiones de escape). En Brasil se encuentra plenamente vigente desde 2016 la norma Euro IV, que también obliga a la utilización de frenos CBS/ABS y a partir del primer día de este año sólo se pueden introducir nuevos modelos que cumplan con la exigente Euro V (leer más). En ese mismo país, la norma Euro II entró en vigencia allá por 2006, y Euro III en 2009.', '2023-01-17', 1),
(21, 'Conversando sobre coches: la comunidad de entusiastas', 'Bienvenidos a nuestro foro de autos, un espacio diseñado para todos aquellos apasionados por los vehículos. Aquí podrás compartir tus experiencias, preguntar y responder dudas, conocer las últimas novedades del mercado automotriz y conectarte con personas que comparten tu interés por los coches. Ya seas un mecánico experto, un coleccionista de autos clásicos o simplemente alguien que disfruta de conducir, ¡este es el lugar perfecto para ti! Únete a nuestra comunidad y comienza a conversar sobre coches.', '2023-02-25', 1),
(22, 'Quiero ver si esto funciona bien.', 'Quiero ver si esto funciona bien.Quiero ver si esto funciona bien.', '2023-02-27', 1),
(23, 'Probando posteo de admin2', 'Probando posteo de admin2 Probando posteo de admin2 Probando posteo de admin2', '2023-03-01', 55);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posteos_has_comentarios`
--

CREATE TABLE `posteos_has_comentarios` (
  `id_posteo` int(11) NOT NULL,
  `id_comentario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `posteos_has_comentarios`
--

INSERT INTO `posteos_has_comentarios` (`id_posteo`, `id_comentario`) VALUES
(5, 1),
(5, 2),
(5, 5),
(7, 4),
(8, 3),
(10, 46),
(13, 47),
(15, 1),
(17, 48),
(18, 52),
(20, 49),
(20, 50),
(20, 51),
(21, 53),
(22, 54),
(23, 55);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(20) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `email`, `password`, `imagen`, `id_rol`) VALUES
(1, 'admin_rol_1', 'test@test.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'perfil-darth-vader.jpg', 1),
(2, 'sup', 'sup@sup.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'perfil-rick-sanchez.png', 2),
(3, 'testrol3', 'bas@bas.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'messi.jpg', 3),
(22, 'cgomez', 'cgomez@hotmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'river.jpg', 1),
(24, 'Franchinna', 'francinnante@gmail.com', '$2y$10$6YP8beP0VSsIlB3Mq44mEe.IEJKylIgqtYWoYXCIFQZHSr8QmqiwS', 'gatito.jpg', 1),
(37, 'Drago_1', 'Drago_1@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_01.png', 3),
(38, 'Edivaldo_2', 'Edivaldo_2@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_02.png', 3),
(39, 'Elvis_3', 'Elvis_3@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_03.png', 3),
(40, 'Elyan_4', 'Elyan_4@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_04.png', 3),
(41, 'Emeric_5', 'Emeric_5@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_05.png', 3),
(42, 'Engracio_6', 'Engracio_6@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_06.png', 3),
(43, 'Ensa_7', 'Ensa_7@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_07.png', 3),
(44, 'Enaut_8', 'Enaut_8@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_08.png', 3),
(45, 'Eleazar_9', 'Eleazar_9@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_09.png', 3),
(46, 'Eros_10', 'Eros_10@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_10.png', 3),
(47, 'Eufemio_11', 'Eufemio_11@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_11.png', 3),
(48, 'Feiyang_12', 'Feiyang_12@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_12.png', 3),
(49, 'Fiorenzo_13', 'Fiorenzo_13@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_13.png', 3),
(50, 'Foudil_14', 'Foudil_14@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_14.png', 3),
(51, 'Joaquin_15', 'Joaquin_15@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_15.png', 3),
(52, 'Pedro_16', 'Pedro_16@gmail.com', '$2y$10$Oloxb57v2TDkdPuf6E1Q1OUiZZNftBcC1TEVuZ3ToPpZ.mOT/WMsS', 'User_16.png', 3),
(53, 'Eros_11', 'vidal@42.com', '$2y$10$ZmHENsdb.zZqCA43Zc7PsOYIfGRXIagy5V87O7cYC/4RffYUbzOju', 'User_09.png', 3),
(54, 'user#19492', 'lucianita@gmail.com', '$2y$10$W4/0QsjN95rjLVLXtOVmaOl4FO9eEL3L4mTGRiXK6fLKUbvpiAcq6', 'pordefecto.jpg', 3),
(55, 'user#15491', 'admin2@admin.com', '$2y$10$azz2xgIdxaGmPP3v4IV46uEMobLuVOmTeJVFmrrmJBKi8S69aaJ5S', 'pordefecto.jpg', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_roles`
--

CREATE TABLE `usuarios_roles` (
  `id_rol` int(11) NOT NULL,
  `permiso` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios_roles`
--

INSERT INTO `usuarios_roles` (`id_rol`, `permiso`) VALUES
(1, 'Admin'),
(2, 'Supervisor'),
(3, 'Basico');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD PRIMARY KEY (`id_usuario`,`id_amigo`),
  ADD KEY `fk_usuarios_has_usuarios_usuarios2_idx` (`id_amigo`),
  ADD KEY `fk_usuarios_has_usuarios_usuarios1_idx` (`id_usuario`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `fk_comentarios_usuarios1_idx` (`id_usuario`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`);

--
-- Indices de la tabla `eventos_has_usuarios`
--
ALTER TABLE `eventos_has_usuarios`
  ADD PRIMARY KEY (`id_evento`,`id_usaurio`),
  ADD KEY `fk_eventos_has_usuarios_usuarios1_idx` (`id_usaurio`),
  ADD KEY `fk_eventos_has_usuarios_eventos1_idx` (`id_evento`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `favoritos_ibfk_2` (`id_posteo`);

--
-- Indices de la tabla `participantes`
--
ALTER TABLE `participantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_participantes_eventos1_idx` (`id_evento`),
  ADD KEY `fk_participantes_usuarios1_idx` (`id_usuario`);

--
-- Indices de la tabla `posteos`
--
ALTER TABLE `posteos`
  ADD PRIMARY KEY (`id_posteo`),
  ADD KEY `fk_posteos_usuarios1_idx` (`id_usuario`);

--
-- Indices de la tabla `posteos_has_comentarios`
--
ALTER TABLE `posteos_has_comentarios`
  ADD PRIMARY KEY (`id_posteo`,`id_comentario`),
  ADD KEY `fk_posteos_has_comentarios_comentarios1_idx` (`id_comentario`),
  ADD KEY `fk_posteos_has_comentarios_posteos1_idx` (`id_posteo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `fk_usuarios_usuarios_roles1_idx` (`id_rol`);

--
-- Indices de la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `participantes`
--
ALTER TABLE `participantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT de la tabla `posteos`
--
ALTER TABLE `posteos`
  MODIFY `id_posteo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `amigos`
--
ALTER TABLE `amigos`
  ADD CONSTRAINT `fk_usuarios_has_usuarios_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuarios_has_usuarios_usuarios2` FOREIGN KEY (`id_amigo`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `fk_comentarios_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `eventos_has_usuarios`
--
ALTER TABLE `eventos_has_usuarios`
  ADD CONSTRAINT `fk_eventos_has_usuarios_eventos1` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id_evento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eventos_has_usuarios_usuarios1` FOREIGN KEY (`id_usaurio`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_posteo`) REFERENCES `posteos` (`id_posteo`);

--
-- Filtros para la tabla `participantes`
--
ALTER TABLE `participantes`
  ADD CONSTRAINT `fk_participantes_eventos1` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id_evento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_participantes_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `posteos`
--
ALTER TABLE `posteos`
  ADD CONSTRAINT `fk_posteos_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `posteos_has_comentarios`
--
ALTER TABLE `posteos_has_comentarios`
  ADD CONSTRAINT `fk_posteos_has_comentarios_comentarios1` FOREIGN KEY (`id_comentario`) REFERENCES `comentarios` (`id_comentario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_posteos_has_comentarios_posteos1` FOREIGN KEY (`id_posteo`) REFERENCES `posteos` (`id_posteo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_usuarios_roles1` FOREIGN KEY (`id_rol`) REFERENCES `usuarios_roles` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
