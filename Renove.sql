-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: railway
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_agendamento`
--

DROP TABLE IF EXISTS `tb_agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_agendamento` (
  `age_id` int NOT NULL AUTO_INCREMENT,
  `ser_id` int NOT NULL,
  `usu_id` int DEFAULT NULL,
  `age_cliente_nome` varchar(150) NOT NULL,
  `age_cliente_telefone` varchar(20) DEFAULT NULL,
  `age_data` date NOT NULL,
  `age_hora` time NOT NULL,
  `age_status` varchar(30) DEFAULT 'Agendado',
  `age_observacao` text,
  PRIMARY KEY (`age_id`),
  KEY `ser_id` (`ser_id`),
  KEY `pro_id` (`usu_id`),
  CONSTRAINT `fk_agendamento_usuario` FOREIGN KEY (`usu_id`) REFERENCES `tb_usuario` (`usu_id`),
  CONSTRAINT `tb_agendamento_ibfk_1` FOREIGN KEY (`ser_id`) REFERENCES `tb_servico` (`ser_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_agendamento`
--

LOCK TABLES `tb_agendamento` WRITE;
/*!40000 ALTER TABLE `tb_agendamento` DISABLE KEYS */;
INSERT INTO `tb_agendamento` VALUES (3,9,3,'Maria','99999999999','2026-06-19','09:00:00','Agendado','Teste'),(4,9,3,'Maria','(99) 99999-9999','2026-06-19','09:00:00','Agendado','TEste');
/*!40000 ALTER TABLE `tb_agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_categoria`
--

DROP TABLE IF EXISTS `tb_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_categoria` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_descricao` varchar(100) NOT NULL,
  `cat_ativo` enum('s','n') DEFAULT 's',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_descricao` (`cat_descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categoria`
--

LOCK TABLES `tb_categoria` WRITE;
/*!40000 ALTER TABLE `tb_categoria` DISABLE KEYS */;
INSERT INTO `tb_categoria` VALUES (1,'Skincare','s'),(2,'Maquiagem','s'),(3,'Cabelos','s'),(4,'Perfumaria','s');
/*!40000 ALTER TABLE `tb_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cliente` (
  `cli_id` int NOT NULL AUTO_INCREMENT,
  `cli_nome` varchar(100) NOT NULL,
  `cli_cpf` char(11) NOT NULL,
  `cli_telefone` varchar(20) NOT NULL,
  `cli_email` varchar(100) NOT NULL,
  `cli_senha` varchar(100) NOT NULL,
  `cli_nascimento` date DEFAULT NULL,
  `cli_genero` varchar(20) NOT NULL DEFAULT 'Não informar',
  `cli_ativo` enum('s','n') DEFAULT 's',
  PRIMARY KEY (`cli_id`),
  UNIQUE KEY `cli_cpf` (`cli_cpf`),
  UNIQUE KEY `cli_email` (`cli_email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

LOCK TABLES `tb_cliente` WRITE;
/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
INSERT INTO `tb_cliente` VALUES (4,'Luiz Gustavo Sá da Silva','47485402811','(18) 98801-4647','gugamer128@gmail.com','Gu13579.','2005-07-18','Masculino','s'),(5,'Vinicius Silva','47815460801','(18) 98801-4647','vinicius@gmail.com','Gu13579.','2006-05-05','Masculino','s'),(6,'Lucas Aparecido','44945723818','(14) 99886-4300','lucasaparecido@gmail.com','La13579.','2005-07-11','Masculino','s'),(7,'Eduardo ferreira vieira','48423113809','(99) 99999-9999','edu@gmail.com','Edu12345','2004-12-27','Masculino','s'),(9,'Maria das dores','30922325855','(99) 99999-9999','maria@email.com','123456','1999-10-10','Não informar','s');
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_descarte`
--

DROP TABLE IF EXISTS `tb_descarte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_descarte` (
  `des_id` int NOT NULL AUTO_INCREMENT,
  `pro_codigo` varchar(50) NOT NULL,
  `des_quantidade` int NOT NULL,
  `des_data` datetime NOT NULL,
  `des_motivo` varchar(150) NOT NULL,
  `des_observacao` text,
  PRIMARY KEY (`des_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_descarte`
--

LOCK TABLES `tb_descarte` WRITE;
/*!40000 ALTER TABLE `tb_descarte` DISABLE KEYS */;
INSERT INTO `tb_descarte` VALUES (1,'REN-006',10,'2026-05-26 00:00:00','Produto danificado','');
/*!40000 ALTER TABLE `tb_descarte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_devolucao`
--

DROP TABLE IF EXISTS `tb_devolucao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_devolucao` (
  `dev_id` int NOT NULL AUTO_INCREMENT,
  `ped_id` int NOT NULL,
  `pro_codigo` varchar(20) NOT NULL,
  `cli_id` int NOT NULL,
  `dev_quantidade` int NOT NULL,
  `dev_motivo` varchar(200) DEFAULT NULL,
  `dev_data` datetime DEFAULT NULL,
  `dev_observacao` text,
  PRIMARY KEY (`dev_id`),
  KEY `ped_id` (`ped_id`),
  KEY `cli_id` (`cli_id`),
  KEY `pro_codigo` (`pro_codigo`),
  CONSTRAINT `tb_devolucao_ibfk_1` FOREIGN KEY (`ped_id`) REFERENCES `tb_pedido` (`ped_id`),
  CONSTRAINT `tb_devolucao_ibfk_2` FOREIGN KEY (`cli_id`) REFERENCES `tb_cliente` (`cli_id`),
  CONSTRAINT `tb_devolucao_ibfk_3` FOREIGN KEY (`pro_codigo`) REFERENCES `tb_produto` (`pro_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_devolucao`
--

LOCK TABLES `tb_devolucao` WRITE;
/*!40000 ALTER TABLE `tb_devolucao` DISABLE KEYS */;
INSERT INTO `tb_devolucao` VALUES (1,3,'REN-002',4,1,'Produto danificado','2026-06-18 02:36:50','veio com a tampa quebrada');
/*!40000 ALTER TABLE `tb_devolucao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_endereco`
--

DROP TABLE IF EXISTS `tb_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_endereco` (
  `end_id` int NOT NULL AUTO_INCREMENT,
  `cli_id` int NOT NULL,
  `end_cep` varchar(10) NOT NULL,
  `end_rua` varchar(255) NOT NULL,
  `end_numero` varchar(20) NOT NULL,
  `end_bairro` varchar(150) NOT NULL,
  `end_cidade` varchar(150) NOT NULL,
  `end_estado` varchar(10) NOT NULL,
  `end_complemento` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`end_id`),
  KEY `cli_id` (`cli_id`),
  CONSTRAINT `tb_endereco_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `tb_cliente` (`cli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_endereco`
--

LOCK TABLES `tb_endereco` WRITE;
/*!40000 ALTER TABLE `tb_endereco` DISABLE KEYS */;
INSERT INTO `tb_endereco` VALUES (4,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(5,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(6,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(7,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(8,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(9,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(10,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(11,4,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(12,7,'19063-800','Rua Josefa Cordeiro Marafon','265','Jardim Santa Fé','Presidente Prudente','SP',''),(13,4,'19062-100','Rua Cyro Dupre Moreira','123','Residencial Florenza','Presidente Prudente','SP','');
/*!40000 ALTER TABLE `tb_endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_laboratorio`
--

DROP TABLE IF EXISTS `tb_laboratorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_laboratorio` (
  `lab_id` int NOT NULL AUTO_INCREMENT,
  `lab_nome` varchar(100) NOT NULL,
  `lab_telefone` varchar(20) DEFAULT NULL,
  `lab_email` varchar(100) DEFAULT NULL,
  `lab_ativo` enum('s','n') DEFAULT 's',
  PRIMARY KEY (`lab_id`),
  UNIQUE KEY `lab_nome` (`lab_nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_laboratorio`
--

LOCK TABLES `tb_laboratorio` WRITE;
/*!40000 ALTER TABLE `tb_laboratorio` DISABLE KEYS */;
INSERT INTO `tb_laboratorio` VALUES (1,'Nivea Lab','1133334444','contato@nivea.com','s'),(2,'Loreal Lab','1144445555','contato@loreal.com','s'),(3,'Renove','11999999999','contato@renove.com','s');
/*!40000 ALTER TABLE `tb_laboratorio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedido`
--

DROP TABLE IF EXISTS `tb_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pedido` (
  `ped_id` int NOT NULL AUTO_INCREMENT,
  `cli_id` int NOT NULL,
  `end_id` int NOT NULL,
  `ped_data` datetime DEFAULT CURRENT_TIMESTAMP,
  `ped_valortotal` decimal(10,2) DEFAULT '0.00',
  `ped_pagamento` varchar(50) DEFAULT NULL,
  `ped_status` varchar(50) DEFAULT 'Realizado',
  PRIMARY KEY (`ped_id`),
  KEY `cli_id` (`cli_id`),
  KEY `end_id` (`end_id`),
  CONSTRAINT `tb_pedido_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `tb_cliente` (`cli_id`),
  CONSTRAINT `tb_pedido_ibfk_2` FOREIGN KEY (`end_id`) REFERENCES `tb_endereco` (`end_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedido`
--

LOCK TABLES `tb_pedido` WRITE;
/*!40000 ALTER TABLE `tb_pedido` DISABLE KEYS */;
INSERT INTO `tb_pedido` VALUES (1,4,7,'2026-05-23 23:07:40',219.80,'pix','Realizado'),(2,4,8,'2026-05-23 23:16:37',429.80,'pix','Realizado'),(3,4,9,'2026-05-23 23:53:17',129.90,'pix','Devolvido'),(4,4,10,'2026-05-24 20:27:46',5698.10,'pix','Realizado'),(5,4,11,'2026-05-25 22:14:09',129.90,'pix','Realizado'),(6,7,12,'2026-05-29 00:33:58',209.93,'pix','Realizado'),(7,4,13,'2026-06-18 22:54:57',9600.00,'pix','Realizado');
/*!40000 ALTER TABLE `tb_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedidoitens`
--

DROP TABLE IF EXISTS `tb_pedidoitens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pedidoitens` (
  `pit_id` int NOT NULL AUTO_INCREMENT,
  `ped_id` int NOT NULL,
  `pro_codigo` varchar(50) NOT NULL,
  `pit_quantidade` int NOT NULL,
  `pit_valorunidade` decimal(10,2) NOT NULL,
  `pit_valortotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`pit_id`),
  KEY `ped_id` (`ped_id`),
  KEY `pro_codigo` (`pro_codigo`),
  CONSTRAINT `tb_pedidoitens_ibfk_1` FOREIGN KEY (`ped_id`) REFERENCES `tb_pedido` (`ped_id`),
  CONSTRAINT `tb_pedidoitens_ibfk_2` FOREIGN KEY (`pro_codigo`) REFERENCES `tb_produto` (`pro_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedidoitens`
--

LOCK TABLES `tb_pedidoitens` WRITE;
/*!40000 ALTER TABLE `tb_pedidoitens` DISABLE KEYS */;
INSERT INTO `tb_pedidoitens` VALUES (1,2,'REN-002',1,129.90,129.90),(2,2,'REN-003',1,299.90,299.90),(3,3,'REN-002',1,129.90,129.90),(4,4,'REN-003',19,299.90,5698.10),(5,5,'REN-002',1,129.90,129.90),(6,6,'REN-003',1,209.93,209.93),(7,7,'REN-007',100,96.00,9600.00);
/*!40000 ALTER TABLE `tb_pedidoitens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_perfil`
--

DROP TABLE IF EXISTS `tb_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_perfil` (
  `per_id` int NOT NULL AUTO_INCREMENT,
  `per_descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`per_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_perfil`
--

LOCK TABLES `tb_perfil` WRITE;
/*!40000 ALTER TABLE `tb_perfil` DISABLE KEYS */;
INSERT INTO `tb_perfil` VALUES (1,'Administrador'),(2,'Funcionario');
/*!40000 ALTER TABLE `tb_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto`
--

DROP TABLE IF EXISTS `tb_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_produto` (
  `pro_codigo` varchar(50) NOT NULL,
  `pro_nome` varchar(100) NOT NULL,
  `pro_descricao` varchar(1000) DEFAULT NULL,
  `pro_preco` decimal(10,2) NOT NULL,
  `pro_estoque` int NOT NULL DEFAULT '0',
  `pro_data_validade` date DEFAULT NULL,
  `pro_ativo` enum('s','n') DEFAULT 's',
  `pro_imagem` varchar(255) DEFAULT NULL,
  `cat_id` int NOT NULL,
  `tip_id` int NOT NULL,
  `lab_id` int NOT NULL,
  PRIMARY KEY (`pro_codigo`),
  KEY `fk_produto_categoria` (`cat_id`),
  KEY `fk_produto_tipo` (`tip_id`),
  KEY `fk_produto_laboratorio` (`lab_id`),
  CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`cat_id`) REFERENCES `tb_categoria` (`cat_id`),
  CONSTRAINT `fk_produto_laboratorio` FOREIGN KEY (`lab_id`) REFERENCES `tb_laboratorio` (`lab_id`),
  CONSTRAINT `fk_produto_tipo` FOREIGN KEY (`tip_id`) REFERENCES `tb_tipo_produto` (`tip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto`
--

LOCK TABLES `tb_produto` WRITE;
/*!40000 ALTER TABLE `tb_produto` DISABLE KEYS */;
INSERT INTO `tb_produto` VALUES ('REN-001','Hidratante Facial','Hidratante com vitamina C',89.90,49,'2027-12-31','s','PRD-1779264864254.png',1,1,1),('REN-002','Base Líquida','Base profissional matte',129.90,28,'2027-11-15','s','PRD-1779264845856.png',2,4,2),('REN-003','Perfume Hypnose','Fragrância sofisticada',299.90,99,'2040-05-28','s','PRD-1779264808069.png',4,5,3),('REN-004','Shampoo Lily','Shampoo hidratante',45.90,60,'2027-09-10','s','PRD-1779315597800.png',3,2,3),('REN-005','Sérum Antirrugas','Sérum com retinol',159.90,35,'2028-03-05','s','PRD-1779316618635.png',1,6,1),('REN-006','Paleta de Sombras','12 Cores',90.00,90,'2030-01-01','s','PRD-1779317152263.png',2,7,3),('REN-007','Cebolinha','50ml',120.00,0,'2026-06-20','s','PRD-1781808759383.png',4,5,3);
/*!40000 ALTER TABLE `tb_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_promocao`
--

DROP TABLE IF EXISTS `tb_promocao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_promocao` (
  `prom_id` int NOT NULL AUTO_INCREMENT,
  `pro_codigo` varchar(50) NOT NULL,
  `prom_desconto` decimal(10,2) NOT NULL,
  `prom_data_inicio` date NOT NULL,
  `prom_data_fim` date NOT NULL,
  `prom_ativo` char(1) DEFAULT 's',
  PRIMARY KEY (`prom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_promocao`
--

LOCK TABLES `tb_promocao` WRITE;
/*!40000 ALTER TABLE `tb_promocao` DISABLE KEYS */;
INSERT INTO `tb_promocao` VALUES (1,'REN-007',20.00,'2026-06-18','2026-06-20','s'),(5,'021',20.00,'2026-06-20','2020-10-10','s'),(6,'021',20.00,'2026-06-20','2020-10-10','s'),(7,'021',20.00,'2026-06-20','2020-10-10','s'),(8,'021',20.00,'2026-06-20','2020-10-10','s'),(9,'021',20.00,'2026-06-20','2020-10-10','s'),(10,'021',20.00,'2026-06-20','2020-10-10','s'),(11,'021',20.00,'2026-06-20','2020-10-10','s'),(12,'021',20.00,'2026-06-20','2020-10-10','s'),(13,'021',20.00,'2026-06-20','2020-10-10','s');
/*!40000 ALTER TABLE `tb_promocao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_recebimento`
--

DROP TABLE IF EXISTS `tb_recebimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_recebimento` (
  `rec_id` int NOT NULL AUTO_INCREMENT,
  `pro_codigo` varchar(50) NOT NULL,
  `rec_quantidade` int NOT NULL,
  `rec_data` date NOT NULL,
  `rec_lote` varchar(80) DEFAULT NULL,
  `rec_validade` date DEFAULT NULL,
  `rec_observacao` text,
  PRIMARY KEY (`rec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_recebimento`
--

LOCK TABLES `tb_recebimento` WRITE;
/*!40000 ALTER TABLE `tb_recebimento` DISABLE KEYS */;
INSERT INTO `tb_recebimento` VALUES (2,'REN-003',100,'2026-05-28','100','2040-09-28','Recebido');
/*!40000 ALTER TABLE `tb_recebimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_servico`
--

DROP TABLE IF EXISTS `tb_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_servico` (
  `ser_id` int NOT NULL AUTO_INCREMENT,
  `ser_descricao` varchar(150) NOT NULL,
  `ser_detalhes` text,
  `ser_valor` decimal(10,2) NOT NULL,
  `ser_duracao_minutos` int NOT NULL,
  `ser_cor` varchar(20) DEFAULT '#ff5a00',
  `ser_ativo` char(1) DEFAULT 's',
  PRIMARY KEY (`ser_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_servico`
--

LOCK TABLES `tb_servico` WRITE;
/*!40000 ALTER TABLE `tb_servico` DISABLE KEYS */;
INSERT INTO `tb_servico` VALUES (5,'Limpeza de Pele Profunda','Remoção de impurezas, cravos e células mortas, promovendo renovação da pele.',89.90,60,'#4900f5','s'),(6,'Hidratação Facial','Tratamento para hidratar e revitalizar a pele, deixando-a mais saudável e macia.',49.90,30,'#64493a','s'),(7,'Design de Sobrancelhas','Modelagem e alinhamento das sobrancelhas conforme o formato do rosto.',35.00,20,'#ff00ea','s'),(8,'Aplicação de Máscara Facial','Aplicação de máscara específica para nutrição, hidratação ou controle da oleosidade.',29.90,15,'#ff5a00','s'),(9,'TEste','Teste',50.00,10,'#ff5a00','s');
/*!40000 ALTER TABLE `tb_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_produto`
--

DROP TABLE IF EXISTS `tb_tipo_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_produto` (
  `tip_id` int NOT NULL AUTO_INCREMENT,
  `tip_descricao` varchar(100) NOT NULL,
  `tip_ativo` enum('s','n') DEFAULT 's',
  PRIMARY KEY (`tip_id`),
  UNIQUE KEY `tip_descricao` (`tip_descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_produto`
--

LOCK TABLES `tb_tipo_produto` WRITE;
/*!40000 ALTER TABLE `tb_tipo_produto` DISABLE KEYS */;
INSERT INTO `tb_tipo_produto` VALUES (1,'Creme','s'),(2,'Shampoo','s'),(3,'Condicionador','s'),(4,'Base','s'),(5,'Perfume','s'),(6,'Sérum','s'),(7,'Paleta','s');
/*!40000 ALTER TABLE `tb_tipo_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usuario` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_nome` varchar(100) NOT NULL,
  `usu_email` varchar(100) NOT NULL,
  `usu_senha` varchar(100) NOT NULL,
  `usu_ativo` enum('s','n') DEFAULT 's',
  `per_id` int DEFAULT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE KEY `usu_email` (`usu_email`),
  KEY `fk_usuario_perfil` (`per_id`),
  CONSTRAINT `fk_usuario_perfil` FOREIGN KEY (`per_id`) REFERENCES `tb_perfil` (`per_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usuario`
--

LOCK TABLES `tb_usuario` WRITE;
/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
INSERT INTO `tb_usuario` VALUES (1,'Luiz Gustavo','luiz@techmode.com','123456','s',1),(2,'Lucas','lucas@techmode.com','54321','s',1),(3,'Marquin','marquin@renove.com','123456','s',2);
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-07  6:36:18
